From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 9 Jul 2011 04:00:08 +0100
Subject: [PATCH 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <1310140790-2132-4-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-4-git-send-email-b29396@freescale.com>
Message-ID: <20110709030008.GD26900@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 11:59:43PM +0800, Dong Aisheng wrote:
> The driver only supports playback firstly.

Once more, *always* CC maintainers.

> +struct mxs_audio_platform_data {
> +	int sysclk;
> +
> +	int (*init) (void);     /* board specific init */
> +	int (*finit) (void);    /* board specific finit */

Eh?  Your machine driver is already entirely board specific...

> +	/* The SAIF clock should be either 512*fs or 384*fs */
> +	card_priv.sysclk = 512 * rate;
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, MXS_SAIF_SYS_CLK,
> +			card_priv.sysclk,
> +			SND_SOC_CLOCK_OUT);

Why are you storing the sysclk?  You never reference it again and
you're using different sysclks for everything in the system.

> +	/* set SGTL5000_SYSCLK as 256*fs to support 96k sample rate */
> +	snd_soc_dai_set_sysclk(codec_dai, SGTL5000_SYSCLK, 256 * rate, 0);
> +
> +	/* The MCLK output rate is 256*fs */
> +	snd_soc_dai_set_clkdiv(cpu_dai, MXS_SAIF_MCLK, 256);

Why are you not checking errors on these?

> +static int mxs_sgtl5000_soc_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	/* TBD: add dapm widgets */
> +
> +	return 0;
> +}

Remove empty functions.

> +static int __devinit mxs_sgtl5000_probe(struct platform_device *pdev)
> +{
> +	struct mxs_audio_platform_data *plat = pdev->dev.platform_data;
> +	int ret;
> +
> +	card_priv.pdev = pdev;
> +
> +	ret = -EINVAL;
> +	if (plat && plat->init && plat->init())
> +		return ret;

You're not calling snd_soc_register_card()...

> +	mxs_sgtl5000_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!mxs_sgtl5000_snd_device)
> +		return -ENOMEM;

...and you're using both a platform device and soc-audio to instantate
which is a bit confused.  New code should not be using soc-audio.
