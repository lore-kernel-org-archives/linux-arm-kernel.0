From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 19 Oct 2016 10:28:25 +0800
Subject: [PATCH v7, 6/8] usb: mtu3: host only mode support
In-Reply-To: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1476844107-31087-7-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

supports host only mode and the code is ported from
host/xhci-mtk.c
IPPC register shared between host and device is moved
into common glue layer.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/Kconfig     |    9 ++
 drivers/usb/mtu3/Makefile    |   11 +-
 drivers/usb/mtu3/mtu3.h      |   47 ++++++-
 drivers/usb/mtu3/mtu3_core.c |   42 +++++-
 drivers/usb/mtu3/mtu3_dr.h   |   85 +++++++++++++
 drivers/usb/mtu3/mtu3_host.c |  288 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/mtu3/mtu3_plat.c |  289 ++++++++++++++++++++++++++++++++----------
 7 files changed, 691 insertions(+), 80 deletions(-)
 create mode 100644 drivers/usb/mtu3/mtu3_dr.h
 create mode 100644 drivers/usb/mtu3/mtu3_host.c

diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 54dadee..59e3f6f 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -4,6 +4,7 @@ config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
 	depends on (USB || USB_GADGET) && HAS_DMA
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system runs on MediaTek SoCs with
 	  Dual Role SuperSpeed USB controller. You can select usb
@@ -18,8 +19,16 @@ config USB_MTU3
 if USB_MTU3
 choice
 	bool "MTU3 Mode Selection"
+	default USB_MTU3_HOST if (USB && !USB_GADGET)
 	default USB_MTU3_GADGET if (!USB && USB_GADGET)
 
+config USB_MTU3_HOST
+	bool "Host only mode"
+	depends on USB=y || USB=USB_MTU3
+	help
+	  Select this when you want to use MTU3 in host mode only,
+	  thereby the gadget feature will be regressed.
+
 config USB_MTU3_GADGET
 	bool "Gadget only mode"
 	depends on USB_GADGET=y || USB_GADGET=USB_MTU3
diff --git a/drivers/usb/mtu3/Makefile b/drivers/usb/mtu3/Makefile
index 532c257..41e45e9 100644
--- a/drivers/usb/mtu3/Makefile
+++ b/drivers/usb/mtu3/Makefile
@@ -1,2 +1,11 @@
 obj-$(CONFIG_USB_MTU3)	+= mtu3.o
-mtu3-y	:= mtu3_plat.o mtu3_core.o mtu3_gadget_ep0.o mtu3_gadget.o mtu3_qmu.o
+
+mtu3-y	:= mtu3_plat.o
+
+ifneq ($(filter y,$(CONFIG_USB_MTU3_HOST)),)
+	mtu3-y	+= mtu3_host.o
+endif
+
+ifneq ($(filter y,$(CONFIG_USB_MTU3_GADGET)),)
+	mtu3-y	+= mtu3_core.o mtu3_gadget_ep0.o mtu3_gadget.o mtu3_qmu.o
+endif
diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 41a0473..a7c0ce8 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -172,6 +172,40 @@ struct mtu3_gpd_ring {
 	struct qmu_gpd *enqueue;
 	struct qmu_gpd *dequeue;
 };
+/**
+ * @mac_base: register base address of device MAC, exclude xHCI's
+ * @ippc_base: register base address of ip port controller interface (IPPC)
+ * @vusb33: usb3.3V shared by device/host IP
+ * @sys_clk: system clock of mtu3, shared by device/host IP
+ * @dr_mode: works in which mode:
+ *		host only, device only or dual-role mode
+ * @u2_ports: number of usb2.0 host ports
+ * @u3_ports: number of usb3.0 host ports
+ * @wakeup_en: it's true when supports remote wakeup in host mode
+ * @wk_deb_p0: port0's wakeup debounce clock
+ * @wk_deb_p1: it's optional, and depends on port1 is supported or not
+ */
+struct ssusb_mtk {
+	struct device *dev;
+	struct mtu3 *u3d;
+	void __iomem *mac_base;
+	void __iomem *ippc_base;
+	struct phy **phys;
+	int num_phys;
+	/* common power & clock */
+	struct regulator *vusb33;
+	struct clk *sys_clk;
+	/* otg */
+	enum usb_dr_mode dr_mode;
+	bool is_host;
+	int u2_ports;
+	int u3_ports;
+	/* usb wakeup for host mode */
+	bool wakeup_en;
+	struct clk *wk_deb_p0;
+	struct clk *wk_deb_p1;
+	struct regmap *pericfg;
+};
 
 /**
  * @fifo_size: it is (@slot + 1) * @fifo_seg_size
@@ -210,6 +244,11 @@ struct mtu3_request {
 	int epnum;
 };
 
+static inline struct ssusb_mtk *dev_to_ssusb(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
 /**
  * struct mtu3 - device driver instance data.
  * @slot: MTU3_U2_IP_SLOT_DEFAULT for U2 IP only,
@@ -222,12 +261,10 @@ struct mtu3_request {
  */
 struct mtu3 {
 	spinlock_t lock;
+	struct ssusb_mtk *ssusb;
 	struct device *dev;
 	void __iomem *mac_base;
 	void __iomem *ippc_base;
-	struct phy *phy;
-	struct regulator *vusb33;
-	struct clk *sys_clk;
 	int irq;
 
 	struct mtu3_fifo_info tx_fifo;
@@ -320,7 +357,7 @@ static inline void mtu3_clrbits(void __iomem *base, u32 offset, u32 bits)
 	writel((tmp & ~(bits)), addr);
 }
 
-int ssusb_check_clocks(struct mtu3 *mtu, u32 ex_clks);
+int ssusb_check_clocks(struct ssusb_mtk *ssusb, u32 ex_clks);
 struct usb_request *mtu3_alloc_request(struct usb_ep *ep, gfp_t gfp_flags);
 void mtu3_free_request(struct usb_ep *ep, struct usb_request *req);
 void mtu3_req_complete(struct mtu3_ep *mep,
@@ -341,8 +378,6 @@ int mtu3_config_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 void mtu3_gadget_suspend(struct mtu3 *mtu);
 void mtu3_gadget_resume(struct mtu3 *mtu);
 void mtu3_gadget_disconnect(struct mtu3 *mtu);
-int ssusb_gadget_init(struct mtu3 *mtu);
-void ssusb_gadget_exit(struct mtu3 *mtu);
 
 irqreturn_t mtu3_ep0_isr(struct mtu3 *mtu);
 extern const struct usb_ep_ops mtu3_ep0_ops;
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index f9817ad..2eef972 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -116,7 +116,7 @@ static int mtu3_device_enable(struct mtu3 *mtu)
 		SSUSB_U2_PORT_HOST_SEL));
 	mtu3_setbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_OTG_SEL);
 
-	return ssusb_check_clocks(mtu, check_clk);
+	return ssusb_check_clocks(mtu->ssusb, check_clk);
 }
 
 static void mtu3_device_disable(struct mtu3 *mtu)
@@ -765,11 +765,38 @@ static void mtu3_hw_exit(struct mtu3 *mtu)
 
 /*-------------------------------------------------------------------------*/
 
-int ssusb_gadget_init(struct mtu3 *mtu)
+int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 {
-	struct device *dev = mtu->dev;
-	int ret;
+	struct device *dev = ssusb->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mtu3 *mtu = NULL;
+	struct resource *res;
+	int ret = -ENOMEM;
+
+	mtu = devm_kzalloc(dev, sizeof(struct mtu3), GFP_KERNEL);
+	if (mtu == NULL)
+		return -ENOMEM;
+
+	mtu->irq = platform_get_irq(pdev, 0);
+	if (mtu->irq <= 0) {
+		dev_err(dev, "fail to get irq number\n");
+		return -ENODEV;
+	}
+	dev_info(dev, "irq %d\n", mtu->irq);
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mac");
+	mtu->mac_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mtu->mac_base)) {
+		dev_err(dev, "error mapping memory for dev mac\n");
+		return PTR_ERR(mtu->mac_base);
+	}
+
+	spin_lock_init(&mtu->lock);
+	mtu->dev = dev;
+	mtu->ippc_base = ssusb->ippc_base;
+	ssusb->mac_base	= mtu->mac_base;
+	ssusb->u3d = mtu;
+	mtu->ssusb = ssusb;
 	mtu->max_speed = usb_get_maximum_speed(dev);
 
 	/* check the max_speed parameter */
@@ -820,14 +847,17 @@ int ssusb_gadget_init(struct mtu3 *mtu)
 
 irq_err:
 	mtu3_hw_exit(mtu);
+	ssusb->u3d = NULL;
 	dev_err(dev, " %s() fail...\n", __func__);
 
 	return ret;
 }
 
-void ssusb_gadget_exit(struct mtu3 *mtu)
+void ssusb_gadget_exit(struct ssusb_mtk *ssusb)
 {
+	struct mtu3 *mtu = ssusb->u3d;
+
 	mtu3_gadget_cleanup(mtu);
-	device_init_wakeup(mtu->dev, false);
+	device_init_wakeup(ssusb->dev, false);
 	mtu3_hw_exit(mtu);
 }
diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
new file mode 100644
index 0000000..07066f4
--- /dev/null
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -0,0 +1,85 @@
+/*
+ * mtu3_dr.h - dual role switch and host glue layer header
+ *
+ * Copyright (C) 2016 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _MTU3_DR_H_
+#define _MTU3_DR_H_
+
+#if IS_ENABLED(CONFIG_USB_MTU3_HOST)
+
+int ssusb_host_init(struct ssusb_mtk *ssusb, struct device_node *parent_dn);
+void ssusb_host_exit(struct ssusb_mtk *ssusb);
+int ssusb_wakeup_of_property_parse(struct ssusb_mtk *ssusb,
+				struct device_node *dn);
+int ssusb_host_enable(struct ssusb_mtk *ssusb);
+int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend);
+int ssusb_wakeup_enable(struct ssusb_mtk *ssusb);
+void ssusb_wakeup_disable(struct ssusb_mtk *ssusb);
+
+#else
+
+static inline int ssusb_host_init(struct ssusb_mtk *ssusb,
+
+	struct device_node *parent_dn)
+{
+	return 0;
+}
+
+static inline void ssusb_host_exit(struct ssusb_mtk *ssusb)
+{}
+
+static inline int ssusb_wakeup_of_property_parse(
+	struct ssusb_mtk *ssusb, struct device_node *dn)
+{
+	return 0;
+}
+
+static inline int ssusb_host_enable(struct ssusb_mtk *ssusb)
+{
+	return 0;
+}
+
+static inline int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
+{
+	return 0;
+}
+
+static inline int ssusb_wakeup_enable(struct ssusb_mtk *ssusb)
+{
+	return 0;
+}
+
+static inline void ssusb_wakeup_disable(struct ssusb_mtk *ssusb)
+{}
+
+#endif
+
+
+#if IS_ENABLED(CONFIG_USB_MTU3_GADGET)
+int ssusb_gadget_init(struct ssusb_mtk *ssusb);
+void ssusb_gadget_exit(struct ssusb_mtk *ssusb);
+#else
+static inline int ssusb_gadget_init(struct ssusb_mtk *ssusb)
+{
+	return 0;
+}
+
+static inline void ssusb_gadget_exit(struct ssusb_mtk *ssusb)
+{}
+#endif
+
+#endif		/* _MTU3_DR_H_ */
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
new file mode 100644
index 0000000..361d6d8
--- /dev/null
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -0,0 +1,288 @@
+/*
+ * mtu3_dr.c - dual role switch and host glue layer
+ *
+ * Copyright (C) 2016 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include "mtu3.h"
+#include "mtu3_dr.h"
+
+#define PERI_WK_CTRL1		0x404
+#define UWK_CTL1_IS_C(x)	(((x) & 0xf) << 26)
+#define UWK_CTL1_IS_E		BIT(25)
+#define UWK_CTL1_IDDIG_C(x)	(((x) & 0xf) << 11)  /* cycle debounce */
+#define UWK_CTL1_IDDIG_E	BIT(10) /* enable debounce */
+#define UWK_CTL1_IDDIG_P	BIT(9)  /* polarity */
+#define UWK_CTL1_IS_P		BIT(6)  /* polarity for ip sleep */
+
+/*
+ * ip-sleep wakeup mode:
+ * all clocks can be turn off, but power domain should be kept on
+ */
+static void ssusb_wakeup_ip_sleep_en(struct ssusb_mtk *ssusb)
+{
+	u32 tmp;
+	struct regmap *pericfg = ssusb->pericfg;
+
+	regmap_read(pericfg, PERI_WK_CTRL1, &tmp);
+	tmp &= ~UWK_CTL1_IS_P;
+	tmp &= ~(UWK_CTL1_IS_C(0xf));
+	tmp |= UWK_CTL1_IS_C(0x8);
+	regmap_write(pericfg, PERI_WK_CTRL1, tmp);
+	regmap_write(pericfg, PERI_WK_CTRL1, tmp | UWK_CTL1_IS_E);
+
+	regmap_read(pericfg, PERI_WK_CTRL1, &tmp);
+	dev_dbg(ssusb->dev, "%s(): WK_CTRL1[P6,E25,C26:29]=%#x\n",
+		__func__, tmp);
+}
+
+static void ssusb_wakeup_ip_sleep_dis(struct ssusb_mtk *ssusb)
+{
+	u32 tmp;
+
+	regmap_read(ssusb->pericfg, PERI_WK_CTRL1, &tmp);
+	tmp &= ~UWK_CTL1_IS_E;
+	regmap_write(ssusb->pericfg, PERI_WK_CTRL1, tmp);
+}
+
+int ssusb_wakeup_of_property_parse(struct ssusb_mtk *ssusb,
+				struct device_node *dn)
+{
+	struct device *dev = ssusb->dev;
+
+	/*
+	 * Wakeup function is optional, so it is not an error if this property
+	 * does not exist, and in such case, no need to get relative
+	 * properties anymore.
+	 */
+	ssusb->wakeup_en = of_property_read_bool(dn, "mediatek,enable-wakeup");
+	if (!ssusb->wakeup_en)
+		return 0;
+
+	ssusb->wk_deb_p0 = devm_clk_get(dev, "wakeup_deb_p0");
+	if (IS_ERR(ssusb->wk_deb_p0)) {
+		dev_err(dev, "fail to get wakeup_deb_p0\n");
+		return PTR_ERR(ssusb->wk_deb_p0);
+	}
+
+	if (of_property_read_bool(dn, "wakeup_deb_p1")) {
+		ssusb->wk_deb_p1 = devm_clk_get(dev, "wakeup_deb_p1");
+		if (IS_ERR(ssusb->wk_deb_p1)) {
+			dev_err(dev, "fail to get wakeup_deb_p1\n");
+			return PTR_ERR(ssusb->wk_deb_p1);
+		}
+	}
+
+	ssusb->pericfg = syscon_regmap_lookup_by_phandle(dn,
+						"mediatek,syscon-wakeup");
+	if (IS_ERR(ssusb->pericfg)) {
+		dev_err(dev, "fail to get pericfg regs\n");
+		return PTR_ERR(ssusb->pericfg);
+	}
+
+	return 0;
+}
+
+static int ssusb_wakeup_clks_enable(struct ssusb_mtk *ssusb)
+{
+	int ret;
+
+	ret = clk_prepare_enable(ssusb->wk_deb_p0);
+	if (ret) {
+		dev_err(ssusb->dev, "failed to enable wk_deb_p0\n");
+		goto usb_p0_err;
+	}
+
+	ret = clk_prepare_enable(ssusb->wk_deb_p1);
+	if (ret) {
+		dev_err(ssusb->dev, "failed to enable wk_deb_p1\n");
+		goto usb_p1_err;
+	}
+
+	return 0;
+
+usb_p1_err:
+	clk_disable_unprepare(ssusb->wk_deb_p0);
+usb_p0_err:
+	return -EINVAL;
+}
+
+static void ssusb_wakeup_clks_disable(struct ssusb_mtk *ssusb)
+{
+	clk_disable_unprepare(ssusb->wk_deb_p1);
+	clk_disable_unprepare(ssusb->wk_deb_p0);
+}
+
+static void host_ports_num_get(struct ssusb_mtk *ssusb)
+{
+	u32 xhci_cap;
+
+	xhci_cap = mtu3_readl(ssusb->ippc_base, U3D_SSUSB_IP_XHCI_CAP);
+	ssusb->u2_ports = SSUSB_IP_XHCI_U2_PORT_NUM(xhci_cap);
+	ssusb->u3_ports = SSUSB_IP_XHCI_U3_PORT_NUM(xhci_cap);
+
+	dev_dbg(ssusb->dev, "host - u2_ports:%d, u3_ports:%d\n",
+		 ssusb->u2_ports, ssusb->u3_ports);
+}
+
+/* only configure ports will be used later */
+int ssusb_host_enable(struct ssusb_mtk *ssusb)
+{
+	void __iomem *ibase = ssusb->ippc_base;
+	int num_u3p = ssusb->u3_ports;
+	int num_u2p = ssusb->u2_ports;
+	u32 check_clk;
+	u32 value;
+	int i;
+
+	/* power on host ip */
+	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL1, SSUSB_IP_HOST_PDN);
+
+	/* power on and enable all u3 ports */
+	for (i = 0; i < num_u3p; i++) {
+		value = mtu3_readl(ibase, SSUSB_U3_CTRL(i));
+		value &= ~(SSUSB_U3_PORT_PDN | SSUSB_U3_PORT_DIS);
+		value |= SSUSB_U3_PORT_HOST_SEL;
+		mtu3_writel(ibase, SSUSB_U3_CTRL(i), value);
+	}
+
+	/* power on and enable all u2 ports */
+	for (i = 0; i < num_u2p; i++) {
+		value = mtu3_readl(ibase, SSUSB_U2_CTRL(i));
+		value &= ~(SSUSB_U2_PORT_PDN | SSUSB_U2_PORT_DIS);
+		value |= SSUSB_U2_PORT_HOST_SEL;
+		mtu3_writel(ibase, SSUSB_U2_CTRL(i), value);
+	}
+
+	check_clk = SSUSB_XHCI_RST_B_STS;
+	if (num_u3p)
+		check_clk = SSUSB_U3_MAC_RST_B_STS;
+
+	return ssusb_check_clocks(ssusb, check_clk);
+}
+
+int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
+{
+	void __iomem *ibase = ssusb->ippc_base;
+	int num_u3p = ssusb->u3_ports;
+	int num_u2p = ssusb->u2_ports;
+	u32 value;
+	int ret;
+	int i;
+
+	/* power down and disable all u3 ports */
+	for (i = 0; i < num_u3p; i++) {
+		value = mtu3_readl(ibase, SSUSB_U3_CTRL(i));
+		value |= SSUSB_U3_PORT_PDN;
+		value |= suspend ? 0 : SSUSB_U3_PORT_DIS;
+		mtu3_writel(ibase, SSUSB_U3_CTRL(i), value);
+	}
+
+	/* power down and disable all u2 ports */
+	for (i = 0; i < num_u2p; i++) {
+		value = mtu3_readl(ibase, SSUSB_U2_CTRL(i));
+		value |= SSUSB_U2_PORT_PDN;
+		value |= suspend ? 0 : SSUSB_U2_PORT_DIS;
+		mtu3_writel(ibase, SSUSB_U2_CTRL(i), value);
+	}
+
+	/* power down host ip */
+	mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL1, SSUSB_IP_HOST_PDN);
+
+	if (!suspend)
+		return 0;
+
+	/* wait for host ip to sleep */
+	ret = readl_poll_timeout(ibase + U3D_SSUSB_IP_PW_STS1, value,
+			  (value & SSUSB_IP_SLEEP_STS), 100, 100000);
+	if (ret)
+		dev_err(ssusb->dev, "ip sleep failed!!!\n");
+
+	return ret;
+}
+
+static void ssusb_host_setup(struct ssusb_mtk *ssusb)
+{
+	host_ports_num_get(ssusb);
+
+	/*
+	 * power on host and power on/enable all ports
+	 * if support OTG, gadget driver will switch port0 to device mode
+	 */
+	ssusb_host_enable(ssusb);
+}
+
+static void ssusb_host_cleanup(struct ssusb_mtk *ssusb)
+{
+	ssusb_host_disable(ssusb, false);
+}
+
+/*
+ * If host supports multiple ports, the VBUSes(5V) of ports except port0
+ * which supports OTG are better to be enabled by default in DTS.
+ * Because the host driver will keep link with devices attached when system
+ * enters suspend mode, so no need to control VBUSes after initialization.
+ */
+int ssusb_host_init(struct ssusb_mtk *ssusb, struct device_node *parent_dn)
+{
+	struct device *parent_dev = ssusb->dev;
+	int ret;
+
+	ssusb_host_setup(ssusb);
+
+	ret = of_platform_populate(parent_dn, NULL, NULL, parent_dev);
+	if (ret) {
+		dev_dbg(parent_dev, "failed to create child devices at %s\n",
+				parent_dn->full_name);
+		return ret;
+	}
+
+	dev_info(parent_dev, "xHCI platform device register success...\n");
+
+	return 0;
+}
+
+void ssusb_host_exit(struct ssusb_mtk *ssusb)
+{
+	of_platform_depopulate(ssusb->dev);
+	ssusb_host_cleanup(ssusb);
+}
+
+int ssusb_wakeup_enable(struct ssusb_mtk *ssusb)
+{
+	int ret = 0;
+
+	if (ssusb->wakeup_en) {
+		ret = ssusb_wakeup_clks_enable(ssusb);
+		ssusb_wakeup_ip_sleep_en(ssusb);
+	}
+	return ret;
+}
+
+void ssusb_wakeup_disable(struct ssusb_mtk *ssusb)
+{
+	if (ssusb->wakeup_en) {
+		ssusb_wakeup_ip_sleep_dis(ssusb);
+		ssusb_wakeup_clks_disable(ssusb);
+	}
+}
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 52fc0ed..facb76c 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -21,14 +21,16 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 #include "mtu3.h"
+#include "mtu3_dr.h"
 
 /* u2-port0 should be powered on and enabled; */
-int ssusb_check_clocks(struct mtu3 *mtu, u32 ex_clks)
+int ssusb_check_clocks(struct ssusb_mtk *ssusb, u32 ex_clks)
 {
-	void __iomem *ibase = mtu->ippc_base;
+	void __iomem *ibase = ssusb->ippc_base;
 	u32 value, check_val;
 	int ret;
 
@@ -38,136 +40,209 @@ int ssusb_check_clocks(struct mtu3 *mtu, u32 ex_clks)
 	ret = readl_poll_timeout(ibase + U3D_SSUSB_IP_PW_STS1, value,
 			(check_val == (value & check_val)), 100, 20000);
 	if (ret) {
-		dev_err(mtu->dev, "clks of sts1 are not stable!\n");
+		dev_err(ssusb->dev, "clks of sts1 are not stable!\n");
 		return ret;
 	}
 
 	ret = readl_poll_timeout(ibase + U3D_SSUSB_IP_PW_STS2, value,
 			(value & SSUSB_U2_MAC_SYS_RST_B_STS), 100, 10000);
 	if (ret) {
-		dev_err(mtu->dev, "mac2 clock is not stable\n");
+		dev_err(ssusb->dev, "mac2 clock is not stable\n");
 		return ret;
 	}
 
 	return 0;
 }
 
-static int ssusb_rscs_init(struct mtu3 *mtu)
+static int ssusb_phy_init(struct ssusb_mtk *ssusb)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ssusb->num_phys; i++) {
+		ret = phy_init(ssusb->phys[i]);
+		if (ret)
+			goto exit_phy;
+	}
+	return 0;
+
+exit_phy:
+	for (; i > 0; i--)
+		phy_exit(ssusb->phys[i - 1]);
+
+	return ret;
+}
+
+static int ssusb_phy_exit(struct ssusb_mtk *ssusb)
+{
+	int i;
+
+	for (i = 0; i < ssusb->num_phys; i++)
+		phy_exit(ssusb->phys[i]);
+
+	return 0;
+}
+
+static int ssusb_phy_power_on(struct ssusb_mtk *ssusb)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ssusb->num_phys; i++) {
+		ret = phy_power_on(ssusb->phys[i]);
+		if (ret)
+			goto power_off_phy;
+	}
+	return 0;
+
+power_off_phy:
+	for (; i > 0; i--)
+		phy_power_off(ssusb->phys[i - 1]);
+
+	return ret;
+}
+
+static void ssusb_phy_power_off(struct ssusb_mtk *ssusb)
+{
+	unsigned int i;
+
+	for (i = 0; i < ssusb->num_phys; i++)
+		phy_power_off(ssusb->phys[i]);
+}
+
+static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
 {
 	int ret = 0;
 
-	ret = regulator_enable(mtu->vusb33);
+	ret = regulator_enable(ssusb->vusb33);
 	if (ret) {
-		dev_err(mtu->dev, "failed to enable vusb33\n");
+		dev_err(ssusb->dev, "failed to enable vusb33\n");
 		goto vusb33_err;
 	}
 
-	ret = clk_prepare_enable(mtu->sys_clk);
+	ret = clk_prepare_enable(ssusb->sys_clk);
 	if (ret) {
-		dev_err(mtu->dev, "failed to enable sys_clk\n");
+		dev_err(ssusb->dev, "failed to enable sys_clk\n");
 		goto clk_err;
 	}
 
-	ret = phy_init(mtu->phy);
+	ret = ssusb_phy_init(ssusb);
 	if (ret) {
-		dev_err(mtu->dev, "failed to init phy\n");
+		dev_err(ssusb->dev, "failed to init phy\n");
 		goto phy_init_err;
 	}
 
-	ret = phy_power_on(mtu->phy);
+	ret = ssusb_phy_power_on(ssusb);
 	if (ret) {
-		dev_err(mtu->dev, "failed to power on phy\n");
+		dev_err(ssusb->dev, "failed to power on phy\n");
 		goto phy_err;
 	}
 
 	return 0;
 
 phy_err:
-	phy_exit(mtu->phy);
+	ssusb_phy_exit(ssusb);
 
 phy_init_err:
-	clk_disable_unprepare(mtu->sys_clk);
+	clk_disable_unprepare(ssusb->sys_clk);
 
 clk_err:
-	regulator_disable(mtu->vusb33);
+	regulator_disable(ssusb->vusb33);
 
 vusb33_err:
 
 	return ret;
 }
 
-static void ssusb_rscs_exit(struct mtu3 *mtu)
+static void ssusb_rscs_exit(struct ssusb_mtk *ssusb)
 {
-	clk_disable_unprepare(mtu->sys_clk);
-	regulator_disable(mtu->vusb33);
-	phy_power_off(mtu->phy);
-	phy_exit(mtu->phy);
+	clk_disable_unprepare(ssusb->sys_clk);
+	regulator_disable(ssusb->vusb33);
+	ssusb_phy_power_off(ssusb);
+	ssusb_phy_exit(ssusb);
 }
 
-static void ssusb_ip_sw_reset(struct mtu3 *mtu)
+static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 {
-	mtu3_setbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
+	/* reset whole ip (xhci & u3d) */
+	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
 	udelay(1);
-	mtu3_clrbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
+	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
 }
 
-static int get_ssusb_rscs(struct platform_device *pdev, struct mtu3 *mtu)
+static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	int i;
+	int ret;
 
-	mtu->phy = devm_of_phy_get_by_index(dev, node, 0);
-	if (IS_ERR(mtu->phy)) {
-		dev_err(dev, "failed to get phy\n");
-		return PTR_ERR(mtu->phy);
-	}
-
-	mtu->irq = platform_get_irq(pdev, 0);
-	if (mtu->irq <= 0) {
-		dev_err(dev, "fail to get irq number\n");
-		return -ENODEV;
+	ssusb->num_phys = of_count_phandle_with_args(node,
+			"phys", "#phy-cells");
+	if (ssusb->num_phys > 0) {
+		ssusb->phys = devm_kcalloc(dev, ssusb->num_phys,
+					sizeof(*ssusb->phys), GFP_KERNEL);
+		if (!ssusb->phys)
+			return -ENOMEM;
+	} else {
+		ssusb->num_phys = 0;
 	}
-	dev_info(dev, "irq %d\n", mtu->irq);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mac");
-	mtu->mac_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(mtu->mac_base)) {
-		dev_err(dev, "error mapping memory for dev mac\n");
-		return PTR_ERR(mtu->mac_base);
+	for (i = 0; i < ssusb->num_phys; i++) {
+		ssusb->phys[i] = devm_of_phy_get_by_index(dev, node, i);
+		if (IS_ERR(ssusb->phys[i])) {
+			dev_err(dev, "failed to get phy-%d\n", i);
+			return PTR_ERR(ssusb->phys[i]);
+		}
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ippc");
-	mtu->ippc_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(mtu->ippc_base)) {
+	ssusb->ippc_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ssusb->ippc_base)) {
 		dev_err(dev, "failed to map memory for ippc\n");
-		return PTR_ERR(mtu->ippc_base);
+		return PTR_ERR(ssusb->ippc_base);
 	}
 
-	mtu->vusb33 = devm_regulator_get(&pdev->dev, "vusb33");
-	if (IS_ERR(mtu->vusb33)) {
+	ssusb->vusb33 = devm_regulator_get(&pdev->dev, "vusb33");
+	if (IS_ERR(ssusb->vusb33)) {
 		dev_err(dev, "failed to get vusb33\n");
-		return PTR_ERR(mtu->vusb33);
+		return PTR_ERR(ssusb->vusb33);
 	}
 
-	mtu->sys_clk = devm_clk_get(dev, "sys_ck");
-	if (IS_ERR(mtu->sys_clk)) {
+	ssusb->sys_clk = devm_clk_get(dev, "sys_ck");
+	if (IS_ERR(ssusb->sys_clk)) {
 		dev_err(dev, "failed to get sys clock\n");
-		return PTR_ERR(mtu->sys_clk);
+		return PTR_ERR(ssusb->sys_clk);
+	}
+
+	ssusb->dr_mode = usb_get_dr_mode(dev);
+	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN) {
+		dev_err(dev, "dr_mode is error\n");
+		return -EINVAL;
 	}
 
+	if (ssusb->dr_mode == USB_DR_MODE_PERIPHERAL)
+		return 0;
+
+	/* if host role is supported */
+	ret = ssusb_wakeup_of_property_parse(ssusb, node);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
 static int mtu3_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	struct mtu3 *mtu;
+	struct ssusb_mtk *ssusb;
 	int ret = -ENOMEM;
 
 	/* all elements are set to ZERO as default value */
-	mtu = devm_kzalloc(dev, sizeof(struct mtu3), GFP_KERNEL);
-	if (!mtu)
+	ssusb = devm_kzalloc(dev, sizeof(*ssusb), GFP_KERNEL);
+	if (!ssusb)
 		return -ENOMEM;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -176,11 +251,10 @@ static int mtu3_probe(struct platform_device *pdev)
 		return -ENOTSUPP;
 	}
 
-	platform_set_drvdata(pdev, mtu);
-	mtu->dev = dev;
-	spin_lock_init(&mtu->lock);
+	platform_set_drvdata(pdev, ssusb);
+	ssusb->dev = dev;
 
-	ret = get_ssusb_rscs(pdev, mtu);
+	ret = get_ssusb_rscs(pdev, ssusb);
 	if (ret)
 		return ret;
 
@@ -189,22 +263,45 @@ static int mtu3_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 	device_enable_async_suspend(dev);
 
-	ret = ssusb_rscs_init(mtu);
+	ret = ssusb_rscs_init(ssusb);
 	if (ret)
 		goto comm_init_err;
 
-	ssusb_ip_sw_reset(mtu);
-
-	ret = ssusb_gadget_init(mtu);
-	if (ret) {
-		dev_err(dev, "failed to initialize gadget\n");
+	ssusb_ip_sw_reset(ssusb);
+
+	if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
+		ssusb->dr_mode = USB_DR_MODE_HOST;
+	else if (IS_ENABLED(CONFIG_USB_MTU3_GADGET))
+		ssusb->dr_mode = USB_DR_MODE_PERIPHERAL;
+
+	/* default as host */
+	ssusb->is_host = !(ssusb->dr_mode == USB_DR_MODE_PERIPHERAL);
+
+	switch (ssusb->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		ret = ssusb_gadget_init(ssusb);
+		if (ret) {
+			dev_err(dev, "failed to initialize gadget\n");
+			goto comm_exit;
+		}
+		break;
+	case USB_DR_MODE_HOST:
+		ret = ssusb_host_init(ssusb, node);
+		if (ret) {
+			dev_err(dev, "failed to initialize host\n");
+			goto comm_exit;
+		}
+		break;
+	default:
+		dev_err(dev, "unsupported mode: %d\n", ssusb->dr_mode);
+		ret = -EINVAL;
 		goto comm_exit;
 	}
 
 	return 0;
 
 comm_exit:
-	ssusb_rscs_exit(mtu);
+	ssusb_rscs_exit(ssusb);
 
 comm_init_err:
 	pm_runtime_put_sync(dev);
@@ -215,16 +312,73 @@ static int mtu3_probe(struct platform_device *pdev)
 
 static int mtu3_remove(struct platform_device *pdev)
 {
-	struct mtu3 *mtu = platform_get_drvdata(pdev);
+	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
+
+	switch (ssusb->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		ssusb_gadget_exit(ssusb);
+		break;
+	case USB_DR_MODE_HOST:
+		ssusb_host_exit(ssusb);
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	ssusb_gadget_exit(mtu);
-	ssusb_rscs_exit(mtu);
+	ssusb_rscs_exit(ssusb);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
+/*
+ * when support dual-role mode, we reject suspend when
+ * it works as device mode;
+ */
+static int __maybe_unused mtu3_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	/* REVISIT: disconnect it for only device mode? */
+	if (!ssusb->is_host)
+		return 0;
+
+	ssusb_host_disable(ssusb, true);
+	ssusb_phy_power_off(ssusb);
+	clk_disable_unprepare(ssusb->sys_clk);
+	ssusb_wakeup_enable(ssusb);
+
+	return 0;
+}
+
+static int __maybe_unused mtu3_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (!ssusb->is_host)
+		return 0;
+
+	ssusb_wakeup_disable(ssusb);
+	clk_prepare_enable(ssusb->sys_clk);
+	ssusb_phy_power_on(ssusb);
+	ssusb_host_enable(ssusb);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mtu3_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtu3_suspend, mtu3_resume)
+};
+
+#define DEV_PM_OPS (IS_ENABLED(CONFIG_PM) ? &mtu3_pm_ops : NULL)
+
 #ifdef CONFIG_OF
 
 static const struct of_device_id mtu3_of_match[] = {
@@ -241,6 +395,7 @@ static int mtu3_remove(struct platform_device *pdev)
 	.remove = mtu3_remove,
 	.driver = {
 		.name = MTU3_DRIVER_NAME,
+		.pm = DEV_PM_OPS,
 		.of_match_table = of_match_ptr(mtu3_of_match),
 	},
 };
-- 
1.7.9.5
