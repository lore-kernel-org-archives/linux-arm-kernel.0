From: agross@codeaurora.org (Andy Gross)
Date: Fri, 11 Sep 2015 12:50:56 -0500
Subject: [PATCH] firmware: qcom: scm: Add function stubs for ARM64
Message-ID: <1441993856-30178-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds stubs for the SCM functions exposed in the QCOM SCM API.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/firmware/Makefile      |    4 +++
 drivers/firmware/qcom_scm-64.c |   63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 drivers/firmware/qcom_scm-64.c

diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4a4b897..2f810c2 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -12,8 +12,12 @@ obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
+ifdef CONFIG_ARM64
+obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-64.o
+else
 obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-32.o
 CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
+endif
 
 obj-y				+= broadcom/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
new file mode 100644
index 0000000..bb6555f
--- /dev/null
+++ b/drivers/firmware/qcom_scm-64.c
@@ -0,0 +1,63 @@
+/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/qcom_scm.h>
+
+/**
+ * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
+ * @entry: Entry point function for the cpus
+ * @cpus: The cpumask of cpus that will use the entry point
+ *
+ * Set the cold boot address of the cpus. Any cpu outside the supported
+ * range would be removed from the cpu present mask.
+ */
+int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
+{
+	return -ENOTSUPP;
+}
+
+/**
+ * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
+ * @entry: Entry point function for the cpus
+ * @cpus: The cpumask of cpus that will use the entry point
+ *
+ * Set the Linux entry point for the SCM to transfer control to when coming
+ * out of a power down. CPU power down may be executed on cpuidle or hotplug.
+ */
+int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
+{
+	return -ENOTSUPP;
+}
+
+/**
+ * qcom_scm_cpu_power_down() - Power down the cpu
+ * @flags - Flags to flush cache
+ *
+ * This is an end point to power down cpu. If there was a pending interrupt,
+ * the control would return from this function, otherwise, the cpu jumps to the
+ * warm boot entry point set for this cpu upon reset.
+ */
+void __qcom_scm_cpu_power_down(u32 flags)
+{
+}
+
+int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
+{
+	return -ENOTSUPP;
+}
+
+int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
+{
+	return -ENOTSUPP;
+}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
