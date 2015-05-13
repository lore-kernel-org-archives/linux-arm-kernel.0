From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 13 May 2015 16:37:05 +0530
Subject: [PATCH v3 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom
 STB SoCs
In-Reply-To: <1431473303-18873-5-git-send-email-computersforpeace@gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <1431473303-18873-5-git-send-email-computersforpeace@gmail.com>
Message-ID: <55533059.6050705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 13 May 2015 04:58 AM, Brian Norris wrote:
> Supports up to two ports which can each be powered on/off and configured
> independently.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

couple of minor comments below
> ---
> v3: no change
>
> v2:
>    - stop sharing SATA_TOP_CTRL registers with SATA driver
>    - kill custom xlate function
>
>   drivers/phy/Kconfig            |   9 ++
>   drivers/phy/Makefile           |   1 +
>   drivers/phy/phy-brcmstb-sata.c | 216 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 226 insertions(+)
>   create mode 100644 drivers/phy/phy-brcmstb-sata.c
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index a53bd5b52df9..36788b6f0220 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -309,4 +309,13 @@ config PHY_QCOM_UFS
>   	help
>   	  Support for UFS PHY on QCOM chipsets.
>
> +config PHY_BRCMSTB_SATA
> +	tristate "Broadcom STB SATA PHY driver"
> +	depends on ARCH_BRCMSTB
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
> +	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
> +
>   endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index f12625178780..c61f3fdd191e 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -40,3 +40,4 @@ obj-$(CONFIG_PHY_STIH41X_USB)		+= phy-stih41x-usb.o
>   obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
>   obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
>   obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
> +obj-$(CONFIG_PHY_BRCMSTB_SATA)		+= phy-brcmstb-sata.o
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> new file mode 100644
> index 000000000000..8387c8cbea8c
> --- /dev/null
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -0,0 +1,216 @@
> +/*
> + * Broadcom SATA3 AHCI Controller PHY Driver
> + *
> + * Copyright ? 2009-2015 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +#define SATA_MDIO_BANK_OFFSET				0x23c
> +#define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
> +#define SATA_MDIO_REG_SPACE_SIZE			0x1000
> +#define SATA_MDIO_REG_LENGTH				0x1f00
> +
> +#define MAX_PORTS					2
> +
> +/* Register offset between PHYs in PCB space */
> +#define SATA_MDIO_REG_SPACE_SIZE			0x1000
> +
> +struct brcm_sata_port {
> +	int portnum;
> +	struct phy *phy;
> +	struct brcm_sata_phy *phy_priv;
> +	bool ssc_en;
> +};
> +
> +struct brcm_sata_phy {
> +	struct device *dev;
> +	void __iomem *phy_base;
> +
> +	struct brcm_sata_port phys[MAX_PORTS];
> +};
> +
> +enum sata_mdio_phy_regs_28nm {

Why should these defines be in enum?


> +	PLL_REG_BANK_0				= 0x50,
> +	PLL_REG_BANK_0_PLLCONTROL_0		= 0x81,
> +
> +	TXPMD_REG_BANK				= 0x1a0,
> +	TXPMD_CONTROL1				= 0x81,
> +	TXPMD_CONTROL1_TX_SSC_EN_FRC		= BIT(0),
> +	TXPMD_CONTROL1_TX_SSC_EN_FRC_VAL	= BIT(1),
> +	TXPMD_TX_FREQ_CTRL_CONTROL1		= 0x82,
> +	TXPMD_TX_FREQ_CTRL_CONTROL2		= 0x83,
> +	TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK	= 0x3ff,
> +	TXPMD_TX_FREQ_CTRL_CONTROL3		= 0x84,
> +	TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK	= 0x3ff,
> +};
> +
> +static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
> +{
> +	struct brcm_sata_phy *priv = port->phy_priv;
> +
> +	return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
> +}
> +
> +static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
> +			      u32 msk, u32 value)
> +{
> +	u32 tmp;
> +
> +	writel(bank, addr + SATA_MDIO_BANK_OFFSET);
> +	tmp = readl(addr + SATA_MDIO_REG_OFFSET(ofs));
> +	tmp = (tmp & msk) | value;
> +	writel(tmp, addr + SATA_MDIO_REG_OFFSET(ofs));
> +}
> +
> +/* These defaults were characterized by H/W group */
> +#define FMIN_VAL_DEFAULT	0x3df
> +#define FMAX_VAL_DEFAULT	0x3df
> +#define FMAX_VAL_SSC		0x83
> +
> +static void cfg_ssc_28nm(struct brcm_sata_port *port)

brcm_sata_cfg_ssc_28nm to make it similar to other functions.
> +{
> +	void __iomem *base = brcm_sata_phy_base(port);
> +	struct brcm_sata_phy *priv = port->phy_priv;
> +	u32 tmp;
> +
> +	/* override the TX spread spectrum setting */
> +	tmp = TXPMD_CONTROL1_TX_SSC_EN_FRC_VAL | TXPMD_CONTROL1_TX_SSC_EN_FRC;
> +	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_CONTROL1, ~tmp, tmp);
> +
> +	/* set fixed min freq */
> +	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL2,
> +			  ~TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK,
> +			  FMIN_VAL_DEFAULT);
> +
> +	/* set fixed max freq depending on SSC config */
> +	if (port->ssc_en) {
> +		dev_info(priv->dev, "enabling SSC on port %d\n", port->portnum);
> +		tmp = FMAX_VAL_SSC;
> +	} else {
> +		tmp = FMAX_VAL_DEFAULT;
> +	}
> +
> +	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL3,
> +			  ~TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK, tmp);
> +}
> +
> +static int brcm_sata_phy_init(struct phy *phy)
> +{
> +	struct brcm_sata_port *port = phy_get_drvdata(phy);
> +
> +	cfg_ssc_28nm(port);
> +
> +	return 0;
> +}
> +
> +static struct phy_ops phy_ops_28nm = {
> +	.init		= brcm_sata_phy_init,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct of_device_id brcm_sata_phy_of_match[] = {
> +	{ .compatible	= "brcm,bcm7445-sata-phy" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> +
> +static int brcm_sata_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *dn = dev->of_node, *child;
> +	struct brcm_sata_phy *priv;
> +	struct resource *res;
> +	struct phy_provider *provider;
> +	int count = 0;
> +
> +	if (of_get_child_count(dn) == 0)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, priv);
> +	priv->dev = dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> +	priv->phy_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->phy_base))
> +		return PTR_ERR(priv->phy_base);
> +
> +	for_each_available_child_of_node(dn, child) {
> +		unsigned int id;
> +		struct brcm_sata_port *port;
> +
> +		if (of_property_read_u32(child, "reg", &id)) {
> +			dev_err(dev, "missing reg property in node %s\n",
> +					child->name);
> +			return -EINVAL;
> +		}
> +
> +		if (id >= MAX_PORTS) {
> +			dev_err(dev, "invalid reg: %u\n", id);
> +			return -EINVAL;
> +		}
> +		if (priv->phys[id].phy) {
> +			dev_err(dev, "already registered port %u\n", id);
> +			return -EINVAL;
> +		}
> +
> +		port = &priv->phys[id];
> +		port->portnum = id;
> +		port->phy_priv = priv;
> +		port->phy = devm_phy_create(dev, child, &phy_ops_28nm);
> +		port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
> +		if (IS_ERR(port->phy)) {
> +			dev_err(dev, "failed to create PHY\n");
> +			return PTR_ERR(port->phy);
> +		}
> +
> +		phy_set_drvdata(port->phy, port);
> +		count++;
> +	}
> +
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider)) {
> +		dev_err(dev, "could not register PHY provider\n");
> +		return PTR_ERR(provider);
> +	}
> +
> +	dev_info(dev, "registered %d port(s)\n", count);

lets not make the boot noisy. Change to dev_dbg?

Thanks
Kishon
