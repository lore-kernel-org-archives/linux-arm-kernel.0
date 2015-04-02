From: jilaiw@codeaurora.org (Jilai Wang)
Date: Thu,  2 Apr 2015 18:06:16 -0400
Subject: [PATCH] firmware: qcom: scm: Add HDCP Support
Message-ID: <1428012376-24545-1-git-send-email-jilaiw@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDCP driver needs to check if secure environment supports HDCP.
If it's supported, then it requires to program some registers
through SCM.
Add qcom_scm_hdcp_available and qcom_scm_hdcp_req to support
these requirements.

Signed-off-by: Jilai Wang <jilaiw@codeaurora.org>
---
 drivers/firmware/qcom_scm.c | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/qcom_scm.h    | 13 +++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 994b50f..31fa666 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+/* Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -492,3 +492,61 @@ void qcom_scm_cpu_power_down(u32 flags)
 			flags & QCOM_SCM_FLUSH_FLAG_MASK);
 }
 EXPORT_SYMBOL(qcom_scm_cpu_power_down);
+
+#define QCOM_SCM_SVC_INFO			0x6
+#define QCOM_IS_CALL_AVAIL_CMD		0x1
+/**
+ * qcom_scm_is_call_available() - Query if service/command is available
+ * @svc_id - serivice ID
+ * @cmd_id - command ID
+ *
+ * Query the secure environment about the availability of a particular
+ * service/command.
+ */
+static int qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
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
+#define QCOM_SCM_SVC_HDCP			0x11
+#define QCOM_SCM_CMD_HDCP			0x01
+/**
+ * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
+ *
+ * Return true if HDCP is supported, false if not.
+ */
+bool qcom_scm_hdcp_available(void)
+{
+	int ret;
+
+	ret = qcom_scm_is_call_available(QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP);
+
+	return (ret > 0) ? true : false;
+}
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
+	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
+		return -ERANGE;
+
+	return qcom_scm_call(QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
+		req, req_cnt * sizeof(*req), resp, sizeof(*resp));
+}
+EXPORT_SYMBOL(qcom_scm_hdcp_req);
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
