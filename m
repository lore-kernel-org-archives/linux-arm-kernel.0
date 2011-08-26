From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 26 Aug 2011 15:32:32 +0200
Subject: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking for each DAIs
	separately
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722260BF@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1314351351-1018-1-git-send-email-b29396@freescale.com>
	<4E57824E.8000400@metafoo.de>
	<65EE16ACC360FA4D99C96DC085B3F7722260BF@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <4E57A070.5090805@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2011 03:17 PM, Dong Aisheng-B29396 wrote:
>> -----Original Message-----
>> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
>> Sent: Friday, August 26, 2011 7:24 PM
>> To: Dong Aisheng-B29396
>> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
>> broonie at opensource.wolfsonmicro.com; lrg at ti.com; s.hauer at pengutronix.de;
>> w.sang at pengutronix.de
>> Subject: Re: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking for each
>> DAIs separately
>>
>> On 08/26/2011 11:35 AM, Dong Aisheng wrote:
>>> [...]
>>>  	/* runtime devices */
>>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c index
>>> 1aee9fc..3f7ded7 100644
>>> --- a/sound/soc/soc-pcm.c
>>> +++ b/sound/soc/soc-pcm.c
>>> @@ -32,33 +32,54 @@ static int soc_pcm_apply_symmetry(struct
>> snd_pcm_substream *substream)
>>>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>>>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>> +	unsigned int race;
>>> +	unsigned int force_rate;
>>>  	int ret;
>>>
>>> +	race = 0;
>>> +	force_rate = 0;
>>> +
>>>  	if (!codec_dai->driver->symmetric_rates &&
>>>  	    !cpu_dai->driver->symmetric_rates &&
>>>  	    !rtd->dai_link->symmetric_rates)
>>>  		return 0;
>>>
>>> +	if (codec_dai->active && codec_dai->driver->symmetric_rates ||
>>> +	     codec_dai->active && rtd->dai_link->symmetric_rates) {
>>
>> parenthesis, please, when mixing && and || in the same expression. Makes
>> it easier to comprehend and protects against accidental mistakes.
> Thanks for reminder, I will take it.
> 
>>> +		if (codec_dai->rate != 0)
>>> +			force_rate = codec_dai->rate;
>>> +		else
>>> +			race = 1;
>>> +	}
>>> +
>>> +	if (cpu_dai->active && cpu_dai->driver->symmetric_rates ||
>>> +	    codec_dai->active && rtd->dai_link->symmetric_rates) {
>>> +		if (cpu_dai->rate != 0)
>>> +			force_rate = cpu_dai->rate;
>>> +		else
>>> +			race = 1;
>>> +	}
>>> +
>>
>> If both dais are active and require symmetry we should call
>> snd_pcm_hw_constraint_minmax for both rates. This will ensure that if
>> both are already active and are running at different rates that there
>> will be no valid rate for the new pcm stream. Maybe extend this function
>> to take the dai as an parameter and call it twice, once for the codec_dai
>> and once for the cpu_dai.
>> This would allow to keep the current structure of the function.
> I was doing like the way as you said before, however, I found the question
> is that do we have to call snd_pcm_hw_constraint_minmax for the same substream
> two times?
> 
> I just thought they should be running at the same rate if both are active.
> Can you help point out in which case they may be different?
>  

This might be some rather obscure and theoretical setup but image the following
situation:

A   C
 \ / \
  B   D

The link between A and B and the link between C and D are active and running at
different rates. Activating the link between C and B should fail, since both
are already active and are running at different rates.
