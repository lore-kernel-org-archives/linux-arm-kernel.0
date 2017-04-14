From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 14 Apr 2017 11:06:32 +0200
Subject: [PATCH v2 2/2] drm: dw-hdmi: gate audio clock from the I2S
 enablement callbacks
In-Reply-To: <20170414083113.4255-3-romain.perier@collabora.com>
References: <20170414083113.4255-1-romain.perier@collabora.com>
 <20170414083113.4255-3-romain.perier@collabora.com>
Message-ID: <d73b3d69-0660-0a91-3e59-eb6119b27ddf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2017 10:31 AM, Romain Perier wrote:
> Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
> step E. and is kept enabled for later use. This clock should be enabled
> and disabled along with the actual audio stream and not always on (that
> is bad for PM). Futhermore, as described by the datasheet, the I2S
> variant need to gate/ungate the clock when the stream is
> enabled/disabled.
> 
> This commit adds a parameter to hdmi_audio_enable_clk() that controls
> when the audio sample clock must be enabled or disabled. Then, it adds
> the call to this function from dw_hdmi_i2s_audio_enable() and
> dw_hdmi_i2s_audio_disable().
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5b328c0..a6da634 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -544,6 +544,12 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
>  
> +static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi, bool enable)
> +{
> +	hdmi_modb(hdmi, enable ? 0 : HDMI_MC_CLKDIS_AUDCLK_DISABLE,
> +		  HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
> +}
> +
>  void dw_hdmi_ahb_audio_enable(struct dw_hdmi *hdmi)
>  {
>  	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
> @@ -557,6 +563,12 @@ void dw_hdmi_ahb_audio_disable(struct dw_hdmi *hdmi)
>  void dw_hdmi_i2s_audio_enable(struct dw_hdmi *hdmi)
>  {
>  	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
> +	hdmi_enable_audio_clk(hdmi, true);
> +}
> +
> +void dw_hdmi_i2s_audio_disable(struct dw_hdmi *hdmi)
> +{
> +	hdmi_enable_audio_clk(hdmi, false);
>  }
>  
>  void dw_hdmi_audio_enable(struct dw_hdmi *hdmi)
> @@ -1592,11 +1604,6 @@ static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
>  			    HDMI_MC_FLOWCTRL);
>  }
>  
> -static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi)
> -{
> -	hdmi_modb(hdmi, 0, HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
> -}
> -
>  /* Workaround to clear the overflow condition */
>  static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  {
> @@ -1710,7 +1717,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  
>  		/* HDMI Initialization Step E - Configure audio */
>  		hdmi_clk_regenerator_update_pixel_clock(hdmi);
> -		hdmi_enable_audio_clk(hdmi);
> +		hdmi_enable_audio_clk(hdmi, true);
>  	}
>  
>  	/* not for DVI mode */
> @@ -2438,6 +2445,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		audio.write	= hdmi_writeb;
>  		audio.read	= hdmi_readb;
>  		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
> +		hdmi->disable_audio = dw_hdmi_i2s_audio_disable;
>  
>  		pdevinfo.name = "dw-hdmi-i2s-audio";
>  		pdevinfo.data = &audio;
> 

Hi Romain,

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
