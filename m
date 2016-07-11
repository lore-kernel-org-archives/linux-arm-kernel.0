From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 11 Jul 2016 08:46:53 +0800
Subject: [PATCH 5/7] drm/rockchip: dw-mipi: support HPD poll
In-Reply-To: <20160708145211.6bf83d8f.john@metanate.com>
References: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
 <1467968701-15620-6-git-send-email-zyw@rock-chips.com>
 <20160708145211.6bf83d8f.john@metanate.com>
Message-ID: <5782EC7D.3080202@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?07?08? 21:52, John Keeping wrote:
> On Fri,  8 Jul 2016 17:04:59 +0800, Chris Zhong wrote:
>
>> At the first time of bind, there is no any panel attach in mipi. Add a
>> DRM_CONNECTOR_POLL_HPD porperty to detect the panel status, when panel
>> probe, the dw_mipi_dsi_host_attach would be called, then mipi-dsi will
>> trigger a event to notify the drm framework.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Can we do something like this instead?  We know that the panel must
> always be attached and this has the advantage that the display size will
> be known when the framebuffer console loads.
>
> -- >8 --
> Subject: [PATCH] drm/rockchip: dw-mipi-dsi: defer probe if panel is not loaded
>
> This ensures that the output resolution is known before fbcon loads.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 6ef5f3be8468..c0499266d116 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -1154,10 +1154,17 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>   
>   	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
>   	dsi->dsi_host.dev = dev;
> -	return mipi_dsi_host_register(&dsi->dsi_host);
> +	ret = mipi_dsi_host_register(&dsi->dsi_host);
> +	if (!ret && !dsi->panel) {
> +		mipi_dsi_host_unregister(&dsi->dsi_host);
> +		drm_encoder_cleanup(&dsi->encoder);
> +		drm_connector_cleanup(&dsi->connector);
> +		ret = -EPROBE_DEFER;

Hi John

Do you verify this patch? I do the similar change before, but found 
panel can't probe.

mipi_dsi_host_register will call device_add, I think the panel probe 
need this.

Seems that mipi panel probe request mipi_dsi_host_register, 
mipi_dsi_host_register request panel on your patch, endless loop.

Thanks.

> +	}
>   
>   err_pllref:
> -	clk_disable_unprepare(dsi->pllref_clk);
> +	if (ret)
> +		clk_disable_unprepare(dsi->pllref_clk);
>   	return ret;
>   }
>   
>
>
>


-- 
?ark Yao
