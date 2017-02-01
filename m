From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 1 Feb 2017 13:41:27 -0500
Subject: [PATCH v4 2/6] drm/rockchip/dsi: dw-mipi: support RK3399 mipi dsi
In-Reply-To: <1485225486-669-3-git-send-email-zyw@rock-chips.com>
References: <1485225486-669-1-git-send-email-zyw@rock-chips.com>
 <1485225486-669-3-git-send-email-zyw@rock-chips.com>
Message-ID: <20170201184127.GB8595@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:38:02AM +0800, Chris Zhong wrote:
> The vopb/vopl switch register of RK3399 mipi is different from RK3288,
> the default setting for mipi dsi mode is different too, so add a
> of_device_id structure to distinguish them, and make sure set the
> correct mode before mipi phy init.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> 
> ---
> 
> Changes in v4:
> - remove the unrelated change
> 
> Changes in v3:
> - base on John Keeping's patch series
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 68 +++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 45af890..b7b67be 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c

<snip>

> @@ -1249,6 +1293,10 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  		clk_disable_unprepare(dsi->pclk);
>  	}
>  
> +	dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
> +	if (IS_ERR(dsi->phy_cfg_clk))
> +		dev_dbg(dev, "have not phy_cfg_clk\n");

You should differentiate between ENODEV and other errors here, returning an
error if it's not ENODEV. If it is ENODEV, just set phy_cfg_clk to NULL, then
you can remove all of the if (IS_ERR(dsi->phy_cfg_clk) checks everywhere since
clk_* functions check for NULL.

Sean

> +
>  	ret = clk_prepare_enable(dsi->pllref_clk);
>  	if (ret) {
>  		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
> -- 
> 2.6.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
