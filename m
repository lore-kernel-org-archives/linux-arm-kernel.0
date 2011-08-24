From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 24 Aug 2011 10:39:51 +0000
Subject: [alsa-devel] [PATCH 1/1] ASoC: soc-core: check rate for
	symmetry only when pcm is ongoing
In-Reply-To: <4E54C352.8030106@metafoo.de>
References: <1314172640-26972-1-git-send-email-b29396@freescale.com>
	<4E54C352.8030106@metafoo.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772223EED@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
> Sent: Wednesday, August 24, 2011 5:25 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; lrg at ti.com; linux-arm-
> kernel at lists.infradead.org; w.sang at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-core: check rate for
> symmetry only when pcm is ongoing
> 
> On 08/24/2011 09:57 AM, Dong Aisheng wrote:
> > For the playback and record using different dai links, checking
> > !rtd->rate for symmetry may not be accurate because that pcm may be
> > acutually not running and the default new open rate is 0, then the
> > warning message "Not enforcing symmetric_rates" will happen each time
> > with running arecord | aplay.
> >
> > Now we only check rate for symmetry when the pcm is really ongoing
> > which seems more sensible.
> 
> 
> This will break the common case where playback and record are using the
> same link. You'll need at least ref-counting for whether the pcm is
> active or not too.
Yes, I will use ref-counting.

> But what is your setup anyway. You have two dai links and both refer to
> the same dais? Or how does it come that the dai is active while rtd->rate
> is not set while you are using different links?

My setup is different dai link for playback and record, however,
the codec dai is the same one.

Since codec dai is active which will cause to do symmetry check,
However, the new open rtd->rate of a different dai link
is not set by default.

Below is the detailed setup:
static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
        {
                .name           = "HiFi Tx",
                .stream_name    = "HiFi Playback",
                .codec_dai_name = "sgtl5000",
                .codec_name     = "sgtl5000.0-000a",
                .cpu_dai_name   = "mxs-saif.0",
                .platform_name  = "mxs-pcm-audio.0",
                .ops            = &mxs_sgtl5000_hifi_ops,
        }, {
                .name           = "HiFi Rx",
                .stream_name    = "HiFi Capture",
                .codec_dai_name = "sgtl5000",
                .codec_name     = "sgtl5000.0-000a",
                .cpu_dai_name   = "mxs-saif.1",
                .platform_name  = "mxs-pcm-audio.1",
                .ops            = &mxs_sgtl5000_hifi_ops,
        },
};



> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  include/sound/soc.h |    1 +
> >  sound/soc/soc-pcm.c |    5 +++++
> >  2 files changed, 6 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/sound/soc.h b/include/sound/soc.h index
> > 3fe658e..8e9931c 100644
> > --- a/include/sound/soc.h
> > +++ b/include/sound/soc.h
> > @@ -851,6 +851,7 @@ struct snd_soc_pcm_runtime  {
> >
> >  	/* Symmetry data - only valid if symmetry is being enforced */
> >  	unsigned int rate;
> > +	unsigned int ongoing;
> >  	long pmdown_time;
> >
> >  	/* runtime devices */
> > diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c index
> > 1aee9fc..f3c1a66 100644
> > --- a/sound/soc/soc-pcm.c
> > +++ b/sound/soc/soc-pcm.c
> > @@ -39,6 +39,9 @@ static int soc_pcm_apply_symmetry(struct
> snd_pcm_substream *substream)
> >  	    !rtd->dai_link->symmetric_rates)
> >  		return 0;
> >
> > +	if (!rtd->ongoing)
> > +		return 0;
> > +
> >  	/* This can happen if multiple streams are starting simultaneously
> -
> >  	 * the second can need to get its constraints before the first has
> >  	 * picked a rate.  Complain and allow the application to carry on.
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
> >  	mutex_unlock(&rtd->pcm_mutex);
> >  	return 0;
> >  }
> 
