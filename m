From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 15:03:24 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120509121945.GT26481@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
Message-ID: <20120509140323.GR3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 01:19:45PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 09, 2012 at 12:16:15PM +0100, Mark Brown wrote:

> > Looking at the code the current usage doesn't seem obviously wrong so
> > there's some work to do - we get a callback assigned on each descriptor
> > we submit so it's a bit surprising that this might not get delivered,
> > though as has been discussed further up the thread that's something that
> > might actually happen and perhaps we need to clarify the interfaces
> > here.

> Go back and look at my opening email in this thread.  Think about
> the comments in include/linux/interrupt.h about the tasklet guarantees.
> Then look at (eg) the IMX DMA engine driver and ascertain how the
> callback is called.  Then look at soc-dmaengine-pcm's callback
> method.

> Put all this together and what you get is that there's absolutely no
> guarantee that the callback will be called for each period.

I'm not saying that the current implementation works perfectly and that
there are no bugs anywhere (indeed, I did say "that [dropped callbacks
are] something that might actually happen"), I'm saying that the way the
interface has been written it's entirely reasonable for someone to
expect that their completion callbacks will be delivered; it's highly
unusual to have a callback like this that's unreliably called and it's
going to be error prone.  As part of fixing this we should look at
trying to ensure that the interface doesn't mislead people.

> You really won't know if it slips just one or two periods, because your
> audio output won't be affected by that.  It _may_ only become apparant
> if DMA catches up with the part of the buffer you're writing to.

> Amd I'm also willing to bet that the IMX DMA engine with ASoC has only
> been tested with an unloaded system.

You're probably going to be OK even under reasonable load for most
applications except VoIP - the buffers tend to end up being reasonably
deep in the context of the scheduler.

> > If we can resolve the issues with reading the current position in
> > dmaengine then this should be fairly simple to address more
> > comprehensively of course, though there will be some hardware imposed
> > limits on what we can do.

> The issue with doing that is it will break existing setups - have a look
> at the various DMA engine implementations of the tx_status method, and
> how many actually set the 'residue' bytes correctly (the answer at the
> moment is none of them do, according to the definition that we've now
> come up with in this thread.)

So as a transition measure can we quirk this in the soc-dmaengine stuff?
It seems like we should be able to, possibly based on capability
information from dmaengine (ISTR some DMA controllers floating around
which weren't able to provide any useful information anyway so we may
need to keep some level of workaround anyway).

> So, really we're not at the point where ASoC maintainers can insist on
> anything of DMA engine at present; we need to get DMA engine stuff sorted
> out so that we have guaranteed API conditions which can be relied upon by
> all users of the API across each DMA engine driver for any particular
> kernel version.

I'm afraid this is trying to bolt the stable door after the horse has
bolted - we've already got most of the drivers using the same code base,
the only ones that aren't are the ones that need to emulate cyclic DMA.

> DMA engine is slowly getting better (mainly through my efforts at trying
> to extract common code, and fix down the API issues) but it needs folk
> with strong and good review skills to ensure that we stop the influx of
> non-conforming code and get that non-conforming code fixed.

For this I think actual cross-platform users are going to be enormously
helpful - part of the reason dmaengine is the way that it is is that
many of the drivers would only ever be used with a fixed set of clients
which only ever used that driver so it was very easy for them to evolve
private conventions without anyone noticing.  Generic users don't allow
this sort of stuff and it seems more sensible to get people to fix their
systems at the dmaengine level than to duplicate the higher level code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/8e66b86d/attachment.sig>
