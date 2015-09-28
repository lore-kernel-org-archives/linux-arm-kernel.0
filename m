From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Mon, 28 Sep 2015 11:35:03 +0800
Subject: [PATCH v8 3/5] usb: phy: add usb3.0 phy driver for mt65xx SoCs
In-Reply-To: <55FBB24A.2010600@ti.com>
References: <1442385864-4368-1-git-send-email-chunfeng.yun@mediatek.com>
 <1442385864-4368-4-git-send-email-chunfeng.yun@mediatek.com>
 <55FBB24A.2010600@ti.com>
Message-ID: <1443411303.5901.9.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
On Fri, 2015-09-18 at 12:12 +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 16 September 2015 12:14 PM, Chunfeng Yun wrote:
> > support usb3.0 phy of mt65xx SoCs
> few nitpicks:
> 
> change $subject. This driver is no longer in usb directory.
> 
> It can be just "phy: add usb3.0 phy driver for mt65xx SoCs".
Ok

> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/phy/Kconfig           |   9 +
> >  drivers/phy/Makefile          |   1 +
> >  drivers/phy/phy-mt65xx-usb3.c | 456 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 466 insertions(+)
> >  create mode 100644 drivers/phy/phy-mt65xx-usb3.c
> > 
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 47da573..ec436c1 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -206,6 +206,15 @@ config PHY_HIX5HD2_SATA
> >  	help
> >  	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
> >  
> > +config PHY_MT65XX_USB3
> > +	tristate "Mediatek USB3.0 PHY Driver"
> > +	depends on ARCH_MEDIATEK && OF
> > +	select GENERIC_PHY
> > +	help
> > +	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver
> > +	  for mt65xx SoCs. it supports two usb2.0 ports and
> > +	  one usb3.0 port.
> > +
> >  config PHY_SUN4I_USB
> >  	tristate "Allwinner sunxi SoC USB PHY driver"
> >  	depends on ARCH_SUNXI && HAS_IOMEM && OF
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > index a5b18c1..a7cc629 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
> >  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> >  obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
> >  obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
> > +obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
> >  obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
> >  obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
> >  obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
> > diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
> > new file mode 100644
> > index 0000000..1f00b05
> > --- /dev/null
> > +++ b/drivers/phy/phy-mt65xx-usb3.c
> > @@ -0,0 +1,456 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <dt-bindings/phy/phy.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +
> > +/*
> > + * for sifslv2 register, but exclude port's;
> > + * relative to USB3_SIF2_BASE base address
> > + */
> > +#define SSUSB_SIFSLV_SPLLC		0x0000
> > +
> > +/* offsets of sub-segment in each port registers */
> > +#define SSUSB_SIFSLV_U2PHY_COM_BASE	0x0000
> > +#define SSUSB_SIFSLV_U3PHYD_BASE	0x0100
> > +#define SSUSB_USB30_PHYA_SIV_B_BASE	0x0300
> > +#define SSUSB_SIFSLV_U3PHYA_DA_BASE	0x0400
> > +
> > +#define U3P_USBPHYACR0		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0000)
> > +#define PA0_RG_U2PLL_FORCE_ON		BIT(15)
> > +
> > +#define U3P_USBPHYACR2		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0008)
> > +#define PA2_RG_SIF_U2PLL_FORCE_EN	BIT(18)
> > +
> > +#define U3P_USBPHYACR5		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0014)
> > +#define PA5_RG_U2_HSTX_SRCTRL		GENMASK(14, 12)
> > +#define PA5_RG_U2_HSTX_SRCTRL_VAL(x)	((0x7 & (x)) << 12)
> > +#define PA5_RG_U2_HS_100U_U3_EN	BIT(11)
> > +
> > +#define U3P_USBPHYACR6		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0018)
> > +#define PA6_RG_U2_ISO_EN		BIT(31)
> > +#define PA6_RG_U2_BC11_SW_EN		BIT(23)
> > +#define PA6_RG_U2_OTG_VBUSCMP_EN	BIT(20)
> > +
> > +#define U3P_U2PHYACR4		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0020)
> > +#define P2C_RG_USB20_GPIO_CTL		BIT(9)
> > +#define P2C_USB20_GPIO_MODE		BIT(8)
> > +#define P2C_U2_GPIO_CTR_MSK	(P2C_RG_USB20_GPIO_CTL | P2C_USB20_GPIO_MODE)
> > +
> > +#define U3D_U2PHYDCR0		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0060)
> > +#define P2C_RG_SIF_U2PLL_FORCE_ON	BIT(24)
> > +
> > +#define U3P_U2PHYDTM0		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0068)
> > +#define P2C_FORCE_UART_EN		BIT(26)
> > +#define P2C_FORCE_DATAIN		BIT(23)
> > +#define P2C_FORCE_DM_PULLDOWN		BIT(21)
> > +#define P2C_FORCE_DP_PULLDOWN		BIT(20)
> > +#define P2C_FORCE_XCVRSEL		BIT(19)
> > +#define P2C_FORCE_SUSPENDM		BIT(18)
> > +#define P2C_FORCE_TERMSEL		BIT(17)
> > +#define P2C_RG_DATAIN			GENMASK(13, 10)
> > +#define P2C_RG_DATAIN_VAL(x)		((0xf & (x)) << 10)
> > +#define P2C_RG_DMPULLDOWN		BIT(7)
> > +#define P2C_RG_DPPULLDOWN		BIT(6)
> > +#define P2C_RG_XCVRSEL			GENMASK(5, 4)
> > +#define P2C_RG_XCVRSEL_VAL(x)		((0x3 & (x)) << 4)
> > +#define P2C_RG_SUSPENDM			BIT(3)
> > +#define P2C_RG_TERMSEL			BIT(2)
> > +#define P2C_DTM0_PART_MASK \
> > +		(P2C_FORCE_DATAIN | P2C_FORCE_DM_PULLDOWN | \
> > +		P2C_FORCE_DP_PULLDOWN | P2C_FORCE_XCVRSEL | \
> > +		P2C_FORCE_TERMSEL | P2C_RG_DMPULLDOWN | \
> > +		P2C_RG_DPPULLDOWN | P2C_RG_TERMSEL)
> > +
> > +#define U3P_U2PHYDTM1		(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x006C)
> > +#define P2C_RG_UART_EN			BIT(16)
> > +#define P2C_RG_VBUSVALID		BIT(5)
> > +#define P2C_RG_SESSEND			BIT(4)
> > +#define P2C_RG_AVALID			BIT(2)
> > +
> > +#define U3P_U3_PHYA_REG0	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0000)
> > +#define P3A_RG_U3_VUSB10_ON		BIT(5)
> > +
> > +#define U3P_U3_PHYA_REG6	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0018)
> > +#define P3A_RG_TX_EIDLE_CM		GENMASK(31, 28)
> > +#define P3A_RG_TX_EIDLE_CM_VAL(x)	((0xf & (x)) << 28)
> > +
> > +#define U3P_U3_PHYA_REG9	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0024)
> > +#define P3A_RG_RX_DAC_MUX		GENMASK(5, 1)
> > +#define P3A_RG_RX_DAC_MUX_VAL(x)	((0x1f & (x)) << 1)
> > +
> > +#define U3P_U3PHYA_DA_REG0	(SSUSB_SIFSLV_U3PHYA_DA_BASE + 0x0000)
> > +#define P3A_RG_XTAL_EXT_EN_U3		GENMASK(11, 10)
> > +#define P3A_RG_XTAL_EXT_EN_U3_VAL(x)	((0x3 & (x)) << 10)
> > +
> > +#define U3P_PHYD_CDR1		(SSUSB_SIFSLV_U3PHYD_BASE + 0x005c)
> > +#define P3D_RG_CDR_BIR_LTD1		GENMASK(28, 24)
> > +#define P3D_RG_CDR_BIR_LTD1_VAL(x)	((0x1f & (x)) << 24)
> > +#define P3D_RG_CDR_BIR_LTD0		GENMASK(12, 8)
> > +#define P3D_RG_CDR_BIR_LTD0_VAL(x)	((0x1f & (x)) << 8)
> > +
> > +#define U3P_XTALCTL3		(SSUSB_SIFSLV_SPLLC + 0x0018)
> > +#define XC3_RG_U3_XTAL_RX_PWD		BIT(9)
> > +#define XC3_RG_U3_FRC_XTAL_RX_PWD	BIT(8)
> > +
> > +struct mt65xx_phy_instance {
> > +	struct phy *phy;
> > +	void __iomem *port_base;
> > +	u32 index;
> > +	u8 type;
> > +};
> > +
> > +struct mt65xx_u3phy {
> > +	struct device *dev;
> > +	void __iomem *sif_base;	/* include sif2, but exclude port's */
> > +	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
> > +	struct mt65xx_phy_instance **phys;
> > +	int nphys;
> > +};
> > +
> > +static void phy_instance_init(struct mt65xx_u3phy *u3phy,
> > +	struct mt65xx_phy_instance *instance)
> > +{
> > +	void __iomem *port_base = instance->port_base;
> > +	u32 index = instance->index;
> > +	u32 tmp;
> > +
> > +	/* switch to USB function. (system register, force ip into usb mode) */
> > +	tmp = readl(port_base + U3P_U2PHYDTM0);
> > +	tmp &= ~P2C_FORCE_UART_EN;
> > +	writel(tmp, port_base + U3P_U2PHYDTM0);
> > +
> > +	tmp = readl(port_base + U3P_U2PHYDTM1);
> > +	tmp &= ~P2C_RG_UART_EN;
> > +	writel(tmp, port_base + U3P_U2PHYDTM1);
> > +
> > +	if (!index) {
> > +		tmp = readl(port_base + U3P_U2PHYACR4);
> > +		tmp &= ~P2C_U2_GPIO_CTR_MSK;
> > +		writel(tmp, port_base + U3P_U2PHYACR4);
> > +	}
> > +
> > +	/* DP/DM BC1.1 path Disable */
> > +	tmp = readl(port_base + U3P_USBPHYACR6);
> > +	tmp &= ~PA6_RG_U2_BC11_SW_EN;
> > +	writel(tmp, port_base + U3P_USBPHYACR6);
> > +
> > +	tmp = readl(port_base + U3P_U3PHYA_DA_REG0);
> > +	tmp &= ~P3A_RG_XTAL_EXT_EN_U3;
> > +	tmp |= P3A_RG_XTAL_EXT_EN_U3_VAL(2);
> > +	writel(tmp, port_base + U3P_U3PHYA_DA_REG0);
> > +
> > +	tmp = readl(port_base + U3P_U3_PHYA_REG9);
> > +	tmp &= ~P3A_RG_RX_DAC_MUX;
> > +	tmp |= P3A_RG_RX_DAC_MUX_VAL(4);
> > +	writel(tmp, port_base + U3P_U3_PHYA_REG9);
> > +
> > +	tmp = readl(port_base + U3P_U3_PHYA_REG6);
> > +	tmp &= ~P3A_RG_TX_EIDLE_CM;
> > +	tmp |= P3A_RG_TX_EIDLE_CM_VAL(0xe);
> > +	writel(tmp, port_base + U3P_U3_PHYA_REG6);
> > +
> > +	tmp = readl(port_base + U3P_PHYD_CDR1);
> > +	tmp &= ~(P3D_RG_CDR_BIR_LTD0 | P3D_RG_CDR_BIR_LTD1);
> > +	tmp |= P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3);
> > +	writel(tmp, port_base + U3P_PHYD_CDR1);
> > +
> > +	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
> > +}
> > +
> > +static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
> > +	struct mt65xx_phy_instance *instance)
> > +{
> > +	void __iomem *port_base = instance->port_base;
> > +	u32 index = instance->index;
> > +	u32 tmp;
> > +
> > +	if (!index) {
> > +		/* Set RG_SSUSB_VUSB10_ON as 1 after VUSB10 ready */
> > +		tmp = readl(port_base + U3P_U3_PHYA_REG0);
> > +		tmp |= P3A_RG_U3_VUSB10_ON;
> > +		writel(tmp, port_base + U3P_U3_PHYA_REG0);
> > +	}
> > +
> > +	/* (force_suspendm=0) (let suspendm=1, enable usb 480MHz pll) */
> > +	tmp = readl(port_base + U3P_U2PHYDTM0);
> > +	tmp &= ~(P2C_FORCE_SUSPENDM | P2C_RG_XCVRSEL);
> > +	tmp &= ~(P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
> > +	writel(tmp, port_base + U3P_U2PHYDTM0);
> > +
> > +	/* OTG Enable */
> > +	tmp = readl(port_base + U3P_USBPHYACR6);
> > +	tmp |= PA6_RG_U2_OTG_VBUSCMP_EN;
> > +	writel(tmp, port_base + U3P_USBPHYACR6);
> > +
> > +	if (!index) {
> > +		tmp = readl(u3phy->sif_base + U3P_XTALCTL3);
> > +		tmp |= XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD;
> > +		writel(tmp, u3phy->sif_base + U3P_XTALCTL3);
> > +		/* [mt8173]disable Change 100uA current from SSUSB */
> > +		tmp = readl(port_base + U3P_USBPHYACR5);
> > +		tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
> > +		writel(tmp, port_base + U3P_USBPHYACR5);
> > +	}
> > +	udelay(800);
> 
> It's good to document delay values. Is it a recommended value from the
> data manual?
> 
I check it with DE, and revise it after many tests.

> Also now the registers doesn't seem to be shared between the PHYs. But
> if it is then all these functions have to be protected with spinlock.
> 
I will pay attention to it.

Thanks a lot

> Thanks
> Kishon
