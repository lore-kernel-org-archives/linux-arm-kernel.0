From: ykk@rock-chips.com (Yakir)
Date: Fri, 22 May 2015 23:26:26 +0800
Subject: [PATCH 07/13] drm: bridge/dw_hdmi: introduce interface to setting
 sample rate
In-Reply-To: <E1Yr1xj-0006kw-4K@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1xj-0006kw-4K@rmk-PC.arm.linux.org.uk>
Message-ID: <555F4AA2.3000204@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

? 2015/5/9 18:26, Russell King ??:
> Introduce dw_hdmi_set_sample_rate(), which allows us to configure the
> audio sample rate, setting the CTS/N values appropriately.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Test on RK3288 platform, it works wells (like patch 03/13 reply)

Test-by: <ykk@rock-chips.com>

Yakir Yang
> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 10 ++++++++++
>   include/drm/bridge/dw_hdmi.h     |  5 +++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 75728ba552d0..0369fab5c695 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -366,6 +366,16 @@ static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
>   	mutex_unlock(&hdmi->audio_mutex);
>   }
>   
> +void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
> +{
> +	mutex_lock(&hdmi->audio_mutex);
> +	hdmi->sample_rate = rate;
> +	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
> +				 hdmi->sample_rate, hdmi->ratio);
> +	mutex_unlock(&hdmi->audio_mutex);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
> +
>   /*
>    * this submodule is responsible for the video data synchronization.
>    * for example, for RGB 4:4:4 input, the data map is defined as
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index de13bfc35634..763af51e1d60 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -12,6 +12,8 @@
>   
>   #include <drm/drmP.h>
>   
> +struct dw_hdmi;
> +
>   enum {
>   	DW_HDMI_RES_8,
>   	DW_HDMI_RES_10,
> @@ -59,4 +61,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>   		 void *data, struct drm_encoder *encoder,
>   		 struct resource *iores, int irq,
>   		 const struct dw_hdmi_plat_data *plat_data);
> +
> +void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
> +
>   #endif /* __IMX_HDMI_H__ */
