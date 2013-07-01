From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 1 Jul 2013 14:55:08 +0200
Subject: [v2 2/4] imx: ahci: enable ahci sata on imx6q platforms
In-Reply-To: <1372672975-2997-3-git-send-email-r65037@freescale.com>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-3-git-send-email-r65037@freescale.com>
Message-ID: <20130701125508.GX516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 06:02:53PM +0800, Richard Zhu wrote:
> Only the imx6q contains the ahci sata controller,
> other imx6 SoCs don't have it.
> 
> Enable the ahci sata only on imx6q platforms
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c |   85 +++++++++++++++++++++++++++++++++++++++-
> +/* imx6q ahci module initialization. */
> +static int imx6q_sata_phy_clk(struct device *dev, int enable)
> +{
> +	int ret = 0;
> +	struct clk *sata_ref_clk;
> +
> +	sata_ref_clk = devm_clk_get(dev, "sata_ref_100m");
> +	if (IS_ERR(sata_ref_clk)) {
> +		dev_err(dev, "can't get sata_ref clock.\n");
> +		return PTR_ERR(sata_ref_clk);
> +	}

devm_clk_get takes a reference to the clock. That's not something you
want to do each time you enable/disable a clock.

> +	if (enable) {
> +		/* Enable PHY clock */
> +		ret = clk_prepare_enable(sata_ref_clk);
> +		if (ret < 0) {
> +			dev_err(dev, "can't prepare-enable sata_ref clock\n");
> +			clk_put(sata_ref_clk);
> +			ret = PTR_ERR(sata_ref_clk);

What are you intending by converting a valid pointer to an error code?

> +		}
> +	} else {
> +		/* Disable PHY clock */
> +		clk_disable_unprepare(sata_ref_clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx6q_sata_init(struct device *dev, void __iomem *addr)
> +{
> +	int ret = 0;
> +	struct regmap *gpr;
> +
> +	ret = imx6q_sata_phy_clk(dev, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (IS_ERR(gpr)) {
> +		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
> +		return PTR_ERR(gpr);
> +	}
> +
> +	/*
> +	 * set PHY Paremeters, two steps to configure the GPR13,
> +	 * one write for rest of parameters, mask of first write
> +	 * is 0x07fffffd, and the other one write for setting
> +	 * the mpll_clk_en.
> +	 */
> +	regmap_update_bits(gpr, 0x34, 0x07fffffd, 0x0593e4c4);

You are adding the register defines in the next patch. Wouldn't it make
sense to use them?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
