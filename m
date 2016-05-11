From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 11 May 2016 09:15:56 -0500
Subject: [Patch v4 6/8] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
References: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1462976158-26016-7-git-send-email-andy.gross@linaro.org>
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
 drivers/firmware/qcom_scm-64.c | 208 +++++++++++++++++++++++++++++++++++++++--
 drivers/firmware/qcom_scm.c    |   2 +
 drivers/firmware/qcom_scm.h    |   5 +
 4 files changed, 209 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 3e71aec..5c290e7 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -455,3 +455,7 @@ int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 	return qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
 		req, req_cnt * sizeof(*req), resp, sizeof(*resp));
 }
+
+void __qcom_scm_init(void)
+{
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index bb6555f..b57468e 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -12,12 +12,148 @@
 
 #include <linux/io.h>
 #include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/types.h>
 #include <linux/qcom_scm.h>
+#include <linux/arm-smccc.h>
+#include <linux/dma-mapping.h>
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
+ * @arginfo:	Metadata describing the arguments in args[]
+ * @args:	The array of arguments for the secure syscall
+ * @res:	The values returned by the secure syscall
+ */
+struct qcom_scm_desc {
+	u32 arginfo;
+	u64 args[MAX_QCOM_SCM_ARGS];
+	struct arm_smccc_res res;
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
+ * @dev:	device
+ * @svc_id:	service identifier
+ * @cmd_id:	command identifier
+ * @fn_id:	The function ID for this syscall
+ * @desc:	Descriptor structure containing arguments and return values
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This should *only* be called in pre-emptible context.
+*/
+static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
+			 struct qcom_scm_desc *desc)
+{
+	int arglen = desc->arginfo & 0xf;
+	int ret, retry_count = 0, i;
+	u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
+	u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
+	dma_addr_t args_phys = 0;
+	void *args_virt = NULL;
+	size_t alloc_len;
+
+	if (unlikely(arglen > N_REGISTER_ARGS)) {
+		alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
+		args_virt = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
+
+		if (!args_virt)
+			return qcom_scm_remap_error(-ENOMEM);
+
+		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
+			__le32 *args = args_virt;
+
+			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
+				args[i] = cpu_to_le32(desc->args[i +
+						      FIRST_EXT_ARG_IDX]);
+		} else {
+			__le64 *args = args_virt;
+
+			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
+				args[i] = cpu_to_le64(desc->args[i +
+						      FIRST_EXT_ARG_IDX]);
+		}
+
+		args_phys = dma_map_single(dev, args_virt, alloc_len,
+					   DMA_TO_DEVICE);
+
+		if (dma_mapping_error(dev, args_phys)) {
+			kfree(args_virt);
+			return qcom_scm_remap_error(-ENOMEM);
+		}
+
+		x5 = args_phys;
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
+	if (args_virt) {
+		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
+		kfree(args_virt);
+	}
+
+	if (desc->res.a0 < 0)
+		return qcom_scm_remap_error(ret);
+
+	return 0;
+}
 
 /**
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
- * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
+ * @entry:	Entry point function for the cpus
+ * @cpus:	The cpumask of cpus that will use the entry point
  *
  * Set the cold boot address of the cpus. Any cpu outside the supported
  * range would be removed from the cpu present mask.
@@ -29,20 +165,21 @@ int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 
 /**
  * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
- * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
+ * @entry:	Entry point function for the cpus
+ * @cpus:	The cpumask of cpus that will use the entry point
  *
  * Set the Linux entry point for the SCM to transfer control to when coming
  * out of a power down. CPU power down may be executed on cpuidle or hotplug.
  */
-int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
+int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
+				  const cpumask_t *cpus)
 {
 	return -ENOTSUPP;
 }
 
 /**
  * qcom_scm_cpu_power_down() - Power down the cpu
- * @flags - Flags to flush cache
+ * @flags:	Flags to flush cache
  *
  * This is an end point to power down cpu. If there was a pending interrupt,
  * the control would return from this function, otherwise, the cpu jumps to the
@@ -52,12 +189,63 @@ void __qcom_scm_cpu_power_down(u32 flags)
 {
 }
 
-int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
+int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 {
-	return -ENOTSUPP;
+	int ret;
+	struct qcom_scm_desc desc = {0};
+
+	desc.arginfo = QCOM_SCM_ARGS(1);
+	desc.args[0] = QCOM_SCM_FNID(svc_id, cmd_id) |
+			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
+
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
+			    &desc);
+
+	return ret ? : desc.res.a1;
 }
 
-int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
+int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
+			u32 req_cnt, u32 *resp)
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
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP, &desc);
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
index 23ccec6..475410b3e 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -189,6 +189,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
+	__qcom_scm_init();
+
 	return 0;
 }
 
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index afe6676..0ea55d7 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -38,7 +38,10 @@ extern int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 extern int __qcom_scm_hdcp_req(struct device *dev,
 		struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
 
+extern void __qcom_scm_init(void);
+
 /* common error codes */
+#define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
 #define QCOM_SCM_EOPNOTSUPP	-4
 #define QCOM_SCM_EINVAL_ADDR	-3
@@ -58,6 +61,8 @@ static inline int qcom_scm_remap_error(int err)
 		return -EOPNOTSUPP;
 	case QCOM_SCM_ENOMEM:
 		return -ENOMEM;
+	case QCOM_SCM_V2_EBUSY:
+		return -EBUSY;
 	}
 	return -EINVAL;
 }
-- 
1.9.1
