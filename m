From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 31 Mar 2015 11:12:51 +0200
Subject: [PATCH RFC 08/11] sound/core: add DRM ELD helper
In-Reply-To: <E1YcfY5-0002vT-5K@rmk-PC.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfY5-0002vT-5K@rmk-PC.arm.linux.org.uk>
Message-ID: <1427793171.2969.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 30.03.2015, 20:40 +0100 schrieb Russell King:
> Add a helper for the EDID like data structure, which is typically passed
> from a HDMI adapter to its associated audio driver.  This informs the
> audio driver of the capabilities of the attached HDMI sink.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  include/sound/pcm_drm_eld.h |  6 +++
>  sound/core/Kconfig          |  3 ++
>  sound/core/Makefile         |  1 +
>  sound/core/pcm_drm_eld.c    | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 101 insertions(+)
>  create mode 100644 include/sound/pcm_drm_eld.h
>  create mode 100644 sound/core/pcm_drm_eld.c
> 
> diff --git a/include/sound/pcm_drm_eld.h b/include/sound/pcm_drm_eld.h
> new file mode 100644
> index 000000000000..93357b25d2e2
> --- /dev/null
> +++ b/include/sound/pcm_drm_eld.h
> @@ -0,0 +1,6 @@
> +#ifndef __SOUND_PCM_DRM_ELD_H
> +#define __SOUND_PCM_DRM_ELD_H
> +
> +int snd_pcm_hw_constraint_eld(struct snd_pcm_runtime *runtime, void *eld);
> +
> +#endif
> diff --git a/sound/core/Kconfig b/sound/core/Kconfig
> index 313f22e9d929..b534c8a6046b 100644
> --- a/sound/core/Kconfig
> +++ b/sound/core/Kconfig
> @@ -6,6 +6,9 @@ config SND_PCM
>  	tristate
>  	select SND_TIMER
>  
> +config SND_PCM_ELD
> +	bool
> +
>  config SND_DMAENGINE_PCM
>  	tristate
>  
> diff --git a/sound/core/Makefile b/sound/core/Makefile
> index 4daf2f58261c..591b49157b4d 100644
> --- a/sound/core/Makefile
> +++ b/sound/core/Makefile
> @@ -13,6 +13,7 @@ snd-$(CONFIG_SND_JACK)	  += jack.o
>  snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
>  		pcm_memory.o memalloc.o
>  snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
> +snd-pcm-$(CONFIG_SND_PCM_ELD) += pcm_drm_eld.o
>  
>  # for trace-points
>  CFLAGS_pcm_lib.o := -I$(src)
> diff --git a/sound/core/pcm_drm_eld.c b/sound/core/pcm_drm_eld.c
> new file mode 100644
> index 000000000000..78d551a1b05f
> --- /dev/null
> +++ b/sound/core/pcm_drm_eld.c
> @@ -0,0 +1,91 @@
> +/*
> + *  PCM DRM helpers
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License.
> + */

Should this say:

+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.

?

Same for patch 9.

regards
Philipp
