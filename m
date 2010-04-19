From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 19 Apr 2010 12:35:15 +0100
Subject: [PATCH 2/4] ASoC: split pxa ssp for reusing code
In-Reply-To: <w2j771cded01004162234j579e1ea9p604fde978b680545@mail.gmail.com>
References: <w2j771cded01004162234j579e1ea9p604fde978b680545@mail.gmail.com>
Message-ID: <1271676915.3208.60.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-04-17 at 13:34 +0800, Haojian Zhuang wrote:
> >From 74dd48ef72989fec0ad706c192784d487f219cc5 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 31 Mar 2010 15:28:37 -0400
> Subject: [PATCH] ASoC: split pxa ssp for reusing code
> 
> Since basic SSP features are shared between PXA2xx and PXA168, the difference
> is focused on clock generating. Now split ssp code into two parts. One is for
> general ssp feature. The other is for pxa2xx parts.
> 
> Update the SSP timing configuration in hw_params(). The SSP timing is verified
> on I2S and Left J interface of PXA168 with 16-bit sample stream.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

> +
> +/*
> + * Set up the SSP DAI format.
> + * The SSP Port must be inactive before calling this function as the
> + * physical interface format is changed.
> + */
> +static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
> +				unsigned int fmt)
> +{
> +	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
> +	u32 sscr0;
> +	u32 sscr1;
> +	u32 sspsp;
> +
> +	/* check if we need to change anything at all */
> +	if (priv->dai_fmt == fmt)
> +		return 0;
> +
> +	pxa_ssp_disable(ssp);

It's better to check if the SSP port is active here and return an error
as duplex streams can call this twice. Disabling the link here, even for
a small time period, could cause an unwanted audible pop/click. 


>  #endif
> diff --git a/sound/soc/pxa/pxa2xx-ssp.c b/sound/soc/pxa/pxa2xx-ssp.c
> new file mode 100644
> index 0000000..eff5334
> --- /dev/null
> +++ b/sound/soc/pxa/pxa2xx-ssp.c
> @@ -0,0 +1,318 @@
> +/*
> + * pxa2xx-ssp.c  --  ALSA Soc Audio Layer
> + *
> + * Copyright 2005,2008 Wolfson Microelectronics PLC.
> + * Author: Liam Girdwood

I'd appreciate my email address here :)

> +/*
> + * Set the SSP ports SYSCLK.
> + */
> +static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> +				int clk_id, unsigned int freq, int dir)
> +{
> +	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
> +	int val;
> +
> +	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
> +		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
> +
> +	dev_dbg(&ssp->pdev->dev,
> +		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
> +		cpu_dai->id, clk_id, freq);
> +
> +	switch (clk_id) {
> +	case PXA2XX_SSP_CLK_NET_PLL:
> +		sscr0 |= SSCR0_MOD;
> +		break;
> +	case PXA2XX_SSP_CLK_PLL:
> +		/* Internal PLL is fixed */
> +		if (cpu_is_pxa25x())
> +			priv->sysclk = 1843200;
> +		else
> +			priv->sysclk = 13000000;
> +		break;
> +	case PXA2XX_SSP_CLK_EXT:
> +		priv->sysclk = freq;
> +		sscr0 |= SSCR0_ECS;
> +		break;
> +	case PXA2XX_SSP_CLK_NET:
> +		priv->sysclk = freq;
> +		sscr0 |= SSCR0_NCS | SSCR0_MOD;
> +		break;
> +	case PXA2XX_SSP_CLK_AUDIO:
> +		priv->sysclk = 0;
> +		pxa_ssp_set_scr(ssp, 1);
> +		sscr0 |= SSCR0_ACS;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	/* The SSP clock must be disabled when changing SSP clock mode
> +	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
> +	if (!cpu_is_pxa3xx())
> +		clk_disable(ssp->clk);

Again, we want to check were are not disabling any clocks when the SSP
is active (i.e. for duplex streams).

This all looks fine except for the handling of duplex streams. e.g.
start aplay and then arecord. The arecord sequence here will re-call the
same DAI ops and temporarily disable the playback. This may or may not
cause clicks on your test board but it's best to avoid.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
