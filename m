From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 23:57:59 +0100
Subject: [RFC] mixture of cleanups to cache-v7.S
In-Reply-To: <20150402224947.GX24899@n2100.arm.linux.org.uk>
References: <20150402224947.GX24899@n2100.arm.linux.org.uk>
Message-ID: <20150402225759.GY24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 11:49:47PM +0100, Russell King - ARM Linux wrote:
> Several cleanups are in the patch below... I'll separate them out, but
> I'd like to hear comments on them.  Basically:
> 
> 1. cache-v7.S is built for ARMv7 CPUs, so there's no reason not to
>    use movw and movt when loading large constants, rather than using
>    "ldr rd,=constant"
> 
> 2. we can do a much more efficient check for the errata in
>    v7_flush_dcache_louis than we were doing - rather than putting the
>    work-around code in the fast path, we can re-organise this such that
>    we only try to run the workaround code if the LoU field is zero.
> 
> 3. shift the bitfield we want to extract in the CLIDR to the appropriate
>    bit position prior to masking; this reduces the complexity of the
>    code, particularly with the SMP differences in v7_flush_dcache_louis.
> 
> 4. pre-shift the Cortex A9 MIDR value to be checked, and shift the
>    actual MIDR to lose the bottom four revision bits.
> 
> 5. as the v7_flush_dcache_louis code is more optimal, I see no reason not
>    to enable this workaround by default now - if people really want it to
>    be disabled, they can still choose that option.  This is in addition
>    to Versatile Express enabling it.  Given the memory corrupting abilities
>    of not having this errata enabled, I think it's only sane that it's
>    something that should be encouraged to be enabled, even though it only
>    affects r0pX CPUs.
> 
> One obvious issue comes up here though - in the case that the LoU bits
> are validly zero, we merely return from v7_flush_dcache_louis with no
> DSB or ISB.  However v7_flush_dcache_all always has a DSB or ISB at the
> end, even if LoC is zero.  Is this an intentional difference, or should
> v7_flush_dcache_louis always end with a DSB+ISB ?

I should point out that if the DSB+ISB is needed, then the code can
instead become as below - basically, we just move the CLIDR into the
appropriate position and call start_flush_levels, which does the DMB,
applies the mask to extract the appropriate field, and then decides
whether it has any levels to process.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2eb6de9465bf..c26dfef393cd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1139,6 +1139,7 @@ config ARM_ERRATA_742231
 config ARM_ERRATA_643719
 	bool "ARM errata: LoUIS bit field in CLIDR register is incorrect"
 	depends on CPU_V7 && SMP
+	default y
 	help
 	  This option enables the workaround for the 643719 Cortex-A9 (prior to
 	  r1p0) erratum. On affected cores the LoUIS bit field of the CLIDR
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index b966656d2c2d..14bfdd584385 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -36,10 +36,10 @@ ENTRY(v7_invalidate_l1)
        mcr     p15, 2, r0, c0, c0, 0
        mrc     p15, 1, r0, c0, c0, 0
 
-       ldr     r1, =0x7fff
+       movw    r1, #0x7fff
        and     r2, r1, r0, lsr #13
 
-       ldr     r1, =0x3ff
+       movw    r1, #0x3ff
 
        and     r3, r1, r0, lsr #3      @ NumWays - 1
        add     r2, r2, #1              @ NumSets
@@ -88,23 +88,20 @@ ENDPROC(v7_flush_icache_all)
  */
 
 ENTRY(v7_flush_dcache_louis)
-	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
-	ALT_SMP(ands	r3, r0, #(7 << 21))	@ extract LoUIS from clidr
-	ALT_UP(ands	r3, r0, #(7 << 27))	@ extract LoUU from clidr
+ALT_SMP(mov	r3, r0, lsr #20)		@ move LoUIS into position
+ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
 #ifdef CONFIG_ARM_ERRATA_643719
-	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
-	ALT_UP(reteq	lr)			@ LoUU is zero, so nothing to do
-	ldreq	r1, =0x410fc090                 @ ID of ARM Cortex A9 r0p?
-	biceq	r2, r2, #0x0000000f             @ clear minor revision number
-	teqeq	r2, r1                          @ test for errata affected core and if so...
-	orreqs	r3, #(1 << 21)			@   fix LoUIS value (and set flags state to 'ne')
+ALT_SMP(ands	r3, r3, #7 << 1)		@ extract LoU field from clidr
+ALT_UP(	b	start_flush_levels)
+	bne	start_flush_levels		@ LoU != 0, start flushing
+	mrc	p15, 0, r2, c0, c0, 0		@ read main ID register
+	movw	r1, #:lower16:(0x410fc090 >> 4)	@ ID of ARM Cortex A9 r0p?
+	movt	r1, #:upper16:(0x410fc090 >> 4)
+	teq	r1, r2, lsr #4			@ test for errata affected core and if so...
+	moveq	r3, #1 << 1			@ fix LoUIS value (and set flags state to 'ne')
 #endif
-	ALT_SMP(mov	r3, r3, lsr #20)	@ r3 = LoUIS * 2
-	ALT_UP(mov	r3, r3, lsr #26)	@ r3 = LoUU * 2
-	reteq	lr				@ return if level == 0
-	mov	r10, #0				@ r10 (starting level) = 0
-	b	flush_levels			@ start flushing cache levels
+	b	start_flush_levels		@ start flushing cache levels
 ENDPROC(v7_flush_dcache_louis)
 
 /*
@@ -117,10 +114,11 @@ ENDPROC(v7_flush_dcache_louis)
  *	- mm    - mm_struct describing address space
  */
 ENTRY(v7_flush_dcache_all)
-	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
-	ands	r3, r0, #0x7000000		@ extract loc from clidr
-	mov	r3, r3, lsr #23			@ left align loc bit field
+	mov	r3, r0, lsr #23			@ align LoC
+start_flush_levels:
+	dmb					@ ensure ordering with previous memory accesses
+	ands	r3, r3, #7 << 1			@ extract loc from clidr
 	beq	finished			@ if loc is 0, then no need to clean
 	mov	r10, #0				@ start clean at cache level 0
 flush_levels:
@@ -140,10 +138,10 @@ flush_levels:
 #endif
 	and	r2, r1, #7			@ extract the length of the cache lines
 	add	r2, r2, #4			@ add 4 (line length offset)
-	ldr	r4, =0x3ff
+	movw	r4, #0x3ff
 	ands	r4, r4, r1, lsr #3		@ find maximum number on the way size
 	clz	r5, r4				@ find bit position of way size increment
-	ldr	r7, =0x7fff
+	movw	r7, #0x7fff
 	ands	r7, r7, r1, lsr #13		@ extract max number of the index size
 loop1:
 	mov	r9, r7				@ create working copy of max index

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
