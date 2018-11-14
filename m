From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 14 Nov 2018 14:12:12 +0530
Subject: [RFC PATCH 2/6] phy: armada38x: add common phy support
In-Reply-To: <E1gMBMi-00089Q-7S@rmk-PC.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMi-00089Q-7S@rmk-PC.armlinux.org.uk>
Message-ID: <d2ff255b-556e-cafa-4134-08c86b915add@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/11/18 6:00 PM, Russell King wrote:
> Add support for the Armada 38x common phy to allow us to change the
> speed of the Ethernet serdes lane.  This driver only supports
> manipulation of the speed, it does not support configuration of the
> common phy.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/phy/marvell/Kconfig                |  10 ++
>  drivers/phy/marvell/Makefile               |   1 +
>  drivers/phy/marvell/phy-armada38x-comphy.c | 236 +++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)
>  create mode 100644 drivers/phy/marvell/phy-armada38x-comphy.c
> 
> diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
> index 6fb4b56e4c14..224ea4e6a46d 100644
> --- a/drivers/phy/marvell/Kconfig
> +++ b/drivers/phy/marvell/Kconfig
> @@ -21,6 +21,16 @@ config PHY_BERLIN_USB
>  	help
>  	  Enable this to support the USB PHY on Marvell Berlin SoCs.
>  
> +config PHY_MVEBU_A38X_COMPHY
> +	tristate "Marvell Armada 38x comphy driver"
> +	depends on ARCH_MVEBU || COMPILE_TEST
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  This driver allows to control the comphy, an hardware block providing
> +	  shared serdes PHYs on Marvell Armada 38x. Its serdes lanes can be
> +	  used by various controllers (Ethernet, sata, usb, PCIe...).
> +
>  config PHY_MVEBU_CP110_COMPHY
>  	tristate "Marvell CP110 comphy driver"
>  	depends on ARCH_MVEBU || COMPILE_TEST
> diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
> index 3975b144f8ec..59b6c03ef756 100644
> --- a/drivers/phy/marvell/Makefile
> +++ b/drivers/phy/marvell/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
>  obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
>  obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
> +obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
>  obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
>  obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
>  obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
> diff --git a/drivers/phy/marvell/phy-armada38x-comphy.c b/drivers/phy/marvell/phy-armada38x-comphy.c
> new file mode 100644
> index 000000000000..61d1965e1cf6
> --- /dev/null
> +++ b/drivers/phy/marvell/phy-armada38x-comphy.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Russell King, Deep Blue Solutions Ltd.
> + *
> + * Partly derived from CP110 comphy driver by Antoine Tenart
> + * <antoine.tenart@bootlin.com>
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +#define MAX_A38X_COMPHY	6
> +#define MAX_A38X_PORTS	3
> +
> +#define COMPHY_CFG1		0x00
> +#define  COMPHY_CFG1_GEN_TX(x)		((x) << 26)
> +#define  COMPHY_CFG1_GEN_TX_MSK		COMPHY_CFG1_GEN_TX(15)
> +#define  COMPHY_CFG1_GEN_RX(x)		((x) << 22)
> +#define  COMPHY_CFG1_GEN_RX_MSK		COMPHY_CFG1_GEN_RX(15)
> +#define  GEN_SGMII_1_25GBPS		6
> +#define  GEN_SGMII_3_125GBPS		8
> +
> +#define COMPHY_STAT1		0x18
> +#define  COMPHY_STAT1_PLL_RDY_TX	BIT(3)
> +#define  COMPHY_STAT1_PLL_RDY_RX	BIT(2)
> +
> +#define COMPHY_SELECTOR		0xfc
> +
> +struct a38x_comphy;
> +
> +struct a38x_comphy_lane {
> +	void __iomem *base;
> +	struct a38x_comphy *priv;
> +	unsigned int n;
> +
> +	int port;
> +};
> +
> +struct a38x_comphy {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct a38x_comphy_lane lane[MAX_A38X_COMPHY];
> +};
> +
> +static const u8 gbe_mux[MAX_A38X_COMPHY][MAX_A38X_PORTS] = {
> +	{ 0, 0, 0 },
> +	{ 4, 5, 0 },
> +	{ 0, 4, 0 },
> +	{ 0, 0, 4 },
> +	{ 0, 3, 0 },
> +	{ 0, 0, 3 },
> +};
> +
> +static void a38x_comphy_set_reg(struct a38x_comphy_lane *lane,
> +				unsigned int offset, u32 mask, u32 value)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(lane->base + offset) & ~mask;
> +	writel(val | value, lane->base + offset);
> +}
> +
> +static void a38x_comphy_set_speed(struct a38x_comphy_lane *lane,
> +				  unsigned int gen_tx, unsigned int gen_rx)
> +{
> +	a38x_comphy_set_reg(lane, COMPHY_CFG1,
> +			    COMPHY_CFG1_GEN_TX_MSK | COMPHY_CFG1_GEN_RX_MSK,
> +			    COMPHY_CFG1_GEN_TX(gen_tx) |
> +		            COMPHY_CFG1_GEN_RX(gen_rx));
> +}
> +
> +static int a38x_comphy_poll(struct a38x_comphy_lane *lane,
> +			    unsigned int offset, u32 mask, u32 value)
> +{
> +	unsigned int timeout = 10;
> +	u32 val;
> +
> +	while (1) {
> +		val = readl_relaxed(lane->base + offset);
> +		if ((val & mask) == value)
> +			return 0;
> +		if (!timeout--)
> +			break;
> +		udelay(10);
> +	}
> +
> +	dev_err(lane->priv->dev, "comphy%u: timed out waiting for status\n",
> +		lane->n);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +/*
> + * We only support changing the speed for comphys configured for GBE.
> + * Since that is all we do, we only poll for PLL ready status.
> + */
> +static int a38x_comphy_set_mode(struct phy *phy, enum phy_mode mode)
> +{
> +	struct a38x_comphy_lane *lane = phy_get_drvdata(phy);
> +	unsigned int gen;
> +	u32 val;
> +
> +	val = readl_relaxed(lane->priv->base + COMPHY_SELECTOR);
> +	val = (val >> (4 * lane->n)) & 0xf;
> +
> +	if (!gbe_mux[lane->n][lane->port] ||
> +	    val != gbe_mux[lane->n][lane->port]) {
> +		dev_warn(lane->priv->dev,
> +			 "comphy%u: not configured for GBE\n", lane->n);
> +		return -EINVAL;
> +	}

Any reason for not doing this check in a38x_comphy_xlate? We could fail during
phy_get if comphy is not configured for GBE then.

Thanks
Kishon
