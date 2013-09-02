From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 21:44:21 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902165932.GZ6617@n2100.arm.linux.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
 <20130902162729.GT3084@sirena.org.uk>
 <20130902165932.GZ6617@n2100.arm.linux.org.uk>
Message-ID: <20130902204421.GW3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 05:59:33PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 05:27:29PM +0100, Mark Brown wrote:

> > That seems like overstating the difficulties.  The updates for any new
> > S/PDIF drivers will be pretty much the same as those for the existing
> > I2S drivers and should just be mechanical changes, nothing too taxing.

> Sorry, you need to explain more.

> Here's the dual-DAI version:

>                 .name = "S/PDIF1",
>                 .stream_name = "IEC958 Playback",
>                 .platform_name = "mvebu-audio.1",
>                 .cpu_dai_name = "kirkwood-spdif.1",
>                 .codec_dai_name = "dit-hifi",
>                 .codec_name = "spdif-dit",

> Here's the DPCM version:
> 
>         {
>                 .name = "S/PDIF1",
>                 .stream_name = "Audio Playback",
>                 .platform_name = "mvebu-audio.1",
>                 .cpu_dai_name = "mvebu-audio.1",
>                 .codec_name = "snd-soc-dummy",
>                 .codec_dai_name = "snd-soc-dummy-dai",
>                 .dynamic = 1,
>         }, {
>                 .name = "Codec",
>                 .stream_name = "IEC958 Playback",
>                 .cpu_dai_name = "snd-soc-dummy-dai",
>                 .platform_name = "snd-soc-dummy",
>                 .no_pcm = 1,
>                 .codec_dai_name = "dit-hifi",
>                 .codec_name = "spdif-dit",
>         },

> The above are two completely different beasts.  Please explain how the DT
> representation for those DAI links can be the same.

If the binding is representing the differences between those two in the
DT then the DT binding is clearly not good since it is exposing Linux
implementation details - all the binding needs to say is that there's
something connected to the S/PDIF output of the audio controller.

> > > 2. When the driver is converted to DPCM, it must use DPCM for
> > >    everything, otherwise it has no way to know which of SPDIF or I2S to
> > >    enable.  The only way I know to work around that is to add additional
> > >    routes to link up the AIF widgets, and that's the solution you're all
> > >    telling me is not acceptable, as per the patch set at the start of
> > >    this thread.
> > 
> > What we have been telling you is that if there is a DAI link present
> > (there should be one for each physical DAI link) then this should be
> > enough information for the framework to know that the two DAIs are
> > linked and if any routes are needed in DAPM these should be added
> > automatically in the same way that we add links for CODEC<->CODEC links
> > at present.

> > It's been said to you off-list that having the links manually added
> > but marking them for removal when the framework figures out how to do
> > that should be OK.

> Sorry, I just don't get this.  What you seem to be telling me here is to
> forget DPCM, and just go with the dual DAI solution.

No, it's not clear to me why you would think that.  If we are talking
about adding DAPM routes matching DAI links then we are talking about
DPCM.  To reiterate the dual DAI implementation would merely be a
 stepping stone to a DPCM based implementation.

> If I have separate CPU DAI links, then I can't do simultaneous operation,
> because both DAI links are entirely separate entities which are activated
> entirely separately.  The only way I know how to handle this is with the
> patch set I've already posted.

As you are aware DPCM supports multiple DAIs and a good DPCM
implementation for this hardware will have one front end DAI for the DMA
and two back end DAIs, one for the S/PDIF interface and one for the I2S
interface.

> We've been through this before: this is also not how Liam's example DPCM
> driver works - please go back and look at those diagrams I drew you of
> how Liam's driver is setup.  I've also said to you that from what I can
> see, the routes are still required for DPCM - those routes are in Liam's
> DPCM driver as well.

This is why in the above message I reminded you of the suggestion that
until the framework does automatically figure out that those routes
should be there the routes are manually added in the driver clearly
marked so they can easily be removed when the framework does the right
thing here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/d125bfda/attachment-0001.sig>
