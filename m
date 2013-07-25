From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Jul 2013 17:11:50 +0800
Subject: [PATCH 4/6] ASoC: sirf-soc-inner: add drivers for both CPU and
 Codec DAIs
In-Reply-To: <20130719183503.GU9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-5-git-send-email-Baohua.Song@csr.com>
 <20130719183503.GU9858@sirena.org.uk>
Message-ID: <CAGsJ_4xvGBj393rKPvDhumgDppe9k+K6Nbcef0KwGiYaHdhkxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/20 Mark Brown <broonie@kernel.org>:
> On Fri, Jul 19, 2013 at 07:07:20PM +0800, Barry Song wrote:
>
>> there is an internal codec embedded in the SiRF SoC. this is not
>> a typical user scenerios of ASoC. but we can still get benefit by
>> sharing platform DMA codes instead of implementing a pure ALSA
>> driver.
>> This driver adds DAI drivers for this internal codec.
>
> To be honest this shouldn't be too exciting from an ASoC point of view -
> just a normal CODEC driver with some stub DAIs.  It looks like it might
> benefit from regmap-mmio and DAPM.

the driver was a legacy pure alsa driver as it is not soc+external
codec+mach framework.
so it has many legacy codes. i agree we can move to regmap-mmio and asoc dapm.

>
>> +static int sirf_inner_control(struct snd_kcontrol *kcontrol,
>> +             struct snd_ctl_elem_value *ucontrol,
>> +             int get, char *name)
>> +{
>> +     struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +     struct snd_soc_card *card = codec->card;
>> +     int i;
>> +     for (i = 0; i < card->num_controls; i++) {
>> +             if (!strcmp(card->controls[i].name, name)) {
>> +                     if (card->controls[i].get && get)
>> +                             return card->controls[i].get(kcontrol, ucontrol);
>> +                     else if (card->controls[i].put && !get)
>> +                             return card->controls[i].put(kcontrol, ucontrol);
>> +             }
>> +     }
>> +     return 0;
>> +}
>
> What is all this about?  I don't quite understand what the goal is and
> there's no comments.

it is a common kcontrol get/set function which will be called by all
of sirf_inner_snd_speaker_set, sirf_inner_snd_headphone_get,
sirf_inner_snd_headphone_set, sirf_inner_snd_speaker_get. after we
move to DAPM, it should be useless.

>
>> +static int sirf_inner_snd_speaker_set(struct snd_kcontrol *kcontrol,
>> +             struct snd_ctl_elem_value *ucontrol)
>> +{
>> +     struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +     struct sirf_soc_inner_audio *sinner_audio = dev_get_drvdata(codec->dev);
>> +
>> +     spin_lock(&sinner_audio->lock);
>> +     sirf_inner_control(kcontrol, ucontrol, 0, "Speaker Out");
>> +
>> +     if (ucontrol->value.integer.value[0]) {
>> +             writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0)
>> +                             | IC_RDACEN | IC_SPSELR,
>> +                             sinner_audio->base + AUDIO_IC_CODEC_CTRL0);
>> +
>> +             writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1) |
>> +                             (1 << sinner_audio->reg_bits->firdac_lout_en_bits),
>> +                             sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
>> +
>> +             writel((readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0) |
>> +                                     IC_SPEN), sinner_audio->base + AUDIO_IC_CODEC_CTRL0);
>
> Is this possibly some supplies plus a power bit?
>
>> +static int sirf_inner_codec_startup(struct snd_pcm_substream *substream,
>> +             struct snd_soc_dai *dai)
>> +{
>> +     struct sirf_soc_inner_audio *sinner_audio = snd_soc_dai_get_drvdata(dai);
>> +     u32 adc_gain_mask = sinner_audio->reg_bits->adc_gain_mask;
>> +     u32 adc_left_gain_shift = sinner_audio->reg_bits->adc_left_gain_shift;
>> +     u32 adc_right_gain_shift = sinner_audio->reg_bits->adc_right_gain_shift;
>> +     u32 mic_max_gain = sinner_audio->reg_bits->mic_max_gain;
>
> Would regmap_field help here?
>
>> +             writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1) |
>> +                     (1 << sinner_audio->reg_bits->codec_clk_en_bits) |
>> +                     (1 << sinner_audio->reg_bits->por_bits),
>> +                     sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
>> +             msleep(50);
>> +
>> +             writel(readl(sinner_audio->base + AUDIO_IC_CODEC_PWR) |
>> +                     MICBIASEN, sinner_audio->base + AUDIO_IC_CODEC_PWR);
>> +             usleep_range(300, 1000);
>
> This all looks a lot like a normal CODEC power up sequence that's been
> open coded but could use DAPM?
>
>> +static void sirf_inner_codec_shutdown(struct snd_pcm_substream *substream,
>> +             struct snd_soc_dai *dai)
>> +{
>> +}
>> +
>> +static int sirf_inner_codec_hw_params(struct snd_pcm_substream *substream,
>> +             struct snd_pcm_hw_params *params,
>> +             struct snd_soc_dai *dai)
>> +{
>> +     return 0;
>> +}
>
> Remove empty functions.

ok.

>
>> +static int sirf_soc_inner_resume(struct platform_device *pdev)
>> +{
>> +     struct sirf_soc_inner_audio *sinner_audio = platform_get_drvdata(pdev);
>> +
>> +     clk_prepare_enable(sinner_audio->clk);
>> +
>> +     writel((readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1)
>> +             | (1 << sinner_audio->reg_bits->codec_clk_en_bits)),
>> +             sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
>> +     writel((readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1)
>> +             | (1 << sinner_audio->reg_bits->adc14b_12_bits)),
>> +             sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
>> +     writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0) | IC_CPFREQ,
>> +             sinner_audio->base + AUDIO_IC_CODEC_CTRL0);
>> +     writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0) | IC_CPEN,
>> +             sinner_audio->base + AUDIO_IC_CODEC_CTRL0);
>> +     return 0;
>> +}
>> +#else
>> +#define sirf_soc_inner_suspend NULL
>> +#define sirf_soc_inner_resume NULL
>> +#endif
>
> Standard runtime PM question and this definitely does look like
> regmap-mmio will help - you've essentially open coded some of it.

we can use runtime PM to handle clock disable/enable here. audio path
widgets, codec and speaker widgets will be handled by DAPM.

-barry
