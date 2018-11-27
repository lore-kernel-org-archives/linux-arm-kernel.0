From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 27 Nov 2018 09:41:20 +0000
Subject: [PATCH 1/4] rtc: add i.MX system controller RTC support
In-Reply-To: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1543311334-8807-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and secure rtc etc..

This patch adds i.MX system controller RTC driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to set/get RTC time and other alarm functions,
since the RTC set time needs to be done in secure EL3 mode (required
by system controller firmware) and alarm functions needs to be done
with general MU IRQ handle, these depend on other components which
are NOT ready, so this patch ONLY enables the RTC time read.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/Kconfig      |   6 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-imx-sc.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/rtc/rtc-imx-sc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef0..3b9642e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1677,6 +1677,12 @@ config RTC_DRV_SNVS
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-snvs".
 
+config RTC_DRV_IMX_SC
+	tristate "NXP i.MX System Controller RTC support"
+	help
+	   If you say yes here you get support for the NXP i.MX System
+	   Controller RTC module.
+
 config RTC_DRV_SIRFSOC
 	tristate "SiRFSOC RTC"
 	depends on ARCH_SIRF
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 290c173..965725f 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_RTC_DRV_SC27XX)	+= rtc-sc27xx.o
 obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
 obj-$(CONFIG_RTC_DRV_SIRFSOC)	+= rtc-sirfsoc.o
 obj-$(CONFIG_RTC_DRV_SNVS)	+= rtc-snvs.o
+obj-$(CONFIG_RTC_DRV_IMX_SC)	+= rtc-imx-sc.o
 obj-$(CONFIG_RTC_DRV_SPEAR)	+= rtc-spear.o
 obj-$(CONFIG_RTC_DRV_STARFIRE)	+= rtc-starfire.o
 obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
new file mode 100644
index 0000000..2466b55
--- /dev/null
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
+#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
+
+struct imx_sc_ipc *rtc_ipc_handle;
+struct rtc_device *rtc;
+
+struct imx_sc_msg_req_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+} __packed;
+
+struct imx_sc_msg_resp_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+	u32 time;
+} __packed;
+
+static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct imx_sc_msg_resp_timer_get_rtc_time *resp;
+	struct imx_sc_msg_req_timer_get_rtc_time msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_TIMER;
+	hdr->func = IMX_SC_TIMER_FUNC_GET_RTC_SEC1970;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("read rtc time failed, ret %d\n", ret);
+		return ret;
+	}
+
+	resp = (struct imx_sc_msg_resp_timer_get_rtc_time *)&msg;
+	rtc_time_to_tm(resp->time, tm);
+
+	return 0;
+}
+
+static const struct rtc_class_ops imx_sc_rtc_ops = {
+	.read_time = imx_sc_rtc_read_time,
+};
+
+static int imx_sc_rtc_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = imx_scu_get_handle(&rtc_ipc_handle);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
+		return ret;
+	}
+
+	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+					&imx_sc_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		dev_err(&pdev->dev, "failed to register rtc: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx_sc_dt_ids[] = {
+	{ .compatible = "nxp,imx8qxp-sc-rtc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx_sc_dt_ids);
+
+static struct platform_driver imx_sc_rtc_driver = {
+	.driver = {
+		.name	= "imx-sc-rtc",
+		.of_match_table = imx_sc_dt_ids,
+	},
+	.probe		= imx_sc_rtc_probe,
+};
+module_platform_driver(imx_sc_rtc_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX System Controller RTC Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
