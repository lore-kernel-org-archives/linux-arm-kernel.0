From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 22 Jul 2015 22:05:43 +0800
Subject: [PATCH v3 3/5] usb: phy: add usb3.0 phy driver for mt65xx SoCs
In-Reply-To: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1437573945-31586-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support usb3.0 phy of mt65xx SoCs

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/Kconfig           |   9 +
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-mt65xx-usb3.c | 426 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 436 insertions(+)
 create mode 100644 drivers/phy/phy-mt65xx-usb3.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index c0e6ede..019cf8b 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -193,6 +193,15 @@ config PHY_HIX5HD2_SATA
 	help
 	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
 
+config PHY_MT65XX_USB3
+	tristate "Mediatek USB3.0 PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
+	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver
+	  for mt65xx SoCs. it supports two usb2.0 ports and
+	  one usb3.0 port.
+
 config PHY_SUN4I_USB
 	tristate "Allwinner sunxi SoC USB PHY driver"
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f344e1b..3ceff2a 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
 obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
 obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
+obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
 obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
new file mode 100644
index 0000000..5da4534
--- /dev/null
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -0,0 +1,426 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Chunfeng.Yun <chunfeng.yun@mediatek.com>
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
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/resource.h>
+
+/*
+ * for sifslv2 register
+ * relative to USB3_SIF2_BASE base address
+ */
+#define SSUSB_SIFSLV_SPLLC	(0x0000)
+#define SSUSB_SIFSLV_U2PHY_COM_BASE	(0x0800)
+#define SSUSB_SIFSLV_U3PHYD_BASE	(0x0900)
+#define SSUSB_USB30_PHYA_SIV_B_BASE	(0x0b00)
+#define SSUSB_SIFSLV_U3PHYA_DA_BASE	(0x0c00)
+
+/*port1 refs. +0x800(refer to port0)*/
+#define U3P_PORT_INTERVAL (0x800)	/*based on port0 */
+#define U3P_PHY_DELTA(index) ((U3P_PORT_INTERVAL) * (index))
+
+#define U3P_USBPHYACR0	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0000)
+#define PA0_RG_U2PLL_FORCE_ON	(0x1 << 15)
+
+#define U3P_USBPHYACR2	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0008)
+#define PA2_RG_SIF_U2PLL_FORCE_EN	(0x1 << 18)
+
+#define U3P_USBPHYACR5	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0014)
+#define PA5_RG_U2_HSTX_SRCTRL		(0x7 << 12)
+#define PA5_RG_U2_HSTX_SRCTRL_VAL(x)	((0x7 & (x)) << 12)
+#define PA5_RG_U2_HS_100U_U3_EN		(0x1 << 11)
+
+#define U3P_USBPHYACR6	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0018)
+#define PA6_RG_U2_ISO_EN		(0x1 << 31)
+#define PA6_RG_U2_BC11_SW_EN	(0x1 << 23)
+#define PA6_RG_U2_OTG_VBUSCMP_EN	(0x1 << 20)
+
+#define U3P_U2PHYACR4	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0020)
+#define P2C_RG_USB20_GPIO_CTL	(0x1 << 9)
+#define P2C_USB20_GPIO_MODE	(0x1 << 8)
+#define P2C_U2_GPIO_CTR_MSK	(P2C_RG_USB20_GPIO_CTL | P2C_USB20_GPIO_MODE)
+
+#define U3D_U2PHYDCR0	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0060)
+#define P2C_RG_SIF_U2PLL_FORCE_ON	(0x1 << 24)
+
+#define U3P_U2PHYDTM0	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0068)
+#define P2C_FORCE_UART_EN	(0x1 << 26)
+#define P2C_FORCE_DATAIN	(0x1 << 23)
+#define P2C_FORCE_DM_PULLDOWN	(0x1 << 21)
+#define P2C_FORCE_DP_PULLDOWN	(0x1 << 20)
+#define P2C_FORCE_XCVRSEL	(0x1 << 19)
+#define P2C_FORCE_SUSPENDM	(0x1 << 18)
+#define P2C_FORCE_TERMSEL	(0x1 << 17)
+#define P2C_RG_DATAIN		(0xf << 10)
+#define P2C_RG_DATAIN_VAL(x)	((0xf & (x)) << 10)
+#define P2C_RG_DMPULLDOWN	(0x1 << 7)
+#define P2C_RG_DPPULLDOWN	(0x1 << 6)
+#define P2C_RG_XCVRSEL		(0x3 << 4)
+#define P2C_RG_XCVRSEL_VAL(x)	((0x3 & (x)) << 4)
+#define P2C_RG_SUSPENDM		(0x1 << 3)
+#define P2C_RG_TERMSEL		(0x1 << 2)
+#define P2C_DTM0_PART_MASK \
+		(P2C_FORCE_DATAIN | P2C_FORCE_DM_PULLDOWN | \
+		P2C_FORCE_DP_PULLDOWN | P2C_FORCE_XCVRSEL | \
+		P2C_FORCE_TERMSEL | P2C_RG_DMPULLDOWN | \
+		P2C_RG_DPPULLDOWN | P2C_RG_TERMSEL)
+
+#define U3P_U2PHYDTM1	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x006C)
+#define P2C_RG_UART_EN		(0x1 << 16)
+#define P2C_RG_VBUSVALID	(0x1 << 5)
+#define P2C_RG_SESSEND		(0x1 << 4)
+#define P2C_RG_AVALID		(0x1 << 2)
+
+#define U3P_U3_PHYA_REG0	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0000)
+#define P3A_RG_U3_VUSB10_ON	(1 << 5)
+
+#define U3P_U3_PHYA_REG6	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0018)
+#define P3A_RG_TX_EIDLE_CM	(0xf << 28)
+#define P3A_RG_TX_EIDLE_CM_VAL(x)	((0xf & (x)) << 28)
+
+#define U3P_U3_PHYA_REG9	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0024)
+#define P3A_RG_RX_DAC_MUX	(0x1f << 1)
+#define P3A_RG_RX_DAC_MUX_VAL(x)	((0x1f & (x)) << 1)
+
+#define U3P_U3PHYA_DA_REG0	(SSUSB_SIFSLV_U3PHYA_DA_BASE + 0x0)
+#define P3A_RG_XTAL_EXT_EN_U3	(0x3 << 10)
+#define P3A_RG_XTAL_EXT_EN_U3_VAL(x)	((0x3 & (x)) << 10)
+
+#define U3P_PHYD_CDR1	(SSUSB_SIFSLV_U3PHYD_BASE + 0x5c)
+#define P3D_RG_CDR_BIR_LTD1		(0x1f << 24)
+#define P3D_RG_CDR_BIR_LTD1_VAL(x)	((0x1f & (x)) << 24)
+#define P3D_RG_CDR_BIR_LTD0		(0x1f << 8)
+#define P3D_RG_CDR_BIR_LTD0_VAL(x)	((0x1f & (x)) << 8)
+
+#define U3P_XTALCTL3		(SSUSB_SIFSLV_SPLLC + 0x18)
+#define XC3_RG_U3_XTAL_RX_PWD		(0x1 << 9)
+#define XC3_RG_U3_FRC_XTAL_RX_PWD	(0x1 << 8)
+
+#define MT65XX_MAX_PHYS	2
+
+struct mt65xx_phy_instance {
+	struct phy *phy;
+	u32 index;
+	u32 delta; /* increament refers to port0 */
+};
+
+struct mt65xx_u3phy {
+	struct device *dev;
+	void __iomem *sif_base;	/* include sif2 */
+	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
+	struct mt65xx_phy_instance phys[MT65XX_MAX_PHYS];
+};
+
+static struct mt65xx_u3phy *to_usbdrd_phy(
+	struct mt65xx_phy_instance *instance)
+{
+	return container_of((instance), struct mt65xx_u3phy,
+			    phys[(instance)->index]);
+}
+
+static void phy_instance_init(struct mt65xx_phy_instance *instance)
+{
+	struct mt65xx_u3phy *u3phy = to_usbdrd_phy(instance);
+	void __iomem *sif_base = u3phy->sif_base + instance->delta;
+	u32 index = instance->index;
+	u32 tmp;
+
+	/* switch to USB function. (system register, force ip into usb mode) */
+	tmp = readl(sif_base + U3P_U2PHYDTM0);
+	tmp &= ~P2C_FORCE_UART_EN;
+	writel(tmp, sif_base + U3P_U2PHYDTM0);
+
+	tmp = readl(sif_base + U3P_U2PHYDTM1);
+	tmp &= ~P2C_RG_UART_EN;
+	writel(tmp, sif_base + U3P_U2PHYDTM1);
+
+	if (!index) {
+		tmp = readl(sif_base + U3P_U2PHYACR4);
+		tmp &= ~P2C_U2_GPIO_CTR_MSK;
+		writel(tmp, sif_base + U3P_U2PHYACR4);
+	}
+
+	/* DP/DM BC1.1 path Disable */
+	tmp = readl(sif_base + U3P_USBPHYACR6);
+	tmp &= ~PA6_RG_U2_BC11_SW_EN;
+	writel(tmp, sif_base + U3P_USBPHYACR6);
+
+	tmp = readl(sif_base + U3P_U3PHYA_DA_REG0);
+	tmp &= ~P3A_RG_XTAL_EXT_EN_U3;
+	tmp |= P3A_RG_XTAL_EXT_EN_U3_VAL(2);
+	writel(tmp, sif_base + U3P_U3PHYA_DA_REG0);
+
+	tmp = readl(sif_base + U3P_U3_PHYA_REG9);
+	tmp &= ~P3A_RG_RX_DAC_MUX;
+	tmp |= P3A_RG_RX_DAC_MUX_VAL(4);
+	writel(tmp, sif_base + U3P_U3_PHYA_REG9);
+
+	tmp = readl(sif_base + U3P_U3_PHYA_REG6);
+	tmp &= ~P3A_RG_TX_EIDLE_CM;
+	tmp |= P3A_RG_TX_EIDLE_CM_VAL(0xe);
+	writel(tmp, sif_base + U3P_U3_PHYA_REG6);
+
+	tmp = readl(sif_base + U3P_PHYD_CDR1);
+	tmp &= ~(P3D_RG_CDR_BIR_LTD0 | P3D_RG_CDR_BIR_LTD1);
+	tmp |= P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3);
+	writel(tmp, sif_base + U3P_PHYD_CDR1);
+
+	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
+}
+
+static void phy_instance_power_on(struct mt65xx_phy_instance *instance)
+{
+	struct mt65xx_u3phy *u3phy = to_usbdrd_phy(instance);
+	void __iomem *sif_base = u3phy->sif_base + instance->delta;
+	u32 index = instance->index;
+	u32 tmp;
+
+	if (!index) {
+		/* Set RG_SSUSB_VUSB10_ON as 1 after VUSB10 ready */
+		tmp = readl(sif_base + U3P_U3_PHYA_REG0);
+		tmp |= P3A_RG_U3_VUSB10_ON;
+		writel(tmp, sif_base + U3P_U3_PHYA_REG0);
+	}
+
+	/* (force_suspendm=0) (let suspendm=1, enable usb 480MHz pll) */
+	tmp = readl(sif_base + U3P_U2PHYDTM0);
+	tmp &= ~(P2C_FORCE_SUSPENDM | P2C_RG_XCVRSEL);
+	tmp &= ~(P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
+	writel(tmp, sif_base + U3P_U2PHYDTM0);
+
+	/* OTG Enable */
+	tmp = readl(sif_base + U3P_USBPHYACR6);
+	tmp |= PA6_RG_U2_OTG_VBUSCMP_EN;
+	writel(tmp, sif_base + U3P_USBPHYACR6);
+
+	if (!index) {
+		tmp = readl(sif_base + U3P_XTALCTL3);
+		tmp |= XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD;
+		writel(tmp, sif_base + U3P_XTALCTL3);
+		/* [mt8173]disable Change 100uA current from SSUSB */
+		tmp = readl(sif_base + U3P_USBPHYACR5);
+		tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
+		writel(tmp, sif_base + U3P_USBPHYACR5);
+	}
+	udelay(800);
+
+	tmp = readl(sif_base + U3P_U2PHYDTM1);
+	tmp |= P2C_RG_VBUSVALID | P2C_RG_AVALID;
+	tmp &= ~P2C_RG_SESSEND;
+	writel(tmp, sif_base + U3P_U2PHYDTM1);
+	/* USB 2.0 slew rate calibration */
+	tmp = readl(sif_base + U3P_USBPHYACR5);
+	tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
+	tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(4);
+	writel(tmp, sif_base + U3P_USBPHYACR5);
+
+	dev_dbg(u3phy->dev, "%s(%d)(delta: 0x%x)\n", __func__,
+		index, u3phy->phys[index].delta);
+}
+
+static void phy_instance_power_off(struct mt65xx_phy_instance *instance)
+{
+	struct mt65xx_u3phy *u3phy = to_usbdrd_phy(instance);
+	void __iomem *sif_base = u3phy->sif_base + instance->delta;
+	u32 index = instance->index;
+	u32 tmp;
+
+	tmp = readl(sif_base + U3P_U2PHYDTM0);
+	tmp &= ~(P2C_RG_XCVRSEL | P2C_RG_DATAIN);
+	tmp |= P2C_RG_XCVRSEL_VAL(1) | P2C_RG_DATAIN_VAL(0);
+	tmp |= P2C_FORCE_SUSPENDM;
+	writel(tmp, sif_base + U3P_U2PHYDTM0);
+
+	/* OTG Disable */
+	tmp = readl(sif_base + U3P_USBPHYACR6);
+	tmp &= ~PA6_RG_U2_OTG_VBUSCMP_EN;
+	writel(tmp, sif_base + U3P_USBPHYACR6);
+	if (!index) {
+		/* (also disable)Change 100uA current switch to USB2.0 */
+		tmp = readl(sif_base + U3P_USBPHYACR5);
+		tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
+		writel(tmp, sif_base + U3P_USBPHYACR5);
+	}
+	udelay(800);
+
+	/* let suspendm=0, set utmi into analog power down */
+	tmp = readl(sif_base + U3P_U2PHYDTM0);
+	tmp &= ~P2C_RG_SUSPENDM;
+	writel(tmp, sif_base + U3P_U2PHYDTM0);
+	udelay(1);
+
+	tmp = readl(sif_base + U3P_U2PHYDTM1);
+	tmp &= ~(P2C_RG_VBUSVALID | P2C_RG_AVALID);
+	tmp |= P2C_RG_SESSEND;
+	writel(tmp, sif_base + U3P_U2PHYDTM1);
+
+	if (!index) {
+		tmp = readl(sif_base + U3P_U3_PHYA_REG0);
+		tmp &= ~P3A_RG_U3_VUSB10_ON;
+		writel(tmp, sif_base + U3P_U3_PHYA_REG0);
+	}
+
+	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
+}
+
+static int u3phy_clk_enable(struct mt65xx_u3phy *u3phy)
+{
+	int ret;
+
+	ret = clk_prepare_enable(u3phy->u3phya_ref);
+	if (ret) {
+		dev_err(u3phy->dev, "failed to enable u3phya_ref\n");
+		return ret;
+	}
+	udelay(100);
+
+	return 0;
+}
+
+static int mt65xx_phy_init(struct phy *phy)
+{
+	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
+
+	phy_instance_init(instance);
+	return 0;
+}
+
+static int mt65xx_phy_power_on(struct phy *phy)
+{
+	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
+
+	phy_instance_power_on(instance);
+	msleep(20);
+	return 0;
+}
+
+static int mt65xx_phy_power_off(struct phy *phy)
+{
+	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
+
+	phy_instance_power_off(instance);
+	return 0;
+}
+
+static struct phy *mt65xx_phy_xlate(struct device *dev,
+					struct of_phandle_args *args)
+{
+	struct mt65xx_u3phy *u3phy = dev_get_drvdata(dev);
+
+	if (WARN_ON(args->args[0] > MT65XX_MAX_PHYS))
+		return ERR_PTR(-ENODEV);
+
+	return u3phy->phys[args->args[0]].phy;
+}
+
+static struct phy_ops mt65xx_u3phy_ops = {
+	.init		= mt65xx_phy_init,
+	.power_on	= mt65xx_phy_power_on,
+	.power_off	= mt65xx_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id mt65xx_u3phy_id_table[] = {
+	{ .compatible = "mediatek,mt8173-u3phy",},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mt65xx_u3phy_id_table);
+
+
+static int mt65xx_u3phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *sif_res;
+	struct mt65xx_u3phy *u3phy;
+	int i;
+
+	u3phy = devm_kzalloc(dev, sizeof(*u3phy), GFP_KERNEL);
+	if (!u3phy)
+		return -ENOMEM;
+
+	u3phy->dev = dev;
+	platform_set_drvdata(pdev, u3phy);
+
+	sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	u3phy->sif_base = devm_ioremap_resource(dev, sif_res);
+	if (IS_ERR(u3phy->sif_base)) {
+		dev_err(dev, "failed to remap sif regs\n");
+		return PTR_ERR(u3phy->sif_base);
+	}
+
+	u3phy->u3phya_ref = devm_clk_get(dev, "u3phya_ref");
+	if (IS_ERR(u3phy->u3phya_ref)) {
+		dev_err(dev, "error to get u3phya_ref\n");
+		return PTR_ERR(u3phy->u3phya_ref);
+	}
+
+	for (i = 0; i < MT65XX_MAX_PHYS; i++) {
+		struct mt65xx_phy_instance *instance;
+		struct phy *phy;
+
+		phy = devm_phy_create(dev, NULL, &mt65xx_u3phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create mt65xx_u3phy phy\n");
+			return PTR_ERR(phy);
+		}
+		instance = &u3phy->phys[i];
+		instance->phy = phy;
+		instance->index = i;
+		instance->delta = U3P_PHY_DELTA(i);
+		phy_set_drvdata(phy, instance);
+	}
+
+	phy_provider = devm_of_phy_provider_register(dev, mt65xx_phy_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "Failed to register phy provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	return u3phy_clk_enable(u3phy);
+}
+
+static int mt65xx_u3phy_remove(struct platform_device *pdev)
+{
+	struct mt65xx_u3phy *u3phy = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(u3phy->u3phya_ref);
+
+	return 0;
+}
+
+static struct platform_driver mt65xx_u3phy_driver = {
+	.probe		= mt65xx_u3phy_probe,
+	.remove		= mt65xx_u3phy_remove,
+	.driver		= {
+		.name	= "mt65xx-u3phy",
+		.of_match_table = mt65xx_u3phy_id_table,
+	},
+};
+
+module_platform_driver(mt65xx_u3phy_driver);
+
+MODULE_DESCRIPTION("Mt65xx USB PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.1.1.dirty
