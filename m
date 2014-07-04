From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 04 Jul 2014 13:10:14 +0200
Subject: [alsa-devel] [PATCH 2/2] ASoC: samsung: Add machine driver for
 odroidx2
In-Reply-To: <53B68A32.8000203@samsung.com>
References: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
 <1400759708-25831-2-git-send-email-s.nawrocki@samsung.com>
 <20140522185334.GT12304@sirena.org.uk> <53B68A32.8000203@samsung.com>
Message-ID: <53B68B96.9010708@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2014 01:04 PM, Sylwester Nawrocki wrote:
> On 22/05/14 20:53, Mark Brown wrote:
>>> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
>>>> +					| SND_SOC_DAIFMT_NB_NF
>>>> +					| SND_SOC_DAIFMT_CBM_CFM);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
>>>> +					| SND_SOC_DAIFMT_NB_NF
>>>> +					| SND_SOC_DAIFMT_CBM_CFM);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>
>> These are constant, set these in the dai_link.
>
> set_fmt also sets master/slave mode of the I2S DAI, after I moved
> this into the cpu_dai link data structure after suspend/resume cycle
> the I2S IP block is not being properly re-configured. Should the
> format setting be added in resume_post callback, or is there any
> other preferred way ? Similarly the syclk settings are being lost
> over suspend/resume cycle and nothing restores them.

The I2S driver should save and restore it's register during suspend/resume.

- Lars
