From: dp@opensource.wolfsonmicro.com (Dimitris Papastamos)
Date: Mon, 17 Jan 2011 10:30:10 +0000
Subject: [alsa-devel] [PATCH] ASoC: CS4271 codec support
In-Reply-To: <1295217350.16460.11.camel@r60e>
References: <1295217350.16460.11.camel@r60e>
Message-ID: <1295260210.11031.38.camel@dplaptop.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-17 at 01:35 +0300, Alexander wrote:
> +/* CS4271 default register settings, except auto-mute is off */
> +static const u8 cs4271_dflt_reg[CS4271_NR_REGS] = {
> +	0, 0, 0, CS4271_DACVOL_ATAPI_AL_BR, 0, 0, 0,
> +	CS4271_MODE2_CPEN | CS4271_MODE2_PDN,
> +};

I'd be better to leave these as defaults, and perform any initialization
in the the cs4271_probe() function.

> +	/* Configure DAC */
> +	val = cs4271_clk_tab[i].speed_mode;
> +
> +	if (cs4271->master)
> +		val |= cs4271_clk_tab[i].mclk_master | CS4271_MODE1_MASTER;
> +	else
> +		val |= cs4271_clk_tab[i].mclk_slave;

This should ideally live in cs4271_set_dai_fmt().

> +	switch (cs4271->mode) {
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		val |= CS4271_MODE1_DAC_DIF_LJ;
> +		break;
> +	case SND_SOC_DAIFMT_I2S:
> +		val |= CS4271_MODE1_DAC_DIF_I2S;
> +		break;
> +	default:
> +		dev_err(codec->dev, "Invalid DAI format\n");
> +		return -EINVAL;
> +	}

Same here.

> +/* CS4271 controls */
> +static DECLARE_TLV_DB_SCALE(cs4271_dac_tlv, -12700, 100, 0);

Are you use this doesn't mute the DAC?  If so the the last parameter
should be 1.

> +#ifdef CONFIG_PM
> +static int cs4271_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
> +{
> +	/* Set power-down bit */
> +	snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN,
> +		CS4271_MODE2_PDN);
> +
> +	return 0;
> +}
> +#else
> +#define cs4271_soc_suspend	NULL
> +#endif /* CONFIG_PM */
> +
> +/* This function used also in codec probe function and not only for PM */
> +static int cs4271_soc_resume(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +
> +	/* Restore codec state */
> +	ret = cs4271_write_cache(codec);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* then disable the power-down bit */
> +	snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
> +
> +	return 0;
> +}

Consider setting the set_bias_level callback and performing the required
work in there.  You can then trigger a change in the bias levels by
calling your cs4271_set_bias_level() function from within your suspend()
and resume() functions.

> +	/*
> +	 * In case of I2C, chip address specified in board data.
> +	 * So cache IO operations use 8 bit codec register address.
> +	 * In case of SPI, chip address and register address
> +	 * passed together as 16 bit value.
> +	 * Anyway, register address is masked with 0xFF inside
> +	 * soc-cache code.
> +	 */

Have you tested your driver using both SPI and I2C?

> +	ret = (cs4271->bus_type == SND_SOC_SPI) ? 16 : 8;

Please avoid using the ternary operator like this.

> +	ret = snd_soc_codec_set_cache_io(codec, ret, 8, cs4271->bus_type);
> +	if (ret) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cs4271_soc_resume(codec);
> +	if (ret < 0)
> +		return ret;

This should also changed to a call to
cs4271_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

> +	.reg_cache_default	= &cs4271_dflt_reg,

No need to use address-of operator here.

> +	.reg_cache_step		= 1,

No need to initialize reg_cache_step.

Thanks,
Dimitris
