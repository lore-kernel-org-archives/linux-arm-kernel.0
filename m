From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Feb 2011 15:00:14 +0000
Subject: [PATCH 1/4] ASoC: Add TI tlv320aic32x4 codec support.
In-Reply-To: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
References: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20110228150014.GI13869@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 25, 2011 at 02:42:47PM +0100, Javier Martin wrote:

> +#define aic32x4_reset(c) snd_soc_write(c, AIC32X4_RESET, 0x01);

Make this a proper function.

> +	SOC_DOUBLE_R_AIC32X4("HP Driver Gain", AIC32X4_HPLGAIN,
> +			AIC32X4_HPRGAIN, 0, 0x23, 0),
> +	SOC_DOUBLE_R_AIC32X4("LO Driver Gain", AIC32X4_LOLGAIN,
> +			AIC32X4_LORGAIN, 0, 0x23, 0),

These should be Volume controls, ideally with TLV information.

> +	SOC_DOUBLE_R("ADC Volume Level", AIC32X4_LADCVOL,
> +			AIC32X4_RADCVOL, 0, 0x28, 0),
> +	SOC_DOUBLE_R("PGA Gain Level", AIC32X4_LMICPGAVOL,
> +			AIC32X4_RMICPGAVOL, 0, 0x5f, 0),

Again, Volume controls.  All gain controls are Volume controls.

> +	SOC_SINGLE("Auto-mute", AIC32X4_DACMUTE, 4, 7, 0),

... Switch.

> +	SOC_SINGLE("MIC BIAS", AIC32X4_MICBIAS, 6, 1, 0),

This should not be user visible, this should be a DAPM widget.

> +static const struct aic32x4_configs aic32x4_reg_init[] = {
> +	{AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE},

What are these "aic32x4_configs" all about?  They look like you're
setting non-default configurations...

> +static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
> +	SOC_DAPM_SINGLE("L_DAC switch", AIC32X4_HPLROUTE, 3, 1, 0),
> +	SOC_DAPM_SINGLE("IN1_L switch", AIC32X4_HPLROUTE, 2, 1, 0),

Switch (similarly for other DAPM controls).

> +	if (codec->hw_write(codec->control_data, data, 2) == 2)
> +		return 0;
> +	else
> +		return -EIO;

Ideally if this returned an error code you'd return that.

> +int snd_soc_get_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	int reg = kcontrol->private_value & 0xff;
> +	int reg2 = (kcontrol->private_value >> 24) & 0xff;
> +	int mask;
> +	int shift;
> +	unsigned short val, val2;
> +
> +	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
> +		mask = 0xff;
> +		shift = 0;
> +	} else if ((!strcmp(kcontrol->id.name, "HP Driver Gain")) ||
> +		   (!strcmp(kcontrol->id.name, "LO Driver Gain"))) {
> +		mask = 0x3F;
> +		shift = 0;
> +	} else if (!strcmp(kcontrol->id.name, "PGA Capture Volume")) {
> +		mask = 0x7F;
> +		shift = 0;
> +	} else {
> +		printk(KERN_ERR "aic32x4: invalid kcontrol name\n");
> +		return -1;
> +	}

According to the info callback you're actually passing the mask in
through the private data and the shift is always zero so there's no need
to do these strcmp().

> +	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
> +		ucontrol->value.integer.value[0] =
> +		    (val <= 48) ? (val + 127) : (val - 129);
> +		ucontrol->value.integer.value[1] =
> +		    (val2 <= 48) ? (val2 + 127) : (val2 - 129);

This looks awfully like the code that was added in the SGTL5000 driver
for volume controls there - this really needs to be factored out into a
standard macro.

> +static struct i2c_driver aic32x4_i2c_driver = {
> +	.driver = {
> +		.name = "tlv320aic32x4-codec",
> +		.owner = THIS_MODULE,

Drop the -codec from the driver name, it's redundant.

> +{
> +	int ret = 0;
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +	ret = i2c_add_driver(&aic32x4_i2c_driver);
> +	if (ret != 0) {
> +		printk(KERN_ERR "Failed to register aic32x4 I2C driver: %d\n",
> +		       ret);
> +	}
> +#endif

Remove the ifdefs if the driver doesn't support non-I2C buses.
