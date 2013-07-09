From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 9 Jul 2013 09:37:31 +0200
Subject: [alsa-devel] [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver
 for at91sam9x5 wm8731 boards
In-Reply-To: <51DACF15.9080303@metafoo.de>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
 <51DACF15.9080303@metafoo.de>
Message-ID: <CACQ1gAh2Cy8VTx4Mgdv2NdrjdX1M7m-5M+8LqY6ncz3kS16O6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/8 Lars-Peter Clausen <lars@metafoo.de>:
> On 07/08/2013 03:29 PM, Richard Genoud wrote:
> [...]
>> +/*
>> + * Logic for a wm8731 as connected on a at91sam9x5 based board.
>> + */
>> +static int at91sam9x5ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
>> +{
> [...]
>> +     codec_dai->driver->playback.rates &= SNDRV_PCM_RATE_8000 |
>> +             SNDRV_PCM_RATE_32000 |
>> +             SNDRV_PCM_RATE_48000 |
>> +             SNDRV_PCM_RATE_96000;
>> +     codec_dai->driver->capture.rates &= SNDRV_PCM_RATE_8000 |
>> +             SNDRV_PCM_RATE_32000 |
>> +             SNDRV_PCM_RATE_48000 |
>> +             SNDRV_PCM_RATE_96000;
>
> That's not right. The driver structure is shared between all instances of
> the codec, a single instance should not modify it. If you need to constrain
> the list of supported rates use snd_pcm_hw_constraint_list().
Ok, I'll do that.

>
>> +
>> +     /* set the codec system clock for DAC and ADC */
>> +     ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
>> +                                  MCLK_RATE, SND_SOC_CLOCK_IN);
>> +     if (ret < 0) {
>> +             dev_err(dev, "ASoC: Failed to set WM8731 SYSCLK: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     /* signal a DAPM event */
>> +     snd_soc_dapm_sync(dapm);
>
> This should not be necessary.
ok
>
>> +     return 0;
>> +}
>

Thanks !

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
