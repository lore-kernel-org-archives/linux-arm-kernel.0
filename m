From: ykk@rock-chips.com (Yang Kuankuan)
Date: Tue, 31 Mar 2015 03:45:15 -0400
Subject: [PATCH RFC 06/11] drm: bridge/dw_hdmi: introduce interfaces to
 enable and disable audio
In-Reply-To: <E1YcfXu-0002v9-SB@rmk-PC.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfXu-0002v9-SB@rmk-PC.arm.linux.org.uk>
Message-ID: <551A508B.1010106@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 03/30/2015 03:40 PM, Russell King wrote:
> iMX6 devices from an errata (ERR005174) where the audio FIFO can be
> emptied while it is partially full, resulting in misalignment of the
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
> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 34 +++++++++++++++++++++++++++++++++-
>   include/drm/bridge/dw_hdmi.h     |  2 ++
>   2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 245d17e58dec..67f07d15c12b 100644
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

It is an smart way to operate audio status that do not relate to the audio
interfaces (AHB or I2S), but I am not sure whether this will work on 
rockchip
platform, I will do some experiment to test it as soon as possible :)

Best regards.
Yakir Yang

>   /*
>    * this submodule is responsible for the video data synchronization.
>    * for example, for RGB 4:4:4 input, the data map is defined as
> @@ -1579,6 +1610,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>   	hdmi->encoder = encoder;
>   
>   	mutex_init(&hdmi->audio_mutex);
> +	spin_lock_init(&hdmi->audio_lock);
>   
>   	of_property_read_u32(np, "reg-io-width", &val);
>   
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 424b51f6a215..ab5d36e83ea2 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -62,5 +62,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>   		 const struct dw_hdmi_plat_data *plat_data);
>   
>   void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
> +void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
> +void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
>   
>   #endif /* __IMX_HDMI_H__ */
