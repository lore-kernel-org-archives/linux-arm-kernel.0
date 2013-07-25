From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Jul 2013 16:57:22 +0800
Subject: [PATCH 5/6] ASoC: sirf-inner: add mach driver for SiRFSoC
 internal codec
In-Reply-To: <20130719185101.GV9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-6-git-send-email-Baohua.Song@csr.com>
 <20130719185101.GV9858@sirena.org.uk>
Message-ID: <CAGsJ_4w5G3ppgWdFYJ0-cMLbuvDMdy+dJneMshkeYz5MR6RW+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/20 Mark Brown <broonie@kernel.org>:
> On Fri, Jul 19, 2013 at 07:07:21PM +0800, Barry Song wrote:
>
>> +#ifndef CONFIG_ANDROID
>> +     unsigned int            gpio_hp_detect;
>> +     struct snd_soc_jack     hp_jack;
>> +#endif
>
> Not for mainline.  I'd suggest setting it up for extcon anyway
> especially if it's just a simple accessory, that should work for both
> Android and mainline.

sounds good as if CONFIG_ANDROID is enabled without
CONFIG_ANDROID_SWITCH, /sys/class/switch/* will be symbolically linked
to /sys/class/extcon/, so that they are still compatible with legacy
userspace processes.

>
>> +static int sirf_inner_speaker_out_put(struct snd_kcontrol *kcontrol,
>> +             struct snd_ctl_elem_value *ucontrol)
>> +{
>> +     int is_spk_out = ucontrol->value.integer.value[0];
>> +     struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +     struct snd_soc_card *card = codec->card;
>> +     struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
>> +
>> +     if (gpio_is_valid(sinner_card->gpio_spk_pa))
>> +             gpio_direction_output(sinner_card->gpio_spk_pa, is_spk_out);
>> +     return 0;
>> +}
>
> Oh, right.  If this is doing what I think this is doing you want to use
> DAPM within the CODEC then this can just become a pin switch or you can
> hook in directly if you continue to use soc-jack - it has DAPM
> integration.

ok. here it is more of machine stuff than codec stuff, so i think we
move to snd_soc_jack_gpio.

-barry
