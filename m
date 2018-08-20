From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 21 Aug 2018 00:08:23 +0800
Subject: [PATCH V5 3/5] soc: imx: sc: add pm svc support
In-Reply-To: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1534781305-4770-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCU PM SVC support which provides clock gate, rate, parent
set support as well as resource power management.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/sc/Makefile          |   1 +
 drivers/soc/imx/sc/svc/pm/rpc_clnt.c | 275 +++++++++++++++++++++++++++++++++++
 include/soc/imx/sc/sci.h             |   2 +
 include/soc/imx/sc/svc/pm/api.h      | 229 +++++++++++++++++++++++++++++
 4 files changed, 507 insertions(+)
 create mode 100644 drivers/soc/imx/sc/svc/pm/rpc_clnt.c
 create mode 100644 include/soc/imx/sc/svc/pm/api.h

diff --git a/drivers/soc/imx/sc/Makefile b/drivers/soc/imx/sc/Makefile
index a3db142..6898815 100644
--- a/drivers/soc/imx/sc/Makefile
+++ b/drivers/soc/imx/sc/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += main/ipc.o
+obj-y += svc/pm/rpc_clnt.o
diff --git a/drivers/soc/imx/sc/svc/pm/rpc_clnt.c b/drivers/soc/imx/sc/svc/pm/rpc_clnt.c
new file mode 100644
index 0000000..32228fa
--- /dev/null
+++ b/drivers/soc/imx/sc/svc/pm/rpc_clnt.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * File containing client-side RPC functions for the PM service. These
+ * function are ported to clients that communicate to the SC.
+ *
+ */
+
+#include <soc/imx/sc/svc/pm/api.h>
+#include "../../main/rpc.h"
+
+/*
+ * This type is used to indicate RPC PM function calls.
+ */
+enum pm_func_e {
+	PM_FUNC_UNKNOWN = 0,
+	PM_FUNC_SET_SYS_POWER_MODE = 19,
+	PM_FUNC_SET_PARTITION_POWER_MODE = 1,
+	PM_FUNC_GET_SYS_POWER_MODE = 2,
+	PM_FUNC_SET_RESOURCE_POWER_MODE = 3,
+	PM_FUNC_GET_RESOURCE_POWER_MODE = 4,
+	PM_FUNC_REQ_LOW_POWER_MODE = 16,
+	PM_FUNC_SET_CPU_RESUME_ADDR = 17,
+	PM_FUNC_REQ_SYS_IF_POWER_MODE = 18,
+	PM_FUNC_SET_CLOCK_RATE = 5,
+	PM_FUNC_GET_CLOCK_RATE = 6,
+	PM_FUNC_CLOCK_ENABLE = 7,
+	PM_FUNC_SET_CLOCK_PARENT = 14,
+	PM_FUNC_GET_CLOCK_PARENT = 15,
+	PM_FUNC_RESET = 13,
+	PM_FUNC_RESET_REASON = 10,
+	PM_FUNC_BOOT = 8,
+	PM_FUNC_REBOOT = 9,
+	PM_FUNC_REBOOT_PARTITION = 12,
+	PM_FUNC_CPU_START = 11,
+};
+
+struct imx_sc_msg_req_set_resource_power_mode {
+	struct sc_rpc_msg hdr;
+	u16 resource;
+	u8 mode;
+} __packed;
+
+struct imx_sc_msg_req_get_resource_power_mode {
+	struct sc_rpc_msg hdr;
+	u16 resource;
+} __packed;
+
+struct imx_sc_msg_resp_get_resource_power_mode {
+	struct sc_rpc_msg hdr;
+	u8 mode;
+} __packed;
+
+struct imx_sc_msg_req_set_clock_rate {
+	struct sc_rpc_msg hdr;
+	u32 rate;
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct imx_sc_msg_req_get_clock_rate {
+	struct sc_rpc_msg hdr;
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct imx_sc_msg_resp_get_clock_rate {
+	struct sc_rpc_msg hdr;
+	u32 rate;
+} __packed;
+
+struct imx_sc_msg_req_clock_enable {
+	struct sc_rpc_msg hdr;
+	u16 resource;
+	u8 clk;
+	u8 enable;
+	u8 autog;
+} __packed;
+
+struct imx_sc_msg_req_set_clock_parent {
+	struct sc_rpc_msg hdr;
+	u16 resource;
+	u8 clk;
+	u8 parent;
+} __packed;
+
+struct imx_sc_msg_req_get_clock_parent {
+	struct sc_rpc_msg hdr;
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct imx_sc_msg_resp_get_clock_parent {
+	struct sc_rpc_msg hdr;
+	u8 parent;
+} __packed;
+
+sc_err_t sc_pm_set_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t resource,
+				       sc_pm_power_mode_t mode)
+{
+	struct imx_sc_msg_req_set_resource_power_mode msg;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_SET_RESOURCE_POWER_MODE;
+	hdr->size = 2;
+
+	msg.resource = resource;
+	msg.mode = mode;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	return (sc_err_t)hdr->func;
+}
+
+sc_err_t sc_pm_get_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t resource,
+				       sc_pm_power_mode_t *mode)
+{
+	struct imx_sc_msg_req_get_resource_power_mode msg;
+	struct imx_sc_msg_resp_get_resource_power_mode *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_GET_RESOURCE_POWER_MODE;
+	hdr->size = 2;
+
+	msg.resource = resource;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	resp = (struct imx_sc_msg_resp_get_resource_power_mode *)&msg;
+	if (mode != NULL)
+		*mode = resp->mode;
+
+	return (sc_err_t)resp->hdr.func;
+}
+
+sc_err_t sc_pm_set_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
+			      sc_pm_clk_t clk, sc_pm_clock_rate_t *rate)
+{
+	struct imx_sc_msg_req_set_clock_rate msg;
+	struct imx_sc_msg_resp_get_clock_rate *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_SET_CLOCK_RATE;
+	hdr->size = 3;
+
+	msg.rate = *rate;
+	msg.resource = resource;
+	msg.clk = clk;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	resp = (struct imx_sc_msg_resp_get_clock_rate *)&msg;
+	if (rate != NULL)
+		*rate = resp->rate;
+
+	return (sc_err_t)resp->hdr.func;
+}
+
+sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
+			      sc_pm_clk_t clk, sc_pm_clock_rate_t *rate)
+{
+	struct imx_sc_msg_req_get_clock_rate msg;
+	struct imx_sc_msg_resp_get_clock_rate *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_GET_CLOCK_RATE;
+	hdr->size = 2;
+
+	msg.resource = resource;
+	msg.clk = clk;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	resp = (struct imx_sc_msg_resp_get_clock_rate *)&msg;
+	if (rate != NULL)
+		*rate = resp->rate;
+
+	return (sc_err_t)resp->hdr.func;
+}
+
+sc_err_t sc_pm_clock_enable(sc_ipc_t ipc, sc_rsrc_t resource,
+			    sc_pm_clk_t clk, bool enable, bool autog)
+{
+	struct imx_sc_msg_req_clock_enable msg;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_CLOCK_ENABLE;
+	hdr->size = 3;
+
+	msg.resource = resource;
+	msg.clk = clk;
+	msg.enable = (uint8_t)enable;
+	msg.autog = (uint8_t)autog;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	return (sc_err_t)hdr->func;
+}
+
+sc_err_t sc_pm_set_clock_parent(sc_ipc_t ipc, sc_rsrc_t resource,
+				sc_pm_clk_t clk, sc_pm_clk_parent_t parent)
+{
+	struct imx_sc_msg_req_set_clock_parent msg;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_SET_CLOCK_PARENT;
+	hdr->size = 2;
+
+	msg.resource = resource;
+	msg.clk = clk;
+	msg.parent = parent;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	return (sc_err_t)hdr->func;
+}
+
+sc_err_t sc_pm_get_clock_parent(sc_ipc_t ipc, sc_rsrc_t resource,
+				sc_pm_clk_t clk, sc_pm_clk_parent_t *parent)
+{
+	struct imx_sc_msg_req_get_clock_parent msg;
+	struct imx_sc_msg_resp_get_clock_parent *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_GET_CLOCK_PARENT;
+	hdr->size = 2;
+
+	msg.resource = resource;
+	msg.clk = clk;
+
+	ret = sc_call_rpc(ipc, (void *)&msg, false);
+	if (ret)
+		return SC_ERR_FAIL;
+
+	resp = (struct imx_sc_msg_resp_get_clock_parent *)&msg;
+	if (parent != NULL)
+		*parent = resp->parent;
+
+	return (sc_err_t)resp->hdr.func;
+}
diff --git a/include/soc/imx/sc/sci.h b/include/soc/imx/sc/sci.h
index de3892a..b7248cf 100644
--- a/include/soc/imx/sc/sci.h
+++ b/include/soc/imx/sc/sci.h
@@ -13,4 +13,6 @@
 #include <soc/imx/sc/ipc.h>
 #include <soc/imx/sc/types.h>
 
+#include <soc/imx/sc/svc/pm/api.h>
+
 #endif /* _SC_SCI_H */
diff --git a/include/soc/imx/sc/svc/pm/api.h b/include/soc/imx/sc/svc/pm/api.h
new file mode 100644
index 0000000..2a9e4b9
--- /dev/null
+++ b/include/soc/imx/sc/svc/pm/api.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Power Management (PM) function. This includes functions for power state
+ * control, clock control, reset control, and wake-up event control.
+ *
+ * PM_SVC (SVC) Power Management Service
+ *
+ * Module for the Power Management (PM) service.
+ */
+
+#ifndef _SC_PM_API_H
+#define _SC_PM_API_H
+
+#include <soc/imx/sc/ipc.h>
+#include <soc/imx/sc/types.h>
+
+/*
+ * Defines for ALL parameters
+ */
+#define SC_PM_CLK_ALL   UINT8_MAX	/* All clocks */
+
+/*
+ * Defines for sc_pm_power_mode_t
+ */
+#define SC_PM_PW_MODE_OFF	0	/* Power off */
+#define SC_PM_PW_MODE_STBY	1	/* Power in standby */
+#define SC_PM_PW_MODE_LP	2	/* Power in low-power */
+#define SC_PM_PW_MODE_ON	3	/* Power on */
+
+/*
+ * Defines for sc_pm_clk_t
+ */
+#define SC_PM_CLK_SLV_BUS	0	/* Slave bus clock */
+#define SC_PM_CLK_MST_BUS	1	/* Master bus clock */
+#define SC_PM_CLK_PER		2	/* Peripheral clock */
+#define SC_PM_CLK_PHY		3	/* Phy clock */
+#define SC_PM_CLK_MISC		4	/* Misc clock */
+#define SC_PM_CLK_MISC0		0	/* Misc 0 clock */
+#define SC_PM_CLK_MISC1		1	/* Misc 1 clock */
+#define SC_PM_CLK_MISC2		2	/* Misc 2 clock */
+#define SC_PM_CLK_MISC3		3	/* Misc 3 clock */
+#define SC_PM_CLK_MISC4		4	/* Misc 4 clock */
+#define SC_PM_CLK_CPU		2	/* CPU clock */
+#define SC_PM_CLK_PLL		4	/* PLL */
+#define SC_PM_CLK_BYPASS	4	/* Bypass clock */
+
+/*
+ * Defines for sc_pm_clk_parent_t
+ */
+#define SC_PM_PARENT_XTAL	0	/* Parent is XTAL. */
+#define SC_PM_PARENT_PLL0	1	/* Parent is PLL0 */
+#define SC_PM_PARENT_PLL1	2	/* Parent is PLL1 or PLL0/2 */
+#define SC_PM_PARENT_PLL2	3	/* Parent in PLL2 or PLL0/4 */
+#define SC_PM_PARENT_BYPS	4	/* Parent is a bypass clock. */
+
+/*
+ * This type is used to declare a power mode. Note resources only use
+ * SC_PM_PW_MODE_OFF and SC_PM_PW_MODE_ON. The other modes are used only
+ * as system power modes.
+ */
+typedef uint8_t sc_pm_power_mode_t;
+
+/*
+ * This type is used to declare a clock.
+ */
+typedef uint8_t sc_pm_clk_t;
+
+/*
+ * This type is used to declare the clock parent.
+ */
+typedef uint8_t sc_pm_clk_parent_t;
+
+/*
+ * This type is used to declare clock rates.
+ */
+typedef uint32_t sc_pm_clock_rate_t;
+
+/*
+ * Power Functions
+ */
+
+/*
+ * This function sets the power mode of a resource.
+ *
+ * @param [in]	ipc		IPC handle
+ * @param [in]	resource	ID of the resource
+ * @param [in]	mode		power mode to apply
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_ERR_PARM if invalid resource or mode,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner
+ *   or parent of the owner
+ *
+ * Resources set to SC_PM_PW_MODE_ON will reflect the
+ * power mode of the partition and will change as that changes.
+ *
+ * Note some resources are still not accessible even when powered up if bus
+ * transactions go through a fabric not powered up. Examples of this are
+ * resources in display and capture subsystems which require the display
+ * controller or the imaging subsytem to be powered up first.
+ */
+sc_err_t sc_pm_set_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t resource,
+				       sc_pm_power_mode_t mode);
+
+/*
+ * This function gets the power mode of a resource.
+ *
+ * @param [in]	ipc		IPC handle
+ * @param [in]	resource	ID of the resource
+ * @param [out]	mode		pointer to return power mode
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Note only SC_PM_PW_MODE_OFF and SC_PM_PW_MODE_ON are valid. The value
+ * returned does not reflect the power mode of the partition..
+ */
+sc_err_t sc_pm_get_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t resource,
+				       sc_pm_power_mode_t *mode);
+
+/*
+ * Clock/PLL Functions
+ */
+
+/*
+ * This function sets the rate of a resource's clock/PLL.
+ *
+ * @param [in]		ipc		IPC handle
+ * @param [in]		resource	ID of the resource
+ * @param [in]		clk		clock/PLL to affect
+ * @param [in,out]	rate		pointer to rate to set,
+ *					return actual rate
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_ERR_PARM if invalid resource or clock/PLL,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner
+ *   or parent of the owner,
+ * - SC_ERR_UNAVAILABLE if clock/PLL not applicable to this resource,
+ * - SC_ERR_LOCKED if rate locked (usually because shared clock/PLL)
+ */
+sc_err_t sc_pm_set_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
+			      sc_pm_clk_t clk, sc_pm_clock_rate_t *rate);
+
+/*
+ * This function gets the rate of a resource's clock/PLL.
+ *
+ * @param [in]	ipc		IPC handle
+ * @param [in]	resource	ID of the resource
+ * @param [in]	clk		clock/PLL to affect
+ * @param [out]	rate		pointer to return rate
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_ERR_PARM if invalid resource or clock/PLL,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner
+ *   or parent of the owner,
+ * - SC_ERR_UNAVAILABLE if clock/PLL not applicable to this resource
+ */
+sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
+			      sc_pm_clk_t clk, sc_pm_clock_rate_t *rate);
+
+/*
+ * This function enables/disables a resource's clock.
+ *
+ * @param [in]	ipc		IPC handle
+ * @param [in]	resource	ID of the resource
+ * @param [in]	clk		clock to affect
+ * @param [in]	enable		enable if true; otherwise disabled
+ * @param [in]	autog		HW auto clock gating
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_ERR_PARM if invalid resource or clock,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner
+ *   or parent of the owner,
+ * - SC_ERR_UNAVAILABLE if clock not applicable to this resource
+ */
+sc_err_t sc_pm_clock_enable(sc_ipc_t ipc, sc_rsrc_t resource,
+			    sc_pm_clk_t clk, bool enable, bool autog);
+
+/*
+ * This function sets the parent of a resource's clock.
+ * This function should only be called when the clock is disabled.
+ *
+ * @param [in]	ipc		IPC handle
+ * @param [in]	resource	ID of the resource
+ * @param [in]	clk		clock to affect
+ * @param [in]	parent		New parent of the clock.
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_ERR_PARM if invalid resource or clock,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner
+ *   or parent of the owner,
+ * - SC_ERR_UNAVAILABLE if clock not applicable to this resource
+ * - SC_ERR_BUSY if clock is currently enabled.
+ */
+sc_err_t sc_pm_set_clock_parent(sc_ipc_t ipc, sc_rsrc_t resource,
+				sc_pm_clk_t clk, sc_pm_clk_parent_t parent);
+
+/*
+ * This function gets the parent of a resource's clock.
+ *
+ * @param [in]	ipc		IPC handle
+ * @param [in]	resource	ID of the resource
+ * @param [in]	clk		clock to affect
+ * @param [out]	parent		pointer to return parent of clock.
+ *
+ * @return Returns an error code (SC_ERR_NONE = success).
+ *
+ * Return errors:
+ * - SC_ERR_PARM if invalid resource or clock,
+ * - SC_ERR_NOACCESS if caller's partition is not the resource owner
+ *   or parent of the owner,
+ * - SC_ERR_UNAVAILABLE if clock not applicable to this resource
+ */
+sc_err_t sc_pm_get_clock_parent(sc_ipc_t ipc, sc_rsrc_t resource,
+				sc_pm_clk_t clk, sc_pm_clk_parent_t *parent);
+
+#endif /* _SC_PM_API_H */
-- 
2.7.4
