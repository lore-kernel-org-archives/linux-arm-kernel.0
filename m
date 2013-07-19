From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Jul 2013 19:51:01 +0100
Subject: [PATCH 5/6] ASoC: sirf-inner: add mach driver for SiRFSoC
 internal codec
In-Reply-To: <1374232042-26088-6-git-send-email-Baohua.Song@csr.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-6-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130719185101.GV9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 07:07:21PM +0800, Barry Song wrote:

> +#ifndef CONFIG_ANDROID
> +	unsigned int            gpio_hp_detect;
> +	struct snd_soc_jack     hp_jack;
> +#endif

Not for mainline.  I'd suggest setting it up for extcon anyway
especially if it's just a simple accessory, that should work for both
Android and mainline.

> +static int sirf_inner_speaker_out_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	int is_spk_out = ucontrol->value.integer.value[0];
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_card *card = codec->card;
> +	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
> +
> +	if (gpio_is_valid(sinner_card->gpio_spk_pa))
> +		gpio_direction_output(sinner_card->gpio_spk_pa, is_spk_out);
> +	return 0;
> +}

Oh, right.  If this is doing what I think this is doing you want to use
DAPM within the CODEC then this can just become a pin switch or you can
hook in directly if you continue to use soc-jack - it has DAPM
integration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130719/df529a7f/attachment.sig>
