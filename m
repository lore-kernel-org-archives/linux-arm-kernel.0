From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:33 -0400
Subject: [PATCh V10 02/12] usb: phy: mv_usb2: add PHY driver for marvell usb2
 controller
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY is seperated from usb controller.
The usb controller used in marvell pxa168/pxa910/mmp2 are same,
but PHY initialization may be different.
the usb controller can support udc/otg/ehci, and for each of
the mode, it need PHY to initialized before use the controller.
Direclty writing the phy driver will make the usb controller
driver to be simple and portable.
The PHY driver will be used by marvell udc/otg/ehci.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/phy/Kconfig       |    9 +
 drivers/usb/phy/Makefile      |    1 +
 drivers/usb/phy/phy-mv-usb2.c |  379 +++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/mv_usb2.h   |   29 +++
 4 files changed, 418 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/phy/phy-mv-usb2.c
 create mode 100644 include/linux/usb/mv_usb2.h

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 372db48..9c03da1 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -170,6 +170,15 @@ config USB_MV_OTG
 
 	  To compile this driver as a module, choose M here.
 
+config MV_USB2_PHY
+	tristate "Marvell USB 2.0 PHY Driver"
+	help
+	  Enable this to support Marvell USB 2.0 PHY driver for Marvell
+	  SoC. This driver will do the PHY initialization and shutdown.
+	  The PHY driver will be used by Marvell udc/ehci/otg driver.
+
+	  To compile this driver as a module, choose M here.
+
 config USB_MXS_PHY
 	tristate "Freescale MXS USB PHY support"
 	depends on ARCH_MXC || ARCH_MXS
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 33863c0..90cc5f5 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_USB_EHCI_TEGRA)		+= phy-tegra-usb.o
 obj-$(CONFIG_USB_GPIO_VBUS)		+= phy-gpio-vbus-usb.o
 obj-$(CONFIG_USB_ISP1301)		+= phy-isp1301.o
 obj-$(CONFIG_USB_MSM_OTG)		+= phy-msm-usb.o
+obj-$(CONFIG_MV_USB2_PHY)		+= phy-mv-usb2.o
 obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
 obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
 obj-$(CONFIG_USB_RCAR_PHY)		+= phy-rcar-usb.o
diff --git a/drivers/usb/phy/phy-mv-usb2.c b/drivers/usb/phy/phy-mv-usb2.c
new file mode 100644
index 0000000..43459ef
--- /dev/null
+++ b/drivers/usb/phy/phy-mv-usb2.c
@@ -0,0 +1,379 @@
+/*
+ * Copyright (C) 2013 Marvell Inc.
+ *
+ * Author:
+ *	Chao Xie <xiechao.mail@gmail.com>
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
+#include <linux/resource.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/mv_usb.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/mv_usb2.h>
+
+/* phy regs */
+/* for pxa910 and mmp2, there is no revision register */
+#define MV_USB2_UTMI_REVISION		0x0
+#define MV_USB2_UTMI_CTRL		0x4
+#define MV_USB2_UTMI_PLL		0x8
+#define MV_USB2_UTMI_TX			0xc
+#define MV_USB2_UTMI_RX			0x10
+#define MV_USB2_UTMI_IVREF		0x14
+#define MV_USB2_UTMI_T0			0x18
+#define MV_USB2_UTMI_T1			0x1c
+#define MV_USB2_UTMI_T2			0x20
+#define MV_USB2_UTMI_T3			0x24
+#define MV_USB2_UTMI_T4			0x28
+#define MV_USB2_UTMI_T5			0x2c
+#define MV_USB2_UTMI_RESERVE		0x30
+#define MV_USB2_UTMI_USB_INT		0x34
+#define MV_USB2_UTMI_DBG_CTL		0x38
+#define MV_USB2_UTMI_OTG_ADDON		0x3c
+
+/* For UTMICTRL Register */
+#define MV_USB2_UTMI_CTRL_USB_CLK_EN			(1 << 31)
+/* pxa168 */
+#define MV_USB2_UTMI_CTRL_SUSPEND_SET1			(1 << 30)
+#define MV_USB2_UTMI_CTRL_SUSPEND_SET2			(1 << 29)
+#define MV_USB2_UTMI_CTRL_RXBUF_PDWN			(1 << 24)
+#define MV_USB2_UTMI_CTRL_TXBUF_PDWN			(1 << 11)
+
+#define MV_USB2_UTMI_CTRL_INPKT_DELAY_SHIFT		30
+#define MV_USB2_UTMI_CTRL_INPKT_DELAY_SOF_SHIFT		28
+#define MV_USB2_UTMI_CTRL_PU_REF_SHIFT			20
+#define MV_USB2_UTMI_CTRL_ARC_PULLDN_SHIFT		12
+#define MV_USB2_UTMI_CTRL_PLL_PWR_UP_SHIFT		1
+#define MV_USB2_UTMI_CTRL_PWR_UP_SHIFT			0
+
+/* For UTMI_PLL Register */
+#define MV_USB2_UTMI_PLL_PLLCALI12_SHIFT		29
+#define MV_USB2_UTMI_PLL_PLLCALI12_MASK			(0x3 << 29)
+
+#define MV_USB2_UTMI_PLL_PLLVDD18_SHIFT			27
+#define MV_USB2_UTMI_PLL_PLLVDD18_MASK			(0x3 << 27)
+
+#define MV_USB2_UTMI_PLL_PLLVDD12_SHIFT			25
+#define MV_USB2_UTMI_PLL_PLLVDD12_MASK			(0x3 << 25)
+
+#define MV_USB2_UTMI_PLL_PLL_READY			(0x1 << 23)
+#define MV_USB2_UTMI_PLL_KVCO_EXT			(0x1 << 22)
+#define MV_USB2_UTMI_PLL_VCOCAL_START			(0x1 << 21)
+
+#define MV_USB2_UTMI_PLL_KVCO_SHIFT			15
+#define MV_USB2_UTMI_PLL_KVCO_MASK			(0x7 << 15)
+
+#define MV_USB2_UTMI_PLL_ICP_SHIFT			12
+#define MV_USB2_UTMI_PLL_ICP_MASK			(0x7 << 12)
+
+#define MV_USB2_UTMI_PLL_FBDIV_SHIFT			4
+#define MV_USB2_UTMI_PLL_FBDIV_MASK			(0xFF << 4)
+
+#define MV_USB2_UTMI_PLL_REFDIV_SHIFT			0
+#define MV_USB2_UTMI_PLL_REFDIV_MASK			(0xF << 0)
+
+/* For UTMI_TX Register */
+#define MV_USB2_UTMI_TX_REG_EXT_FS_RCAL_SHIFT		27
+#define MV_USB2_UTMI_TX_REG_EXT_FS_RCAL_MASK		(0xf << 27)
+
+#define MV_USB2_UTMI_TX_REG_EXT_FS_RCAL_EN_SHIFT	26
+#define MV_USB2_UTMI_TX_REG_EXT_FS_RCAL_EN_MASK		(0x1 << 26)
+
+#define MV_USB2_UTMI_TX_TXVDD12_SHIFT			22
+#define MV_USB2_UTMI_TX_TXVDD12_MASK			(0x3 << 22)
+
+#define MV_USB2_UTMI_TX_CK60_PHSEL_SHIFT		17
+#define MV_USB2_UTMI_TX_CK60_PHSEL_MASK			(0xf << 17)
+
+#define MV_USB2_UTMI_TX_IMPCAL_VTH_SHIFT		14
+#define MV_USB2_UTMI_TX_IMPCAL_VTH_MASK			(0x7 << 14)
+
+#define MV_USB2_UTMI_TX_REG_RCAL_START			(0x1 << 12)
+
+#define MV_USB2_UTMI_TX_LOW_VDD_EN_SHIFT		11
+
+#define MV_USB2_UTMI_TX_AMP_SHIFT			0
+#define MV_USB2_UTMI_TX_AMP_MASK			(0x7 << 0)
+
+/* For UTMI_RX Register */
+#define MV_USB2_UTMI_RX_REG_SQ_LENGTH_SHIFT		15
+#define MV_USB2_UTMI_RX_REG_SQ_LENGTH_MASK		(0x3 << 15)
+
+#define MV_USB2_UTMI_RX_SQ_THRESH_SHIFT			4
+#define MV_USB2_UTMI_RX_SQ_THRESH_MASK			(0xf << 4)
+
+/* For UTMI_OTG_ADDON Register. Only for pxa168 */
+#define MV_USB2_UTMI_OTG_ADDON_OTG_ON			(1 << 0)
+
+enum mv_usb2_phy_type {
+	PXA168_USB,
+	PXA910_USB,
+	MMP2_USB,
+};
+
+static int _mv_usb2_phy_init(struct mv_usb2_phy *mv_phy)
+{
+	struct platform_device *pdev = mv_phy->pdev;
+	unsigned int loops = 0;
+	void __iomem *base = mv_phy->base;
+	unsigned int val;
+
+	val = readl(base + MV_USB2_UTMI_CTRL);
+	/* Initialize the USB PHY power */
+	if (mv_phy->type == PXA910_USB) {
+		val |= (1 << MV_USB2_UTMI_CTRL_INPKT_DELAY_SOF_SHIFT)
+			| (1 << MV_USB2_UTMI_CTRL_PU_REF_SHIFT);
+	}
+
+	val |= (1 << MV_USB2_UTMI_CTRL_PLL_PWR_UP_SHIFT)
+		| (1 << MV_USB2_UTMI_CTRL_PWR_UP_SHIFT);
+	writel(val, base + MV_USB2_UTMI_CTRL);
+
+	/* UTMI_PLL settings */
+	val = readl(base + MV_USB2_UTMI_PLL);
+	val &= ~(MV_USB2_UTMI_PLL_PLLVDD18_MASK
+		| MV_USB2_UTMI_PLL_PLLVDD12_MASK
+		| MV_USB2_UTMI_PLL_PLLCALI12_MASK
+		| MV_USB2_UTMI_PLL_FBDIV_MASK
+		| MV_USB2_UTMI_PLL_REFDIV_MASK
+		| MV_USB2_UTMI_PLL_ICP_MASK
+		| MV_USB2_UTMI_PLL_KVCO_MASK
+		| MV_USB2_UTMI_PLL_VCOCAL_START);
+
+	val |= (0xee << MV_USB2_UTMI_PLL_FBDIV_SHIFT)
+		| (0xb << MV_USB2_UTMI_PLL_REFDIV_SHIFT)
+		| (3 << MV_USB2_UTMI_PLL_PLLVDD18_SHIFT)
+		| (3 << MV_USB2_UTMI_PLL_PLLVDD12_SHIFT)
+		| (3 << MV_USB2_UTMI_PLL_PLLCALI12_SHIFT)
+		| (1 << MV_USB2_UTMI_PLL_ICP_SHIFT)
+		| (3 << MV_USB2_UTMI_PLL_KVCO_SHIFT);
+	writel(val, base + MV_USB2_UTMI_PLL);
+
+	/* UTMI_TX */
+	val = readl(base + MV_USB2_UTMI_TX);
+	val &= ~(MV_USB2_UTMI_TX_REG_EXT_FS_RCAL_EN_MASK
+		| MV_USB2_UTMI_TX_TXVDD12_MASK
+		| MV_USB2_UTMI_TX_CK60_PHSEL_MASK
+		| MV_USB2_UTMI_TX_IMPCAL_VTH_MASK
+		| MV_USB2_UTMI_TX_REG_EXT_FS_RCAL_MASK
+		| MV_USB2_UTMI_TX_AMP_MASK
+		| MV_USB2_UTMI_TX_REG_RCAL_START);
+	val |= (3 << MV_USB2_UTMI_TX_TXVDD12_SHIFT)
+		| (4 << MV_USB2_UTMI_TX_CK60_PHSEL_SHIFT)
+		| (4 << MV_USB2_UTMI_TX_IMPCAL_VTH_SHIFT)
+		| (8 << MV_USB2_UTMI_TX_REG_EXT_FS_RCAL_SHIFT)
+		| (3 << MV_USB2_UTMI_TX_AMP_SHIFT);
+	writel(val, base + MV_USB2_UTMI_TX);
+
+	/* UTMI_RX */
+	val = readl(base + MV_USB2_UTMI_RX);
+	val &= ~(MV_USB2_UTMI_RX_SQ_THRESH_MASK
+		| MV_USB2_UTMI_RX_REG_SQ_LENGTH_MASK);
+	val |= (7 << MV_USB2_UTMI_RX_SQ_THRESH_SHIFT)
+		| (2 << MV_USB2_UTMI_RX_REG_SQ_LENGTH_SHIFT);
+	writel(val, base + MV_USB2_UTMI_RX);
+
+	/* UTMI_IVREF */
+	if (mv_phy->type == PXA168_USB)
+		/*
+		 * Fixing Microsoft Altair board interface with NEC hub issue -
+		 * Set UTMI_IVREF from 0x4a3 to 0x4bf.
+		 */
+		writel(0x4bf, base + MV_USB2_UTMI_IVREF);
+
+	/*
+	 * Toggle VCOCAL_START bit of UTMI_PLL. It is active at rising edge.
+	 * It is low level by UTMI_PLL initialization above.
+	 */
+	val = readl(base + MV_USB2_UTMI_PLL);
+	/*
+	 * Delay 200us for low level, and 40us for high level.
+	 * Make sure we can get a effective rising edege.
+	 * It should be set to low after issue rising edge.
+	 * The delay value is suggested by DE.
+	 */
+	usleep_range(200, 300);
+	val |= MV_USB2_UTMI_PLL_VCOCAL_START;
+	writel(val, base + MV_USB2_UTMI_PLL);
+	usleep_range(40, 50);
+	val &= ~MV_USB2_UTMI_PLL_VCOCAL_START;
+	writel(val, base + MV_USB2_UTMI_PLL);
+
+	/*
+	 * Toggle REG_RCAL_START bit of UTMI_TX.
+	 * it is low level by UTMI_TX initialization above.
+	 */
+	val = readl(base + MV_USB2_UTMI_TX);
+	/* same as VCOCAL_START, except it is triggered by low->high->low */
+	usleep_range(400, 500);
+	val |= MV_USB2_UTMI_TX_REG_RCAL_START;
+	writel(val, base + MV_USB2_UTMI_TX);
+	usleep_range(40, 50);
+	val &= ~MV_USB2_UTMI_TX_REG_RCAL_START;
+	writel(val, base + MV_USB2_UTMI_TX);
+	usleep_range(400, 500);
+
+	/* Make sure PHY PLL is ready */
+	loops = 0;
+	while (1) {
+		val = readl(base + MV_USB2_UTMI_PLL);
+		if (val & MV_USB2_UTMI_PLL_PLL_READY)
+			break;
+		usleep_range(1000, 1100);
+		loops++;
+		if (loops > 100) {
+			dev_warn(&pdev->dev, "calibrate timeout, UTMI_PLL %x\n",
+				 readl(base + MV_USB2_UTMI_PLL));
+			return -ETIME;
+		}
+	}
+
+	if (mv_phy->type == PXA168_USB) {
+		val = readl(base + MV_USB2_UTMI_RESERVE);
+		val |= (1 << 5);
+		writel(val, base + MV_USB2_UTMI_RESERVE);
+		/* Turn on UTMI PHY OTG extension */
+		writel(MV_USB2_UTMI_OTG_ADDON_OTG_ON,
+		       base + MV_USB2_UTMI_OTG_ADDON);
+	}
+
+	return 0;
+}
+
+static int _mv_usb2_phy_shutdown(struct mv_usb2_phy *mv_phy)
+{
+	void __iomem *base = mv_phy->base;
+	unsigned int val;
+
+	if (mv_phy->type == PXA168_USB)
+		writel(0, base + MV_USB2_UTMI_OTG_ADDON);
+
+	val = readl(base + MV_USB2_UTMI_CTRL);
+	val &= ~(MV_USB2_UTMI_CTRL_RXBUF_PDWN
+		| MV_USB2_UTMI_CTRL_TXBUF_PDWN
+		| MV_USB2_UTMI_CTRL_USB_CLK_EN
+		| (1 << MV_USB2_UTMI_CTRL_PWR_UP_SHIFT)
+		| (1 << MV_USB2_UTMI_CTRL_PLL_PWR_UP_SHIFT));
+
+	writel(val, base + MV_USB2_UTMI_CTRL);
+
+	return 0;
+}
+
+static int mv_usb2_phy_init(struct usb_phy *phy)
+{
+	struct mv_usb2_phy *mv_phy = container_of(phy, struct mv_usb2_phy, phy);
+
+	clk_prepare_enable(mv_phy->clk);
+	_mv_usb2_phy_init(mv_phy);
+
+	return 0;
+}
+
+static void mv_usb2_phy_shutdown(struct usb_phy *phy)
+{
+	struct mv_usb2_phy *mv_phy = container_of(phy, struct mv_usb2_phy, phy);
+
+	_mv_usb2_phy_shutdown(mv_phy);
+	clk_disable_unprepare(mv_phy->clk);
+}
+
+static int mv_usb2_phy_probe(struct platform_device *pdev)
+{
+	struct mv_usb2_phy *mv_phy;
+	struct resource *r;
+	const struct platform_device_id *id;
+
+	mv_phy = devm_kzalloc(&pdev->dev, sizeof(*mv_phy), GFP_KERNEL);
+	if (mv_phy == NULL) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	id = platform_get_device_id(pdev);
+
+	if (id == NULL) {
+		dev_err(&pdev->dev, "missing id_entry\n");
+		return -ENODEV;
+	}
+
+	mv_phy->type = (unsigned int)(id->driver_data);
+	mv_phy->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mv_phy->clk)) {
+		dev_err(&pdev->dev, "failed to get clock.\n");
+		return PTR_ERR(mv_phy->clk);
+	}
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
+		return -ENODEV;
+	}
+	mv_phy->base = devm_ioremap_resource(&pdev->dev, r);
+	if (mv_phy->base == NULL) {
+		dev_err(&pdev->dev, "error map register base\n");
+		return -EBUSY;
+	}
+
+	mv_phy->phy.dev = &pdev->dev;
+	mv_phy->phy.label = "mv-usb2";
+	mv_phy->phy.type = USB_PHY_TYPE_USB2;
+	mv_phy->phy.init = mv_usb2_phy_init;
+	mv_phy->phy.shutdown = mv_usb2_phy_shutdown;
+
+	usb_add_phy_dev(&mv_phy->phy);
+
+	platform_set_drvdata(pdev, mv_phy);
+
+	return 0;
+}
+
+static int mv_usb2_phy_remove(struct platform_device *pdev)
+{
+	struct mv_usb2_phy *mv_phy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&mv_phy->phy);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_device_id mv_usb2_phy_ids[] = {
+	{ .name = "pxa168-usb-phy",	.driver_data = PXA168_USB },
+	{ .name = "pxa910-usb-phy",	.driver_data = PXA910_USB },
+	{ .name = "mmp2-usb-phy",	.driver_data = MMP2_USB },
+	{}
+};
+
+static struct platform_driver mv_usb2_phy_driver = {
+	.probe	= mv_usb2_phy_probe,
+	.remove = mv_usb2_phy_remove,
+	.driver = {
+		.name   = "pxa168-usb-phy",
+	},
+	.id_table = mv_usb2_phy_ids,
+};
+
+module_platform_driver(mv_usb2_phy_driver);
+MODULE_ALIAS("platform: mv_usb2");
+MODULE_AUTHOR("Marvell Inc.");
+MODULE_DESCRIPTION("Marvell USB2 phy driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/usb/mv_usb2.h b/include/linux/usb/mv_usb2.h
new file mode 100644
index 0000000..dfabd4e
--- /dev/null
+++ b/include/linux/usb/mv_usb2.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2013 Marvell Inc.
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
+#ifndef __MV_USB2_H
+#define __MV_USB2_H
+
+#define MV_USB2_PHY_INDEX	0
+#define MV_USB2_OTG_PHY_INDEX	1
+
+struct mv_usb2_phy {
+	struct usb_phy		phy;
+	struct platform_device	*pdev;
+	unsigned int		type;
+	void __iomem		*base;
+	struct clk		*clk;
+};
+
+#endif
-- 
1.7.4.1
