From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 16 Jun 2016 09:15:22 +0800
Subject: [PATCH v5] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
In-Reply-To: <CADR9n49m7anZpDbbb3=ZGBaacOuXc4F=Yid0eyMey1LfEJx8Pw@mail.gmail.com>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
 <CADR9n49m7anZpDbbb3=ZGBaacOuXc4F=Yid0eyMey1LfEJx8Pw@mail.gmail.com>
Message-ID: <5761FDAA.1070802@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

// + Adam,

On 2016?06?16? 03:43, Steve Barber wrote:
> On Mon, Jun 13, 2016 at 1:42 AM, Xing Zheng<zhengxing@rock-chips.com>  wrote:
>> +
>> +static int rockchip_sound_da7219_hw_params(struct snd_pcm_substream *substream,
>> +                            struct snd_pcm_hw_params *params)
>> +{
>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +       struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +       struct snd_soc_dai *codec_dai = rtd->codec_dai;
>> +       struct snd_soc_dapm_context *dapm =&rtd->card->dapm;
>> +       int mclk, ret;
>> +
>> +       snd_soc_dapm_disable_pin(dapm, "Speakers");
>> +       snd_soc_dapm_disable_pin(dapm, "Int Mic");
>> +       snd_soc_dapm_enable_pin(dapm, "Headphones");
>> +       snd_soc_dapm_enable_pin(dapm, "Headset Mic");
>> +       snd_soc_dapm_sync(dapm);
>> +
>> +       /* in bypass mode, the mclk has to be one of the frequencies below */
>> +       switch (params_rate(params)) {
>> +       case 8000:
>> +       case 16000:
>> +       case 24000:
>> +       case 32000:
>> +       case 48000:
>> +       case 64000:
>> +       case 96000:
>> +               mclk = 12288000;
>> +               break;
>> +       case 11025:
>> +       case 22050:
>> +       case 44100:
>> +       case 88200:
>> +               mclk = 11289600;
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
>> +                                    SND_SOC_CLOCK_OUT);
>> +       if (ret<  0) {
>> +               dev_err(codec_dai->dev, "Can't set cpu clock out %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
>> +                                    SND_SOC_CLOCK_IN);
>> +       if (ret<  0) {
>> +               dev_err(codec_dai->dev, "Can't set codec clock in %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_MCLK, 0, 0);
>> +       if (ret<  0) {
>> +               dev_err(codec_dai->dev, "Can't set pll sysclk mclk %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +       struct snd_soc_codec *codec = rtd->codec_dais[0]->codec;
>> +       int ret;
>> +
>> +       /* Enable Headset and 4 Buttons Jack detection */
>> +       ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
>> +                                   SND_JACK_HEADSET |
> Should this also include SND_JACK_LINEOUT? da7219 differentiates
> between the two so not including lineout means, for example, we can
> miss jack insertion/removal events.
>
Hi Adam,

Could you please confirm Steve says that about SND_JACK_LINEOUT?

Thanks.

-- 
- Xing Zheng
