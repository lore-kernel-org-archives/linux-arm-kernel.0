From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:16:12 +0000
Subject: [PATCH 2/3] ARM: sa11x0: fix sleep entry
In-Reply-To: <20120203191528.GE14129@n2100.arm.linux.org.uk>
References: <20120203191528.GE14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOcG-0005gL-DC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes, we get stuck while trying to enter sleep.  This seems
to occur if we do not have udelay() in the instruction cache. Avoid
this by requesting a short delay prior to modifying the SDRAM timings.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/sleep.S |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index e822331..30cc672 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -26,27 +26,36 @@
  *
  * Causes sa11x0 to enter sleep state
  *
+ * Must be aligned to a cacheline.
  */
-
+	.balign	32
 ENTRY(sa1100_finish_suspend)
 	@ disable clock switching
 	mcr	p15, 0, r1, c15, c2, 2
 
-        @ Adjust memory timing before lowering CPU clock
-	@ Clock speed adjustment without changing memory timing makes
-	@ CPU hang in some cases
-        ldr     r0, =MDREFR
-        ldr     r1, [r0]
-        orr     r1, r1, #MDREFR_K1DB2
-        str     r1, [r0]
+	ldr	r6, =MDREFR
+	ldr	r4, [r6]
+	orr     r4, r4, #MDREFR_K1DB2
+	ldr	r5, =PPCR
+
+	@ Pre-load __udelay into the I-cache
+	mov	r0, #1
+	bl	__udelay
+	mov	r0, r0
+
+	@ The following must all exist in a single cache line to
+	@ avoid accessing memory until this sequence is complete,
+	@ otherwise we occasionally hang.
+
+	@ Adjust memory timing before lowering CPU clock
+	str     r4, [r6]
 
 	@ delay 90us and set CPU PLL to lowest speed
 	@ fixes resume problem on high speed SA1110
 	mov	r0, #90
 	bl	__udelay
-	ldr	r0, =PPCR
 	mov	r1, #0
-	str	r1, [r0]
+	str	r1, [r5]
 	mov	r0, #90
 	bl	__udelay
 
@@ -85,12 +94,10 @@ ENTRY(sa1100_finish_suspend)
 	bic	r5, r5, #FMsk(MSC_RT)
 	bic	r5, r5, #FMsk(MSC_RT)<<16
 
-	ldr	r6, =MDREFR
-
 	ldr	r7, [r6]
-bic	r7, r7, #0x0000FF00
-bic	r7, r7, #0x000000F0
-orr	r8, r7, #MDREFR_SLFRSH
+	bic	r7, r7, #0x0000FF00
+	bic	r7, r7, #0x000000F0
+	orr	r8, r7, #MDREFR_SLFRSH
 
 	ldr	r9, =MDCNFG
 	ldr	r10, [r9]
-- 
1.7.4.4
