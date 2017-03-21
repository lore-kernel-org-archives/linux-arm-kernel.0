From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 21 Mar 2017 16:29:09 -0400
Subject: [PATCH v3 1/4] drm/rockchip/dsi: check phy_cfg_clk only for RK3399
In-Reply-To: <20170321201623.GF19389@art_vandelay>
References: <1489722865-22122-1-git-send-email-zyw@rock-chips.com>
 <1489722865-22122-2-git-send-email-zyw@rock-chips.com>
 <20170321201623.GF19389@art_vandelay>
Message-ID: <20170321202908.GJ19389@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:16:23PM -0400, Sean Paul wrote:
> On Fri, Mar 17, 2017 at 11:54:21AM +0800, Chris Zhong wrote:
> > For RK3399, the phy_cfg_clk is a required clock, if phy_cfg_clk is
> > disabled, MIPI phy can not work. Let's return a error if there is no
> > phy_cfg_clk in dts property, when the pdata match RK3399.
> > 
> 
> The dt bindings say this is a required clock, I think you'll need to update them
> to reflect that this is optional for certain SoCs
> 

As stated in the other patch, I didn't read the binding close enough. Sorry
about that.

Reviewed-by: Sean Paul <seanpaul@chromium.org>

Sean

> Sean
> 
> > Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> > ---
> > 
> > Changes in v3:
> > - add a DW_MIPI_NEEDS_PHY_CFG_CLK for RK3399
> > 
> > Changes in v2: None
> > 
> >  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > index f84f9ae..68f48b0 100644
> > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > @@ -251,6 +251,8 @@
> >  #define THS_PRE_PROGRAM_EN	BIT(7)
> >  #define THS_ZERO_PROGRAM_EN	BIT(6)
> >  
> > +#define DW_MIPI_NEEDS_PHY_CFG_CLK	BIT(0)
> > +
> >  enum {
> >  	BANDGAP_97_07,
> >  	BANDGAP_98_05,
> > @@ -279,6 +281,7 @@ struct dw_mipi_dsi_plat_data {
> >  	u32 grf_switch_reg;
> >  	u32 grf_dsi0_mode;
> >  	u32 grf_dsi0_mode_reg;
> > +	unsigned int flags;
> >  	unsigned int max_data_lanes;
> >  };
> >  
> > @@ -1136,6 +1139,7 @@ static struct dw_mipi_dsi_plat_data rk3399_mipi_dsi_drv_data = {
> >  	.grf_switch_reg = RK3399_GRF_SOC_CON19,
> >  	.grf_dsi0_mode = RK3399_GRF_DSI_MODE,
> >  	.grf_dsi0_mode_reg = RK3399_GRF_SOC_CON22,
> > +	.flags = DW_MIPI_NEEDS_PHY_CFG_CLK,
> >  	.max_data_lanes = 4,
> >  };
> >  
> > @@ -1227,15 +1231,13 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
> >  		clk_disable_unprepare(dsi->pclk);
> >  	}
> >  
> > -	dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
> > -	if (IS_ERR(dsi->phy_cfg_clk)) {
> > -		ret = PTR_ERR(dsi->phy_cfg_clk);
> > -		if (ret != -ENOENT) {
> > +	if (pdata->flags & DW_MIPI_NEEDS_PHY_CFG_CLK) {
> > +		dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
> > +		if (IS_ERR(dsi->phy_cfg_clk)) {
> > +			ret = PTR_ERR(dsi->phy_cfg_clk);
> >  			dev_err(dev, "Unable to get phy_cfg_clk: %d\n", ret);
> >  			return ret;
> >  		}
> > -		dsi->phy_cfg_clk = NULL;
> > -		dev_dbg(dev, "have not phy_cfg_clk\n");
> >  	}
> >  
> >  	ret = clk_prepare_enable(dsi->pllref_clk);
> > -- 
> > 2.6.3
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS

-- 
Sean Paul, Software Engineer, Google / Chromium OS
