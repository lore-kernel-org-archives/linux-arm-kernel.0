From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Sep 2013 22:18:30 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902204421.GW3084@sirena.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
 <20130902162729.GT3084@sirena.org.uk>
 <20130902165932.GZ6617@n2100.arm.linux.org.uk>
 <20130902204421.GW3084@sirena.org.uk>
Message-ID: <20130902211830.GA6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 09:44:21PM +0100, Mark Brown wrote:
> On Mon, Sep 02, 2013 at 05:59:33PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 02, 2013 at 05:27:29PM +0100, Mark Brown wrote:
> 
> > > That seems like overstating the difficulties.  The updates for any new
> > > S/PDIF drivers will be pretty much the same as those for the existing
> > > I2S drivers and should just be mechanical changes, nothing too taxing.
> 
> > Sorry, you need to explain more.
> 
> > Here's the dual-DAI version:
> 
> >                 .name = "S/PDIF1",
> >                 .stream_name = "IEC958 Playback",
> >                 .platform_name = "mvebu-audio.1",
> >                 .cpu_dai_name = "kirkwood-spdif.1",
> >                 .codec_dai_name = "dit-hifi",
> >                 .codec_name = "spdif-dit",
> 
> > Here's the DPCM version:
> > 
> >         {
> >                 .name = "S/PDIF1",
> >                 .stream_name = "Audio Playback",
> >                 .platform_name = "mvebu-audio.1",
> >                 .cpu_dai_name = "mvebu-audio.1",
> >                 .codec_name = "snd-soc-dummy",
> >                 .codec_dai_name = "snd-soc-dummy-dai",
> >                 .dynamic = 1,
> >         }, {
> >                 .name = "Codec",
> >                 .stream_name = "IEC958 Playback",
> >                 .cpu_dai_name = "snd-soc-dummy-dai",
> >                 .platform_name = "snd-soc-dummy",
> >                 .no_pcm = 1,
> >                 .codec_dai_name = "dit-hifi",
> >                 .codec_name = "spdif-dit",
> >         },
> 
> > The above are two completely different beasts.  Please explain how the DT
> > representation for those DAI links can be the same.
> 
> If the binding is representing the differences between those two in the
> DT then the DT binding is clearly not good since it is exposing Linux
> implementation details - all the binding needs to say is that there's
> something connected to the S/PDIF output of the audio controller.

Can you explain how the kernel would know the difference between a DPCM
and a non-DPCM setup from just the information in the DT please?

> > > > 2. When the driver is converted to DPCM, it must use DPCM for
> > > >    everything, otherwise it has no way to know which of SPDIF or I2S to
> > > >    enable.  The only way I know to work around that is to add additional
> > > >    routes to link up the AIF widgets, and that's the solution you're all
> > > >    telling me is not acceptable, as per the patch set at the start of
> > > >    this thread.
> > > 
> > > What we have been telling you is that if there is a DAI link present
> > > (there should be one for each physical DAI link) then this should be
> > > enough information for the framework to know that the two DAIs are
> > > linked and if any routes are needed in DAPM these should be added
> > > automatically in the same way that we add links for CODEC<->CODEC links
> > > at present.
> 
> > > It's been said to you off-list that having the links manually added
> > > but marking them for removal when the framework figures out how to do
> > > that should be OK.
> 
> > Sorry, I just don't get this.  What you seem to be telling me here is to
> > forget DPCM, and just go with the dual DAI solution.
> 
> No, it's not clear to me why you would think that.  If we are talking
> about adding DAPM routes matching DAI links then we are talking about
> DPCM.  To reiterate the dual DAI implementation would merely be a
>  stepping stone to a DPCM based implementation.

Your reply to my question about DPCM seems to be talking about the
dual-DAI solution.  Maybe you need to be more specific about what
"two DAIs" you are referring to.

> > If I have separate CPU DAI links, then I can't do simultaneous operation,
> > because both DAI links are entirely separate entities which are activated
> > entirely separately.  The only way I know how to handle this is with the
> > patch set I've already posted.
> 
> As you are aware DPCM supports multiple DAIs and a good DPCM
> implementation for this hardware will have one front end DAI for the DMA
> and two back end DAIs, one for the S/PDIF interface and one for the I2S
> interface.

Isn't that what this patch series creates - the front end DAI is the CPU
DAI, and the backend DAIs are provided by the snd-soc-dummy-dai.  I
refer you to this in Liam's driver:

        /* Back End DAI links */
        {
                /* SSP0 - Codec */
                .name = "Codec",
                .be_id = 0,
                .cpu_dai_name = "snd-soc-dummy-dai",
                .platform_name = "snd-soc-dummy",
                .no_pcm = 1,
                .codec_name = "...0-001c",
                .codec_dai_name = "...-aif1",
                .ignore_suspend = 1,
                .ignore_pmdown_time = 1,
                .be_hw_params_fixup = ...,
                .ops = &haswell_ops,
                .dpcm_playback = 1,
                .dpcm_capture = 1,
        },
        {
                /* SSP1 - BT */
                .name = "SSP1-Codec",
                .be_id = 1,
                .cpu_dai_name = "snd-soc-dummy-dai",
                .platform_name = "snd-soc-dummy",
                .no_pcm = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
                .ignore_suspend = 1,
                .ignore_pmdown_time = 1,
        },

Notice that for the DPCM BE, there is no CPU-layer involvement here.

The difference here is that at the moment, with this patch series plus
the DPCM add-on patch, I am only creating one BE, but that BE is being
created in exactly the same way as the above is doing.

> > We've been through this before: this is also not how Liam's example DPCM
> > driver works - please go back and look at those diagrams I drew you of
> > how Liam's driver is setup.  I've also said to you that from what I can
> > see, the routes are still required for DPCM - those routes are in Liam's
> > DPCM driver as well.
> 
> This is why in the above message I reminded you of the suggestion that
> until the framework does automatically figure out that those routes
> should be there the routes are manually added in the driver clearly
> marked so they can easily be removed when the framework does the right
> thing here.

I'm not sure how the framework could figure out these things
automatically.  If you go back to the diagram which I drew you for
Liam's driver, it's not a simple CPU-AIF to Codec linkage - there's
a mixer in the middle of it as well.  There's also feedback from that
mixer (which is on the output side) to an input stream to the CPU DAI
side.

Liam also suggested that there could be DAPM routing which can control
how the FE and BEs are linked together.

So, I still don't see that there is anything wrong with my patch series
plus DPCM-enabling patch, apart from the issues which I've reported.
Maybe you could review it and provide specific comments against the
patches highlighting the code which you have issues with.

As for providing ALSA with a set of PCM operations, I'm not sure what
they should be for a DPCM backend.
