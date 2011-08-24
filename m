From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 24 Aug 2011 13:01:08 +0200
Subject: [alsa-devel] [PATCH 1/1] ASoC: soc-core: check rate for symmetry
	only when pcm is ongoing
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F772223EED@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1314172640-26972-1-git-send-email-b29396@freescale.com>
	<4E54C352.8030106@metafoo.de>
	<65EE16ACC360FA4D99C96DC085B3F772223EED@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <4E54D9F4.1010206@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2011 12:39 PM, Dong Aisheng-B29396 wrote:
>> -----Original Message-----
>> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
>> Sent: Wednesday, August 24, 2011 5:25 PM
>> To: Dong Aisheng-B29396
>> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
>> broonie at opensource.wolfsonmicro.com; lrg at ti.com; linux-arm-
>> kernel at lists.infradead.org; w.sang at pengutronix.de
>> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-core: check rate for
>> symmetry only when pcm is ongoing
>>
>> On 08/24/2011 09:57 AM, Dong Aisheng wrote:
>>> For the playback and record using different dai links, checking
>>> !rtd->rate for symmetry may not be accurate because that pcm may be
>>> acutually not running and the default new open rate is 0, then the
>>> warning message "Not enforcing symmetric_rates" will happen each time
>>> with running arecord | aplay.
>>>
>>> Now we only check rate for symmetry when the pcm is really ongoing
>>> which seems more sensible.
>>
>>
>> This will break the common case where playback and record are using the
>> same link. You'll need at least ref-counting for whether the pcm is
>> active or not too.
> Yes, I will use ref-counting.
> 
>> But what is your setup anyway. You have two dai links and both refer to
>> the same dais? Or how does it come that the dai is active while rtd->rate
>> is not set while you are using different links?
> 
> My setup is different dai link for playback and record, however,
> the codec dai is the same one.
> 
> Since codec dai is active which will cause to do symmetry check,
> However, the new open rtd->rate of a different dai link
> is not set by default.
> 
> Below is the detailed setup:
> static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
>         {
>                 .name           = "HiFi Tx",
>                 .stream_name    = "HiFi Playback",
>                 .codec_dai_name = "sgtl5000",
>                 .codec_name     = "sgtl5000.0-000a",
>                 .cpu_dai_name   = "mxs-saif.0",
>                 .platform_name  = "mxs-pcm-audio.0",
>                 .ops            = &mxs_sgtl5000_hifi_ops,
>         }, {
>                 .name           = "HiFi Rx",
>                 .stream_name    = "HiFi Capture",
>                 .codec_dai_name = "sgtl5000",
>                 .codec_name     = "sgtl5000.0-000a",
>                 .cpu_dai_name   = "mxs-saif.1",
>                 .platform_name  = "mxs-pcm-audio.1",
>                 .ops            = &mxs_sgtl5000_hifi_ops,
>         },
> };
> 

This is an interesting case, since you still want to use the same rate for
capture and playback, since the codec needs this. So the warning is actually
correct, you want symmetry but it was not enforced. Though it is not really due
to an race.

For this kind of setup we'd have to store the current rate in the codec and
cpu_dais themselves and then have something along the lines of this in
soc_pcm_apply_symmetry:

if (codec_dai->active) {
	if (codec_dai->rate != 0) {
		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
				SNDRV_PCM_HW_PARAM_RATE,
				codec_dai->rate, codec_dai->rate);
	} else {
		race = true;
	}
}
if (cpu_dai->active) {
	if (cpu_dai->rate != 0) {
		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
				SNDRV_PCM_HW_PARAM_RATE,
				cpu_dai->rate, cpu_dai->rate);
	} else {
		race = true;
	}
}

if (race)
	dev_warn(&rtd->dev,
		"Not enforcing symmetric_rates due to race\n");
