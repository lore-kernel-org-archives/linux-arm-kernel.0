From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 17 Oct 2017 14:10:34 -0400
Subject: [RFC PATCH v4 4/8] drm/rockchip: dw_hdmi: Fix error handling path
In-Reply-To: <20171017101624.12506-5-jeffy.chen@rock-chips.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-5-jeffy.chen@rock-chips.com>
Message-ID: <20171017181034.tsplfsmq7vi4uhmo@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:16:20PM +0800, Jeffy Chen wrote:
> Add missing clk_disable_unprepare() in bind()'s error handling path.

This also isn't disabled in unbind(), is that intentional?

> 
> Fixes: 12b9f204e804 ("drm: bridge/dw_hdmi: add rockchip rk3288 support")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 1eb02a82fd91..582283da7861 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -383,8 +383,10 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
>  	 * which would have called the encoder cleanup.  Do it manually.
>  	 */
> -	if (ret)
> +	if (ret) {
>  		drm_encoder_cleanup(encoder);
> +		clk_disable_unprepare(hdmi->vpll_clk);

Same comment with respect to rockchip_hdmi_parse_dt(). This bug would have
probably been avoided if the contents of rockchip_hdmi_parse_dt() were inline
with dw_hdmi_rockchip_bind(), since then it's obvious what needs to be cleaned
up.

Sean

> +	}
>  
>  	return ret;
>  }
> -- 
> 2.11.0
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
