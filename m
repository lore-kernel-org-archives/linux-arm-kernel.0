From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jul 2011 17:58:21 +0200
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <1310483085-31442-4-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
Message-ID: <20110713155821.GL1928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 11:04:38PM +0800, Dong Aisheng wrote:
> The driver only supports playback firstly.
> For recording, as we have to use two saif instances to implement full
> duplex (playback & recording) due to hardware limitation, we need to
> figure out a good design to fit in ASoC.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  sound/soc/mxs/mxs-sgtl5000.c |  170 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 170 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
> new file mode 100644
> index 0000000..be9b5d5
> --- /dev/null
> +++ b/sound/soc/mxs/mxs-sgtl5000.c
> @@ -0,0 +1,170 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

No parameters here, drop it.

> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/gpio.h>

The last three, too.

> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/jack.h>
> +#include <sound/soc-dapm.h>
> +#include <asm/mach-types.h>
> +
> +#include "../codecs/sgtl5000.h"
> +#include "mxs-saif.h"
> +
> +static int mxs_sgtl5000_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	unsigned int rate = params_rate(params);

Here you initialize 'rate'...

> +	u32 dai_format, mclk;
> +	int ret;
> +
> +	/* sgtl5000 does not support 512*rate when in 96000 fs */
> +	rate = params_rate(params);

...so this line can go.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/dcaca5af/attachment.sig>
