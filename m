From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 29 Nov 2016 01:44:23 -0600
Subject: [PATCH 2/2] firmware: qcom: scm: Fix interrupted SCM calls
In-Reply-To: <1480405463-23165-1-git-send-email-andy.gross@linaro.org>
References: <1480405463-23165-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1480405463-23165-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a Qualcomm specific quirk to the arm_smccc_smc call.

On Qualcomm ARM64 platforms, the SMC call can return before it has
completed.  If this occurs, the call can be restarted, but it requires
using the returned session ID value from the interrupted SMC call.

The quirk stores off the session ID from the interrupted call in the
quirk structure so that it can be used by the caller.

This patch folds in a fix given by Sricharan R:
https://lkml.org/lkml/2016/9/28/272

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/kernel/smccc-call.S |  9 ++++++++-
 drivers/firmware/qcom_scm-64.c | 11 +++++++++--
 include/linux/arm-smccc.h      | 11 ++++++++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 7b0b3f6..8191fde 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -12,6 +12,7 @@
  *
  */
 #include <linux/linkage.h>
+#include <linux/arm-smccc.h>
 #include <asm/asm-offsets.h>
 
 	.macro SMCCC instr
@@ -20,7 +21,13 @@
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
 	stp	x2, x3, [x4, #ARM_SMCCC_RES_X2_OFFS]
-	ret
+	ldr	x4, [sp, #8]
+	cbz	x4, 1f /* no quirk structure */
+	ldr	x9, [x4, #ARM_SMCCC_QUIRK_ID_OFFS]
+	cmp	x9, #ARM_SMCCC_QUIRK_QCOM_A6
+	b.ne	1f
+	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
+1:	ret
 	.cfi_endproc
 	.endm
 
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index d164a9b..6e997a6 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -91,6 +91,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 	dma_addr_t args_phys = 0;
 	void *args_virt = NULL;
 	size_t alloc_len;
+	struct arm_smccc_quirk quirk = {.id = ARM_SMCCC_QUIRK_QCOM_A6};
 
 	if (unlikely(arglen > N_REGISTER_ARGS)) {
 		alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
@@ -131,10 +132,16 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 					 qcom_smccc_convention,
 					 ARM_SMCCC_OWNER_SIP, fn_id);
 
+		quirk.state.a6 = 0;
+
 		do {
 			arm_smccc_smc(cmd, desc->arginfo, desc->args[0],
-				      desc->args[1], desc->args[2], x5, 0, 0,
-				      res, NULL);
+				      desc->args[1], desc->args[2], x5,
+				      quirk.state.a6, 0, res, &quirk);
+
+			if (res->a0 == QCOM_SCM_INTERRUPTED)
+				cmd = res->a0;
+
 		} while (res->a0 == QCOM_SCM_INTERRUPTED);
 
 		mutex_unlock(&qcom_scm_lock);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 74231b4c..0a239a0 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -14,9 +14,6 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
-#include <linux/linkage.h>
-#include <linux/types.h>
-
 /*
  * This file provides common defines for ARM SMC Calling Convention as
  * specified in
@@ -60,6 +57,13 @@
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
 #define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
 
+#define ARM_SMCCC_QUIRK_NONE		0
+#define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
+
+#ifndef __ASSEMBLY__
+
+#include <linux/linkage.h>
+#include <linux/types.h>
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
@@ -115,4 +119,5 @@ asmlinkage void arm_smccc_hvc(unsigned long a0, unsigned long a1,
 			unsigned long a5, unsigned long a6, unsigned long a7,
 			struct arm_smccc_res *res);
 
+#endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
1.9.1
