From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 13:19:45 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120509111614.GH3955@opensource.wolfsonmicro.com>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
Message-ID: <20120509121945.GT26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 12:16:15PM +0100, Mark Brown wrote:
> Looking at the code the current usage doesn't seem obviously wrong so
> there's some work to do - we get a callback assigned on each descriptor
> we submit so it's a bit surprising that this might not get delivered,
> though as has been discussed further up the thread that's something that
> might actually happen and perhaps we need to clarify the interfaces
> here.

Go back and look at my opening email in this thread.  Think about
the comments in include/linux/interrupt.h about the tasklet guarantees.
Then look at (eg) the IMX DMA engine driver and ascertain how the
callback is called.  Then look at soc-dmaengine-pcm's callback
method.

Put all this together and what you get is that there's absolutely no
guarantee that the callback will be called for each period.

You really won't know if it slips just one or two periods, because your
audio output won't be affected by that.  It _may_ only become apparant
if DMA catches up with the part of the buffer you're writing to.

Amd I'm also willing to bet that the IMX DMA engine with ASoC has only
been tested with an unloaded system.

> If we can resolve the issues with reading the current position in
> dmaengine then this should be fairly simple to address more
> comprehensively of course, though there will be some hardware imposed
> limits on what we can do.

The issue with doing that is it will break existing setups - have a look
at the various DMA engine implementations of the tx_status method, and
how many actually set the 'residue' bytes correctly (the answer at the
moment is none of them do, according to the definition that we've now
come up with in this thread.)

This is *exactly* the kind of issues we have with DMA engine at present;
the implementations are at best poor quality, partly because the API is
poorly documented and no one has particularly thought about these issues.
Every DMA engine implementation implements the entire API using its own
private code, so each one has its own differing behaviour.

So, really we're not at the point where ASoC maintainers can insist on
anything of DMA engine at present; we need to get DMA engine stuff sorted
out so that we have guaranteed API conditions which can be relied upon by
all users of the API across each DMA engine driver for any particular
kernel version.

Until we have that, we're going to hit problems.  See the recent
brokenness over whether the DMA engine callback is called with spinlocks
held or not, which then caused drivers to spring up their own tasklets
which they schedule from the DMA engine callback.

DMA engine is slowly getting better (mainly through my efforts at trying
to extract common code, and fix down the API issues) but it needs folk
with strong and good review skills to ensure that we stop the influx of
non-conforming code and get that non-conforming code fixed.
