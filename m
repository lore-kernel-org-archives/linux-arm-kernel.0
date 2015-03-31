From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 31 Mar 2015 11:10:34 +0200
Subject: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
In-Reply-To: <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
Message-ID: <1427793034.2969.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, den 30.03.2015, 20:40 +0100 schrieb Russell King:
> Add a helper to create the IEC958 channel status from an ALSA
> snd_pcm_runtime structure, taking account of the sample rate.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  include/sound/pcm_iec958.h |  9 ++++++
>  sound/core/Kconfig         |  3 ++
>  sound/core/Makefile        |  2 ++
>  sound/core/pcm_iec958.c    | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 84 insertions(+)
>  create mode 100644 include/sound/pcm_iec958.h
>  create mode 100644 sound/core/pcm_iec958.c
> 
> diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
> new file mode 100644
> index 000000000000..0eed397aca8e
> --- /dev/null
> +++ b/include/sound/pcm_iec958.h
> @@ -0,0 +1,9 @@
> +#ifndef __SOUND_PCM_IEC958_H
> +#define __SOUND_PCM_IEC958_H
> +
> +#include <linux/types.h>
> +
> +int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> +	size_t len);
> +
> +#endif
> diff --git a/sound/core/Kconfig b/sound/core/Kconfig
> index b534c8a6046b..1507469425ec 100644
> --- a/sound/core/Kconfig
> +++ b/sound/core/Kconfig
> @@ -9,6 +9,9 @@ config SND_PCM
>  config SND_PCM_ELD
>  	bool
>  
> +config SND_PCM_IEC958
> +	bool
> +
>  config SND_DMAENGINE_PCM
>  	tristate
>  
> diff --git a/sound/core/Makefile b/sound/core/Makefile
> index 591b49157b4d..70ea06712ec2 100644
> --- a/sound/core/Makefile
> +++ b/sound/core/Makefile
> @@ -14,10 +14,12 @@ snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
>  		pcm_memory.o memalloc.o
>  snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
>  snd-pcm-$(CONFIG_SND_PCM_ELD) += pcm_drm_eld.o
> +snd-pcm-$(CONFIG_SND_PCM_IEC958) += snd-pcm-iec958.o
>  
>  # for trace-points
>  CFLAGS_pcm_lib.o := -I$(src)
>  
> +snd-pcm-iec958-objs := pcm_iec958.o
>  snd-pcm-dmaengine-objs := pcm_dmaengine.o

This fails to build for me on 4.0-rc6:
make[2]: *** No rule to make target 'sound/core/snd-pcm-iec958.o', needed by 'sound/core/snd-pcm.o'.  Stop.
scripts/Makefile.build:403: recipe for target 'sound/core' failed

unless I change it to either:
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -14,7 +14,8 @@ snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
                pcm_memory.o memalloc.o
 snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
 snd-pcm-$(CONFIG_SND_PCM_ELD) += pcm_drm_eld.o
-snd-pcm-$(CONFIG_SND_PCM_IEC958) += snd-pcm-iec958.o
+
+obj-$(CONFIG_SND_PCM_IEC958) += snd-pcm-iec958.o
 
 # for trace-points
 CFLAGS_pcm_lib.o := -I$(src)

or:
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -14,12 +14,11 @@ snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
                pcm_memory.o memalloc.o
 snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
 snd-pcm-$(CONFIG_SND_PCM_ELD) += pcm_drm_eld.o
-snd-pcm-$(CONFIG_SND_PCM_IEC958) += snd-pcm-iec958.o
+snd-pcm-$(CONFIG_SND_PCM_IEC958) += pcm_iec958.o
 
 # for trace-points
 CFLAGS_pcm_lib.o := -I$(src)
 
-snd-pcm-iec958-objs := pcm_iec958.o
 snd-pcm-dmaengine-objs := pcm_dmaengine.o
 
 snd-rawmidi-objs  := rawmidi.o

regards
Philipp
