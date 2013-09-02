From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 23:35:00 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902211830.GA6617@n2100.arm.linux.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
 <20130902162729.GT3084@sirena.org.uk>
 <20130902165932.GZ6617@n2100.arm.linux.org.uk>
 <20130902204421.GW3084@sirena.org.uk>
 <20130902211830.GA6617@n2100.arm.linux.org.uk>
Message-ID: <20130902223500.GA3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 10:18:30PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 09:44:21PM +0100, Mark Brown wrote:

> > If the binding is representing the differences between those two in the
> > DT then the DT binding is clearly not good since it is exposing Linux
> > implementation details - all the binding needs to say is that there's
> > something connected to the S/PDIF output of the audio controller.

> Can you explain how the kernel would know the difference between a DPCM
> and a non-DPCM setup from just the information in the DT please?

In the short term from the machine driver of course - linking things
together is what it's there for.  In the longer term I'd expect that the
compatible string could be moved over to a generic machine driver which
can understand the way we're representing the device internally, or
perhaps we'll change that internal representation and it'd do something
totally different anyway, but no need to worry about that for now.

> > > > What we have been telling you is that if there is a DAI link present
> > > > (there should be one for each physical DAI link) then this should be
> > > > enough information for the framework to know that the two DAIs are
> > > > linked and if any routes are needed in DAPM these should be added
> > > > automatically in the same way that we add links for CODEC<->CODEC links
> > > > at present.

> Your reply to my question about DPCM seems to be talking about the
> dual-DAI solution.  Maybe you need to be more specific about what
> "two DAIs" you are referring to.

The two DAIs that are linked by a DAI link are the two DAIs at either
end of the link, for example the I2S DAI on the SoC and the I2S DAI on
the CODEC.

> > As you are aware DPCM supports multiple DAIs and a good DPCM
> > implementation for this hardware will have one front end DAI for the DMA
> > and two back end DAIs, one for the S/PDIF interface and one for the I2S
> > interface.

> Isn't that what this patch series creates - the front end DAI is the CPU
> DAI, and the backend DAIs are provided by the snd-soc-dummy-dai.  I

Not in this patch series as far as I can see, there appear to be no
references to the dummy DAI in it.  From a comment later on in your mail
I suspect you're thinking of the result of adding some additional
changes to the series, please squash those into the existing patches
appropriately and resubmit.

> Notice that for the DPCM BE, there is no CPU-layer involvement here.

> The difference here is that at the moment, with this patch series plus
> the DPCM add-on patch, I am only creating one BE, but that BE is being
> created in exactly the same way as the above is doing.

You should have one back end DAI per physical DAI.

> > This is why in the above message I reminded you of the suggestion that
> > until the framework does automatically figure out that those routes
> > should be there the routes are manually added in the driver clearly
> > marked so they can easily be removed when the framework does the right
> > thing here.

> I'm not sure how the framework could figure out these things
> automatically.  If you go back to the diagram which I drew you for
> Liam's driver, it's not a simple CPU-AIF to Codec linkage - there's
> a mixer in the middle of it as well.  There's also feedback from that

This is not correct, there is no mixer in the link between the back end
and the CODEC.

> mixer (which is on the output side) to an input stream to the CPU DAI
> side.

> Liam also suggested that there could be DAPM routing which can control
> how the FE and BEs are linked together.

This is correct, it is in fact required for operation - you are of
course well aware that front ends and back ends are not connected using
DAI links but are instead connected using normal DAPM links.  This
should all be very simple for Kirkwood.

> So, I still don't see that there is anything wrong with my patch series
> plus DPCM-enabling patch, apart from the issues which I've reported.
> Maybe you could review it and provide specific comments against the
> patches highlighting the code which you have issues with.

I think the most serious issues with the current series were already
covered by Lars-Peter and the discussion in these subtreads, no need to
repeat things.

> As for providing ALSA with a set of PCM operations, I'm not sure what
> they should be for a DPCM backend.

Unless there is a need to actually take some action you can, naturally,
provide stubs.  You should provide the minimal set of stubs required for
operation in your testing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/25592c19/attachment.sig>
