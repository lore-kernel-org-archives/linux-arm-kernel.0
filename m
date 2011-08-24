From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 24 Aug 2011 10:30:50 +0000
Subject: [PATCH 1/1] ASoC: soc-core: check rate for symmetry only when
	pcm is ongoing
In-Reply-To: <20110824091902.GR9232@opensource.wolfsonmicro.com>
References: <1314172640-26972-1-git-send-email-b29396@freescale.com>
	<20110824091902.GR9232@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772223ECB@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: Wednesday, August 24, 2011 5:19 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
> lrg at ti.com; s.hauer at pengutronix.de; w.sang at pengutronix.de
> Subject: Re: [PATCH 1/1] ASoC: soc-core: check rate for symmetry only
> when pcm is ongoing
> 
> On Wed, Aug 24, 2011 at 03:57:20PM +0800, Dong Aisheng wrote:
> 
> > Now we only check rate for symmetry when the pcm is really ongoing
> > which seems more sensible.
> 
> There's a genuine issue here due to the raciness of the ALSA APIs - we're
> not enforcing constraints and we should be.  If the two programs end up
> setting incompatible rates we need to handle that.
Yes, I also noticed that.
I did not find a proper fix since we may not imagine the execute sequence of
user level.
Anyway, this patch is for fixing the wrong warning message.

> >  	/* Symmetry data - only valid if symmetry is being enforced */
> >  	unsigned int rate;
> > +	unsigned int ongoing;
> 
> This isn't a clear name, I don't understand it.
How about change to active?

> > @@ -209,6 +212,7 @@ static int soc_pcm_open(struct snd_pcm_substream
> *substream)
> >  	cpu_dai->active++;
> >  	codec_dai->active++;
> >  	rtd->codec->active++;
> > +	rtd->ongoing = 1;
> >  	mutex_unlock(&rtd->pcm_mutex);
> >  	return 0;
> >
> > @@ -322,6 +326,7 @@ static int soc_pcm_close(struct snd_pcm_substream
> *substream)
> >  			SND_SOC_DAPM_STREAM_STOP);
> >  	}
> >
> > +	rtd->ongoing = 0;
> 
> What happens when the stream in one direction is stopped but not the
> other?  For example, capture stops but playback continues.
Yes, that's an issue which I neglected.
Thanks for the reminder.
I'm going to use a ref-counter as cpu_dai->active.
So the code could be like when open pcm, rtd->active++ and when close pcm, rtd->active--.

Regards
Dong Aisheng 
