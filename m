From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 11 Mar 2012 11:38:48 +0000
Subject: [PATCH 1/4] add a mc13783 codec driver
In-Reply-To: <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120311113848.GA3233@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 03:55:13PM +0100, Philippe R?tornaz wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> sha 20111307:
> - rebased to 3.0-rc2
> - implement tdm slot settings
> - made it work with single ssi port
> - more register names instead of hardcoded numbers
> 
> philippe 20120803:
> - Add headset detection
> - add mic2 bias
> - enable headset output by default

If including stuff like this please include it after the ---.  Things
like notes about the odd arrangements with the SSI ports which will have
ongoing meaning are much more useful in the changelog.

Overall this looks fairly clean but very out of date, for example
there's a custom register cache impelementation and no DAPM.

> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 7122386..7b7b55e 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -807,7 +807,8 @@ err_revision:
>  		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
>  
>  	if (mc13xxx->flags & MC13XXX_USE_CODEC)
> -		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
> +					pdata->codec, sizeof(*pdata->codec));
>  
>  	if (mc13xxx->flags & MC13XXX_USE_RTC)
>  		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");

It's probably worth pushing the MFD updates separately to Samuel,
ideally they could go in during the next merge window even if the CODEC
driver doesn't make it.

>  	select SND_SOC_MAX98095 if I2C
>  	select SND_SOC_MAX9850 if I2C
>  	select SND_SOC_MAX9877 if I2C
> +	select SND_SOC_MC13783 if SPI
>  	select SND_SOC_PCM3008

This should depend on the MFD core, not the bus - it won't build without
the MFD core.

> +struct mc13783_priv {
> +	struct snd_soc_codec codec;
> +	struct mc13xxx *mc13xxx;
> +
> +	u32 reg_cache[42];

No custom register caches please (use the framework), and magic numbers
are generally bad.  Ideally the MFD would be converted over to regmap
which would give even more of a win.

> +	/* DAI clock master masks */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		val |= AUDIO_C_CLK_EN;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		val |= AUDIO_CSM;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		return -EINVAL;
> +	}
> +
> +	val |= AUDIO_C_RESET;
> +
> +	mc13783_write(codec, reg, val);

This would be better using snd_soc_update_bits(), that way repeated
calls won't actually write to the hardware.  A similar issue applies
throughout, in some cases it looks like this will also fix locking
issues with doing read/modify/writes on partial register bits.

> +static int mc13783_set_fmt_sync(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	int ret;
> +
> +	ret = mc13783_set_fmt(dai, fmt, MC13783_AUDIO_DAC);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * In synchronous mode force the voice codec into slave mode
> +	 * so that the clock / framesync from the stereo DAC is used
> +	 */
> +	fmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
> +	fmt |= SND_SOC_DAIFMT_CBS_CFS;
> +	ret = mc13783_set_fmt(dai, fmt, MC13783_AUDIO_CODEC);

This looks like you want to be complaining about some invalid setups?

> +static void mc13783_startup(struct snd_soc_dai *dai, int reg)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int val;
> +
> +	val = mc13783_read(codec, reg);
> +	val &= ~AUDIO_C_RESET;
> +	val |= AUDIO_C_EN;
> +	mc13783_write(codec, reg, val);
> +}

This looks like it should be either DAPM or set_bias_level...

> +static void mc13783_shutdown(struct snd_soc_dai *dai, int reg)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int val;
> +
> +	val = mc13783_read(codec, reg);
> +	mc13783_write(codec, reg, val & ~AUDIO_C_EN);
> +}

...and I suspect there's issues with simultaneous playback and record.

> +static int mc13783_capure_cache;

Don't use global statics, use the private data.

> +static const char *mc13783_asp[] = {"Off", "Codec", "Right"};
> +static const char *mc13783_alsp[] = {"Off", "Codec", "Right"};
> +
> +static const char *mc13783_ahs[] = {"Codec", "Mixer"};
> +
> +static const char *mc13783_ahsout[] = {"Off", "Auto", "On"};
> +
> +static const char *mc13783_arxout[] = {"Codec", "Mixer"};

A lot of this looks like it should be in DAPM - it looks like routing
control.

> +static const char *mc13783_capture[] = {"off/off", "rxinl/rxinr",
> +	"mc1lin/mc1rin", "off/mc1rin", "off/mc2in", "mc1lin/mc2in",
> +	"off/txin", "mc1lin/txin", "mc1lin/rxinr", "mc1lin/off"};

This does too, looking at the code that implements the enum it appears
that the chip is more flexible than the what's being offered here, it
looks like there's a bunch of separate controls.

> +	SOC_SINGLE("MC1 Bias enable", 38, 0, 1, 0),
> +	SOC_SINGLE("MC2 Bias enable", 38, 1, 1, 0),

This should definitely be DAPM, users shouldn't have to manually control
the bias from userspace.

> +	priv = kzalloc(sizeof(struct mc13783_priv), GFP_KERNEL);
> +	if (priv == NULL)
> +		return -ENOMEM;

devm_kzalloc() (which will fix a memory leak on remove).

> +static __init int mc13783_init(void)
> +{
> +	return platform_driver_register(&mc13783_codec_driver);
> +}

module_platform_driver().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120311/a52a16e6/attachment-0001.sig>
