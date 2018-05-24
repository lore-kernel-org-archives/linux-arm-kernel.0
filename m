From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 24 May 2018 10:27:01 +0200
Subject: [linux-sunxi] Re: [PATCH 12/15] drm/sun4i: Add support for
 second clock parent to DW HDMI PHY clk driver
In-Reply-To: <4018914.loHx9iTxYh@jernej-laptop>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-13-jernej.skrabec@siol.net>
 <20180521081253.cmx2mvfbfybgmtlv@flea>
 <4018914.loHx9iTxYh@jernej-laptop>
Message-ID: <20180524082701.q5lr6adjnjdseq6o@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 05:02:23PM +0200, Jernej ?krabec wrote:
> Hi,
> 
> Dne ponedeljek, 21. maj 2018 ob 10:12:53 CEST je Maxime Ripard napisal(a):
> > On Sat, May 19, 2018 at 08:31:24PM +0200, Jernej Skrabec wrote:
> > > Expand HDMI PHY clock driver to support second clock parent.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  6 +-
> > >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 29 ++++++-
> > >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 90 ++++++++++++++++------
> > >  3 files changed, 98 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index 801a17222762..aadbe0a10b0c
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > @@ -98,7 +98,8 @@
> > > 
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
> > > 
> > > -#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
> > > +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
> > > +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT	26
> > > 
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
> > >  #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
> > > 
> > > @@ -190,6 +191,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi
> > > *hdmi);
> > > 
> > >  void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
> > >  const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
> > > 
> > > -int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
> > > +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
> > > +			 bool second_parent);
> > > 
> > >  #endif /* _SUN8I_DW_HDMI_H_ */
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index deba47ed69d8..7a911f0a3ae3
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > > @@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi
> > > *hdmi,> 
> > >  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
> > >  	
> > >  			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
> > > 
> > > -	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
> > > +	/*
> > > +	 * NOTE: We have to be careful not to overwrite PHY parent
> > > +	 * clock selection bit and clock divider.
> > > +	 */
> > > +	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> > > +			   ~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> > > +			   pll_cfg1_init);
> > 
> > It feels like it belongs in a separate patch.
> 
> Why? clk_set_rate() on HDMI PHY clock is called before this function, so 
> SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL bit is already set to correct value. Original 
> code doesn't take this into account and sets it to 0 here in all cases, which 
> obviously is not right.
> 
> If you insist on splitting this in new patch, it has to be applied before 
> clock changes. It would also need to include "reset PLL clock configuration" 
> chunk (next change in this patch), otherwise other SoCs with only one parent 
> could get 1 there, which is obviously wrong. Note that I didn't really tested 
> if default value of this bit is 0 or 1, but I wouldn't really like to depend 
> on default values.

I don't have a strong feeling about this, but to me, the fact that you
don't want to overwrite the muxing bit because the clock might use it
is sensible in itself, disregarding the fact that the clock *will* use
it.

> 
> > 
> > >  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
> > >  	
> > >  			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
> > >  			   pll_cfg2_init);
> > > 
> > > @@ -352,6 +358,10 @@ static void sun8i_hdmi_phy_init_h3(struct
> > > sun8i_hdmi_phy *phy)> 
> > >  			   SUN8I_HDMI_PHY_ANA_CFG3_SCLEN |
> > >  			   SUN8I_HDMI_PHY_ANA_CFG3_SDAEN);
> > > 
> > > +	/* reset PLL clock configuration */
> > > +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
> > > +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG, 0);
> > > +
> > 
> > Ditto,
> > 
> > > +
> > > +		/*
> > > +		 * Even though HDMI PHY clock doesn't have enable/disable
> > > +		 * handlers, we have to enable it. Otherwise it could happen
> > > +		 * that parent PLL is not enabled by clock framework in a
> > > +		 * highly unlikely event when parent PLL is used solely for
> > > +		 * HDMI PHY clock.
> > > +		 */
> > > +		clk_prepare_enable(phy->clk_phy);
> > 
> > The implementation of the clock doesn't really matter in our API
> > usage. If we're using a clock, we have to call
> > clk_prepare_enable. That's documented everywhere, and mentionning how
> > the clock is implemented is an abstraction leakage and it's
> > irrelevant. I'd simply remove the comment here.
> > 
> > And it should be in a separate patch as well.
> 
> OK. Should I add Fixes tag, since current code obviously is not by the specs? 
> It could still get in 4.17...

Yep!

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/374eaf4a/attachment.sig>
