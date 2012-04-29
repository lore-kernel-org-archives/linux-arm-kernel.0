From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 00:34:12 +0200
Subject: [PATCH 04/11] MXS: Add data shared between imx-otg and EHCI driver
In-Reply-To: <1335738860-26623-1-git-send-email-marex@denx.de>
References: <1335738860-26623-1-git-send-email-marex@denx.de>
Message-ID: <1335738860-26623-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common data shared between the MXS EHCI HCD driver,
the MXS USB Gadget driver and the imx-otg driver. These data allow
passing clock and memory stuff from imx-otg driver into the
host/gadget driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 include/linux/usb/mxs-usb.h |   94 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 include/linux/usb/mxs-usb.h

diff --git a/include/linux/usb/mxs-usb.h b/include/linux/usb/mxs-usb.h
new file mode 100644
index 0000000..3f5b5fc
--- /dev/null
+++ b/include/linux/usb/mxs-usb.h
@@ -0,0 +1,94 @@
+/*
+ * include/linux/usb/mxs-usb.h
+ *
+ * Freescale i.MX USB driver shared data.
+ *
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ * on behalf of DENX Software Engineering GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __INCLUDE_LINUX_USB_MXS_USB_H__
+#define __INCLUDE_LINUX_USB_MXS_USB_H__
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+
+#include <linux/usb/otg.h>
+
+/* MXS USB PHY register definitions. */
+#define HW_USBPHY_PWD				0x00
+
+#define HW_USBPHY_CTRL				0x30
+#define HW_USBPHY_CTRL_SET			0x34
+#define HW_USBPHY_CTRL_CLR			0x38
+#define HW_USBPHY_CTRL_TOG			0x3c
+
+#define BM_USBPHY_CTRL_SFTRST			(1 << 31)
+#define BM_USBPHY_CTRL_CLKGATE			(1 << 30)
+#define BM_USBPHY_CTRL_ENVBUSCHG_WKUP		(1 << 23)
+#define BM_USBPHY_CTRL_ENIDCHG_WKUP		(1 << 22)
+#define BM_USBPHY_CTRL_ENDPDMCHG_WKUP		(1 << 21)
+#define BM_USBPHY_CTRL_WAKEUP_IRQ		(1 << 17)
+#define BM_USBPHY_CTRL_ENIRQWAKEUP		(1 << 16)
+#define BM_USBPHY_CTRL_ENUTMILEVEL3		(1 << 15)
+#define BM_USBPHY_CTRL_ENUTMILEVEL2		(1 << 14)
+#define BM_USBPHY_CTRL_ENIRQDEVPLUGIN		(1 << 11)
+#define BM_USBPHY_CTRL_RESUME_IRQ		(1 << 10)
+#define BM_USBPHY_CTRL_ENIRQRESUMEDETECT	(1 << 9)
+#define BM_USBPHY_CTRL_ENOTGIDDETECT		(1 << 7)
+#define BM_USBPHY_CTRL_ENDEVPLUGINDETECT	(1 << 4)
+#define BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ	(1 << 3)
+#define BM_USBPHY_CTRL_ENIRQHOSTDISCON		(1 << 2)
+#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	(1 << 1)
+
+#define HW_USBPHY_STATUS			0x40
+
+#define BM_USBPHY_STATUS_OTGID_STATUS		(1 << 8)
+#define BM_USBPHY_STATUS_DEVPLUGIN_STATUS	(1 << 6)
+#define BM_USBPHY_STATUS_HOSTDISCON_STATUS	(1 << 3)
+
+struct imx_otg_priv {
+	uint32_t		gpio_vbus;
+	uint32_t		gpio_vbus_inverted;
+	enum usb_otg_state	new_state;
+	enum usb_otg_state	cur_state;
+	struct usb_otg		otg;
+	struct work_struct	work;
+	struct device		*dev;
+};
+
+struct imx_otg {
+	struct platform_device	*pdev_host;
+	struct platform_device	*pdev_gadget;
+
+	struct clk		*clk;
+	struct resource		*mem_res;
+	void __iomem		*mem;
+	int			irq;
+	int			irq_wakeup;
+
+	struct imx_otg_priv	priv;
+};
+
+struct imx_usb_platform_data {
+	uint32_t		gpio_vbus;
+	bool			gpio_vbus_inverted;
+	bool			host_mode;
+	bool			gadget_mode;
+};
+
+#endif /* __INCLUDE_LINUX_USB_MXS_USB_H__ */
-- 
1.7.10
