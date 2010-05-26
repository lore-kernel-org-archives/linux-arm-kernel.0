From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Wed, 26 May 2010 12:07:21 +0100
Subject: [alsa-devel] [RFC PATCH v2 1/3] ep93xx i2s audio driver
In-Reply-To: <1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
	<1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
Message-ID: <1274872041.3240.158.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-26 at 17:09 +1200, Ryan Mallon wrote:
> Add ep93xx i2s audio driver
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>  sound/soc/Kconfig             |    1 +
>  sound/soc/Makefile            |    1 +
>  sound/soc/ep93xx/Kconfig      |    9 +
>  sound/soc/ep93xx/Makefile     |    8 +
>  sound/soc/ep93xx/ep93xx-i2s.c |  489 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/ep93xx/ep93xx-i2s.h |   25 ++
>  sound/soc/ep93xx/ep93xx-pcm.c |  323 +++++++++++++++++++++++++++
>  sound/soc/ep93xx/ep93xx-pcm.h |   22 ++
>  8 files changed, 878 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/ep93xx/Kconfig
>  create mode 100644 sound/soc/ep93xx/Makefile
>  create mode 100644 sound/soc/ep93xx/ep93xx-i2s.c
>  create mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
>  create mode 100644 sound/soc/ep93xx/ep93xx-pcm.c
>  create mode 100644 sound/soc/ep93xx/ep93xx-pcm.h
> 

Overall looks OK, just some comments below.

> +static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info)
> +{
> +	int i;
> +
> +	/* Enable clocks */
> +	clk_enable(info->mclk);
> +	clk_enable(info->sclk);
> +	clk_enable(info->lrclk);
> +
> +	/* Enable i2s */
> +	ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 1);
> +
> +	/* Enable fifos */
> +	for (i = 0; i < 3; i++) {
> +		ep93xx_i2s_write_reg(info, EP93XX_I2S_RX0EN + (i * 4), 1);
> +		ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN + (i * 4), 1);

Just curious, do we always need to enable both the RX and TX FIFOs ? Is
there unnecessary system overhead here when we have playback only or
capture only use cases ?


> +static void ep93xx_pcm_buffer_started(void *cookie,
> +				      struct ep93xx_dma_buffer *buf)
> +{
> +}

Do we need this ?



> +
> +static int ep93xx_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

This can be removed

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
