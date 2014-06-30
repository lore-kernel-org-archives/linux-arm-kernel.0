From: balbi@ti.com (Felipe Balbi)
Date: Mon, 30 Jun 2014 12:00:41 -0500
Subject: [Patch v7 2/3] usb: phy: Add Qualcomm DWC3 HS/SS PHY drivers
In-Reply-To: <1404144233-17222-3-git-send-email-agross@codeaurora.org>
References: <1404144233-17222-1-git-send-email-agross@codeaurora.org>
 <1404144233-17222-3-git-send-email-agross@codeaurora.org>
Message-ID: <20140630170041.GD31442@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

first of all, since this is a brand new PHY driver, could you guys use
the generic phy framework instead ? (drivers/phy)

On Mon, Jun 30, 2014 at 11:03:52AM -0500, Andy Gross wrote:
> diff --git a/drivers/usb/phy/phy-qcom-hsusb.c b/drivers/usb/phy/phy-qcom-hsusb.c
> new file mode 100644
> index 0000000..7a44b13
> --- /dev/null
> +++ b/drivers/usb/phy/phy-qcom-hsusb.c
> @@ -0,0 +1,348 @@
> +/* Copyright (c) 2013-2014, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/phy.h>
> +
> +/**
> + *  USB QSCRATCH Hardware registers
> + */
> +#define QSCRATCH_CTRL_REG		(0x04)
> +#define QSCRATCH_GENERAL_CFG		(0x08)
> +#define PHY_CTRL_REG			(0x10)
> +#define PARAMETER_OVERRIDE_X_REG	(0x14)
> +#define CHARGING_DET_CTRL_REG		(0x18)
> +#define CHARGING_DET_OUTPUT_REG		(0x1c)
> +#define ALT_INTERRUPT_EN_REG		(0x20)
> +#define PHY_IRQ_STAT_REG		(0x24)
> +#define CGCTL_REG			(0x28)
> +
> +#define PHY_3P3_VOL_MIN			3050000 /* uV */
> +#define PHY_3P3_VOL_MAX			3300000 /* uV */
> +#define PHY_3P3_HPM_LOAD		16000	/* uA */
> +
> +#define PHY_1P8_VOL_MIN			1800000 /* uV */
> +#define PHY_1P8_VOL_MAX			1800000 /* uV */
> +#define PHY_1P8_HPM_LOAD		19000	/* uA */
> +
> +/* TODO: these are suspicious */
> +#define USB_VDDCX_NO			1	/* index */
> +#define USB_VDDCX_MIN			5	/* index */
> +#define USB_VDDCX_MAX			7	/* index */
> +
> +/* PHY_CTRL_REG */
> +#define HSUSB_CTRL_DMSEHV_CLAMP			BIT(24)
> +#define HSUSB_CTRL_USB2_SUSPEND			BIT(23)
> +#define HSUSB_CTRL_UTMI_CLK_EN			BIT(21)
> +#define	HSUSB_CTRL_UTMI_OTG_VBUS_VALID		BIT(20)
> +#define HSUSB_CTRL_USE_CLKCORE			BIT(18)
> +#define HSUSB_CTRL_DPSEHV_CLAMP			BIT(17)
> +#define HSUSB_CTRL_COMMONONN			BIT(11)
> +#define HSUSB_CTRL_ID_HV_CLAMP			BIT(9)
> +#define HSUSB_CTRL_OTGSESSVLD_CLAMP		BIT(8)
> +#define HSUSB_CTRL_CLAMP_EN			BIT(7)
> +#define HSUSB_CTRL_RETENABLEN			BIT(1)
> +#define HSYSB_CTRL_POR				BIT(0)
> +
> +
> +/* QSCRATCH_GENERAL_CFG */
> +#define HSUSB_GCFG_XHCI_REV		BIT(2)
> +
> +struct qcom_dwc3_hs_phy {
> +	struct usb_phy		phy;
> +	void __iomem		*base;
> +	struct device		*dev;
> +
> +	struct clk		*xo_clk;
> +	struct clk		*utmi_clk;
> +
> +	struct regulator	*v3p3;
> +	struct regulator	*v1p8;
> +	struct regulator	*vddcx;
> +	struct regulator	*vbus;
> +};
> +
> +#define	phy_to_dw_phy(x)	container_of((x), struct qcom_dwc3_hs_phy, phy)
> +
> +/**
> + * Write register.
> + *
> + * @base - QCOM DWC3 PHY base virtual address.
> + * @offset - register offset.
> + * @val - value to write.
> + */
> +static inline void qcom_dwc3_hs_write(void __iomem *base, u32 offset, u32 val)
> +{
> +	writel(val, base + offset);
> +}
> +
> +/**
> + * Write register and read back masked value to confirm it is written
> + *
> + * @base - QCOM DWC3 PHY base virtual address.
> + * @offset - register offset.
> + * @mask - register bitmask specifying what should be updated
> + * @val - value to write.
> + */
> +static inline void qcom_dwc3_hs_write_readback(void __iomem *base, u32 offset,
> +					    const u32 mask, u32 val)
> +{
> +	u32 write_val, tmp = readl(base + offset);
> +
> +	tmp &= ~mask;		/* retain other bits */
> +	write_val = tmp | val;
> +
> +	writel(write_val, base + offset);
> +
> +	/* Read back to see if val was written */
> +	tmp = readl(base + offset);
> +	tmp &= mask;		/* clear other bits */
> +
> +	if (tmp != val)
> +		pr_err("write: %x to QSCRATCH: %x FAILED\n", val, offset);

really nit-picking - and I'm not even sure I care - but passing a dev
pointer to use dev_err() here might be a good idea.

> +}
> +
> +static void qcom_dwc3_hs_phy_shutdown(struct usb_phy *x)
> +{
> +	struct qcom_dwc3_hs_phy *phy = phy_to_dw_phy(x);
> +	int ret;
> +
> +	ret = regulator_set_voltage(phy->v3p3, 0, PHY_3P3_VOL_MAX);
> +	if (ret)
> +		dev_err(phy->dev, "cannot set voltage for v3p3\n");
> +
> +	ret = regulator_set_voltage(phy->v1p8, 0, PHY_1P8_VOL_MAX);
> +	if (ret)
> +		dev_err(phy->dev, "cannot set voltage for v1p8\n");
> +
> +	ret = regulator_disable(phy->v1p8);

alright, now this is really a personal doubt. Is it really necessary to
set zero 0 volts if you're going to shut it down ?

> +	if (ret)
> +		dev_err(phy->dev, "cannot disable v1p8\n");
> +
> +	ret = regulator_disable(phy->v3p3);
> +	if (ret)
> +		dev_err(phy->dev, "cannot disable v3p3\n");
> +
> +	ret = regulator_set_voltage(phy->vddcx, USB_VDDCX_NO, USB_VDDCX_MAX);
> +	if (ret)
> +		dev_err(phy->dev, "cannot set voltage for vddcx\n");
> +
> +	ret = regulator_disable(phy->vddcx);
> +	if (ret)
> +		dev_err(phy->dev, "cannot enable vddcx\n");
> +
> +	clk_disable_unprepare(phy->utmi_clk);
> +}
> +
> +static int qcom_dwc3_hs_phy_init(struct usb_phy *x)
> +{
> +	struct qcom_dwc3_hs_phy	*phy = phy_to_dw_phy(x);
> +	int ret;
> +	u32 val;
> +
> +	clk_prepare_enable(phy->utmi_clk);
> +
> +	ret = regulator_set_voltage(phy->vddcx, USB_VDDCX_MIN, USB_VDDCX_MAX);
> +	if (ret)
> +		dev_err(phy->dev, "cannot set voltage for vddcx\n");
> +
> +	ret = regulator_enable(phy->vddcx);
> +	if (ret)
> +		dev_err(phy->dev, "cannot enable vddcx\n");
> +
> +	ret = regulator_set_voltage(phy->v3p3, PHY_3P3_VOL_MIN,
> +				    PHY_3P3_VOL_MAX);
> +	if (ret)
> +		dev_err(phy->dev, "cannot set voltage for v3p3\n");
> +
> +	ret = regulator_set_voltage(phy->v1p8, PHY_1P8_VOL_MIN,
> +				    PHY_1P8_VOL_MAX);
> +	if (ret)
> +		dev_err(phy->dev, "cannot set voltage for v1p8\n");
> +
> +	ret = regulator_set_optimum_mode(phy->v1p8, PHY_1P8_HPM_LOAD);
> +	if (ret < 0)
> +		dev_err(phy->dev, "cannot set HPM of regulator v1p8\n");
> +
> +	ret = regulator_enable(phy->v1p8);
> +	if (ret)
> +		dev_err(phy->dev, "cannot enable v1p8\n");
> +
> +	ret = regulator_set_optimum_mode(phy->v3p3, PHY_3P3_HPM_LOAD);
> +	if (ret < 0)
> +		dev_err(phy->dev, "cannot set HPM of regulator v3p3\n");
> +
> +	ret = regulator_enable(phy->v3p3);
> +	if (ret)
> +		dev_err(phy->dev, "cannot enable v3p3\n");
> +
> +	/*
> +	 * HSPHY Initialization: Enable UTMI clock, select 19.2MHz fsel
> +	 * enable clamping, and disable RETENTION (power-on default is ENABLED)
> +	 */
> +	val = HSUSB_CTRL_DPSEHV_CLAMP | HSUSB_CTRL_DMSEHV_CLAMP |
> +		HSUSB_CTRL_RETENABLEN  | HSUSB_CTRL_COMMONONN |
> +		HSUSB_CTRL_OTGSESSVLD_CLAMP | HSUSB_CTRL_ID_HV_CLAMP |
> +		HSUSB_CTRL_DPSEHV_CLAMP | HSUSB_CTRL_UTMI_OTG_VBUS_VALID |
> +		HSUSB_CTRL_UTMI_CLK_EN | HSUSB_CTRL_CLAMP_EN | 0x70;
> +
> +	/* use core clock if external reference is not present */
> +	if (!phy->xo_clk)
> +		val |= HSUSB_CTRL_USE_CLKCORE;
> +
> +	qcom_dwc3_hs_write(phy->base, PHY_CTRL_REG, val);
> +	usleep_range(2000, 2200);
> +
> +	/*
> +	 * write HSPHY init value to QSCRATCH reg to set HSPHY parameters like
> +	 * VBUS valid threshold, disconnect valid threshold, DC voltage level,
> +	 * preempasis and rise/fall time.
> +	 */
> +	qcom_dwc3_hs_write_readback(phy->base, PARAMETER_OVERRIDE_X_REG,
> +				0x03ffffff, 0x00d191a4);

this can be dangerous, actually. VBUS Valid Threshold, Session Valid
Threshold, etc, are all defined by the USB spec, why would you have to
change it ? Maybe this is related to some errata and should be wrapped
with a revision check or something ?

> +	/* Disable (bypass) VBUS and ID filters */
> +	qcom_dwc3_hs_write(phy->base, QSCRATCH_GENERAL_CFG,
> +		HSUSB_GCFG_XHCI_REV);
> +
> +	return 0;
> +}
> +
> +static int qcom_dwc3_hs_phy_set_vbus(struct usb_phy *x, int on)
> +{
> +	struct qcom_dwc3_hs_phy	*phy = phy_to_dw_phy(x);
> +	int ret = 0;
> +
> +	if (IS_ERR(phy->vbus))
> +		return on ? PTR_ERR(phy->vbus) : 0;

this regulator seems to be optional, should you error out here if it's
not available at all ?

> +
> +	if (on)
> +		ret = regulator_enable(phy->vbus);
> +	else
> +		ret = regulator_disable(phy->vbus);
> +
> +	if (ret)
> +		dev_err(x->dev, "Cannot %s Vbus\n", on ? "set" : "off");
> +	return ret;
> +}
> +
> +static int qcom_dwc3_hs_probe(struct platform_device *pdev)
> +{
> +	struct qcom_dwc3_hs_phy	*phy;
> +	struct resource		*res;
> +	void __iomem		*base;
> +
> +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, phy);
> +
> +	phy->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(phy->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	phy->vddcx = devm_regulator_get(phy->dev, "vddcx");
> +	if (IS_ERR(phy->vddcx)) {
> +		dev_dbg(phy->dev, "cannot get vddcx\n");
> +		return  PTR_ERR(phy->vddcx);
> +	}
> +
> +	phy->v3p3 = devm_regulator_get(phy->dev, "v3p3");
> +	if (IS_ERR(phy->v3p3)) {
> +		dev_dbg(phy->dev, "cannot get v3p3\n");
> +		return PTR_ERR(phy->v3p3);
> +	}
> +
> +	phy->v1p8 = devm_regulator_get(phy->dev, "v1p8");
> +	if (IS_ERR(phy->v1p8)) {
> +		dev_dbg(phy->dev, "cannot get v1p8\n");
> +		return PTR_ERR(phy->v1p8);
> +	}
> +
> +	phy->vbus = devm_regulator_get(phy->dev, "vbus");
> +	if (IS_ERR(phy->vbus))
> +		dev_dbg(phy->dev, "Failed to get vbus\n");
> +
> +	phy->utmi_clk = devm_clk_get(phy->dev, "utmi");
> +	if (IS_ERR(phy->utmi_clk)) {
> +		dev_dbg(phy->dev, "cannot get UTMI handle\n");
> +		return PTR_ERR(phy->utmi_clk);
> +	}
> +
> +	phy->xo_clk = devm_clk_get(phy->dev, "xo");
> +	if (IS_ERR(phy->xo_clk)) {
> +		dev_dbg(phy->dev, "cannot get TCXO buffer handle\n");
> +		phy->xo_clk = NULL;
> +	}
> +
> +	clk_set_rate(phy->utmi_clk, 60000000);
> +
> +	if (phy->xo_clk)
> +		clk_prepare_enable(phy->xo_clk);
> +
> +	phy->base		= base;
> +	phy->phy.dev		= phy->dev;
> +	phy->phy.label		= "qcom-dwc3-hsphy";
> +	phy->phy.init		= qcom_dwc3_hs_phy_init;
> +	phy->phy.shutdown	= qcom_dwc3_hs_phy_shutdown;
> +	phy->phy.set_vbus	= qcom_dwc3_hs_phy_set_vbus;
> +	phy->phy.type		= USB_PHY_TYPE_USB2;
> +	phy->phy.state          = OTG_STATE_UNDEFINED;
> +
> +	usb_add_phy_dev(&phy->phy);
> +	return 0;
> +}
> +
> +static int qcom_dwc3_hs_remove(struct platform_device *pdev)
> +{
> +	struct qcom_dwc3_hs_phy *phy = platform_get_drvdata(pdev);
> +
> +	if (phy->xo_clk)
> +		clk_disable_unprepare(phy->xo_clk);
> +
> +	clk_disable_unprepare(phy->utmi_clk);
> +
> +	usb_remove_phy(&phy->phy);

you might have exposed a bug on the current PHY framework. There's no
guarantee that your regulators will be turned off when you remove this
driver. ehehehe..

ps: most comments are valid for the ssusb.c PHY driver as well. In fact,
they seem to be pretty similar; perhaps there's a way to share more code
between them ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/80714b70/attachment.sig>
