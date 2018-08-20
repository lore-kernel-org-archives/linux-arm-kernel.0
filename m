From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 21 Aug 2018 00:08:25 +0800
Subject: [PATCH V5 5/5] soc: imx: sc: add misc svc support
In-Reply-To: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1534781305-4770-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCU MISC SVC support which provides misc control get/set functions.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/sc/Makefile            |   1 +
 drivers/soc/imx/sc/svc/misc/rpc_clnt.c | 106 +++++++++++++++++++++++++++++++++
 include/soc/imx/sc/sci.h               |   1 +
 include/soc/imx/sc/svc/misc/api.h      |  60 +++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/soc/imx/sc/svc/misc/rpc_clnt.c
 create mode 100644 include/soc/imx/sc/svc/misc/api.h

diff --git a/drivers/soc/imx/sc/Makefile b/drivers/soc/imx/sc/Makefile
index 3a709b2..6a3159f 100644
--- a/drivers/soc/imx/sc/Makefile
+++ b/drivers/soc/imx/sc/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += main/ipc.o
+obj-y += svc/misc/rpc_clnt.o
 obj-y += svc/pad/rpc_clnt.o
 obj-y += svc/pm/rpc_clnt.o
diff --git a/drivers/soc/imx/sc/svc/misc/rpc_clnt.c b/drivers/soc/imx/sc/svc/misc/rpc_clnt.c
new file mode 100644
index 0000000..810a0ad
--- /dev/null
+++ b/drivers/soc/imx/sc/svc/misc/rpc_clnt.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * File containing client-side RPC functions for the MISC service. These
+ * function are ported to clients that communicate to the SC.
+ *
+ */
+
+#include <soc/imx/sc/svc/misc/api.h>
+#include "../../main/rpc.h"
+
+/*
+ * This type is used to indicate RPC MISC function calls.
+ */
+enum misc_func_e {
+	MISC_FUNC_UNKNOWN = 0,
+	MISC_FUNC_SET_CONTROL = 1,
+	MISC_FUNC_GET_CONTROL = 2,
+	MISC_FUNC_SET_MAX_DMA_GROUP = 4,
+	MISC_FUNC_SET_DMA_GROUP = 5,
+	MISC_FUNC_SECO_IMAGE_LOAD = 8,
+	MISC_FUNC_SECO_AUTHENTICATE = 9,
+	MISC_FUNC_DEBUG_OUT = 10,
+	MISC_FUNC_WAVEFORM_CAPTURE = 6,
+	MISC_FUNC_BUILD_INFO = 15,
+	MISC_FUNC_UNIQUE_ID = 19,
+	MISC_FUNC_SET_ARI = 3,
+	MISC_FUNC_BOOT_STATUS = 7,
+	MISC_FUNC_BOOT_DONE = 14,
+	MISC_FUNC_OTP_FUSE_READ = 11,
+	MISC_FUNC_OTP_FUSE_WRITE = 17,
+	MISC_FUNC_SET_TEMP = 12,
+	MISC_FUNC_GET_TEMP = 13,
+	MISC_FUNC_GET_BOOT_DEV = 16,
+	MISC_FUNC_GET_BUTTON_STATUS = 18,
+};
+
+struct imx_sc_msg_req_misc_set_ctrl {
+	struct sc_rpc_msg hdr;
+	u32 ctrl;
+	u32 val;
+	u16 resource;
+} __packed;
+
+struct imx_sc_msg_req_misc_get_ctrl {
+	struct sc_rpc_msg hdr;
+	u32 ctrl;
+	u16 resource;
+} __packed;
+
+struct imx_sc_msg_resp_misc_get_ctrl {
+	struct sc_rpc_msg hdr;
+	u32 val;
+} __packed;
+
+sc_err_t sc_misc_set_control(sc_ipc_t ipc, sc_rsrc_t resource,
+			     sc_ctrl_t ctrl, uint32_t val)
+{
+	struct imx_sc_msg_req_misc_set_ctrl msg;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_MISC;
+	hdr->func = (uint8_t)MISC_FUNC_SET_CONTROL;
+	hdr->size = 4;
+
+	msg.ctrl = ctrl;
+	msg.val = val;
+	msg.resource = resource;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	return (sc_err_t)hdr->func;
+}
+
+sc_err_t sc_misc_get_control(sc_ipc_t ipc, sc_rsrc_t resource,
+			     sc_ctrl_t ctrl, uint32_t *val)
+{
+	struct imx_sc_msg_req_misc_get_ctrl msg;
+	struct imx_sc_msg_resp_misc_get_ctrl *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_MISC;
+	hdr->func = (uint8_t)MISC_FUNC_GET_CONTROL;
+	hdr->size = 3;
+
+	msg.ctrl = ctrl;
+	msg.resource = resource;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	resp = (struct imx_sc_msg_resp_misc_get_ctrl *)&msg;
+	if (val != NULL)
+		*val = resp->val;
+
+	return (sc_err_t)resp->hdr.func;
+}
diff --git a/include/soc/imx/sc/sci.h b/include/soc/imx/sc/sci.h
index 2407890..867b9c5 100644
--- a/include/soc/imx/sc/sci.h
+++ b/include/soc/imx/sc/sci.h
@@ -13,6 +13,7 @@
 #include <soc/imx/sc/ipc.h>
 #include <soc/imx/sc/types.h>
 
+#include <soc/imx/sc/svc/misc/api.h>
 #include <soc/imx/sc/svc/pad/api.h>
 #include <soc/imx/sc/svc/pm/api.h>
 
diff --git a/include/soc/imx/sc/svc/misc/api.h b/include/soc/imx/sc/svc/misc/api.h
new file mode 100644
index 0000000..e217f4c
--- /dev/null
+++ b/include/soc/imx/sc/svc/misc/api.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Miscellaneous (MISC) function.
+ *
+ * MISC_SVC (SVC) Miscellaneous Service
+ *
+ * Module for the Miscellaneous (MISC) service.
+ */
+
+#ifndef _SC_MISC_API_H
+#define _SC_MISC_API_H
+
+#include <soc/imx/sc/ipc.h>
+#include <soc/imx/sc/types.h>
+
+/*
+ * Control Functions
+ */
+
+/*
+ * This function sets a miscellaneous control value.
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource the control is associated with
+ * @param[in]     ctrl        control to change
+ * @param[in]     val         value to apply to the control
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_PARM if arguments out of range or invalid,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner or parent
+ *   of the owner
+ */
+sc_err_t sc_misc_set_control(sc_ipc_t ipc, sc_rsrc_t resource,
+			     sc_ctrl_t ctrl, uint32_t val);
+
+/*
+ * This function gets a miscellaneous control value.
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource the control is associated with
+ * @param[in]     ctrl        control to get
+ * @param[out]    val         pointer to return the control value
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_PARM if arguments out of range or invalid,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner or parent
+ *   of the owner
+ */
+sc_err_t sc_misc_get_control(sc_ipc_t ipc, sc_rsrc_t resource,
+			     sc_ctrl_t ctrl, uint32_t *val);
+
+#endif /* _SC_MISC_API_H */
-- 
2.7.4
