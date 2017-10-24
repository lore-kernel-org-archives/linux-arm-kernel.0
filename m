From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Oct 2017 16:58:26 +0800
Subject: [PATCH v2 2/2] phy: add combo phy driver for HiSilicon STB SoCs
In-Reply-To: <0ccecbc3-68fe-e134-36e0-6075f723d384@hisilicon.com>
References: <1508757968-22729-1-git-send-email-shawnguo@kernel.org>
 <1508757968-22729-3-git-send-email-shawnguo@kernel.org>
 <0ccecbc3-68fe-e134-36e0-6075f723d384@hisilicon.com>
Message-ID: <20171024085825.GE6403@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 07:42:32PM +0800, Jiancheng Xue wrote:
> > +static int histb_pcie_phy_init(struct histb_combphy_priv *priv)
> > +{
> > +	struct regmap *peri = priv->peri;
> > +	int ret;
> > +
> > +	/* set to pcie mode */
> > +	regmap_update_bits(peri, PERI_CTRL, COMBPHY1_MODE_MASK,
> > +			    COMBPHY_MODE_PCIE << COMBPHY_MODE_SHIFT);
> > +
> > +	regmap_update_bits(peri, PERI_COMBPHY1_CFG,
> > +			    COMBPHY1_BYPASS_CODEC_MASK,
> > +			    ~COMBPHY1_BYPASS_CODEC_VAL);
> > +
> > +	ret = clk_prepare_enable(priv->ref);
> > +	if (ret) {
> > +		dev_err(&priv->phy->dev, "clk_prepare_enable fail!\n");
> > +		return ret;
> > +	}
> > +
> > +	reset_control_deassert(priv->por);
> > +
> > +	regmap_update_bits(peri, PERI_COMBPHY1_CFG,
> > +			    COMBPHY1_CLKREF_OUT_OEN_MASK,
> > +			    COMBPHY1_CLKREF_OUT_OEN_VAL);
> > +
> > +	/* need to wait for EP clk stable */
> > +	mdelay(5);
> > +
> > +	nano_register_write(peri, PERI_COMBPHY1_CFG, 0x1, 0x8);
> > +	nano_register_write(peri, PERI_COMBPHY1_CFG, 0xc, 0x9);
> > +	nano_register_write(peri, PERI_COMBPHY1_CFG, 0x1a, 0x4);
> > +
> > +	return 0;
> > +}
> > +
> > +static int histb_pcie_phy_exit(struct histb_combphy_priv *priv)
> > +{
> > +	regmap_update_bits(priv->peri, PERI_COMBPHY1_CFG,
> > +				COMBPHY1_CLKREF_OUT_OEN_MASK,
> > +				~COMBPHY1_CLKREF_OUT_OEN_VAL);
> > +	reset_control_deassert(priv->por);
> > +	clk_disable_unprepare(priv->ref);
> > +
> > +	return 0;
> > +}
> > +
> > +static int histb_usb_phy_init(struct histb_combphy_priv *priv)
> > +{
> > +	int ret;
> > +
> I think the work mode should be set to usb3 first as histb_pcie_phy_init does.
> The current one may be not usb3.

Thanks for the reminding.  We will address that in the next version.

Shawn

> > +	ret = clk_prepare_enable(priv->ref);
> > +	if (ret) {
> > +		dev_err(&priv->phy->dev, "clk_prepare_enable fail!\n");
> > +		return ret;
> > +	}
> > +	reset_control_deassert(priv->por);
> > +	mdelay(1);
> > +
> > +	return 0;
> > +}
