From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun,  7 Oct 2018 21:04:43 +0800
Subject: [PATCH V9 3/3] firmware: imx: add misc svc support
In-Reply-To: <1538917483-1818-1-git-send-email-aisheng.dong@nxp.com>
References: <1538917483-1818-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1538917483-1818-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCU MISC SVC support which provides misc control get/set functions.

Cc: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v8->v9:
 * update firmware headfile patch from include/soc/imx to
   include/linux/firmware/imx
v7->v8:
 * updating function/enums names with imx_sc prefix
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
 drivers/firmware/imx/Makefile         |  2 +-
 drivers/firmware/imx/misc.c           | 99 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sci.h      |  1 +
 include/linux/firmware/imx/svc/misc.h | 55 +++++++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/misc.c
 create mode 100644 include/linux/firmware/imx/svc/misc.h

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
index 0000000..97f5424
--- /dev/null
+++ b/drivers/firmware/imx/misc.c
@@ -0,0 +1,99 @@
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
+#include <linux/firmware/imx/svc/misc.h>
+
+struct imx_sc_msg_req_misc_set_ctrl {
+	struct imx_sc_rpc_msg hdr;
+	u32 ctrl;
+	u32 val;
+	u16 resource;
+} __packed;
+
+struct imx_sc_msg_req_misc_get_ctrl {
+	struct imx_sc_rpc_msg hdr;
+	u32 ctrl;
+	u16 resource;
+} __packed;
+
+struct imx_sc_msg_resp_misc_get_ctrl {
+	struct imx_sc_rpc_msg hdr;
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
+ * @return Returns 0 for success and < 0 for errors.
+ */
+
+int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
+			    u8 ctrl, u32 val)
+{
+	struct imx_sc_msg_req_misc_set_ctrl msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = (uint8_t)IMX_SC_RPC_SVC_MISC;
+	hdr->func = (uint8_t)IMX_SC_MISC_FUNC_SET_CONTROL;
+	hdr->size = 4;
+
+	msg.ctrl = ctrl;
+	msg.val = val;
+	msg.resource = resource;
+
+	return imx_scu_call_rpc(ipc, &msg, true);
+}
+EXPORT_SYMBOL(imx_sc_misc_set_control);
+
+/*
+ * This function gets a miscellaneous control value.
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource the control is associated with
+ * @param[in]     ctrl        control to get
+ * @param[out]    val         pointer to return the control value
+ *
+ * @return Returns 0 for success and < 0 for errors.
+ */
+
+int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
+			    u8 ctrl, u32 *val)
+{
+	struct imx_sc_msg_req_misc_get_ctrl msg;
+	struct imx_sc_msg_resp_misc_get_ctrl *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = (uint8_t)IMX_SC_RPC_SVC_MISC;
+	hdr->func = (uint8_t)IMX_SC_MISC_FUNC_GET_CONTROL;
+	hdr->size = 3;
+
+	msg.ctrl = ctrl;
+	msg.resource = resource;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_misc_get_ctrl *)&msg;
+	if (val != NULL)
+		*val = resp->val;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_misc_get_control);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index ff3227a..29ada60 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -13,4 +13,5 @@
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/types.h>
 
+#include <linux/firmware/imx/svc/misc.h>
 #endif /* _SC_SCI_H */
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
new file mode 100644
index 0000000..e21c49a
--- /dev/null
+++ b/include/linux/firmware/imx/svc/misc.h
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
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPC MISC function calls.
+ */
+enum imx_misc_func {
+	IMX_SC_MISC_FUNC_UNKNOWN = 0,
+	IMX_SC_MISC_FUNC_SET_CONTROL = 1,
+	IMX_SC_MISC_FUNC_GET_CONTROL = 2,
+	IMX_SC_MISC_FUNC_SET_MAX_DMA_GROUP = 4,
+	IMX_SC_MISC_FUNC_SET_DMA_GROUP = 5,
+	IMX_SC_MISC_FUNC_SECO_IMAGE_LOAD = 8,
+	IMX_SC_MISC_FUNC_SECO_AUTHENTICATE = 9,
+	IMX_SC_MISC_FUNC_DEBUG_OUT = 10,
+	IMX_SC_MISC_FUNC_WAVEFORM_CAPTURE = 6,
+	IMX_SC_MISC_FUNC_BUILD_INFO = 15,
+	IMX_SC_MISC_FUNC_UNIQUE_ID = 19,
+	IMX_SC_MISC_FUNC_SET_ARI = 3,
+	IMX_SC_MISC_FUNC_BOOT_STATUS = 7,
+	IMX_SC_MISC_FUNC_BOOT_DONE = 14,
+	IMX_SC_MISC_FUNC_OTP_FUSE_READ = 11,
+	IMX_SC_MISC_FUNC_OTP_FUSE_WRITE = 17,
+	IMX_SC_MISC_FUNC_SET_TEMP = 12,
+	IMX_SC_MISC_FUNC_GET_TEMP = 13,
+	IMX_SC_MISC_FUNC_GET_BOOT_DEV = 16,
+	IMX_SC_MISC_FUNC_GET_BUTTON_STATUS = 18,
+};
+
+/*
+ * Control Functions
+ */
+
+int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
+			    u8 ctrl, u32 val);
+
+int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
+			    u8 ctrl, u32 *val);
+
+#endif /* _SC_MISC_API_H */
-- 
2.7.4
