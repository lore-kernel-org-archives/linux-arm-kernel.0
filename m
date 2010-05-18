From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 May 2010 19:44:33 +0100
Subject: [RFC PATCH 3/3] ep93xx i2s snapper cl15 support
In-Reply-To: <4BF21DB0.2070908@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com>
	<4BF21DB0.2070908@bluewatersys.com>
Message-ID: <20100518184433.GE22554@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 04:55:12PM +1200, Ryan Mallon wrote:

> +//#define CODEC_CLOCK 11289600
> +#define CODEC_CLOCK 5644800

Hrm?

> +
> +static int snappercl15_startup(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Remove this and all other empty functions.

> +static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
> +{
> +	printk(KERN_INFO "%s - here\n", __FUNCTION__);

Debug code, should probably be removed or at least make pr_debug().

> +	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
> +	snd_soc_dapm_enable_pin(codec, "Line In");
> +	snd_soc_dapm_enable_pin(codec, "Mic Jack");

No need to enable pins, this is the default condition.  You could mark
any unused pins on the CODEC as _nc_pin() though.

> +	snd_soc_dapm_sync(codec);

The core should take care of this for you (so many machines need it that
it was pulled in).
