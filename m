From: digetx@gmail.com (Dmitry Osipenko)
Date: Tue, 20 Jan 2015 15:36:55 +0300
Subject: [PATCH 2/2] ARM: l2c: Maintain CPU endianness for early resume
 function
Message-ID: <1421757420-20983-1-git-send-email-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In big endian CPU mode l2x0_saved_regs structure stores registers values in BE
format. In order to maintain BE CPU mode, these values and immediate constants
must be converted back to LE format before writing them to cache controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mm/l2c-l2x0-resume.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mm/l2c-l2x0-resume.S b/arch/arm/mm/l2c-l2x0-resume.S
index fda415e..9f99c7e 100644
--- a/arch/arm/mm/l2c-l2x0-resume.S
+++ b/arch/arm/mm/l2c-l2x0-resume.S
@@ -30,6 +30,15 @@ ENTRY(l2c310_early_resume)
 	teq	r1, #0
 	reteq	lr
 
+	@ Reverse for big endian kernel
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
@@ -51,6 +60,7 @@ ENTRY(l2c310_early_resume)
 
 	str	r2, [r1, #L2X0_AUX_CTRL]
 	mov	r9, #L2X0_CTRL_EN
+ARM_BE8(rev	r9, r9)
 	str	r9, [r1, #L2X0_CTRL]
 	ret	lr
 ENDPROC(l2c310_early_resume)
-- 
2.2.1
