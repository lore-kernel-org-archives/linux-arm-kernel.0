From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 19 Apr 2017 10:19:50 +0530
Subject: [PATCH v2 1/2] drm: dw-hdmi: add specific I2S and AHB functions
 for stream handling
In-Reply-To: <20170414083113.4255-2-romain.perier@collabora.com>
References: <20170414083113.4255-1-romain.perier@collabora.com>
 <20170414083113.4255-2-romain.perier@collabora.com>
Message-ID: <07756d59-b2e6-cf6e-6948-9166de6befe5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/14/2017 02:01 PM, Romain Perier wrote:
> Currently, CTS+N is forced to zero as a workaround of the IP block for
> i.MX platforms. This is requested in the datasheet of the corresponding
> IP for AHB mode only. However, we have seen that it introduces glitches
> or delays when playing a sound on HDMI for I2S mode. This proves that we
> cannot keep the current functions for handling audio stream as-is if
> these contain workaround that are specific to a mode.
>
> This commit introduces two callbacks, one for each variant.
> dw_hdmi_setup defines the right function depending on the detected
> variant. Then, the exported functions dw_hdmi_audio_enable and
> dw_hdmi_audio_disable calls the corresponding callbacks
>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 4b6f216..5b328c0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -173,6 +173,8 @@ struct dw_hdmi {
>
>  	unsigned int reg_shift;
>  	struct regmap *regm;
> +	void (*enable_audio)(struct dw_hdmi *hdmi);
> +	void (*disable_audio)(struct dw_hdmi *hdmi);
>  };
>
>  #define HDMI_IH_PHY_STAT0_RX_SENSE \
> @@ -542,13 +544,29 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
>
> +void dw_hdmi_ahb_audio_enable(struct dw_hdmi *hdmi)
> +{
> +	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
> +}
> +
> +void dw_hdmi_ahb_audio_disable(struct dw_hdmi *hdmi)
> +{
> +	hdmi_set_cts_n(hdmi, hdmi->audio_cts, 0);
> +}
> +
> +void dw_hdmi_i2s_audio_enable(struct dw_hdmi *hdmi)
> +{
> +	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
> +}
> +

I get some sparse warnings asking for the above 3 to be static.

Thanks,
Archit

>  void dw_hdmi_audio_enable(struct dw_hdmi *hdmi)
>  {
>  	unsigned long flags;
>
>  	spin_lock_irqsave(&hdmi->audio_lock, flags);
>  	hdmi->audio_enable = true;
> -	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
> +	if (hdmi->enable_audio)
> +		hdmi->enable_audio(hdmi);
>  	spin_unlock_irqrestore(&hdmi->audio_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_audio_enable);
> @@ -559,7 +577,8 @@ void dw_hdmi_audio_disable(struct dw_hdmi *hdmi)
>
>  	spin_lock_irqsave(&hdmi->audio_lock, flags);
>  	hdmi->audio_enable = false;
> -	hdmi_set_cts_n(hdmi, hdmi->audio_cts, 0);
> +	if (hdmi->disable_audio)
> +		hdmi->disable_audio(hdmi);
>  	spin_unlock_irqrestore(&hdmi->audio_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_audio_disable);
> @@ -2404,6 +2423,8 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		audio.irq = irq;
>  		audio.hdmi = hdmi;
>  		audio.eld = hdmi->connector.eld;
> +		hdmi->enable_audio = dw_hdmi_ahb_audio_enable;
> +		hdmi->disable_audio = dw_hdmi_ahb_audio_disable;
>
>  		pdevinfo.name = "dw-hdmi-ahb-audio";
>  		pdevinfo.data = &audio;
> @@ -2416,6 +2437,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		audio.hdmi	= hdmi;
>  		audio.write	= hdmi_writeb;
>  		audio.read	= hdmi_readb;
> +		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
>
>  		pdevinfo.name = "dw-hdmi-i2s-audio";
>  		pdevinfo.data = &audio;
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
