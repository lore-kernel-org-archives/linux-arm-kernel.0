From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 26 Nov 2013 20:09:16 +0100
Subject: KNOT / CONTINUOUS (was: [PATCH] ASoC: kirkwood: Fix invalid
 SPDIF format)
In-Reply-To: <s5h8uwba2gv.wl%tiwai@suse.de>
References: <20131126104140.16e3eb87@armhf>
 <s5h8uwba2gv.wl%tiwai@suse.de>
Message-ID: <20131126200916.47a45929@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013 11:20:48 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Not against the patch itself, but just found looking through it:
> 
> > @@ -493,7 +497,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
> >  		.rates = SNDRV_PCM_RATE_8000_192000 |
> >  			 SNDRV_PCM_RATE_CONTINUOUS |
> >  			 SNDRV_PCM_RATE_KNOT,
> 
> Setting both CONTINUOUS and KNOT doesn't make sense.

Hi Takashi,

I understand 'continuous', but I could not find any clear definition of
'knot'. May you explain what is its purpose?

BTW, if you may help me, while looking for SNDRV_PCM_RATE_KNOT,
I found this sequence in soc-pcm.c:

	if (codec_stream->rates
		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
		hw->rates |= cpu_stream->rates;
	if (cpu_stream->rates
		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
		hw->rates |= codec_stream->rates;

and it seems related to the problem I have:

- the cpu dai (kirkwood i2s) may generate any continuous rate
  8000..192000 as shown in the patch.

- the HDMI transmitter (tda998x) accepts either i2s or s/pdif audio
  input at any continuous rate, but when getting audio from s/pdif, the
  lowest rate is 22.06kHz.

In the associated codec, if I define:

	.rates = SNDRV_PCM_RATE_22050 |
		SNDRV_PCM_RATE_32000 |
		...
		SNDRV_PCM_RATE_192000 |
		SNDRV_PCM_RATE_CONTINUOUS,

audio works fine with streams at 33.075kHz (the kirkwood clock is
exactly 33.075kHz). But when I want a stream at 7850Hz, the kirkwood
i2s driver gets a clock at 8000Hz and the tda998x cannot do audio
output.

Otherwise, removing SNDRV_PCM_RATE_CONTINUOUS in the codec, I can hear
the 7850Hz stream which is converted to 22.05 kHz by vlc, but when I
want a stream at 33.075kHz, vlc converts it to 32kHz.

So, with the commit d9ad6296ec3b4a55b "ASoC: PCM_RATE: Check for KNOT
and CONTINUOUS flags", I cannot get the exact clock I want.

Do you know the reason of this patch, and, if it must stay, is there
any possible bypass?

Thanks.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
