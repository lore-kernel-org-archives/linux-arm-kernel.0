From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Oct 2015 14:52:42 +0100
Subject: [PATCH v2 2/2] ASoC: atmel-i2s: add driver for the new Atmel I2S
 controller
In-Reply-To: <f8dada26149491a584b83a59e8fcbec378ff6964.1443535188.git.cyrille.pitchen@atmel.com>
References: <cover.1443535188.git.cyrille.pitchen@atmel.com>
 <f8dada26149491a584b83a59e8fcbec378ff6964.1443535188.git.cyrille.pitchen@atmel.com>
Message-ID: <20151005135242.GP12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 04:09:20PM +0200, Cyrille Pitchen wrote:

> +	if (pending & ATMEL_I2SC_INT_RXOR) {
> +		mask = ATMEL_I2SC_SR_RXOR;
> +
> +		for (ch = 0; ch < ATMEL_I2SC_MAX_TDM_CHANNELS; ++ch)
> +			if (sr & ATMEL_I2SC_SR_RXORCH(ch)) {
> +				mask |= ATMEL_I2SC_SR_RXORCH(ch);
> +				dev_err(dev->dev,
> +					"RX overrun on channel %d\n", ch);
> +			}
> +		regmap_write(dev->regmap, ATMEL_I2SC_SCR, mask);
> +	}

Coding style - the for loop needs { } for legibility.

> +	if (pending & ATMEL_I2SC_INT_TXUR) {
> +		mask = ATMEL_I2SC_SR_TXUR;
> +
> +		for (ch = 0; ch < ATMEL_I2SC_MAX_TDM_CHANNELS; ++ch)
> +			if (sr & ATMEL_I2SC_SR_TXURCH(ch)) {
> +				mask |= ATMEL_I2SC_SR_TXURCH(ch);
> +				dev_err(dev->dev,
> +					"TX underrun on channel %d\n", ch);
> +			}
> +		regmap_write(dev->regmap, ATMEL_I2SC_SCR, mask);
> +
> +	}
> +
> +	return IRQ_HANDLED;

This IRQ_HANDLED should be generated only if one of the interrupts we
know about got handled - there was a check to see if any of the unmasked
bits is set earlier on in the function but that's not quite the same
check.

> +
> +static int atmel_i2s_prepare(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct atmel_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +	bool is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
> +	unsigned int rhr, sr = 0;
> +
> +	if (is_playback) {
> +		regmap_read(dev->regmap, ATMEL_I2SC_SR, &sr);
> +		if (sr & ATMEL_I2SC_SR_RXRDY) {
> +			dev_dbg(dev->dev, "RXRDY is set\n");
> +			regmap_read(dev->regmap, ATMEL_I2SC_RHR, &rhr);
> +		}
> +	}

What's this doing?  It just seems to do two reads and issue a debug
message...

> +static int atmel_i2s_sama5d2_mck_init(struct atmel_i2s_dev *dev,
> +				      struct device_node *np)
> +{
> +	#define SFR_I2SCLKSEL 0x90U
> +	struct regmap *sfr;
> +	int id;
> +
> +	id = of_alias_get_id(np, "i2s");
> +	if (id < 0) {
> +		dev_err(dev->dev, "failed to get alias ID\n");
> +		return id;
> +	}
> +	if (id > 1) {
> +		dev_err(dev->dev, "invalid I2S controller ID: %d\n", id);
> +		return -EINVAL;
> +	}

This didn't appear in the DT binding and looks pretty funky - what's
going on here?

> +	sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
> +	if (IS_ERR(sfr)) {
> +		dev_err(dev->dev, "failed to get SFR syscon\n");
> +		return PTR_ERR(sfr);
> +	}

This didn't appear in the binding either.

> +	/* Get hardware capabilities. */
> +	match = of_match_node(atmel_i2s_dt_ids, np);
> +	dev->caps = match ? match->data : NULL;

Please don't abuse the ternery operator like this, just write a normal
if statement :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/bb5e951a/attachment-0001.sig>
