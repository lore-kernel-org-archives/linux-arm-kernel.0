From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 8 Sep 2016 10:54:34 +0530
Subject: [PATCH v2 1/2] phy: rockchip-typec: add pm runtime support
In-Reply-To: <1473289577-14101-1-git-send-email-zyw@rock-chips.com>
References: <1473289577-14101-1-git-send-email-zyw@rock-chips.com>
Message-ID: <57D0F612.10702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 08 September 2016 04:36 AM, Chris Zhong wrote:
> Adds pm_runtime support for rockchip Type-C, so that power domain is
> enabled only when there is a transaction going on to help save power.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
> Changes in v2:
> -- add pm_runtime_put_sync in err case
> 
>  drivers/phy/phy-rockchip-typec.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
> index fb58a27..0b2f528 100644
> --- a/drivers/phy/phy-rockchip-typec.c
> +++ b/drivers/phy/phy-rockchip-typec.c
> @@ -552,6 +552,12 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
>  		goto err_clk_core;
>  	}
>  
> +	ret = pm_runtime_get_sync(tcphy->dev);
> +	if (ret < 0) {
> +		dev_err(tcphy->dev, "cannot get pm runtime %d\n", ret);
> +		goto err_clk_ref;
> +	}

phy_core will do get_sync for you if.. <see below>
> +
>  	reset_control_deassert(tcphy->tcphy_rst);
>  
>  	property_enable(tcphy, &cfg->typec_conn_dir, tcphy->flip);
> @@ -600,8 +606,10 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
>  	return 0;
>  
>  err_wait_pma:
> +	pm_runtime_put_sync(tcphy->dev);
>  	reset_control_assert(tcphy->uphy_rst);
>  	reset_control_assert(tcphy->tcphy_rst);
> +err_clk_ref:
>  	clk_disable_unprepare(tcphy->clk_ref);
>  err_clk_core:
>  	clk_disable_unprepare(tcphy->clk_core);
> @@ -610,6 +618,7 @@ err_clk_core:
>  
>  static void tcphy_phy_deinit(struct rockchip_typec_phy *tcphy)
>  {
> +	pm_runtime_put_sync(tcphy->dev);
>  	reset_control_assert(tcphy->tcphy_rst);
>  	reset_control_assert(tcphy->uphy_rst);
>  	reset_control_assert(tcphy->pipe_rst);
> @@ -987,6 +996,15 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(phy_provider);
>  	}
>  
> +	pm_runtime_enable(dev);

... pm_runtime_enable is invoked before phy_create.

Thanks
Kishon
