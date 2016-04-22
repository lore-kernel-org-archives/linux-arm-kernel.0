From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 22 Apr 2016 17:17:08 -0500
Subject: [PATCH 4/8] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1461363432-5730-5-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kumar Gala <galak@codeaurora.org>

Add an implementation of the SCM interface that works on ARM64 SoCs.  This
is used by things like determine if we have HDCP support or not on the
system.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm-32.c |   4 +
 drivers/firmware/qcom_scm-64.c | 194 ++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/qcom_scm.c    |   7 ++
 drivers/firmware/qcom_scm.h    |   4 +
 4 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 9e3dc2f..0d2a3f8 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -482,3 +482,7 @@ int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
 	return qcom_scm_call(QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
 		req, req_cnt * sizeof(*req), resp, sizeof(*resp));
 }
+
+void __qcom_scm_init(void)
+{
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index bb6555f..86bec08 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -13,6 +13,142 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/qcom_scm.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/qcom_scm.h>
+#include <linux/arm-smccc.h>
+
+#include <asm/cacheflush.h>
+#include <asm/compiler.h>
+#include <asm/smp_plat.h>
+
+#include "qcom_scm.h"
+
+#define QCOM_SCM_FNID(s, c) ((((s) & 0xFF) << 8) | ((c) & 0xFF))
+
+#define MAX_QCOM_SCM_ARGS 10
+#define MAX_QCOM_SCM_RETS 3
+
+#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
+			   (((a) & 0xff) << 4) | \
+			   (((b) & 0xff) << 6) | \
+			   (((c) & 0xff) << 8) | \
+			   (((d) & 0xff) << 10) | \
+			   (((e) & 0xff) << 12) | \
+			   (((f) & 0xff) << 14) | \
+			   (((g) & 0xff) << 16) | \
+			   (((h) & 0xff) << 18) | \
+			   (((i) & 0xff) << 20) | \
+			   (((j) & 0xff) << 22) | \
+			   (num & 0xffff))
+
+#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+
+/**
+ * struct qcom_scm_desc
+ * @arginfo: Metadata describing the arguments in args[]
+ * @args: The array of arguments for the secure syscall
+ * @res: The values returned by the secure syscall
+ * @extra_args_virt: The buffer containing extra arguments
+		   (that don't fit in available registers)
+ * @extra_args_phys: The physical address of the extra arguments
+ */
+struct qcom_scm_desc {
+	u32 arginfo;
+	u64 args[MAX_QCOM_SCM_ARGS];
+	struct arm_smccc_res res;
+
+	/* private */
+	void *extra_args_virt;
+	dma_addr_t extra_args_phys;
+	size_t alloc_size;
+};
+
+static u64 qcom_smccc_convention = -1;
+static DEFINE_MUTEX(qcom_scm_lock);
+
+#define QCOM_SCM_EBUSY_WAIT_MS 30
+#define QCOM_SCM_EBUSY_MAX_RETRY 20
+
+#define N_EXT_QCOM_SCM_ARGS 7
+#define FIRST_EXT_ARG_IDX 3
+#define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
+
+/**
+ * qcom_scm_call() - Invoke a syscall in the secure world
+ * @svc_id: service identifier
+ * @cmd_id: command identifier
+ * @fn_id: The function ID for this syscall
+ * @desc: Descriptor structure containing arguments and return values
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This should *only* be called in pre-emptible context.
+ *
+*/
+static int qcom_scm_call(u32 svc_id, u32 cmd_id, struct qcom_scm_desc *desc)
+{
+	int arglen = desc->arginfo & 0xf;
+	int ret, retry_count = 0, i;
+	u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
+	u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
+
+	if (unlikely(arglen > N_REGISTER_ARGS)) {
+		desc->alloc_size = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
+		desc->extra_args_virt =
+			qcom_scm_alloc_buffer(desc->alloc_size,
+						 &desc->extra_args_phys,
+						 GFP_KERNEL);
+		if (!desc->extra_args_virt)
+			return qcom_scm_remap_error(-ENOMEM);
+
+		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
+			u32 *args = desc->extra_args_virt;
+
+			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
+				args[i] = desc->args[i + FIRST_EXT_ARG_IDX];
+		} else {
+			u64 *args = desc->extra_args_virt;
+
+			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
+				args[i] = desc->args[i + FIRST_EXT_ARG_IDX];
+		}
+
+		x5 = desc->extra_args_phys;
+	}
+
+	do {
+		mutex_lock(&qcom_scm_lock);
+
+		cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
+					 qcom_smccc_convention,
+					 ARM_SMCCC_OWNER_SIP, fn_id);
+
+		do {
+			arm_smccc_smc(cmd, arglen, desc->args[0], desc->args[1],
+				      desc->args[2], x5, 0, 0, &desc->res);
+		} while (desc->res.a0 == QCOM_SCM_INTERRUPTED);
+
+		mutex_unlock(&qcom_scm_lock);
+
+		if (desc->res.a0 == QCOM_SCM_V2_EBUSY) {
+			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
+				break;
+			msleep(QCOM_SCM_EBUSY_WAIT_MS);
+		}
+	}  while (desc->res.a0 == QCOM_SCM_V2_EBUSY);
+
+	if (desc->extra_args_virt)
+		qcom_scm_free_buffer(desc->alloc_size, desc->extra_args_virt,
+				     desc->extra_args_phys);
+
+	if (desc->res.a0 < 0)
+		return qcom_scm_remap_error(ret);
+
+	return 0;
+}
 
 /**
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
@@ -50,14 +186,68 @@ int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
  */
 void __qcom_scm_cpu_power_down(u32 flags)
 {
+	return;
 }
 
 int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
 {
-	return -ENOTSUPP;
+	int ret;
+	struct qcom_scm_desc desc = {0};
+
+	desc.arginfo = QCOM_SCM_ARGS(1);
+	desc.args[0] = QCOM_SCM_FNID(svc_id, cmd_id) |
+			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
+
+	ret = qcom_scm_call(QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
+			    &desc);
+
+	if (ret)
+		return ret;
+
+	return desc.res.a1;
 }
 
 int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
 {
-	return -ENOTSUPP;
+	int ret;
+	struct qcom_scm_desc desc = {0};
+
+	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
+		return -ERANGE;
+
+	desc.args[0] = req[0].addr;
+	desc.args[1] = req[0].val;
+	desc.args[2] = req[1].addr;
+	desc.args[3] = req[1].val;
+	desc.args[4] = req[2].addr;
+	desc.args[5] = req[2].val;
+	desc.args[6] = req[3].addr;
+	desc.args[7] = req[3].val;
+	desc.args[8] = req[4].addr;
+	desc.args[9] = req[4].val;
+	desc.arginfo = QCOM_SCM_ARGS(10);
+
+	ret = qcom_scm_call(QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP, &desc);
+	*resp = desc.res.a1;
+
+	return ret;
+}
+
+void __qcom_scm_init(void)
+{
+	u64 cmd;
+	struct arm_smccc_res res;
+	u32 function = QCOM_SCM_FNID(QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD);
+
+	/* First try a SMC64 call */
+	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
+				 ARM_SMCCC_OWNER_SIP, function);
+
+	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_SHIFT)),
+		      0, 0, 0, 0, 0, &res);
+
+	if (!res.a0 && res.a1)
+		qcom_smccc_convention = ARM_SMCCC_SMC_64;
+	else
+		qcom_smccc_convention = ARM_SMCCC_SMC_32;
 }
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 8e1eeb8..7d7b12b 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -166,6 +166,11 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL(qcom_scm_is_available);
 
+static void qcom_scm_init(void)
+{
+	__qcom_scm_init();
+}
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
@@ -208,6 +213,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
+	qcom_scm_init();
+
 	return 0;
 }
 
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 7dcc733..d3f1f0a 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -36,7 +36,9 @@ extern int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id);
 extern int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 		u32 *resp);
 
+extern void __qcom_scm_init(void);
 /* common error codes */
+#define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
 #define QCOM_SCM_EOPNOTSUPP	-4
 #define QCOM_SCM_EINVAL_ADDR	-3
@@ -56,6 +58,8 @@ static inline int qcom_scm_remap_error(int err)
 		return -EOPNOTSUPP;
 	case QCOM_SCM_ENOMEM:
 		return -ENOMEM;
+	case QCOM_SCM_V2_EBUSY:
+		return err;
 	}
 	return -EINVAL;
 }
-- 
1.9.1
