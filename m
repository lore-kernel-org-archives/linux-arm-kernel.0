From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jul 2014 13:51:21 +0100
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <28702317.aD0C1Ga3DS@avalon>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87d2cwvmxa.wl%kuninori.morimoto.gx@gmail.com> <3361994.F0HgAeJkR9@avalon>
 <28702317.aD0C1Ga3DS@avalon>
Message-ID: <20140724125120.GN21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 01:07:43PM +0200, Laurent Pinchart wrote:
> Now we have a core issue. On one side there's rsnd_soc_dai_trigger() being 
> called in atomic context, and on the other side the function ends up calling 
> dmaengine_prep_dma_cyclic() which needs to allocate memory. To make this more 
> func the DMA engine API is undocumented and completely silent on whether the 
> prep functions are allowed to sleep. The question is, who's wrong ?

For slave DMA drivers, there is the expectation that the prepare
functions will be callable from tasklet context, without any locks
held by the driver.  So, it's expected that the prepare functions
will work from tasklet context.

I don't think we've ever specified whether they should be callable
from interrupt context, but in practice, we have drivers which do
exactly that, so I think the decision has already been made - they
will be callable from IRQ context, and so GFP_ATOMIC is required
in the driver.

> The rcar-dmac DMA engine driver uses runtime PM. When not used, the device is 
> suspended. The driver calls pm_runtime_get_sync() to resume the device, and 
> needs to do so when a descriptor is submitted. This operation, currently 
> performed in the tx_submit handler, could be moved to the prep_dma_cyclic or 
> issue_pending handler, but the three operations are called in a row from 
> rsnd_dma_start(), itself ultimately called from snd_pcm_lib_write1() with the 
> spinlock held. This means I have no place in my DMA engine driver where I can 
> resume the device.

Right, runtime PM with DMA engine drivers is hard.  The best that can
be done right now is to pm_runtime_get() in the alloc_chan_resources()
method and put it in free_chan_resources() if you don't want to do the
workqueue thing.

There's a problem with the workqueue thing though - by doing so, you
make it asynchronous to the starting of the DMA.  The DMA engine API
allows for delayed starting (it's actually the normal thing for DMA
engine), but that may not always be appropriate or desirable.

> One could argue that the rcar-dmac driver could use a work queue to
> handle power management. That's correct, but the additional complexity,
> which would be required in *all* DMA engine drivers, seem too high to
> me. If we need to go that way, this is really a task that the DMA
> engine core should handle.

As I mention above, the problem with that is getting the workqueue to
run soon enough that it doesn't cause a performance degredation or
other issues.

There's also expectations from other code - OMAP for example explicitly
needs DMA to be started on the hardware before the audio block can be
enabled (from what I remember, it tickless an erratum if this is not
done.)

> Let's start by answering the background question and updating the DMA engine 
> API documentation once and for good : in which context are drivers allowed to 
> call the prep, tx_submit and issue_pending functions ?

IRQs-off contexts. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
