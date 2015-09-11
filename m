From: agross@codeaurora.org (Andy Gross)
Date: Fri, 11 Sep 2015 16:01:16 -0500
Subject: [Patch v2] firmware: qcom: scm: Add function stubs for ARM64
Message-ID: <1442005276-31971-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds stubs for the SCM functions exposed in the QCOM SCM API.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/firmware/Kconfig       |    8 +++++
 drivers/firmware/Makefile      |    3 +-
 drivers/firmware/qcom_scm-64.c |   63 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/qcom_scm-64.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 99c69a3..72720eb 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -136,6 +136,14 @@ config QCOM_SCM
 	bool
 	depends on ARM || ARM64
 
+config QCOM_SCM_32
+	def_bool y
+	depends on QCOM_SCM && ARM
+
+config QCOM_SCM_64
+	def_bool y
+	depends on QCOM_SCM && ARM64
+
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4a4b897..73f841c 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -12,7 +12,8 @@ obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
-obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-32.o
+obj-$(CONFIG_QCOM_SCM_64)	+= qcom_scm-64.o
+obj-$(CONFIG_QCOM_SCM_32)	+= qcom_scm-32.o
 CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
 
 obj-y				+= broadcom/
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
