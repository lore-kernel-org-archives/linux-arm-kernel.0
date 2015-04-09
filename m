From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Apr 2015 14:46:56 +0100
Subject: [PATCH 4/7] ARM: cache-v7: optimise branches in
 v7_flush_cache_louis
In-Reply-To: <2927556.fYRDzU3Hag@wuerfel>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <2570741.Vc3c6Ovx3m@wuerfel>
 <20150409082116.GV12732@n2100.arm.linux.org.uk>
 <2927556.fYRDzU3Hag@wuerfel>
Message-ID: <20150409134656.GX12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 12:29:12PM +0200, Arnd Bergmann wrote:
> On Thursday 09 April 2015 09:21:16 Russell King - ARM Linux wrote:
> > On Thu, Apr 09, 2015 at 10:13:06AM +0200, Arnd Bergmann wrote:
> > > 
> > > With this in linux-next, I get a build failure on randconfig kernels with
> > > THUMB2_KERNEL enabled:
> > > 
> > > arch/arm/mm/cache-v7.S: Assembler messages:
> > > arch/arm/mm/cache-v7.S:99: Error: ALT_UP() content must assemble to exactly 4 bytes
> > > 
> > > Any idea for a method that will work with all combinations of SMP/UP
> > > and ARM/THUMB? The best I could come up with was to add an extra 'mov r0,r0',
> > > but that gets rather ugly as you then have to do it only for THUMB2.
> > 
> > How about we make ALT_UP() add the additional padding?  Something like
> > this maybe?
> > 
> > diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> > index f67fd3afebdf..79f421796aab 100644
> > --- a/arch/arm/include/asm/assembler.h
> > +++ b/arch/arm/include/asm/assembler.h
> > @@ -237,6 +237,9 @@
> >  	.pushsection ".alt.smp.init", "a"			;\
> >  	.long	9998b						;\
> >  9997:	instr							;\
> > +	.if . - 9997b == 2					;\
> > +		nop						;\
> > +	.endif
> >  	.if . - 9997b != 4					;\
> >  		.error "ALT_UP() content must assemble to exactly 4 bytes";\
> >  	.endif							;\
> > 
> 
> This looks like a good solution, and works fine after adding the
> missing ';\' characters behind the .endif.
> 
> I don't expect any problems but I'm doing some more randconfig builds
> now with this patch, and if you don't hear back today, feel free to add
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.  I'm also intending to merge this too - we could go a bit
further, but I don't want to at the moment...

8<====
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: remove uses of ALT_UP(W(...))

Since we expand a thumb ALT_UP() instruction instruction to be 32-bit,
we no longer need to manually code this.  Remove instances of
ALT_UP(W()).

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/assembler.h |  4 ----
 arch/arm/lib/bitops.h            |  4 ++--
 arch/arm/mm/cache-v7.S           | 10 +++++-----
 arch/arm/mm/tlb-v7.S             |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 186270b3e194..ed823dcc8296 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -283,11 +283,7 @@
 #else
 #error Incompatible SMP platform
 #endif
-	.ifeqs "\mode","arm"
 	ALT_UP(nop)
-	.else
-	ALT_UP(W(nop))
-	.endif
 #endif
 	.endm
 
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 7d807cfd8ef5..0f2055fe21af 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -14,7 +14,7 @@ UNWIND(	.fnstart	)
 #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 	.arch_extension	mp
 	ALT_SMP(W(pldw)	[r1])
-	ALT_UP(W(nop))
+	ALT_UP(nop)
 #endif
 	mov	r3, r2, lsl r3
 1:	ldrex	r2, [r1]
@@ -41,7 +41,7 @@ UNWIND(	.fnstart	)
 #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 	.arch_extension	mp
 	ALT_SMP(W(pldw)	[r1])
-	ALT_UP(W(nop))
+	ALT_UP(nop)
 #endif
 1:	ldrex	r2, [r1]
 	ands	r0, r2, r3		@ save old value of bit
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 51d6a336bac2..21f084bdf60a 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -273,7 +273,7 @@ ENTRY(v7_coherent_user_range)
 	bic	r12, r0, r3
 #ifdef CONFIG_ARM_ERRATA_764369
 	ALT_SMP(W(dsb))
-	ALT_UP(W(nop))
+ALT_UP(	nop)
 #endif
 1:
  USER(	mcr	p15, 0, r12, c7, c11, 1	)	@ clean D line to the point of unification
@@ -326,7 +326,7 @@ ENTRY(v7_flush_kern_dcache_area)
 	bic	r0, r0, r3
 #ifdef CONFIG_ARM_ERRATA_764369
 	ALT_SMP(W(dsb))
-	ALT_UP(W(nop))
+ALT_UP(	nop)
 #endif
 1:
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line / unified line
@@ -354,7 +354,7 @@ v7_dma_inv_range:
 	bic	r0, r0, r3
 #ifdef CONFIG_ARM_ERRATA_764369
 	ALT_SMP(W(dsb))
-	ALT_UP(W(nop))
+ALT_UP(	nop)
 #endif
 	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
 
@@ -381,7 +381,7 @@ v7_dma_clean_range:
 	bic	r0, r0, r3
 #ifdef CONFIG_ARM_ERRATA_764369
 	ALT_SMP(W(dsb))
-	ALT_UP(W(nop))
+ALT_UP(	nop)
 #endif
 1:
 	mcr	p15, 0, r0, c7, c10, 1		@ clean D / U line
@@ -403,7 +403,7 @@ ENTRY(v7_dma_flush_range)
 	bic	r0, r0, r3
 #ifdef CONFIG_ARM_ERRATA_764369
 	ALT_SMP(W(dsb))
-	ALT_UP(W(nop))
+ALT_UP(	nop)
 #endif
 1:
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index e5101a3bc57c..58261e0415c2 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -41,7 +41,7 @@ ENTRY(v7wbi_flush_user_tlb_range)
 	asid	r3, r3				@ mask ASID
 #ifdef CONFIG_ARM_ERRATA_720789
 	ALT_SMP(W(mov)	r3, #0	)
-	ALT_UP(W(nop)		)
+ALT_UP(	nop)
 #endif
 	orr	r0, r3, r0, lsl #PAGE_SHIFT	@ Create initial MVA
 	mov	r1, r1, lsl #PAGE_SHIFT
-- 
1.8.3.1


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
