From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Aug 2018 15:53:55 +0100
Subject: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
In-Reply-To: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
Message-ID: <20180829145355.GD27808@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 05:47:26PM +0300, Codrin Ciubotariu wrote:

> +static const unsigned int wm8731_rates_12288000[] = {
> +	8000, 32000, 48000, 96000,
> +};
> +
> +static struct snd_pcm_hw_constraint_list wm8731_constraints_12288000 = {
> +	.list = wm8731_rates_12288000,
> +	.count = ARRAY_SIZE(wm8731_rates_12288000),
> +};
> +
> +static int snd_proto_startup(struct snd_pcm_substream *substream)
> +{
> +	/* Setup constraints, because there is a 12.288 MHz XTAL on the board */
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +				   SNDRV_PCM_HW_PARAM_RATE,
> +				   &wm8731_constraints_12288000);
> +	return 0;
> +}

This bit is better added to the CODEC driver since it'll apply to any
system where there's this clock rate (someone else could come in and add
other rates, no need to do that yourself though it'd be nice of course).

That also has the nice bonus that with that I think you'd be able to use
the graph card rather than a custom driver?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180829/7bf525a1/attachment.sig>
