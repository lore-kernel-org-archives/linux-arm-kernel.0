From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 04 Sep 2012 15:14:11 +0200
Subject: [alsa-devel] [RFC 1/3] ASoC: dmaengine: Don't use runtime	private
 data for dmaengine data
In-Reply-To: <50451A4A.9000108@metafoo.de>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
 <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk>
 <5045124D.3050604@metafoo.de>
 <20120903204325.GA728@n2100.arm.linux.org.uk>
 <50451A4A.9000108@metafoo.de>
Message-ID: <s5ha9x62an0.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Mon, 03 Sep 2012 22:59:54 +0200,
Lars-Peter Clausen wrote:
> 
> On 09/03/2012 10:43 PM, Russell King - ARM Linux wrote:
> > On Mon, Sep 03, 2012 at 10:25:49PM +0200, Lars-Peter Clausen wrote:
> >> On 09/03/2012 06:59 PM, Liam Girdwood wrote:
> >>> Use a dedicated member to store dmaengine data so that drivers can
> >>> use private data for their own purposes.
> >>>
> >>
> >> The idea was that we'll eventually get to a point where we won't need private
> >> data for the drivers using the generic dmaengine code. But for the transitional
> >> period there is snd_dmaengine_pcm_{set,get}_data which allows to attach driver
> >> private data to the dmaengine pcm. For an example see how the other users of
> >> dmaengine pcm handle this.
> > 
> > That's fine if you are writing new drivers from scatch, or know the
> > driver you're converting inside-out.  Neither applies here (I've
> > struggled to do anything with the OMAP audio stuff for many many
> > reasons.)
> > 
> > I rather wish that people who did know the OMAP ASoC driver had stepped
> > up to this conversion, but alas they haven't.
> > 
> > In any case, if you want people to use the this soc-dmaengine helper
> > then you have to make the conversion to it simple, and requiring
> > everyone to totally restructure their drivers to use it does not make
> > that process simple.
> > 
> > What you have here is the result of several transformations to the
> > driver, which would _not_ have been possible without this first patch
> > from Liam.
> 
> Ok, it might have been helpful in the conversion process, but for the final
> patch it would be nice if you could replace
> 
> struct snd_pcm_runtime *runtime = substream->runtime;
> struct omap_runtime_data *prtd = runtime->private_data;
> struct omap_pcm_dma_data *dma_data = prtd->dma_data;
> with
> struct omap_pcm_dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
> 
> and in the hwparams callback use
> 
> snd_dmaengine_pcm_set_data(substream, dma_data);
> 
> and then drop patch 1 and 2 from the series.

We discussed with Liam about the addition of new field in ALSA core,
and concluded that a bit different approach, at least, more generic
name is preferred, even if a new field is inevitably needed.

So, eventually some change may happen in near future in ALSA core
side, but still it'd be really helpful if the callers have been
standardized beforehand with a helper function like above.


thanks,

Takashi
