From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 26 Sep 2018 00:27:58 +0800
Subject: [PATCH V7 3/3] firmware: imx: add misc svc support
In-Reply-To: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
References: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1537892878-30933-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCU MISC SVC support which provides misc control get/set functions.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v6->v7:
 * move MISC_FUNC enums into headfile
 * delete void * cast
 * move function description over the function definition
v5->v6:
 * move into drivers/firmware/imx
 * using structure sc_ipc as handle instread of sc_ipc_t
 * patch title changed
v4->v5:
 * new patch
---
 drivers/firmware/imx/Makefile  |   2 +-
 drivers/firmware/imx/misc.c    | 110 +++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/scu/sci.h      |   1 +
 include/soc/imx/scu/svc/misc.h |  55 +++++++++++++++++++++
 4 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/misc.c
 create mode 100644 include/soc/imx/scu/svc/misc.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 9b1e2fe..0ac04df 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_IMX_SCU)	+= imx-scu.o
+obj-$(CONFIG_IMX_SCU)	+= imx-scu.o misc.o
diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
new file mode 100644
index 0000000..88b8f7f
--- /dev/null
+++ b/drivers/firmware/imx/misc.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *  Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * File containing client-side RPC functions for the MISC service. These
+ * function are ported to clients that communicate to the SC.
+ *
+ */
+
+#include <soc/imx/scu/svc/misc.h>
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
+sc_err_t sc_misc_set_control(struct sc_ipc *ipc, sc_rsrc_t resource,
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
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	return (sc_err_t)hdr->func;
+}
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
+sc_err_t sc_misc_get_control(struct sc_ipc *ipc, sc_rsrc_t resource,
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
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	resp = (struct imx_sc_msg_resp_misc_get_ctrl *)&msg;
+	if (val != NULL)
+		*val = resp->val;
+
+	return (sc_err_t)resp->hdr.func;
+}
diff --git a/include/soc/imx/scu/sci.h b/include/soc/imx/scu/sci.h
index e0657d3..4a60d70 100644
--- a/include/soc/imx/scu/sci.h
+++ b/include/soc/imx/scu/sci.h
@@ -13,4 +13,5 @@
 #include <soc/imx/scu/ipc.h>
 #include <soc/imx/scu/types.h>
 
+#include <soc/imx/scu/svc/misc.h>
 #endif /* _SC_SCI_H */
diff --git a/include/soc/imx/scu/svc/misc.h b/include/soc/imx/scu/svc/misc.h
new file mode 100644
index 0000000..3519077
--- /dev/null
+++ b/include/soc/imx/scu/svc/misc.h
@@ -0,0 +1,55 @@
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
+#include <soc/imx/scu/sci.h>
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
+/*
+ * Control Functions
+ */
+
+sc_err_t sc_misc_set_control(struct sc_ipc *ipc, sc_rsrc_t resource,
+			     sc_ctrl_t ctrl, uint32_t val);
+
+sc_err_t sc_misc_get_control(struct sc_ipc *ipc, sc_rsrc_t resource,
+			     sc_ctrl_t ctrl, uint32_t *val);
+
+#endif /* _SC_MISC_API_H */
-- 
2.7.4
