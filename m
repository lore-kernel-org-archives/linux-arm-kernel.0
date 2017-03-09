From: briannorris@chromium.org (Brian Norris)
Date: Wed, 8 Mar 2017 16:39:23 -0800
Subject: [PATCH 3/4] phy: rockchip-typec: support DP phy switch
In-Reply-To: <1486712654-15431-4-git-send-email-zyw@rock-chips.com>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
 <1486712654-15431-4-git-send-email-zyw@rock-chips.com>
Message-ID: <20170309003921.GA101174@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 03:44:13PM +0800, Chris Zhong wrote:
> There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
> only one PHY can connect to DP controller at one time, the other should
> be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
> set this bit means enable PHY 1, clear this bit means enable PHY 0.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
>  drivers/phy/phy-rockchip-typec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
> index 7cfb0f8..1604aaa 100644
> --- a/drivers/phy/phy-rockchip-typec.c
> +++ b/drivers/phy/phy-rockchip-typec.c
> @@ -267,6 +267,7 @@ struct rockchip_usb3phy_port_cfg {
>  	struct usb3phy_reg usb3tousb2_en;
>  	struct usb3phy_reg external_psm;
>  	struct usb3phy_reg pipe_status;
> +	struct usb3phy_reg uphy_dp_sel;
>  };
>  
>  struct rockchip_typec_phy {
> @@ -736,6 +737,7 @@ static const struct phy_ops rockchip_usb3_phy_ops = {
>  static int rockchip_dp_phy_power_on(struct phy *phy)
>  {
>  	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
> +	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
>  	int new_mode, ret = 0;
>  	u32 val;
>  
> @@ -766,6 +768,8 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
>  		tcphy_phy_init(tcphy, new_mode);
>  	}
>  
> +	property_enable(tcphy, &cfg->uphy_dp_sel, 1);
> +
>  	ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,

Idea for future work: this should just be readl_poll_timeout() here, and
throughout the driver.

>  				 val, val & DP_MODE_A2, 1000,
>  				 PHY_MODE_SET_TIMEOUT);
> @@ -869,6 +873,11 @@ static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
>  	if (ret)
>  		return ret;
>  
> +	ret = tcphy_get_param(dev, &cfg->uphy_dp_sel,
> +			      "rockchip,uphy-dp-sel");
> +	if (ret)
> +		return ret;

What about existing device trees? You're essentially adding this
new property and requiring it at the same time.

Or are we considering no RK3399 DP stable at the moment? I guess we
haven't actually merged any device trees that support this yet, no?

Brian

> +
>  	tcphy->grf_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
>  							  "rockchip,grf");
>  	if (IS_ERR(tcphy->grf_regs)) {
> -- 
> 2.6.3
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
