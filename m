From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 27 May 2015 12:43:08 +0200
Subject: [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI
 driver
In-Reply-To: <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
Message-ID: <20150527104308.GA8341@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 11:26:57AM +0100, Russell King wrote:
> Parse the ELD (EDID like data) stored from the HDMI driver to restrict
> the sample rates and channels which are available to ALSA.  This causes
> the ALSA device to reflect the capabilities of the overall audio path,
> not just what is supported at the HDMI source interface level.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I completely missed the new eld helpers in this series, so fairly late
with a few questions here.

In x86/desktop gpus we pass around the eld in hw, and there's an interrupt
on the snd side every time that materially changes. Same goes for other
state changes like the display pipe getting lit up/disabled again.

How is hotplug handling done here? You update the eld in get_modes, but I
don't see any notification from hdmi->audio (it only seems to get updated
at open time, no idea whether that's enough). And it looks like there's a
potential use-after-free when the drm side updates the eld and frees the
old one, while the snd side tries to access this.

Just curious questions really, I probably don't understand what's exactly
going on. But I do think that we need a more formal way for drm/snd to
talk to each another (i915 is growing quite a few hairy things in that
area outside of eld atm). Problems we have are around shared power wells
and clocks (x86 doesn't help here without all the dt goodness). But
there's also stuff like figuring out the right dividers for a given
audio/video clock. eld and hotplug is still done in hw, but I've heard
noises that we need to have a sw approach too on some platforms at least.

Cheers, Daniel
> ---
>  drivers/gpu/drm/bridge/Kconfig             | 1 +
>  drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 6 ++++++
>  drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h | 1 +
>  drivers/gpu/drm/bridge/dw_hdmi.c           | 3 +++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 56ed35fe0734..204861bfb867 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -7,6 +7,7 @@ config DRM_DW_HDMI_AHB_AUDIO
>  	tristate "Synopsis Designware AHB Audio interface"
>  	depends on DRM_DW_HDMI && SND
>  	select SND_PCM
> +	select SND_PCM_ELD
>  	select SND_PCM_IEC958
>  	help
>  	  Support the AHB Audio interface which is part of the Synopsis
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
> index e98c291268f4..2bb68bda3cb0 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
> @@ -12,11 +12,13 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <drm/bridge/dw_hdmi.h>
> +#include <drm/drm_edid.h>
>  
>  #include <sound/asoundef.h>
>  #include <sound/core.h>
>  #include <sound/initval.h>
>  #include <sound/pcm.h>
> +#include <sound/pcm_drm_eld.h>
>  #include <sound/pcm_iec958.h>
>  
>  #include "dw_hdmi-ahb-audio.h"
> @@ -284,6 +286,10 @@ static int dw_hdmi_open(struct snd_pcm_substream *substream)
>  
>  	runtime->hw = dw_hdmi_hw;
>  
> +	ret = snd_pcm_hw_constraint_eld(runtime, dw->data.eld);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = snd_pcm_limit_hw_rates(runtime);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
> index 1e840118d90a..91f631beecc7 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
> +++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
> @@ -8,6 +8,7 @@ struct dw_hdmi_audio_data {
>  	void __iomem *base;
>  	int irq;
>  	struct dw_hdmi *hdmi;
> +	u8 *eld;
>  };
>  
>  #endif
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 1cb427935ed2..dc0aed18019d 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -1446,6 +1446,8 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  
>  		drm_mode_connector_update_edid_property(connector, edid);
>  		ret = drm_add_edid_modes(connector, edid);
> +		/* Store the ELD */
> +		drm_edid_to_eld(connector, edid);
>  		kfree(edid);
>  	} else {
>  		dev_dbg(hdmi->dev, "failed to get edid\n");
> @@ -1725,6 +1727,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>  		audio.base = hdmi->regs;
>  		audio.irq = irq;
>  		audio.hdmi = hdmi;
> +		audio.eld = hdmi->connector.eld;
>  
>  		pdevinfo.name = "dw-hdmi-ahb-audio";
>  		pdevinfo.data = &audio;
> -- 
> 1.8.3.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
