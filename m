From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 16 May 2011 22:25:34 +0100
Subject: [alsa-devel] [PATCH v2 1/3] ASoC: Asahi Kasei AK4641 codec driver
In-Reply-To: <1305579805-15617-2-git-send-email-mad_soft@inbox.ru>
References: <1305579805-15617-1-git-send-email-mad_soft@inbox.ru>
	<1305579805-15617-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <20110516212533.GA2570@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 01:03:23AM +0400, Dmitry Artamonow wrote:
> A driver for the AK4641 codec used in iPAQ hx4700 and Glofiish M800
> among others.

This looks pretty good - a few small issues realting to the use of old
APIs and coding standards below but nothing serious.

> +static int ak4641_sync(struct snd_soc_codec *codec)
> +{
> +	u8 *cache = codec->reg_cache;
> +	int i, r = 0;
> +
> +	for (i = 0; i < AK4641_CACHEREGNUM; i++)
> +		r |= snd_soc_write(codec, i, cache[i]);
> +
> +	return r;
> +};

You should be able to use snd_soc_cache_sync() instead of open coding
this.  There's also a stray ; in there.

> +
> +static int ak4641_add_widgets(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +	snd_soc_dapm_new_controls(dapm, ak4641_dapm_widgets,
> +				  ARRAY_SIZE(ak4641_dapm_widgets));
> +
> +	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
> +
> +	snd_soc_dapm_new_widgets(dapm);
> +	return 0;

You should be able to convert these to data based init using the
dapm_widgets and dapm_routes fields in the CODEC driver.

> +	u8 mode2 = snd_soc_read(codec, AK4641_MODE2) & ~(0x3 << 5);

Use snd_soc_update_bits() to do a read/modify/write cycle rather than
open coding it - it's clearer and will save writing when there's no
change.  A similar thing applies in several of the other DAI operations
and set_bias_level().
