From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 01 Aug 2014 11:24:13 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <20140724125120.GN21766@n2100.arm.linux.org.uk>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <28702317.aD0C1Ga3DS@avalon> <20140724125120.GN21766@n2100.arm.linux.org.uk>
Message-ID: <5972281.SIICqHk85N@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thursday 24 July 2014 13:51:21 Russell King - ARM Linux wrote:
> On Wed, Jul 23, 2014 at 01:07:43PM +0200, Laurent Pinchart wrote:
> > Now we have a core issue. On one side there's rsnd_soc_dai_trigger() being
> > called in atomic context, and on the other side the function ends up
> > calling dmaengine_prep_dma_cyclic() which needs to allocate memory. To
> > make this more func the DMA engine API is undocumented and completely
> > silent on whether the prep functions are allowed to sleep. The question
> > is, who's wrong ?
>
> For slave DMA drivers, there is the expectation that the prepare functions
> will be callable from tasklet context, without any locks held by the driver. 
> So, it's expected that the prepare functions will work from tasklet context.
> 
> I don't think we've ever specified whether they should be callable from
> interrupt context, but in practice, we have drivers which do exactly that,
> so I think the decision has already been made - they will be callable from
> IRQ context, and so GFP_ATOMIC is required in the driver.

I agree with you, the decision has made itself to use allocation routines that 
will not sleep. However,

$ grep -r GFP_NOWAIT drivers/dma | wc -l
22
$ grep -r GFP_ATOMIC drivers/dma | wc -l
24

Looks like a draw to me :-) I'm pretty sure most of the decisions to use 
GFP_NOWAIT or GFP_ATOMIC are cases of cargo-cult programming instead of 
resulting from a thoughtful process. We should document this in Maxime's new 
DMA engine internals documentation.

This being said, I wonder whether allowing the prep functions to be called in 
atomic context was a sane decision. We've pushed the whole DMA engine API to 
atomic context, leading to such niceties as memory allocation pressure and the 
impossibility to implement runtime PM support without resorting to a work 
queue for the sole purpose of power management, in *every* DMA engine driver. 
I can't help but thinking something is broken.

I'd like your opinion on that. Whether fixing it would be worth the effort is 
a different question, so we could certainly conclude that we'll have to live 
with an imperfect design for the time being.

> > The rcar-dmac DMA engine driver uses runtime PM. When not used, the device
> > is suspended. The driver calls pm_runtime_get_sync() to resume the
> > device, and needs to do so when a descriptor is submitted. This
> > operation, currently performed in the tx_submit handler, could be moved
> > to the prep_dma_cyclic or issue_pending handler, but the three operations
> > are called in a row from rsnd_dma_start(), itself ultimately called from
> > snd_pcm_lib_write1() with the spinlock held. This means I have no place
> > in my DMA engine driver where I can resume the device.
> 
> Right, runtime PM with DMA engine drivers is hard. The best that can be done
> right now is to pm_runtime_get() in the alloc_chan_resources() method and
> put it in free_chan_resources() if you don't want to do the workqueue thing.

That's an easy enough implementation, but given that channels are usually 
requested at probe time and released at remove time, that would be roughly 
equivalent to no PM at all.

> There's a problem with the workqueue thing though - by doing so, you make it
> asynchronous to the starting of the DMA. The DMA engine API allows for
> delayed starting (it's actually the normal thing for DMA engine), but that
> may not always be appropriate or desirable.

If I'm not mistaken, the DMA engine API doesn't provide a way to synchronously 
start DMA transfers. An implementation could do so, but no guarantee is 
offered by the API to the caller. I agree, however, that it could be an issue.

Doesn't this call for a new pair of open/close-like functions in the API ? 
They would be called right before a client driver starts using a channel, and 
right after it stops using it. Those functions would be allowed to sleep.

Beside simplifying power management, those functions could also be used for 
lazy hardware channel allocation. Renesas SoCs have DMA engines that include 
general-purpose channels, usable by any slave. There are more slaves than 
hardware channels, so not all slaves can be used at the same time. At the 
moment the hardware channel is allocated when requesting the DMA engine 
channel, at probe time for most slave drivers. This breaks when too many 
slaves get registered, even if they're not all used at the same time. Some 
kind of lazy/delayed allocation scheme would be useful.

Another option would be to request the DMA engine channel later than probe 
time, when the channel will actually be used. However, that would break 
deferred probing, and would possibly degrade performances.

> > One could argue that the rcar-dmac driver could use a work queue to
> > handle power management. That's correct, but the additional complexity,
> > which would be required in *all* DMA engine drivers, seem too high to
> > me. If we need to go that way, this is really a task that the DMA
> > engine core should handle.
> 
> As I mention above, the problem with that is getting the workqueue to run
> soon enough that it doesn't cause a performance degredation or other issues.

That's why I liked the ability to sleep in the prep functions ;-)

> There's also expectations from other code - OMAP for example explicitly
> needs DMA to be started on the hardware before the audio block can be
> enabled (from what I remember, it tickless an erratum if this is not done.)

Nice. That pretty much bans the usage of a workqueue then, we need something 
else.

> > Let's start by answering the background question and updating the DMA
> > engine API documentation once and for good : in which context are drivers
> > allowed to call the prep, tx_submit and issue_pending functions ?
> 
> IRQs-off contexts. :)

-- 
Regards,

Laurent Pinchart
