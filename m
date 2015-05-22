From: ykk@rock-chips.com (Yakir)
Date: Fri, 22 May 2015 23:28:58 +0800
Subject: [PATCH 08/13] drm: bridge/dw_hdmi: introduce interfaces to enable
 and disable audio
In-Reply-To: <E1Yr1xo-0006l0-8E@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1xo-0006l0-8E@rmk-PC.arm.linux.org.uk>
Message-ID: <555F4B3A.3070907@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

? 2015/5/9 18:26, Russell King ??:
> iMX6 devices suffer from an errata (ERR005174) where the audio FIFO can
> be emptied while it is partially full, resulting in misalignment of the
> audio samples.
>
> To prevent this, the errata workaround recommends writing N as zero
> until the audio FIFO has been loaded by DMA.  Writing N=0 prevents the
> HDMI bridge from reading from the audio FIFO, effectively disabling
> audio.
>
> This means we need to provide the audio driver with a pair of functions
> to enable/disable audio.  These are dw_hdmi_audio_enable() and
> dw_hdmi_audio_disable().
>
> A spinlock is introduced to ensure that setting the CTS/N values can't
> race, ensuring that the audio driver calling the enable/disable
> functions (which are called in an atomic context) can't race with a
> modeset.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Test on RK3288 platform, it works wells. Previously I use to switch off
the i2s audio clock, for now seems it is not necessary.

Test-by: Yakir Yang <ykk@rock-chips.com>

Thanks,
Yakir Yang

> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 34 +++++++++++++++++++++++++++++++++-
>   include/drm/bridge/dw_hdmi.h     |  2 ++
>   2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 0369fab5c695..adda3a988f36 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -18,6 +18,7 @@
>   #include <linux/hdmi.h>
>   #include <linux/mutex.h>
>   #include <linux/of_device.h>
> +#include <linux/spinlock.h>
>   
>   #include <drm/drm_of.h>
>   #include <drm/drmP.h>
> @@ -124,8 +125,12 @@ struct dw_hdmi {
>   	struct i2c_adapter *ddc;
>   	void __iomem *regs;
>   
> +	spinlock_t audio_lock;
>   	struct mutex audio_mutex;
>   	unsigned int sample_rate;
> +	unsigned int audio_cts;
> +	unsigned int audio_n;
> +	bool audio_enable;
>   	int ratio;
>   
>   	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
> @@ -347,7 +352,11 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>   	dev_dbg(hdmi->dev, "%s: samplerate=%ukHz ratio=%d pixelclk=%luMHz N=%d cts=%d\n",
>   		__func__, sample_rate, ratio, pixel_clk, n, cts);
>   
> -	hdmi_set_cts_n(hdmi, cts, n);
> +	spin_lock_irq(&hdmi->audio_lock);
> +	hdmi->audio_n = n;
> +	hdmi->audio_cts = cts;
> +	hdmi_set_cts_n(hdmi, cts, hdmi->audio_enable ? n : 0);
> +	spin_unlock_irq(&hdmi->audio_lock);
>   }
>   
>   static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
> @@ -376,6 +385,28 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
>   }
>   EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
>   
> +void dw_hdmi_audio_enable(struct dw_hdmi *hdmi)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hdmi->audio_lock, flags);
> +	hdmi->audio_enable = true;
> +	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
> +	spin_unlock_irqrestore(&hdmi->audio_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_audio_enable);
> +
> +void dw_hdmi_audio_disable(struct dw_hdmi *hdmi)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hdmi->audio_lock, flags);
> +	hdmi->audio_enable = false;
> +	hdmi_set_cts_n(hdmi, hdmi->audio_cts, 0);
> +	spin_unlock_irqrestore(&hdmi->audio_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_audio_disable);
> +
>   /*
>    * this submodule is responsible for the video data synchronization.
>    * for example, for RGB 4:4:4 input, the data map is defined as
> @@ -1578,6 +1609,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>   	hdmi->encoder = encoder;
>   
>   	mutex_init(&hdmi->audio_mutex);
> +	spin_lock_init(&hdmi->audio_lock);
>   
>   	of_property_read_u32(np, "reg-io-width", &val);
>   
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 763af51e1d60..bae79f3c4d28 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -63,5 +63,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>   		 const struct dw_hdmi_plat_data *plat_data);
>   
>   void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
> +void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
> +void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
>   
>   #endif /* __IMX_HDMI_H__ */
