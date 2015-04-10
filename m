From: jilaiw@codeaurora.org (Jilai Wang)
Date: Fri, 10 Apr 2015 16:15:59 -0400
Subject: [PATCH] firmware: qcom: scm: Add HDCP Support (V2)
In-Reply-To: <1428012376-24545-1-git-send-email-jilaiw@codeaurora.org>
References: <1428012376-24545-1-git-send-email-jilaiw@codeaurora.org>
Message-ID: <1428696959-24555-1-git-send-email-jilaiw@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDCP driver needs to check if secure environment supports HDCP.
If it's supported, then it requires to program some registers
through SCM.
Add qcom_scm_hdcp_available and qcom_scm_hdcp_req to support
these requirements.
V1: original change
V2: Add ARM64 SoCs support

Signed-off-by: Jilai Wang <jilaiw@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 25 ++++++++++++++++++++++++-
 drivers/firmware/qcom_scm-64.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/qcom_scm.c    | 32 +++++++++++++++++++++++++++++++-
 drivers/firmware/qcom_scm.h    | 11 ++++++++++-
 include/linux/qcom_scm.h       | 13 ++++++++++++-
 5 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 89be15e..aa9194e 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+/* Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -485,3 +485,26 @@ void __qcom_scm_cpu_power_down(u32 flags)
 	qcom_scm_call_atomic1(QCOM_SCM_SVC_BOOT, QCOM_SCM_CMD_TERMINATE_PC,
 			flags & QCOM_SCM_FLUSH_FLAG_MASK);
 }
+
+int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
+{
+	int ret;
+	u32 svc_cmd = (svc_id << 10) | cmd_id;
+	u32 ret_val = 0;
+
+	ret = qcom_scm_call(QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD, &svc_cmd,
+			sizeof(svc_cmd), &ret_val, sizeof(ret_val));
+	if (ret)
+		return ret;
+
+	return ret_val;
+}
+
+int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
+{
+	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
+		return -ERANGE;
+
+	return qcom_scm_call(QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
+		req, req_cnt * sizeof(*req), resp, sizeof(*resp));
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 72b75d6..fb17234 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -435,7 +435,46 @@ void __qcom_scm_cpu_power_down(u32 flags)
 	qcom_scm_call_atomic(QCOM_SCM_SVC_BOOT, QCOM_SCM_CMD_TERMINATE_PC, &desc);
 }
 
-#define QCOM_SCM_SVC_INFO              0x6
+int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
+{
+	int ret;
+	struct qcom_scm_desc desc = {0};
+
+	desc.arginfo = QCOM_SCM_ARGS(1);
+	desc.args[0] = QCOM_SCM_SIP_FNID(svc_id, cmd_id);
+
+	ret = qcom_scm_call(
+		QCOM_SCM_SIP_FNID(QCOM_SCM_SVC_INFO, IS_CALL_AVAIL_CMD),
+		&desc);
+
+	if (ret)
+		return ret;
+
+	return desc.ret[0];
+}
+
+int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
+{
+	int ret, i, j;
+	struct qcom_scm_desc desc = {0};
+
+	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
+		return -ERANGE;
+
+	for (i = 0, j = 0; i < req_cnt; i++) {
+		desc.args[j++] = req[i].addr;
+		desc.args[j++] = req[i].val;
+	}
+	desc.arginfo = QCOM_SCM_ARGS(j);
+
+	ret = qcom_scm_call(
+		QCOM_SCM_SIP_FNID(QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP),
+		&desc);
+	*resp = desc.ret[0];
+
+	return ret;
+}
+
 static int __init qcom_scm_init(void)
 {
 	int ret;
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 9989241..45c008d 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+/* Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -64,3 +64,33 @@ void qcom_scm_cpu_power_down(u32 flags)
 	__qcom_scm_cpu_power_down(flags);
 }
 EXPORT_SYMBOL(qcom_scm_cpu_power_down);
+
+/**
+ * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
+ *
+ * Return true if HDCP is supported, false if not.
+ */
+bool qcom_scm_hdcp_available(void)
+{
+	int ret;
+
+	ret = __qcom_scm_is_call_available(QCOM_SCM_SVC_HDCP,
+		QCOM_SCM_CMD_HDCP);
+
+	return (ret > 0) ? true : false;
+}
+EXPORT_SYMBOL(qcom_scm_hdcp_available);
+
+/**
+ * qcom_scm_hdcp_req() - Send HDCP request.
+ * @req: HDCP request array
+ * @req_cnt: HDCP request array count
+ * @resp: response buffer passed to SCM
+ *
+ * Write HDCP register(s) through SCM.
+ */
+int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
+{
+	return __qcom_scm_hdcp_req(req, req_cnt, resp);
+}
+EXPORT_SYMBOL(qcom_scm_hdcp_req);
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 9fbede4..a5839fd 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010-2015, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -26,4 +26,13 @@ extern int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
 #define QCOM_SCM_FLUSH_FLAG_MASK	0x3
 #define QCOM_SCM_CMD_CORE_HOTPLUGGED	0x10
 extern void __qcom_scm_cpu_power_down(u32 flags);
+
+#define QCOM_SCM_SVC_INFO		0x6
+#define QCOM_IS_CALL_AVAIL_CMD		0x1
+extern int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id);
+
+#define QCOM_SCM_SVC_HDCP		0x11
+#define QCOM_SCM_CMD_HDCP		0x01
+extern int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
+		u32 *resp);
 #endif
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index d7a974d..6e7d5ec 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010-2015, The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -16,6 +16,17 @@
 extern int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
 extern int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus);
 
+#define QCOM_SCM_HDCP_MAX_REQ_CNT	5
+
+struct qcom_scm_hdcp_req {
+	u32 addr;
+	u32 val;
+};
+
+extern bool qcom_scm_hdcp_available(void);
+extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
+		u32 *resp);
+
 #define QCOM_SCM_CPU_PWR_DOWN_L2_ON	0x0
 #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
