From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Nov 2009 11:11:16 +0000
Subject: [alsa-devel] [PATCH 06/12] imx-ssi sound driver
In-Reply-To: <1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20091120111115.GA1316@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 04:48:20PM +0100, Sascha Hauer wrote:

This looks pretty good overall, but it'd be nice to split the DMA bits
out into a separate file simply because this is how the code is normally
structured.  Given all the conditionals for the FIQ/DMA selection in the
DMA code I did wonder if it might not be easiest to just have separate
DMA drivers for the two (probably sharing some routines that are
identical).  

Right now the conditionals are spread out through the driver which feels
a bit intrusive given that the selection between the two models will be
done once.  A split like that should also make it easier for someone to
swap in SDMA support at some point in the future, I'd hope.

Otherwise my comments are all very minor, though I've not tried running
it up on an actual platform and verifying the functionality yet:

> --- /dev/null
> +++ b/sound/soc/imx/imx-ssi.c
> @@ -0,0 +1,1349 @@

> +#include "../codecs/ac97.h"

Why do you need to include the header for a particular CODEC driver in a
CPU DAI driver?  I didn't actually notice any references to it in the
code so perhaps it could just be deleted.

> +
> +/*
> + * SSI DAI format configuration.
> + * Should only be called when port is inactive (i.e. SSIEN = 0).
> + * Note: We don't use the I2S modes but instead manually configure the
> + * SSI for I2S.

Might be nice to carry on the comment and explain why not :)

> +#define IMX_SSI_RATES \
> +	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
> +	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
> +	SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> +	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
> +	SNDRV_PCM_RATE_96000)

SNDRV_PCM_RATE_8000_96000

> +static int snd_imx_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Remove this if it's not needed.

> +device_initcall(imx_ssi_init);

It take it this is required for the FIQ?
