From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 26 Nov 2013 20:37:00 +0100
Subject: [alsa-devel] KNOT / CONTINUOUS
In-Reply-To: <20131126200916.47a45929@armhf>
References: <20131126104140.16e3eb87@armhf> <s5h8uwba2gv.wl%tiwai@suse.de>
 <20131126200916.47a45929@armhf>
Message-ID: <5294F85C.4000105@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 08:09 PM, Jean-Francois Moine wrote:
> On Tue, 26 Nov 2013 11:20:48 +0100
> Takashi Iwai <tiwai@suse.de> wrote:
> 
>> Not against the patch itself, but just found looking through it:
>>
>>> @@ -493,7 +497,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
>>>  		.rates = SNDRV_PCM_RATE_8000_192000 |
>>>  			 SNDRV_PCM_RATE_CONTINUOUS |
>>>  			 SNDRV_PCM_RATE_KNOT,
>>
>> Setting both CONTINUOUS and KNOT doesn't make sense.
> 
> Hi Takashi,
> 
> I understand 'continuous', but I could not find any clear definition of
> 'knot'. May you explain what is its purpose?

CONTINUOUS means that any rate between the specified min and max is fine, if
no min or max is specified any rate is fine. KNOT means there are rates
supported other than the standard rates defines by ALSA, but the other rates
are enumerable. You'd typically specify them by explicitly listing them all
and use a list constraint or you'd use one of the ratio constraints.

> 
> BTW, if you may help me, while looking for SNDRV_PCM_RATE_KNOT,
> I found this sequence in soc-pcm.c:
> 
> 	if (codec_stream->rates
> 		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
> 		hw->rates |= cpu_stream->rates;
> 	if (cpu_stream->rates
> 		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
> 		hw->rates |= codec_stream->rates;

I think this code is wrong, but I don't think it is related to your problem.

> 
> and it seems related to the problem I have:
> 
> - the cpu dai (kirkwood i2s) may generate any continuous rate
>   8000..192000 as shown in the patch.
> 

If you set SNDRV_PCM_RATE_CONTINUOUS, the other rates flags will be ignored
(IIRC). You need to explicitly specify the minimum and maximum rates if they
exist.

> - the HDMI transmitter (tda998x) accepts either i2s or s/pdif audio
>   input at any continuous rate, but when getting audio from s/pdif, the
>   lowest rate is 22.06kHz.
> 
> In the associated codec, if I define:
> 
> 	.rates = SNDRV_PCM_RATE_22050 |
> 		SNDRV_PCM_RATE_32000 |
> 		...
> 		SNDRV_PCM_RATE_192000 |
> 		SNDRV_PCM_RATE_CONTINUOUS,
> 
> audio works fine with streams at 33.075kHz (the kirkwood clock is
> exactly 33.075kHz). But when I want a stream at 7850Hz, the kirkwood
> i2s driver gets a clock at 8000Hz and the tda998x cannot do audio
> output.
> 
> Otherwise, removing SNDRV_PCM_RATE_CONTINUOUS in the codec, I can hear
> the 7850Hz stream which is converted to 22.05 kHz by vlc, but when I
> want a stream at 33.075kHz, vlc converts it to 32kHz.
> 
> So, with the commit d9ad6296ec3b4a55b "ASoC: PCM_RATE: Check for KNOT
> and CONTINUOUS flags", I cannot get the exact clock I want.
> 
> Do you know the reason of this patch, and, if it must stay, is there
> any possible bypass?

In your codec driver you should specify the minimum and maximum supported
rate by calling snd_pcm_hw_constraint_minmax() in the DAI startup callback.

- Lars
