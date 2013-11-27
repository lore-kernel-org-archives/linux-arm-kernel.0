From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 27 Nov 2013 08:16:41 +0100
Subject: [alsa-devel] KNOT / CONTINUOUS
In-Reply-To: <5294F85C.4000105@metafoo.de>
References: <20131126104140.16e3eb87@armhf> <s5h8uwba2gv.wl%tiwai@suse.de>
 <20131126200916.47a45929@armhf> <5294F85C.4000105@metafoo.de>
Message-ID: <s5h61rewbza.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 26 Nov 2013 20:37:00 +0100,
Lars-Peter Clausen wrote:
> 
> On 11/26/2013 08:09 PM, Jean-Francois Moine wrote:
> > On Tue, 26 Nov 2013 11:20:48 +0100
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> >> Not against the patch itself, but just found looking through it:
> >>
> >>> @@ -493,7 +497,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
> >>>  		.rates = SNDRV_PCM_RATE_8000_192000 |
> >>>  			 SNDRV_PCM_RATE_CONTINUOUS |
> >>>  			 SNDRV_PCM_RATE_KNOT,
> >>
> >> Setting both CONTINUOUS and KNOT doesn't make sense.
> > 
> > Hi Takashi,
> > 
> > I understand 'continuous', but I could not find any clear definition of
> > 'knot'. May you explain what is its purpose?
> 
> CONTINUOUS means that any rate between the specified min and max is fine, if
> no min or max is specified any rate is fine. KNOT means there are rates
> supported other than the standard rates defines by ALSA, but the other rates
> are enumerable. You'd typically specify them by explicitly listing them all
> and use a list constraint or you'd use one of the ratio constraints.
> 
> > 
> > BTW, if you may help me, while looking for SNDRV_PCM_RATE_KNOT,
> > I found this sequence in soc-pcm.c:
> > 
> > 	if (codec_stream->rates
> > 		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
> > 		hw->rates |= cpu_stream->rates;
> > 	if (cpu_stream->rates
> > 		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
> > 		hw->rates |= codec_stream->rates;
> 
> I think this code is wrong, but I don't think it is related to your problem.

It's not completely wrong, but imperfect, indeed.

Essentially, the rates bits are set by a line above the code snippet:
	hw->rates = codec_stream->rates & cpu_stream->rates;

And, the code above handles exceptional rules for CONTINUOUS and
KNOT.  It would work if either codec or cpu DAI has KNOT or CONTINUOUS
flag and another doesn't but only explicit rate bits, because
CONTINUOUS does allow any rates and KNOW may allow any rates.
(So, basically you need no other SNDRV_PCM_RATE_*bits if you have
CONTINUOUS or KNOT bit.)  And the actual rates are limited by rate_min
and rate_max values.

It won't work properly, however, if one side has KNOT and another has
CONTINUOUS.  Then it'd end up with CONTINUOUS|KNOT, which is wrong.

Instead, the following should work (if I counted all possible cases
properly):

	hw->rates = codec_stream->rates & cpu_stream->rates;
	if (codec_stream->rates
		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
		hw->rates |= cpu_stream->rates & ~SNDRV_PCM_RATE_CONTINUOUS;
	if (cpu_stream->rates
		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
		hw->rates |= codec_stream->rates & ~SNDRV_PCM_RATE_CONTINUOUS;

The code looks tricky, so a proper comment should be added there.


Takashi
