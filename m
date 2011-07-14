From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Jul 2011 13:16:31 +0100
Subject: [alsa-devel] [RFC PATCH] ASoC: codecs: add codec driver for
	MFD mc13783
In-Reply-To: <1310131198-493-1-git-send-email-J.Lambrecht@televic.com>
References: <1310131198-493-1-git-send-email-J.Lambrecht@televic.com>
Message-ID: <20110714121630.GA14249@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 03:19:58PM +0200, J??rgen Lambrecht wrote:
> Sascha Hauer's driver from Pengutronix' imx-sound branch.
> Added some code found in a linux 2.6.33.
> Needs further work and cleanup.

*Always* CC maintainers, and follow all the other advice in
SubmittingPatches too.
> @@ -37,6 +37,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_MAX98095 if I2C
>  	select SND_SOC_MAX9850 if I2C
>  	select SND_SOC_MAX9877 if I2C
> +	select SND_SOC_MC13783 if SPI
>  	select SND_SOC_PCM3008
>  	select SND_SOC_SGTL5000 if I2C

I'm pretty sure this is a MFD...

> +#define MC13783_REG_CACHE_SIZE	42
> +
> +struct mc13783_priv {
> +	struct snd_soc_codec codec;
> +	struct mc13783 *mc13783;
> +
> +	u32 reg_cache[MC13783_REG_CACHE_SIZE];

Use the standard cache infrastructure please - soc-cache.c.

> +	if (dai->id == MC13783_ID_STEREO_DAC)
> +		mc13783_write(codec, PMIC_AUDIO_DAC, reg);
> +	else
> +		mc13783_write(codec, PMIC_AUDIO_CODEC, reg);

Here and in several other places in your driver you should use
snd_soc_update_bits().

> +static int mc13783_pcm_get(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
> +	int val;
> +
> +	val = mc13783_read(codec, PMIC_AUDIO_RX_0);
> +	ucontrol->value.enumerated.item[0] = (val >> RX_0_ADDSTDC) & 1;
> +	printk(KERN_DEBUG "pcm_get %d\n", ucontrol->value.enumerated.item[0]);

If this were useful it should be dev_dbg() but I suspect it's not.
Similarly for all the other debug prints.

> +
> +	r36 = mc13783_read(codec, PMIC_AUDIO_RX_0);
> +	r37 = mc13783_read(codec, PMIC_AUDIO_RX_1);


You've meaningful constants for the register names and now you use magic
numbers.... :)

> +	if (ucontrol->value.enumerated.item[0]) {
> +		r36 |= (1 << RX_0_ADDRXIN);
> +		r37 |= (1 << RX_1_ARXINEN);
> +	} else {
> +		r36 &= ~(1 << RX_0_ADDRXIN);
> +		r37 &= ~(1 << RX_1_ARXINEN);
> +	}

This stuff is all rather abstruse but it looks like you want two mono
controls rather than a gang control for the bidirectional control.

> +static int mc13783_capure_cache;
> +
> +static int mc13783_get_capture(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	ucontrol->value.enumerated.item[0] = mc13783_capure_cache;
> +	return 0;
> +}

Use the device data.

> +	mc13783_capure_cache = ucontrol->value.enumerated.item[0];
> +	r38 &= ~(AMC1REN | AMC2EN | ATXINEN | RXINREC | AMC1LEN);

This looks awfully like it should be done in DAPM.

> +	SOC_SINGLE("PCM Playback Volume", PMIC_AUDIO_RX_1, 6, 15, 0),

dB infomration please.

> +static int mc13783_probe(struct snd_soc_codec *codec)
> +{
> +	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
> +	int i, ret = 0;
> +
> +	/* these are the reset values */
> +	priv->reg_cache[PMIC_AUDIO_RX_0]  = (1 << RX_0_HSPGDIG); //0x001000;
> +	priv->reg_cache[PMIC_AUDIO_RX_1]  = 0x00d35A;
> +	priv->reg_cache[PMIC_AUDIO_TX]    = 0x420000;
> +	priv->reg_cache[PMIC_SSI_NETWORK] = 0x013060;
> +	priv->reg_cache[PMIC_AUDIO_CODEC] = 0x180027;
> +	priv->reg_cache[PMIC_AUDIO_DAC]   = 0x0e0004;

Use any arrray to initialize.

> +	snd_soc_add_controls(codec, mc13783_control_list,
> +			     ARRAY_SIZE(mc13783_control_list));

Use the data in the card to set this up.
