From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Sep 2013 00:00:11 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902223500.GA3084@sirena.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
 <20130902162729.GT3084@sirena.org.uk>
 <20130902165932.GZ6617@n2100.arm.linux.org.uk>
 <20130902204421.GW3084@sirena.org.uk>
 <20130902211830.GA6617@n2100.arm.linux.org.uk>
 <20130902223500.GA3084@sirena.org.uk>
Message-ID: <20130902230011.GC6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 11:35:00PM +0100, Mark Brown wrote:
> Not in this patch series as far as I can see, there appear to be no
> references to the dummy DAI in it.  From a comment later on in your mail
> I suspect you're thinking of the result of adding some additional
> changes to the series, please squash those into the existing patches
> appropriately and resubmit.

I'm thinking of making _no_ changes to this series at present, because
I fail to see anything wrong with it.

As for "no references to the dummy DAI in it" - I did mention the
additional patch which is _not_ part of this series which contains
the changes to enable DPCM.  Here's an extract which I posted just
two messages before this one of the resulting DAI link structure:

Here's the DPCM version:                                                        
                                                                                
        {                                                                       
                .name = "S/PDIF1",                                              
                .stream_name = "Audio Playback",                                
                .platform_name = "mvebu-audio.1",                               
                .cpu_dai_name = "mvebu-audio.1",                                
                .codec_name = "snd-soc-dummy",                                  
                .codec_dai_name = "snd-soc-dummy-dai",                          
                .dynamic = 1,                                                   
        }, {                                                                    
                .name = "Codec",                                                
                .stream_name = "IEC958 Playback",                               
                .cpu_dai_name = "snd-soc-dummy-dai",                            
                .platform_name = "snd-soc-dummy",                               
                .no_pcm = 1,                                                    
                .codec_dai_name = "dit-hifi",                                   
                .codec_name = "spdif-dit",                                      
        },                                                                      

Please see the second entry.  This is the backend DAI setup.  This refers
to the dummy DAI for the CPU, and has 'no_pcm' set - both of which I
believe are required to indicate that this is representing a backend DAI.

As I've said before, the reason I haven't included this file is that it
is unclear that it is useful for non-DT setups.  As there is no non-DT
Cubox support in the kernel and never will be, I don't see any point
submitting it as part of this series.

Secondly, I don't see the point of it being part of this series, because
if we merge the changes for DPCM support, the thing falls apart - I'm
not going to list the problems yet again.

> > Notice that for the DPCM BE, there is no CPU-layer involvement here.
> 
> > The difference here is that at the moment, with this patch series plus
> > the DPCM add-on patch, I am only creating one BE, but that BE is being
> > created in exactly the same way as the above is doing.
> 
> You should have one back end DAI per physical DAI.

What do you mean "physical DAI"?  Do you mean "CPU DAI" which would be a
front end DAI?

Liam told me that it was possible to have multiple backends for a single
front end.  You've also told me on IRC:

16:29 < broonie> I have a pretty good idea of how I'd expect to see the
 hardware represented - two BEs for the DAIs connected to a FE for the DMA.

That isn't two FEs.  You explicitly state there "two BEs" for a single FE.

> > > This is why in the above message I reminded you of the suggestion that
> > > until the framework does automatically figure out that those routes
> > > should be there the routes are manually added in the driver clearly
> > > marked so they can easily be removed when the framework does the right
> > > thing here.
> 
> > I'm not sure how the framework could figure out these things
> > automatically.  If you go back to the diagram which I drew you for
> > Liam's driver, it's not a simple CPU-AIF to Codec linkage - there's
> > a mixer in the middle of it as well.  There's also feedback from that
> 
> This is not correct, there is no mixer in the link between the back end
> and the CODEC.

Let me re-post the structure of the widgets linking the codecs streams and
CPU streams in Liam's driver then.

CPU DAI drivers:    DAI stream names:
--------------------------------------
System Pin          System Playback
Offload0 Pin        Offload0 Playback
Offload1 Pin        Offload1 Playback
Loopback Pin        Loopback Capture
Capture Pin         Analog Capture

DAPM routes:
[s]System Playback   --------v           .----> [aif]SSP0 CODEC OUT
[s]Offload0 Playback ---> [w]Playback VMixer
[s]Offload1 Playback --------^           `----> [s]Loopback Capture
 
[aif]SSP0 CODEC IN ---> [s]Analog Capture

where [s] is a stream widget, [w] is a DAPM widget, and [aif] is an
AIF widget.

Looks like there's a mixer in there to me.  It may not be a bit of
hardware which actually does mixing or anything (I don't know what it
does) but that appears to be DAPM structure which Liam creates between
the CPU streams and the codecs.

> > mixer (which is on the output side) to an input stream to the CPU DAI
> > side.
> 
> > Liam also suggested that there could be DAPM routing which can control
> > how the FE and BEs are linked together.
> 
> This is correct, it is in fact required for operation - you are of
> course well aware that front ends and back ends are not connected using
> DAI links but are instead connected using normal DAPM links.  This
> should all be very simple for Kirkwood.

And these are the DAPM routes which you're telling me to put a comment
against because they will need to be removed.  I can't see why they'd
ever need to be removed, and I can't see how ASoC could possibly
know the structure between the CPU and codec in DPCM solutions.

> > So, I still don't see that there is anything wrong with my patch series
> > plus DPCM-enabling patch, apart from the issues which I've reported.
> > Maybe you could review it and provide specific comments against the
> > patches highlighting the code which you have issues with.
> 
> I think the most serious issues with the current series were already
> covered by Lars-Peter and the discussion in these subtreads, no need to
> repeat things.

Sorry, I thought Lars-Peter's comments were about getting something that
would be acceptable to go in _before_ DPCM was in a working state.

So, I'll re-state again.  I see nothing wrong with my patch series plus
the DPCM-enabling patch.  I see this as a complete and proper DPCM
solution with no flaws in the driver code what so ever.  I don't see
Lars-Peter's comments being relevant to the DPCM solution, but only to
a stop-gap solution.

> > As for providing ALSA with a set of PCM operations, I'm not sure what
> > they should be for a DPCM backend.
> 
> Unless there is a need to actually take some action you can, naturally,
> provide stubs.  You should provide the minimal set of stubs required for
> operation in your testing.

That needs to go in the ASoC code though - I don't think I have access
to the ALSA PCM which has been created for the backend DAI(s).  Remember,
the backend DAIs are "owned" by the dummy DAI driver, not the CPU driver,
so the CPU driver doesn't get to see any operations for that.
