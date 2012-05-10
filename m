From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2012 08:44:03 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <1336621458.1540.280.camel@vkoul-udesk3>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
Message-ID: <20120510074403.GA3190@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 09:14:18AM +0530, Vinod Koul wrote:
> On Wed, 2012-05-09 at 13:19 +0100, Russell King - ARM Linux wrote:
> > On Wed, May 09, 2012 at 12:16:15PM +0100, Mark Brown wrote:
> > > Looking at the code the current usage doesn't seem obviously wrong so
> > > there's some work to do - we get a callback assigned on each descriptor
> > > we submit so it's a bit surprising that this might not get delivered,
> > > though as has been discussed further up the thread that's something that
> > > might actually happen and perhaps we need to clarify the interfaces
> > > here.
> > 
> > Go back and look at my opening email in this thread.  Think about
> > the comments in include/linux/interrupt.h about the tasklet guarantees.
> > Then look at (eg) the IMX DMA engine driver and ascertain how the
> > callback is called.  Then look at soc-dmaengine-pcm's callback
> > method.
> > 
> > Put all this together and what you get is that there's absolutely no
> > guarantee that the callback will be called for each period.
> > 
> > You really won't know if it slips just one or two periods, because your
> > audio output won't be affected by that.  It _may_ only become apparant
> > if DMA catches up with the part of the buffer you're writing to.
> > 
> > Amd I'm also willing to bet that the IMX DMA engine with ASoC has only
> > been tested with an unloaded system. 
> 
> DMAengine mandates the callback be called from tasklet. Yes under a very
> heavy loaded systems there can be a certain case where callback maybe
> delayed. Or the tasklet gets scheduled _once_ for couple of dma
> completions, thus missed
> 
> But tell me what prevents the dmac driver for fixing this. In ISR they
> can easily find which descriptor is completed and mark them so.
> In tasklet, it can ensure that all callback are generated including
> previous missed ones, if that is something the usage of dmaengine needs.
> 
> For audio needs I think it is fine if we miss, as long as subsequent
> comes untill we get underrun/overrun.
> 
> Quite a few ASoC drivers use dmaengine today (cyclic was added keeping
> audio in mind), so adding library helps to avoid each ASoC driver having
> its own implementation. It indirectly ensures that APIs are properly
> implemented as well and any bugs due to deviation form std behavior gets
> identified and fixed!

I'm not going to describe the problem for a third time.  I've said what it
is.  I've pointed at the drivers which are potentially a problem.  Please
look over them and you'll see the problem.

In fact, please look at both imx-dma.c _and_ imx-sdma.c - search for
"callback" and have a look at the code around there.

You will find that imx-dma.c processes one descriptor per tasklet run,
and calls the callback under a spinlock.

You'll find that imx-sdma.c always calls callbacks from IRQ context.
