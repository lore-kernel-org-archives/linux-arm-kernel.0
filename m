From: ykk@rock-chips.com (Yang Kuankuan)
Date: Tue, 31 Mar 2015 04:30:39 -0400
Subject: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
In-Reply-To: <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
Message-ID: <551A5B2F.50203@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 03/30/2015 03:40 PM, Russell King wrote:
> Add a helper to create the IEC958 channel status from an ALSA
> snd_pcm_runtime structure, taking account of the sample rate.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   include/sound/pcm_iec958.h |  9 ++++++
>   sound/core/Kconfig         |  3 ++
>   sound/core/Makefile        |  2 ++
>   sound/core/pcm_iec958.c    | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 84 insertions(+)
>   create mode 100644 include/sound/pcm_iec958.h
>   create mode 100644 sound/core/pcm_iec958.c
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
>   config SND_PCM_ELD
>   	bool
>   
> +config SND_PCM_IEC958
> +	bool
> +
>   config SND_DMAENGINE_PCM
>   	tristate
>   
> diff --git a/sound/core/Makefile b/sound/core/Makefile
> index 591b49157b4d..70ea06712ec2 100644
> --- a/sound/core/Makefile
> +++ b/sound/core/Makefile
> @@ -14,10 +14,12 @@ snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
>   		pcm_memory.o memalloc.o
>   snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
>   snd-pcm-$(CONFIG_SND_PCM_ELD) += pcm_drm_eld.o
> +snd-pcm-$(CONFIG_SND_PCM_IEC958) += snd-pcm-iec958.o
>   
>   # for trace-points
>   CFLAGS_pcm_lib.o := -I$(src)
>   
> +snd-pcm-iec958-objs := pcm_iec958.o
>   snd-pcm-dmaengine-objs := pcm_dmaengine.o
>   
>   snd-rawmidi-objs  := rawmidi.o
> diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
> new file mode 100644
> index 000000000000..e1ff88a17dde
> --- /dev/null
> +++ b/sound/core/pcm_iec958.c
> @@ -0,0 +1,70 @@
> +/*
> + *  PCM DRM helpers
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License.
> + */
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <sound/asoundef.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_iec958.h>
> +
> +/**
> + * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
> + * @runtime: pcm runtime structure with ->rate filled in
> + * @cs: channel status buffer, at least four bytes
> + * @len: length of channel status buffer
> + *
> + * Create the consumer format channel status data in @cs of maximum size
> + * @len corresponding to the parameters of the PCM runtime @runtime.
> + *
> + * Drivers may wish to tweak the contents of the buffer after creation.
> + *
> + * Returns: length of buffer, or negative error code if something failed.
> + */
> +int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> +	size_t len)
> +{
> +	unsigned int fs;
> +
> +	if (len < 4)
> +		return -EINVAL;
> +
> +	switch (runtime->rate) {
> +	case 32000:
> +		fs = IEC958_AES3_CON_FS_32000;
> +		break;
> +	case 44100:
> +		fs = IEC958_AES3_CON_FS_44100;
> +		break;
> +	case 48000:
> +		fs = IEC958_AES3_CON_FS_48000;
> +		break;
> +	case 88200:
> +		fs = IEC958_AES3_CON_FS_88200;
> +		break;
> +	case 96000:
> +		fs = IEC958_AES3_CON_FS_96000;
> +		break;
> +	case 176400:
> +		fs = IEC958_AES3_CON_FS_176400;
> +		break;
> +	case 192000:
> +		fs = IEC958_AES3_CON_FS_192000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	memset(cs, 0, len);
> +
> +	cs[0] = IEC958_AES0_CON_NOT_COPYRIGHT | IEC958_AES0_CON_EMPHASIS_NONE;
> +	cs[1] = IEC958_AES1_CON_GENERAL;
> +	cs[2] = IEC958_AES2_CON_SOURCE_UNSPEC | IEC958_AES2_CON_CHANNEL_UNSPEC;
> +	cs[3] = IEC958_AES3_CON_CLOCK_1000PPM | fs;
> +

Pretty good, also suitable to rockchip platform, but why not add the
"IEC958_AES2_CON_CHANNEL_MASK" & "IEC958_AES2_CON_WORDLEN" ?

Seems sample frequency & channle number & word length are the basic
message :)

Best regards.
Yakir Yang

> +	return len;
> +}
> +EXPORT_SYMBOL(snd_pcm_create_iec958_consumer);
