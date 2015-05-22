From: ykk@rock-chips.com (Yakir)
Date: Fri, 22 May 2015 23:22:47 +0800
Subject: [PATCH 03/13] drm: bridge/dw_hdmi: clean up
 hdmi_set_clk_regenerator()
In-Reply-To: <E1Yr1xO-0006kg-K0@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1xO-0006kg-K0@rmk-PC.arm.linux.org.uk>
Message-ID: <555F49C7.9060904@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

? 2015/5/9 18:26, Russell King ??:
> Clean up hdmi_set_clk_regenerator() by allowing it to take the audio
> sample rate and ratio directly, rather than hiding it inside the
> function.  Raise the unsupported pixel clock/sample rate message from
> debug to error level as this results in audio not working correctly.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Test on RK3288 platform, it works wells while do not need clear
the ncts_atomic_write bit in aud_n3, so no need more code it's find.

Test-by: <ykk@rock-chips.com>

Best regards,
Yakir Yang
> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 23ea8c5c85b6..75099b80ca7e 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -335,39 +335,37 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
>   }
>   
>   static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> -				     unsigned long pixel_clk)
> +	unsigned long pixel_clk, unsigned int sample_rate, unsigned int ratio)
>   {
> -	unsigned int clk_n, clk_cts;
> +	unsigned int n, cts;
>   
> -	clk_n = hdmi_compute_n(hdmi->sample_rate, pixel_clk,
> -			       hdmi->ratio);
> -	clk_cts = hdmi_compute_cts(hdmi->sample_rate, pixel_clk,
> -				   hdmi->ratio);
> -
> -	if (!clk_cts) {
> -		dev_dbg(hdmi->dev, "%s: pixel clock not supported: %lu\n",
> -			__func__, pixel_clk);
> -		return;
> +	n = hdmi_compute_n(sample_rate, pixel_clk, ratio);
> +	cts = hdmi_compute_cts(sample_rate, pixel_clk, ratio);
> +	if (!cts) {
> +		dev_err(hdmi->dev,
> +			"%s: pixel clock/sample rate not supported: %luMHz / %ukHz\n",
> +			__func__, pixel_clk, sample_rate);
>   	}
>   
> -	dev_dbg(hdmi->dev, "%s: samplerate=%d  ratio=%d  pixelclk=%lu  N=%d cts=%d\n",
> -		__func__, hdmi->sample_rate, hdmi->ratio,
> -		pixel_clk, clk_n, clk_cts);
> +	dev_dbg(hdmi->dev, "%s: samplerate=%ukHz ratio=%d pixelclk=%luMHz N=%d cts=%d\n",
> +		__func__, sample_rate, ratio, pixel_clk, n, cts);
>   
> -	hdmi_set_cts_n(hdmi, clk_cts, clk_n);
> +	hdmi_set_cts_n(hdmi, cts, n);
>   }
>   
>   static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
>   {
>   	mutex_lock(&hdmi->audio_mutex);
> -	hdmi_set_clk_regenerator(hdmi, 74250000);
> +	hdmi_set_clk_regenerator(hdmi, 74250000, hdmi->sample_rate,
> +				 hdmi->ratio);
>   	mutex_unlock(&hdmi->audio_mutex);
>   }
>   
>   static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
>   {
>   	mutex_lock(&hdmi->audio_mutex);
> -	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
> +	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
> +				 hdmi->sample_rate, hdmi->ratio);
>   	mutex_unlock(&hdmi->audio_mutex);
>   }
>   
