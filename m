From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 21 Aug 2018 00:08:24 +0800
Subject: [PATCH V5 4/5] soc: imx: sc: add pad svc support
In-Reply-To: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1534781305-4770-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCU PAD SVC support which provides pad get/set functions.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/sc/Makefile           |  1 +
 drivers/soc/imx/sc/svc/pad/rpc_clnt.c | 82 +++++++++++++++++++++++++++++++++++
 include/soc/imx/sc/sci.h              |  1 +
 include/soc/imx/sc/svc/pad/api.h      | 60 +++++++++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/soc/imx/sc/svc/pad/rpc_clnt.c
 create mode 100644 include/soc/imx/sc/svc/pad/api.h

diff --git a/drivers/soc/imx/sc/Makefile b/drivers/soc/imx/sc/Makefile
index 6898815..3a709b2 100644
--- a/drivers/soc/imx/sc/Makefile
+++ b/drivers/soc/imx/sc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += main/ipc.o
+obj-y += svc/pad/rpc_clnt.o
 obj-y += svc/pm/rpc_clnt.o
diff --git a/drivers/soc/imx/sc/svc/pad/rpc_clnt.c b/drivers/soc/imx/sc/svc/pad/rpc_clnt.c
new file mode 100644
index 0000000..f300aef
--- /dev/null
+++ b/drivers/soc/imx/sc/svc/pad/rpc_clnt.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * File containing client-side RPC functions for the PAD service. These
+ * function are ported to clients that communicate to the SC.
+ *
+ */
+
+#include <soc/imx/sc/svc/pad/api.h>
+#include "../../main/rpc.h"
+
+/*
+ * This type is used to indicate RPC PAD function calls.
+ */
+enum pad_func_e {
+	PAD_FUNC_SET = 15,
+	PAD_FUNC_GET = 16,
+};
+
+struct imx_sc_msg_req_pad_set {
+	struct sc_rpc_msg hdr;
+	u32 val;
+	u16 pad;
+} __packed;
+
+struct imx_sc_msg_req_pad_get {
+	struct sc_rpc_msg hdr;
+	u16 pad;
+} __packed;
+
+struct imx_sc_msg_resp_pad_get {
+	struct sc_rpc_msg hdr;
+	u32 val;
+} __packed;
+
+sc_err_t sc_pad_set(sc_ipc_t ipc, sc_pad_t pad, uint32_t val)
+{
+	struct imx_sc_msg_req_pad_set msg;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PAD;
+	hdr->func = (uint8_t)PAD_FUNC_SET;
+	hdr->size = 3;
+
+	msg.val = val;
+	msg.pad = pad;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	return (sc_err_t)hdr->func;
+}
+
+sc_err_t sc_pad_get(sc_ipc_t ipc, sc_pad_t pad, uint32_t *val)
+{
+	struct imx_sc_msg_req_pad_get msg;
+	struct imx_sc_msg_resp_pad_get *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PAD;
+	hdr->func = (uint8_t)PAD_FUNC_GET;
+	hdr->size = 2;
+
+	msg.pad = pad;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	resp = (struct imx_sc_msg_resp_pad_get *)&msg;
+	if (val != NULL)
+		*val = resp->val;
+
+	return (sc_err_t)resp->hdr.func;
+}
diff --git a/include/soc/imx/sc/sci.h b/include/soc/imx/sc/sci.h
index b7248cf..2407890 100644
--- a/include/soc/imx/sc/sci.h
+++ b/include/soc/imx/sc/sci.h
@@ -13,6 +13,7 @@
 #include <soc/imx/sc/ipc.h>
 #include <soc/imx/sc/types.h>
 
+#include <soc/imx/sc/svc/pad/api.h>
 #include <soc/imx/sc/svc/pm/api.h>
 
 #endif /* _SC_SCI_H */
diff --git a/include/soc/imx/sc/svc/pad/api.h b/include/soc/imx/sc/svc/pad/api.h
new file mode 100644
index 0000000..d7d80b6
--- /dev/null
+++ b/include/soc/imx/sc/svc/pad/api.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Pad Control (PAD) function.
+ *
+ * PAD_SVC (SVC) Pad Service
+ *
+ * Module for the Pad Control (PAD) service.
+ *
+ */
+
+#ifndef _SC_PAD_API_H
+#define _SC_PAD_API_H
+
+#include <soc/imx/sc/ipc.h>
+#include <soc/imx/sc/types.h>
+
+/*
+ * This type is used to indicate a pad. Valid values are SoC specific.
+ *
+ * Refer to the SoC [Pad List](@ref PADS) for valid pad values.
+ */
+typedef uint16_t sc_pad_t;
+
+/*
+ * This function configures the settings for a pad. This setting is SoC
+ * specific.
+ *
+ * @param [in]	ipc	IPC handle
+ * @param [in]	pad	pad to configure
+ * @param [in]	val	value to set
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_PARM if arguments out of range or invalid,
+ * - SC_ERR_NOACCESS if caller's partition is not the pad owner
+ */
+sc_err_t sc_pad_set(sc_ipc_t ipc, sc_pad_t pad, uint32_t val);
+
+/*
+ * This function gets the settings for a pad. This setting is SoC
+ * specific.
+ *
+ * @param [in]	ipc	IPC handle
+ * @param [in]	pad	pad to query
+ * @param [out]	val	pointer to return setting
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_PARM if arguments out of range or invalid,
+ * - SC_ERR_NOACCESS if caller's partition is not the pad owner
+ */
+sc_err_t sc_pad_get(sc_ipc_t ipc, sc_pad_t pad, uint32_t *val);
+
+#endif /* _SC_PAD_API_H */
-- 
2.7.4
