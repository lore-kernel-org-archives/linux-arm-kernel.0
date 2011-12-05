From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Mon,  5 Dec 2011 16:36:10 +0530
Subject: [PATCH V4 3/5] ARM: s5p: add L2 early resume code
In-Reply-To: <1323083172-14096-1-git-send-email-amit.kachhap@linaro.org>
References: <1323083172-14096-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1323083172-14096-4-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds code to resume L2 before MMU is enabled in
suspend and cpuidle resume paths. s3c_cpu_resume is moved to the
data section with appropriate comments.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/plat-s5p/sleep.S |   44 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-s5p/sleep.S b/arch/arm/plat-s5p/sleep.S
index 0fd591b..006bd01 100644
--- a/arch/arm/plat-s5p/sleep.S
+++ b/arch/arm/plat-s5p/sleep.S
@@ -23,9 +23,18 @@
 */
 
 #include <linux/linkage.h>
-#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/hardware/cache-l2x0.h>
 
-	.text
+/*
+ *	 The following code is located into the .data section. This is to
+ *	 allow l2x0_regs_phys to be accessed with a relative load while we
+ *	 can't rely on any MMU translation. We could have put l2x0_regs_phys
+ *	 in the .text section as well, but some setups might insist on it to
+ *	 be truly read-only. (Reference from: arch/arm/kernel/sleep.S)
+ */
+	.data
+	.align
 
 	/*
 	 * sleep magic, to allow the bootloader to check for an valid
@@ -39,11 +48,34 @@
 	 * s3c_cpu_resume
 	 *
 	 * resume code entry for bootloader to call
-	 *
-	 * we must put this code here in the data segment as we have no
-	 * other way of restoring the stack pointer after sleep, and we
-	 * must not write to the code segment (code is read-only)
 	 */
 
 ENTRY(s3c_cpu_resume)
+#ifdef CONFIG_CACHE_L2X0
+	adr	r0, l2x0_regs_phys
+	ldr	r0, [r0]
+	ldr	r1, [r0, #L2X0_R_PHY_BASE]
+	ldr	r2, [r1, #L2X0_CTRL]
+	tst	r2, #0x1
+	bne	resume_l2on
+	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
+	str	r2, [r1, #L2X0_AUX_CTRL]
+	ldr	r2, [r0, #L2X0_R_TAG_LATENCY]
+	str	r2, [r1, #L2X0_TAG_LATENCY_CTRL]
+	ldr	r2, [r0, #L2X0_R_DATA_LATENCY]
+	str	r2, [r1, #L2X0_DATA_LATENCY_CTRL]
+	ldr	r2, [r0, #L2X0_R_PREFETCH_CTRL]
+	str	r2, [r1, #L2X0_PREFETCH_CTRL]
+	ldr	r2, [r0, #L2X0_R_PWR_CTRL]
+	str	r2, [r1, #L2X0_POWER_CTRL]
+	mov	r2, #1
+	str	r2, [r1, #L2X0_CTRL]
+resume_l2on:
+#endif
 	b	cpu_resume
+ENDPROC(s3c_cpu_resume)
+#ifdef CONFIG_CACHE_L2X0
+	.globl l2x0_regs_phys
+l2x0_regs_phys:
+	.long	0
+#endif
-- 
1.7.1
