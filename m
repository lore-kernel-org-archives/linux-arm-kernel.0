From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Nov 2015 16:13:11 +0000
Subject: [PATCH v2 1/2] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <1446717194-8572-2-git-send-email-zhengsq@rock-chips.com>
References: <1446717194-8572-1-git-send-email-zhengsq@rock-chips.com>
 <1446717194-8572-2-git-send-email-zhengsq@rock-chips.com>
Message-ID: <20151105161311.GR18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 05:53:13PM +0800, Shunqian Zheng wrote:

This is basically all good, a few very minor comments below but nothing
that should take any time to fix.

> +static const char *rk3036_codec_antipop_text[] = {"none", "work"};
> +static const unsigned int rk3036_codec_antipop_values[] = {0x1, 0x2};
> +
> +static SOC_VALUE_ENUM_DOUBLE_DECL(rk3036_codec_antipop_enum, INNO_R09,
> +		INNO_R09_HPL_ANITPOP_SHIFT, INNO_R09_HPR_ANITPOP_SHIFT, 0x3,
> +		rk3036_codec_antipop_text, rk3036_codec_antipop_values);

This looks like a simple boolean control rather than an enum - it looks
like it's just turning antipop on and off.

> +	SOC_DOUBLE_R_RANGE_TLV("Headphone Volume", INNO_R07, INNO_R08,
> +		INNO_HP_GAIN_SHIFT, INNO_HP_GAIN_N39DB,
> +		INNO_HP_GAIN_0DB, 0, rk3036_codec_hp_tlv),
> +	SOC_DOUBLE("Zero Cross Detect", INNO_R06, INNO_R06_VOUTL_CZ_SHIFT,
> +		INNO_R06_VOUTR_CZ_SHIFT, 1, 0),

This should be "Zero Cross Switch".

> +	SOC_DOUBLE("HP Mute", INNO_R09, INNO_R09_HPL_MUTE_SHIFT,
> +		INNO_R09_HPR_MUTE_SHIFT, 1, 1),

This should be "Headphone Switch".

> +static int rk3036_codec_add_widgets(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> +
> +	snd_soc_add_codec_controls(codec, rk3036_codec_dapm_controls,
> +		ARRAY_SIZE(rk3036_codec_dapm_controls));
> +
> +	snd_soc_dapm_new_controls(dapm, rk3036_codec_dapm_widgets,
> +		ARRAY_SIZE(rk3036_codec_dapm_widgets));
> +
> +	snd_soc_dapm_add_routes(dapm, rk3036_codec_dapm_routes,
> +		ARRAY_SIZE(rk3036_codec_dapm_routes));

Just point at the tables from the driver structure and let the core do
the initialisation for you.

> +static int rk3036_codec_set_bias_level(struct snd_soc_codec *codec,
> +				       enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_STANDBY:
> +		/* set a big current for capacitor charging. */
> +		snd_soc_write(codec, INNO_R10, INNO_R10_MAX_CUR);
> +		/* start precharge */
> +		snd_soc_write(codec, INNO_R06, INNO_R06_DAC_PRECHARGE);

Do we not need to wait for this to ramp?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151105/c1e7d135/attachment.sig>
