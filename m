From: digetx@gmail.com (Dmitry Osipenko)
Date: Wed, 18 Mar 2015 18:52:44 +0300
Subject: [PATCH v3] ARM: l2c: Maintain CPU endianness for early resume function
Message-ID: <1426693972-6612-1-git-send-email-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In big-endian CPU mode l2x0_saved_regs structure stores registers values in BE
format. In order to maintain BE CPU mode, these values and immediate constants
must be converted back to LE format before writing them to cache controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Changelog:
V2: no code change, fixed patch numbering, extended mail recipients list
V3: added missed register reverse for 'ldr' instructions

 arch/arm/mm/l2c-l2x0-resume.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mm/l2c-l2x0-resume.S b/arch/arm/mm/l2c-l2x0-resume.S
index fda415e4..ecb5b74 100644
--- a/arch/arm/mm/l2c-l2x0-resume.S
+++ b/arch/arm/mm/l2c-l2x0-resume.S
@@ -30,9 +30,19 @@ ENTRY(l2c310_early_resume)
 	teq	r1, #0
 	reteq	lr
 
+	@ Reverse for big-endian kernel
+ARM_BE8(rev	r2, r2)
+ARM_BE8(rev	r3, r3)
+ARM_BE8(rev	r4, r4)
+ARM_BE8(rev	r5, r5)
+ARM_BE8(rev	r6, r6)
+ARM_BE8(rev	r7, r7)
+ARM_BE8(rev	r8, r8)
+
 	@ The prefetch and power control registers are revision dependent
 	@ and can be written whether or not the L2 cache is enabled
 	ldr	r0, [r1, #L2X0_CACHE_ID]
+ARM_BE8(rev	r0, r0)
 	and	r0, r0, #L2X0_CACHE_ID_RTL_MASK
 	cmp	r0, #L310_CACHE_ID_RTL_R2P0
 	strcs	r7, [r1, #L310_PREFETCH_CTRL]
@@ -41,6 +51,7 @@ ENTRY(l2c310_early_resume)
 
 	@ Don't setup the L2 cache if it is already enabled
 	ldr	r0, [r1, #L2X0_CTRL]
+ARM_BE8(rev	r0, r0)
 	tst	r0, #L2X0_CTRL_EN
 	retne	lr
 
@@ -51,6 +62,7 @@ ENTRY(l2c310_early_resume)
 
 	str	r2, [r1, #L2X0_AUX_CTRL]
 	mov	r9, #L2X0_CTRL_EN
+ARM_BE8(rev	r9, r9)
 	str	r9, [r1, #L2X0_CTRL]
 	ret	lr
 ENDPROC(l2c310_early_resume)
-- 
2.3.2
