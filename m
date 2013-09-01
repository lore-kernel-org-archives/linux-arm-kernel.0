From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Sep 2013 13:34:33 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901121928.GC3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130831210518.GK6617@n2100.arm.linux.org.uk>
 <20130901121928.GC3084@sirena.org.uk>
Message-ID: <20130901123433.GR6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 01:19:28PM +0100, Mark Brown wrote:
> On Sat, Aug 31, 2013 at 10:05:18PM +0100, Russell King - ARM Linux wrote:
> 
> > I'm not the only one: I've heard other people complain about the _exact_
> > same issue with ASoC: ASoC is difficult to work with, and many people
> > just seem to give up with it - or keep their stuff in their own trees
> > locally.  I can very well see why that happens.
> 
> We do appear to have a fairly good success rate with systems working
> with mainline; I can only think of one driver that didn't make it in and
> that was one where we had a bit of an issue getting the code to visually
> resemble Linux code so I don't feel too bad about it.  I am aware of
> some people who didn't work upstream, we've generally had some useful
> discussions with them once we've found each other.

I wonder whether you include my ASoC sa11x0 assabet driver in that,
which I gave up trying to get into mainline, because it didn't fit
ASoC with its requirement to have the SSP transmit DMA running in
order to capture, and didn't use the latest soc-dmaengine stuff.
That driver remains in my tree, and is continually forward-ported,
and built in my nightly ARM builds.

> > As for "This is the either/or approach I've been suggesting."  No, that's
> > another false statement from Mark.  What Mark has been suggesting all
> > along is to use DPCM - and that's something which I tried for ages to
> > get working, and it just doesn't work (as evidenced by the oopses and
> > warnings that get spat out of the kernel.)
> 
> While it is correct that I have been saying the final result should use
> DPCM (since this is what the hardware looks like) you will recall that I
> did recently suggest either/or as a stepping stone towards a full
> implementation, allowing systems with only S/PDIF to be supported while
> the other issues are still being worked on.

Yes, and when I asked for details how you'd like that done, you
conveniently decided that you would not reply to that.

> > There are two choices in how the hardware is used: either one output
> > only is used, or if both outputs are used, they must be used "as one" -
> > both outputs must be simultaneously enabled and disabled.  As far as
> > I know, that's not possible with two DAIs.
> 
> That is correct, this is why I call it an either/or approach - a system
> would be able to use either I2S or S/PDIF but not both.  For systems
> with both I2S and S/PDIF connected one or the other would have to be
> chosen by the machine driver.
> 
> > And here's the patch I tried.
> 
> Ah, I'm not sure that I have seen this before (it's certainly not been
> submitted).  Just looking at the diff this all seems fine for an
> either/or approach though...

You wouldn't have seen this exact patch before, because it's a delta
between _this_ series and the one which I just built using the patch
from back in May 2013.  However, I believe you have seen the May 2013
patch at some point along the way.

> > index 2c459c1..62e5b62 100644
> > --- a/sound/soc/kirkwood/kirkwood-spdif.c
> > +++ b/sound/soc/kirkwood/kirkwood-spdif.c
> > @@ -61,7 +61,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
> >  		.name = "S/PDIF0",
> >  		.stream_name = "S/PDIF0 PCM Playback",
> >  		.platform_name = "kirkwood-pcm-audio.0",
> > -		.cpu_dai_name = "kirkwood-i2s.0",
> > +		.cpu_dai_name = "kirkwood-spdif.0",
> >  		.codec_dai_name = "dit-hifi",
> >  		.codec_name = "spdif-dit",
> >  		.ops = &kirkwood_spdif_ops,
> > @@ -73,7 +73,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
> >  		.name = "S/PDIF1",
> >  		.stream_name = "IEC958 Playback",
> >  		.platform_name = "kirkwood-pcm-audio.1",
> > -		.cpu_dai_name = "kirkwood-i2s.1",
> > +		.cpu_dai_name = "kirkwood-spdif.1",
> >  		.codec_dai_name = "dit-hifi",
> >  		.codec_name = "spdif-dit",
> >  		.ops = &kirkwood_spdif_ops,
> 
> ...this file does not appear to be in mainline and some of the rest of
> the context suggested this was based off something old.

Correct - and I have no intention of submitting this file, because it
presupposes mainline non-DT support for Dove.  Non-DT support for Dove
is being removed from mainline at present.  The mainline SIS5531 clock
driver which provides the external clock for this on the Cubox does
not support non-DT.

The non-DT support I run has full support for everything on Dove, which
means I can do much more in-depth testing than just running madplay or
something similar to check that there's audio out - which is about the
limit of what can be done with DT-only setups at the moment, such as
the DPCM bug triggered by vlc.

This is where those who are using mainline kernels with DT on Dove
platforms (like Jean-Francois and Sebastian) need a working solution to
this in a form which they can come up with a representative DT solution.
This is not a one-person effort - there's multiple efforts working on
this, and it's all inter-linked.
