From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Aug 2014 01:19:16 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <20140804175458.GH30282@n2100.arm.linux.org.uk>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2568292.I2Yo4lJlu6@avalon> <20140804175458.GH30282@n2100.arm.linux.org.uk>
Message-ID: <1877927.dGcJCfKbeH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Monday 04 August 2014 18:54:58 Russell King - ARM Linux wrote:
> On Mon, Aug 04, 2014 at 07:00:36PM +0200, Laurent Pinchart wrote:
> > On Friday 01 August 2014 15:30:20 Russell King - ARM Linux wrote:
> >>  This sequence must occur in a timely manner as some DMA engine
> >> 
> >> implementations hold a lock between the prepare and submit callbacks
> >> (Dan explicitly permits this as part of the API.)
> > 
> > That really triggers a red alarm in the part of my brain that deals with
> > API design, but I suppose it would be too difficult to change that.
> 
> Mine to, but there's not a lot which can be done about it without changing a
> lot of users.

Well, the good side is that it "only" requires enough motivation and free time 
then :-)

> >>> The DMA_PRIVATE capability flag seems to play a role here, but it's
> >>> far from being clear how that mechanism is supposed to work. This
> >>> should be documented as well, and any light you could shed on this
> >>> dark corner of the API would help.
> >> 
> >> Why do you think that DMA_PRIVATE has a bearing in the callbacks? It
> >> doesn't.
> > 
> > Not on callbacks, but on how pending descriptors are pushed to the
> > hardware. The flag is explicitly checked in dma_issue_pending_all().
> 
> Right.  So, let me put a question to you - what do you think is the
> effect of the check in dma_issue_pending_all()?
> 
> I'll give you a hint - disregard the comment at the top of the function,
> because that's out of date.

I suppose the idea is that dma_issue_pending_all() is only used for memcpy 
offload, and can thus ignore channels used for slave transfers.

The code seems to be buggy though. A DMA engine that can serve both memcpy and 
slave transfers could have one channel allocated for memcpy first, then a 
second channel allocated for slave transfers. This would cause the DMA_PRIVATE 
flag to be set, which will prevent dma_issue_pending_all() from calling the 
device_issue_pending operation of the memcpy channel.

> >> DMA_PRIVATE is all about channel allocation as I explained yesterday,
> >> and whether the channel is available for async_tx usage.
> >> 
> >> A channel marked DMA_PRIVATE is not available for async_tx usage at
> >> any moment.  A channel without DMA_PRIVATE is available for async_tx
> >> usage until it is allocated for the slave API - at which point the
> >> generic DMA engine code will mark the channel with DMA_PRIVATE,
> >> thereby taking it away from async_tx API usage.  When the slave API
> >> frees the channel, DMA_PRIVATE will be cleared, making the channel
> >> available for async_tx usage.
> >> 
> >> So, basically, DMA_PRIVATE set -> async_tx usage not allowed.
> >> DMA_PRIVATE clear -> async_tx usage permitted.  It really is that
> >> simple.
> > 
> > DMA_PRIVATE is a dma_device flag, not a dma_chan flag. As soon as one
> > channel is allocated by __dma_request_channel() the whole device is
> > marked with DMA_PRIVATE, making all channels private. What am I missing ?
> 
> I can't answer that - I don't know why the previous authors decided to
> make it a DMA-device wide property - presumably there are DMA controllers
> where this matters.

If I understand the history correctly, the reason to make DMA_PRIVATE a device 
flag is to avoid starving slaves by allocating all channels of a device for 
memcpy. If the DMA_PRIVATE flag is set by the DMA engine driver that works as 
expected. If the DMA engine can be used for both, though, there's no 
guarantee, and the behaviour won't be very predictable.

By the way, shouldn't DMA_PRIVATE be renamed to something more explicit, such 
as DMA_NO_MEMCPY or DMA_SLAVE_ONLY ?

> However, one thing to realise is that a dma_device is a virtual concept -
> it is a set of channels which share a common set of properties.  It is not
> a physical device.  It is entirely reasonable for a set of channels on a
> physical device to be shared between two different dma_device instances
> and handed out by the driver code as needed.

When the channels are independent, sure, but they sometimes share hardware 
resources. For instance the Renesas R-Car Gen2 SoCs have 2 generic-purpose DMA 
engines usable for both memcpy and slave transfers, each of them having 15 
channels. Each DMA engine arbitrates memory accesses from the different 
channels, using either fixed priorities, or a round-robin arbitration. In that 
case it wouldn't make much sense to split the 15 channels across several 
dma_device instances.

I actually have the opposite problem, in my case channels of physically 
separate DMA engines can be used interchangeably to serve the system's slaves. 
Using the DMA engine DT bindings, DT nodes of the slaves currently reference a 
specific DMA engine, even if they can be served by both. This leads to limited 
dynamic channel allocation capabilities (especially when taking into account 
lazy channel allocation as mentioned in another mail in this thread).

> >>> Similarly, the DMA engine API is split in functions with different
> >>> prefixes (mostly dmaengine_*, dma_async_*, dma_*, and various
> >>> unprefixed niceties such as async_tx_ack or txd_lock. If there's a
> >>> rationale for that (beyond just historical reasons) it should also
> >>> be documented, otherwise a cleanup would help all the confused DMA
> >>> engine users (myself included).
> >> 
> >> dmaengine_* are generally the interface functions to the DMA engine
> >> code, which have been recently introduced to avoid the multiple levels of
> >> pointer indirection having to be typed in every driver.
> >> 
> >> dma_async_* are the DMA engine interface functions for the async_tx API.
> >> 
> >> dma_* predate the dmaengine_* naming, and are probably too generic, so
> >> should probably end up being renamed to dmaengine_*.
> > 
> > Thank you for the confirmation. I'll see if I can cook up a patch. It will
> > likely be pretty large and broad though, but I guess there's no way around
> > it.
> >
> >> txd_* are all about the DMA engine descriptors.
> >> 
> >> async_tx_* are the higher level async_tx API functions.
> > 
> > Thank you for the information. How about the dma_async_* functions, should
> > they be renamed to dmaengine_* as well ? Or are some of them part of the
> > async_tx_* API ?
> 
> Well, these:
> 
> dma_async_device_register
> dma_async_device_unregister
> dma_async_tx_descriptor_init
> 
> are more DMA engine core <-> DMA engine driver interface functions than
> user functions.  The remainder of the dma_async_* functions are internal
> to the async_tx API.

I was also thinking about dma_async_issue_pending(). Isn't that function part 
of the DMA engine API rather than the async API ?

-- 
Regards,

Laurent Pinchart
