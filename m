From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 11 Jul 2017 15:11:42 +0530
Subject: [PATCH v3 3/4] phy: usb: phy-brcm-usb: Add Broadcom STB USB phy
 driver
In-Reply-To: <1498575553-19311-4-git-send-email-alcooperx@gmail.com>
References: <1498575553-19311-1-git-send-email-alcooperx@gmail.com>
 <1498575553-19311-4-git-send-email-alcooperx@gmail.com>
Message-ID: <2cdd9fa8-163b-260d-f8e5-193d56d7d0a8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 27 June 2017 08:29 PM, Al Cooper wrote:
> Add a new USB Phy driver for Broadcom STB SoCs. This driver
> supports Broadcom STB ARM and MIPS SoCs. This driver in
> combination with the Broadcom STB ohci, ehci and xhci
> drivers will enable USB1.1, USB2.0 and USB3.0 support.
> This Phy driver also supports the Broadcom UDC gadget
> driver.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  MAINTAINERS                              |    7 +
>  drivers/phy/broadcom/Kconfig             |   12 +
>  drivers/phy/broadcom/Makefile            |    3 +
>  drivers/phy/broadcom/phy-brcm-usb-init.c | 1125 ++++++++++++++++++++++++++++++
>  drivers/phy/broadcom/phy-brcm-usb-init.h |   95 +++
>  drivers/phy/broadcom/phy-brcm-usb.c      |  359 ++++++++++
>  6 files changed, 1601 insertions(+)
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init.c
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init.h
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d711d53..63b6f41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2774,6 +2774,13 @@ L:	linux-pm at vger.kernel.org
>  S:	Maintained
>  F:	drivers/cpufreq/bmips-cpufreq.c
>  
> +BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
> +M:	Al Cooper <alcooperx@gmail.com>
> +L:	linux-kernel at vger.kernel.org
> +L:	bcm-kernel-feedback-list at broadcom.com
> +S:	Maintained
> +F:	drivers/phy/broadcom/phy-brcm-usb*
> +
>  BROADCOM TG3 GIGABIT ETHERNET DRIVER
>  M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
>  M:	Prashant Sreedharan <prashant@broadcom.com>
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index c4b632e..b8caa68 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -66,3 +66,15 @@ config PHY_BRCM_SATA
>  	help
>  	  Enable this to support the Broadcom SATA PHY.
>  	  If unsure, say N.
> +
> +config PHY_BRCM_USB
> +	tristate "Broadcom STB USB PHY driver"
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> +	depends on OF
> +	select GENERIC_PHY
> +	default ARCH_BRCMSTB || BMIPS_GENERIC
> +	help
> +	  Enable this to support the Broadcom STB USB PHY.
> +	  This driver is required by the USB XHCI, EHCI and OHCI
> +	  drivers.
> +	  If unsure, say N.
> diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
> index 4eb82ec..7c37ba6 100644
> --- a/drivers/phy/broadcom/Makefile
> +++ b/drivers/phy/broadcom/Makefile
> @@ -5,3 +5,6 @@ obj-$(CONFIG_PHY_BCM_NS_USB3)		+= phy-bcm-ns-usb3.o
>  obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
>  obj-$(CONFIG_PHY_NS2_USB_DRD)		+= phy-bcm-ns2-usbdrd.o
>  obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
> +obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
> +
> +phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
.
.
<snip>
.
.
> diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
> new file mode 100644
> index 0000000..2c5f10a
> --- /dev/null
> +++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
> @@ -0,0 +1,95 @@
> +/*
> + * Copyright (C) 2014-2017 Broadcom
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _USB_BRCM_COMMON_INIT_H
> +#define _USB_BRCM_COMMON_INIT_H
> +
> +#define USB_CTLR_MODE_HOST 0
> +#define USB_CTLR_MODE_DEVICE 1
> +#define USB_CTLR_MODE_DRD 2
> +#define USB_CTLR_MODE_TYPEC_PD 3
> +
> +struct  brcm_usb_init_params;
> +
> +struct brcm_usb_init_ops {
> +	void (*init_ipp)(struct brcm_usb_init_params *params);
> +	void (*init_common)(struct brcm_usb_init_params *params);
> +	void (*init_eohci)(struct brcm_usb_init_params *params);
> +	void (*init_xhci)(struct brcm_usb_init_params *params);
> +	void (*uninit_common)(struct brcm_usb_init_params *params);
> +	void (*uninit_eohci)(struct brcm_usb_init_params *params);
> +	void (*uninit_xhci)(struct brcm_usb_init_params *params);
> +};
> +
> +struct  brcm_usb_init_params {
> +	void __iomem *ctrl_regs;
> +	void __iomem *xhci_ec_regs;
> +	int ioc;
> +	int ipp;
> +	int mode;
> +	u32 family_id;
> +	u32 product_id;
> +	int selected_family;
> +	const char *family_name;
> +	const u32 *usb_reg_bits_map;
> +	const struct brcm_usb_init_ops *ops;
> +};
> +
> +void brcm_usb_set_family_map(struct brcm_usb_init_params *params);
> +int brcm_usb_init_get_dual_select(struct brcm_usb_init_params *params);
> +void brcm_usb_init_set_dual_select(struct brcm_usb_init_params *params,
> +				int mode);
> +
> +static inline void brcm_usb_init_ipp(struct brcm_usb_init_params *ini)
> +{
> +	if (ini->ops->init_ipp)
> +		ini->ops->init_ipp(ini);
> +}
> +
> +static inline void brcm_usb_init_common(struct brcm_usb_init_params *ini)
> +{
> +	if (ini->ops->init_common)
> +		ini->ops->init_common(ini);
> +}
> +
> +static inline void brcm_usb_init_eohci(struct brcm_usb_init_params *ini)
> +{
> +	if (ini->ops->init_eohci)
> +		ini->ops->init_eohci(ini);
> +}
> +
> +static inline void brcm_usb_init_xhci(struct brcm_usb_init_params *ini)
> +{
> +	if (ini->ops->init_xhci)
> +		ini->ops->init_xhci(ini);
> +}
> +
> +static inline void brcm_usb_uninit_common(struct brcm_usb_init_params *ini)
> +{
> +	if (ini->ops->uninit_common)
> +		ini->ops->uninit_common(ini);
> +}
> +
> +static inline void brcm_usb_uninit_eohci(struct brcm_usb_init_params *ini)
> +{
> +	if (ini->ops->uninit_eohci)
> +		ini->ops->uninit_eohci(ini);
> +}
> +
> +static inline void brcm_usb_uninit_xhci(struct brcm_usb_init_params *ini)
> +{
> +	if (ini->ops->uninit_xhci)
> +		ini->ops->uninit_xhci(ini);
> +}

I'm not sure if we need all this callback ops since arm and mips really doesn't
have a different set of ops. mips only have few ops missing. That can be
managed with a flag IMO.
> +
> +#endif /* _USB_BRCM_COMMON_INIT_H */
> diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
> new file mode 100644
> index 0000000..cd18616
> --- /dev/null
> +++ b/drivers/phy/broadcom/phy-brcm-usb.c
> @@ -0,0 +1,359 @@
> +/*
> + * phy-brcm-usb.c - Broadcom USB Phy Driver
> + *
> + * Copyright (C) 2015-2017 Broadcom
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/soc/brcmstb/brcmstb.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#include "phy-brcm-usb-init.h"
> +
> +enum brcm_usb_phy_id {
> +	BRCM_USB_PHY_2_0 = 0,
> +	BRCM_USB_PHY_3_0,
> +	BRCM_USB_PHY_ID_MAX
> +};
> +
> +struct value_to_name_map {
> +	int value;
> +	const char *name;
> +};
> +
> +static struct value_to_name_map brcm_dr_mode_to_name[] = {
> +	{ USB_CTLR_MODE_HOST, "host" },
> +	{ USB_CTLR_MODE_DEVICE, "peripheral" },
> +	{ USB_CTLR_MODE_DRD, "drd" },
> +	{ USB_CTLR_MODE_TYPEC_PD, "typec-pd" }
> +};
> +
> +struct brcm_usb_phy {
> +	struct phy *phy;
> +	unsigned int id;
> +	bool inited;
> +};
> +
> +struct brcm_usb_phy_data {
> +	struct  brcm_usb_init_params ini;
> +	bool			has_eohci;
> +	bool			has_xhci;
> +	struct clk		*usb_20_clk;
> +	struct clk		*usb_30_clk;
> +	struct mutex		mutex;
> +	int			init_count;
> +	struct brcm_usb_phy	phys[BRCM_USB_PHY_ID_MAX];
> +};
> +
> +#define to_brcm_usb_phy_data(phy) \
> +	container_of((phy), struct brcm_usb_phy_data, phys[(phy)->id])
> +
> +static int brcm_usb_phy_init(struct phy *gphy)
> +{
> +	struct brcm_usb_phy *phy = phy_get_drvdata(gphy);
> +	struct brcm_usb_phy_data *priv = to_brcm_usb_phy_data(phy);
> +
> +	/*
> +	 * Use a lock to make sure a second caller waits until
> +	 * the base phy is inited before using it.
> +	 */
> +	mutex_lock(&priv->mutex);
> +	if (priv->init_count++ == 0) {
> +		clk_enable(priv->usb_20_clk);
> +		clk_enable(priv->usb_30_clk);
> +		brcm_usb_init_common(&priv->ini);
> +	}
> +	mutex_unlock(&priv->mutex);
> +	if (phy->id == BRCM_USB_PHY_2_0)
> +		brcm_usb_init_eohci(&priv->ini);
> +	else if (phy->id == BRCM_USB_PHY_3_0)
> +		brcm_usb_init_xhci(&priv->ini);
> +	phy->inited = true;
> +	dev_dbg(&gphy->dev, "INIT, id: %d, total: %d\n", phy->id,
> +		priv->init_count);
> +
> +	return 0;
> +}
> +
> +static int brcm_usb_phy_exit(struct phy *gphy)
> +{
> +	struct brcm_usb_phy *phy = phy_get_drvdata(gphy);
> +	struct brcm_usb_phy_data *priv = to_brcm_usb_phy_data(phy);
> +
> +	dev_dbg(&gphy->dev, "EXIT\n");
> +	if (phy->id == BRCM_USB_PHY_2_0)
> +		brcm_usb_uninit_eohci(&priv->ini);
> +	if (phy->id == BRCM_USB_PHY_3_0)
> +		brcm_usb_uninit_xhci(&priv->ini);
> +
> +	/* If both xhci and eohci are gone, reset everything else */
> +	mutex_lock(&priv->mutex);
> +	if (--priv->init_count == 0) {
> +		brcm_usb_uninit_common(&priv->ini);
> +		clk_disable(priv->usb_20_clk);
> +		clk_disable(priv->usb_30_clk);
> +	}
> +	mutex_unlock(&priv->mutex);
> +	phy->inited = false;
> +	return 0;
> +}
> +
> +static struct phy_ops brcm_usb_phy_ops = {
> +	.init		= brcm_usb_phy_init,
> +	.exit		= brcm_usb_phy_exit,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct phy *brcm_usb_phy_xlate(struct device *dev,
> +				struct of_phandle_args *args)
> +{
> +	struct brcm_usb_phy_data *data = dev_get_drvdata(dev);
> +
> +	/*
> +	 * values 0 and 1 are for backward compatibility with
> +	 * device tree nodes from older bootloaders.
> +	 */
> +	switch (args->args[0]) {
> +	case 0:
> +	case PHY_TYPE_USB2:
> +		return data->phys[BRCM_USB_PHY_2_0].phy;
> +	case 1:
> +	case PHY_TYPE_USB3:
> +		return data->phys[BRCM_USB_PHY_3_0].phy;
> +	}
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static int name_to_value(struct value_to_name_map *table, int count,
> +			const char *name, int *value)
> +{
> +	int x;
> +
> +	*value = 0;
> +	for (x = 0; x < count; x++) {
> +		if (sysfs_streq(name, table[x].name)) {
> +			*value = x;
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int brcm_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct brcm_usb_phy_data *priv;
> +	struct phy *gphy;
> +	struct phy_provider *phy_provider;
> +	struct device_node *dn = pdev->dev.of_node;
> +	int err;
> +	const char *mode;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->ini.family_id = brcmstb_get_family_id();
> +	priv->ini.product_id = brcmstb_get_product_id();

These APIs can be invoked only if CONFIG_SOC_BRCMSTB is set right?
Can't we get these ids directly from device tree?
> +	brcm_usb_set_family_map(&priv->ini);
> +	dev_dbg(&pdev->dev, "Best mapping table is for %s\n",
> +		priv->ini.family_name);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "can't get USB_CTRL base address\n");
> +		return -EINVAL;
> +	}
> +	priv->ini.ctrl_regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->ini.ctrl_regs)) {
> +		dev_err(dev, "can't map CTRL register space\n");
> +		return -EINVAL;
> +	}
> +
> +	/* The XHCI EC registers are optional */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (res != NULL) {
> +		priv->ini.xhci_ec_regs =
> +			devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(priv->ini.xhci_ec_regs)) {
> +			dev_err(dev, "can't map XHCI EC register space\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	of_property_read_u32(dn, "brcm,ipp", &priv->ini.ipp);
> +	of_property_read_u32(dn, "brcm,ioc", &priv->ini.ioc);
> +
> +	priv->ini.mode = USB_CTLR_MODE_HOST;
> +	err = of_property_read_string(dn, "dr_mode", &mode);
> +	if (err == 0) {
> +		name_to_value(&brcm_dr_mode_to_name[0],
> +			ARRAY_SIZE(brcm_dr_mode_to_name),
> +			mode, &priv->ini.mode);
> +	}
> +
> +	if (of_property_read_bool(dn, "has_xhci_only")) {
> +		priv->has_xhci = true;
> +	} else {
> +		priv->has_eohci = true;
> +		if (of_property_read_bool(dn, "has_xhci"))
> +			priv->has_xhci = true;
> +	}
the dt binding documentation has mentioned brcm,has-xhci-only, brcm,has-xhci. I
think instead of having has_xhci_only property, there can be a sub-node for
each phy. So if there is only xhci, there can be a single sub-node and if there
are more, there can be multiple sub-nodes.

> +	if (priv->has_eohci) {
> +		gphy = devm_phy_create(dev, NULL, &brcm_usb_phy_ops);
> +		if (IS_ERR(gphy)) {
> +			dev_err(dev, "failed to create EHCI/OHCI PHY\n");
> +			return PTR_ERR(gphy);
> +		}
> +		priv->phys[BRCM_USB_PHY_2_0].phy = gphy;
> +		priv->phys[BRCM_USB_PHY_2_0].id = BRCM_USB_PHY_2_0;
> +		phy_set_drvdata(gphy, &priv->phys[BRCM_USB_PHY_2_0]);
> +	}
> +	if (priv->has_xhci) {
> +		gphy = devm_phy_create(dev, NULL, &brcm_usb_phy_ops);
> +		if (IS_ERR(gphy)) {
> +			dev_err(dev, "failed to create XHCI PHY\n");
> +			return PTR_ERR(gphy);
> +		}
> +		priv->phys[BRCM_USB_PHY_3_0].phy = gphy;
> +		priv->phys[BRCM_USB_PHY_3_0].id = BRCM_USB_PHY_3_0;
> +		phy_set_drvdata(gphy, &priv->phys[BRCM_USB_PHY_3_0]);
> +	}
> +	mutex_init(&priv->mutex);
> +	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
> +	if (IS_ERR(priv->usb_20_clk)) {
> +		dev_info(&pdev->dev, "Clock not found in Device Tree\n");
> +		priv->usb_20_clk = NULL;
> +	}
> +	err = clk_prepare_enable(priv->usb_20_clk);
> +	if (err)
> +		return err;
> +
> +	/* Get the USB3.0 clocks if we have XHCI */
> +	if (priv->has_xhci) {
> +		priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
> +		if (IS_ERR(priv->usb_30_clk)) {
> +			dev_info(&pdev->dev,
> +				"USB3.0 clock not found in Device Tree\n");
> +			priv->usb_30_clk = NULL;
> +		}
> +		err = clk_prepare_enable(priv->usb_30_clk);
> +		if (err)
> +			return err;
> +	}

Instead of having has_xhci checks all over probe, can't we have a single
function that performs all the initialization.
> +
> +	brcm_usb_init_ipp(&priv->ini);
> +
> +	/* start with everything off */
> +	if (priv->has_xhci)
> +		brcm_usb_uninit_xhci(&priv->ini);
> +	if (priv->has_eohci)
> +		brcm_usb_uninit_eohci(&priv->ini);
> +	brcm_usb_uninit_common(&priv->ini);
> +	clk_disable(priv->usb_20_clk);
> +	clk_disable(priv->usb_30_clk);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, brcm_usb_phy_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int brcm_usb_phy_suspend(struct device *dev)
> +{
> +	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
> +
> +	if (priv->init_count) {
> +		clk_disable(priv->usb_20_clk);
> +		clk_disable(priv->usb_30_clk);
> +	}
> +	return 0;
> +}
> +
> +static int brcm_usb_phy_resume(struct device *dev)
> +{
> +	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
> +
> +	clk_enable(priv->usb_20_clk);
> +	clk_enable(priv->usb_30_clk);
> +	brcm_usb_init_ipp(&priv->ini);
> +
> +	/*
> +	 * Initialize anything that was previously initialized.
> +	 * Uninitialize anything that wasn't previously initialized.
> +	 */
> +	if (priv->init_count) {
> +		brcm_usb_init_common(&priv->ini);
> +		if (priv->phys[BRCM_USB_PHY_2_0].inited) {
> +			brcm_usb_init_eohci(&priv->ini);
> +		} else if (priv->has_eohci) {
> +			brcm_usb_uninit_eohci(&priv->ini);
> +			clk_disable(priv->usb_20_clk);
> +		}
> +		if (priv->phys[BRCM_USB_PHY_3_0].inited) {
> +			brcm_usb_init_xhci(&priv->ini);
> +		} else if (priv->has_xhci) {
> +			brcm_usb_uninit_xhci(&priv->ini);
> +			clk_disable(priv->usb_30_clk);
> +		}
> +	} else {
> +		if (priv->has_xhci)
> +			brcm_usb_uninit_xhci(&priv->ini);
> +		if (priv->has_eohci)
> +			brcm_usb_uninit_eohci(&priv->ini);
> +		brcm_usb_uninit_common(&priv->ini);
> +		clk_disable(priv->usb_20_clk);
> +		clk_disable(priv->usb_30_clk);
> +	}
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops brcm_usb_phy_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(brcm_usb_phy_suspend, brcm_usb_phy_resume)
> +};
> +
> +static const struct of_device_id brcm_usb_dt_ids[] = {
> +	{ .compatible = "brcm,brcmstb-usb-phy" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, brcm_usb_dt_ids);
> +
> +static struct platform_driver brcm_usb_driver = {
> +	.probe		= brcm_usb_phy_probe,
> +	.driver		= {
> +		.name	= "brcmstb-usb-phy",
> +		.owner	= THIS_MODULE,
> +		.pm = &brcm_usb_phy_pm_ops,
> +		.of_match_table = brcm_usb_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(brcm_usb_driver);
> +
> +MODULE_ALIAS("platform:brcmstb-usb-phy");
> +MODULE_AUTHOR("Al Cooper <acooper@broadcom.com>");
> +MODULE_DESCRIPTION("BRCM USB PHY driver");
> +MODULE_LICENSE("GPL v2");
> 
