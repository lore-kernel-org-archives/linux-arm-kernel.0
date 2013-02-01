From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 1 Feb 2013 11:45:57 -0600
Subject: [PATCHv3 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <1359740758-29703-1-git-send-email-dinguyen@altera.com>
References: <1359740758-29703-1-git-send-email-dinguyen@altera.com>
Message-ID: <1359740758-29703-4-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

mach-socfpga is another platform that needs to use
v7_invalidate_l1 to bringup additional cores. There was a comment that
the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Tested-by: Pavel Machek <pavel@denx.de>
Tested-by: Stephen Warren <swarren@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 arch/arm/mach-imx/headsmp.S      |   47 -------------------------------------
 arch/arm/mach-shmobile/headsmp.S |   48 --------------------------------------
 arch/arm/mach-tegra/headsmp.S    |   43 ----------------------------------
 arch/arm/mm/cache-v7.S           |   46 ++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 138 deletions(-)

diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index 7e49deb..921fc15 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -17,53 +17,6 @@
 
 	.section ".text.head", "ax"
 
-/*
- * The secondary kernel init calls v7_flush_dcache_all before it enables
- * the L1; however, the L1 comes out of reset in an undefined state, so
- * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
- * of cache lines with uninitialized data and uninitialized tags to get
- * written out to memory, which does really unpleasant things to the main
- * processor.  We fix this by performing an invalidate, rather than a
- * clean + invalidate, before jumping into the kernel.
- *
- * This funciton is cloned from arch/arm/mach-tegra/headsmp.S, and needs
- * to be called for both secondary cores startup and primary core resume
- * procedures.  Ideally, it should be moved into arch/arm/mm/cache-v7.S.
- */
-ENTRY(v7_invalidate_l1)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
-	mcr	p15, 2, r0, c0, c0, 0
-	mrc	p15, 1, r0, c0, c0, 0
-
-	ldr	r1, =0x7fff
-	and	r2, r1, r0, lsr #13
-
-	ldr	r1, =0x3ff
-
-	and	r3, r1, r0, lsr #3	@ NumWays - 1
-	add	r2, r2, #1		@ NumSets
-
-	and	r0, r0, #0x7
-	add	r0, r0, #4	@ SetShift
-
-	clz	r1, r3		@ WayShift
-	add	r4, r3, #1	@ NumWays
-1:	sub	r2, r2, #1	@ NumSets--
-	mov	r3, r4		@ Temp = NumWays
-2:	subs	r3, r3, #1	@ Temp--
-	mov	r5, r3, lsl r1
-	mov	r6, r2, lsl r0
-	orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-	mcr	p15, 0, r5, c7, c6, 2
-	bgt	2b
-	cmp	r2, #0
-	bgt	1b
-	dsb
-	isb
-	mov	pc, lr
-ENDPROC(v7_invalidate_l1)
-
 #ifdef CONFIG_SMP
 ENTRY(v7_secondary_startup)
 	bl	v7_invalidate_l1
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index b202c12..96001fd 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -16,54 +16,6 @@
 
 	__CPUINIT
 
-/* Cache invalidation nicked from arch/arm/mach-imx/head-v7.S, thanks!
- *
- * The secondary kernel init calls v7_flush_dcache_all before it enables
- * the L1; however, the L1 comes out of reset in an undefined state, so
- * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
- * of cache lines with uninitialized data and uninitialized tags to get
- * written out to memory, which does really unpleasant things to the main
- * processor.  We fix this by performing an invalidate, rather than a
- * clean + invalidate, before jumping into the kernel.
- *
- * This funciton is cloned from arch/arm/mach-tegra/headsmp.S, and needs
- * to be called for both secondary cores startup and primary core resume
- * procedures.  Ideally, it should be moved into arch/arm/mm/cache-v7.S.
- */
-ENTRY(v7_invalidate_l1)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
-	mcr	p15, 2, r0, c0, c0, 0
-	mrc	p15, 1, r0, c0, c0, 0
-
-	ldr	r1, =0x7fff
-	and	r2, r1, r0, lsr #13
-
-	ldr	r1, =0x3ff
-
-	and	r3, r1, r0, lsr #3	@ NumWays - 1
-	add	r2, r2, #1		@ NumSets
-
-	and	r0, r0, #0x7
-	add	r0, r0, #4	@ SetShift
-
-	clz	r1, r3		@ WayShift
-	add	r4, r3, #1	@ NumWays
-1:	sub	r2, r2, #1	@ NumSets--
-	mov	r3, r4		@ Temp = NumWays
-2:	subs	r3, r3, #1	@ Temp--
-	mov	r5, r3, lsl r1
-	mov	r6, r2, lsl r0
-	orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-	mcr	p15, 0, r5, c7, c6, 2
-	bgt	2b
-	cmp	r2, #0
-	bgt	1b
-	dsb
-	isb
-	mov	pc, lr
-ENDPROC(v7_invalidate_l1)
-
 ENTRY(shmobile_invalidate_start)
 	bl	v7_invalidate_l1
 	b	secondary_startup
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index 4a317fa..fb082c4 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -18,49 +18,6 @@
         .section ".text.head", "ax"
 	__CPUINIT
 
-/*
- * Tegra specific entry point for secondary CPUs.
- *   The secondary kernel init calls v7_flush_dcache_all before it enables
- *   the L1; however, the L1 comes out of reset in an undefined state, so
- *   the clean + invalidate performed by v7_flush_dcache_all causes a bunch
- *   of cache lines with uninitialized data and uninitialized tags to get
- *   written out to memory, which does really unpleasant things to the main
- *   processor.  We fix this by performing an invalidate, rather than a
- *   clean + invalidate, before jumping into the kernel.
- */
-ENTRY(v7_invalidate_l1)
-        mov     r0, #0
-        mcr     p15, 2, r0, c0, c0, 0
-        mrc     p15, 1, r0, c0, c0, 0
-
-        ldr     r1, =0x7fff
-        and     r2, r1, r0, lsr #13
-
-        ldr     r1, =0x3ff
-
-        and     r3, r1, r0, lsr #3  @ NumWays - 1
-        add     r2, r2, #1          @ NumSets
-
-        and     r0, r0, #0x7
-        add     r0, r0, #4          @ SetShift
-
-        clz     r1, r3              @ WayShift
-        add     r4, r3, #1          @ NumWays
-1:      sub     r2, r2, #1          @ NumSets--
-        mov     r3, r4              @ Temp = NumWays
-2:      subs    r3, r3, #1          @ Temp--
-        mov     r5, r3, lsl r1
-        mov     r6, r2, lsl r0
-        orr     r5, r5, r6          @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-        mcr     p15, 0, r5, c7, c6, 2
-        bgt     2b
-        cmp     r2, #0
-        bgt     1b
-        dsb
-        isb
-        mov     pc, lr
-ENDPROC(v7_invalidate_l1)
-
 
 ENTRY(tegra_secondary_startup)
         bl      v7_invalidate_l1
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 7539ec2..15451ee 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -19,6 +19,52 @@
 #include "proc-macros.S"
 
 /*
+ * The secondary kernel init calls v7_flush_dcache_all before it enables
+ * the L1; however, the L1 comes out of reset in an undefined state, so
+ * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
+ * of cache lines with uninitialized data and uninitialized tags to get
+ * written out to memory, which does really unpleasant things to the main
+ * processor.  We fix this by performing an invalidate, rather than a
+ * clean + invalidate, before jumping into the kernel.
+ *
+ * This function is cloned from arch/arm/mach-tegra/headsmp.S, and needs
+ * to be called for both secondary cores startup and primary core resume
+ * procedures.
+ */
+ENTRY(v7_invalidate_l1)
+       mov     r0, #0
+       mcr     p15, 2, r0, c0, c0, 0
+       mrc     p15, 1, r0, c0, c0, 0
+
+       ldr     r1, =0x7fff
+       and     r2, r1, r0, lsr #13
+
+       ldr     r1, =0x3ff
+
+       and     r3, r1, r0, lsr #3      @ NumWays - 1
+       add     r2, r2, #1              @ NumSets
+
+       and     r0, r0, #0x7
+       add     r0, r0, #4      @ SetShift
+
+       clz     r1, r3          @ WayShift
+       add     r4, r3, #1      @ NumWays
+1:     sub     r2, r2, #1      @ NumSets--
+       mov     r3, r4          @ Temp = NumWays
+2:     subs    r3, r3, #1      @ Temp--
+       mov     r5, r3, lsl r1
+       mov     r6, r2, lsl r0
+       orr     r5, r5, r6      @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
+       mcr     p15, 0, r5, c7, c6, 2
+       bgt     2b
+       cmp     r2, #0
+       bgt     1b
+       dsb
+       isb
+       mov     pc, lr
+ENDPROC(v7_invalidate_l1)
+
+/*
  *	v7_flush_icache_all()
  *
  *	Flush the whole I-cache.
-- 
1.7.9.5
