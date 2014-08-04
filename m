From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 04 Aug 2014 19:00:36 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <20140801143020.GQ30282@n2100.arm.linux.org.uk>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <18522523.T2zy7HfoJ2@avalon> <20140801143020.GQ30282@n2100.arm.linux.org.uk>
Message-ID: <2568292.I2Yo4lJlu6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Friday 01 August 2014 15:30:20 Russell King - ARM Linux wrote:
> On Fri, Aug 01, 2014 at 10:51:26AM +0200, Laurent Pinchart wrote:
> > I'll take this opportunity to question why we have a separation between
> > tx_submit and issue_pending. What's the rationale for that, especially
> > given that dma_issue_pending_all() might kick in at any point and issue
> > pending transfers for all devices. A driver could thus see its submitted
> > but not issued transactions being issued before it explicitly calls
> > dma_async_issue_pending().
> 
> A prepared but not submitted transaction is not a pending transaction.
> 
> The split is necessary so that a callback can be attached to the
> transaction.  This partially comes from the async-tx API, and also
> gets a lot of use with the slave API.
> 
> The prepare function allocates the descriptor and does the initial
> setup, but does not mark the descriptor as a pending transaction.
> It returns the descriptor, and the caller is then free to add a
> callback function and data pointer to the descriptor before finally
> submitting it.

No disagreement on that. However, as Geert pointed out, my question was 
related to the split between dmaengine_submit() and dma_async_issue_pending(), 
not between the prep_* functions and dmaengine_submit().

>  This sequence must occur in a timely manner as some DMA engine
> implementations hold a lock between the prepare and submit callbacks (Dan
> explicitly permits this as part of the API.)

That really triggers a red alarm in the part of my brain that deals with API 
design, but I suppose it would be too difficult to change that.

> > The DMA_PRIVATE capability flag seems to play a role here, but it's far
> > from being clear how that mechanism is supposed to work. This should be
> > documented as well, and any light you could shed on this dark corner of
> > the API would help.
> 
> Why do you think that DMA_PRIVATE has a bearing in the callbacks? It
> doesn't.

Not on callbacks, but on how pending descriptors are pushed to the hardware. 
The flag is explicitly checked in dma_issue_pending_all().

> DMA_PRIVATE is all about channel allocation as I explained yesterday, and
> whether the channel is available for async_tx usage.
> 
> A channel marked DMA_PRIVATE is not available for async_tx usage at
> any moment.  A channel without DMA_PRIVATE is available for async_tx
> usage until it is allocated for the slave API - at which point the
> generic DMA engine code will mark the channel with DMA_PRIVATE,
> thereby taking it away from async_tx API usage.  When the slave API
> frees the channel, DMA_PRIVATE will be cleared, making the channel
> available for async_tx usage.
> 
> So, basically, DMA_PRIVATE set -> async_tx usage not allowed.
> DMA_PRIVATE clear -> async_tx usage permitted.  It really is that
> simple.

DMA_PRIVATE is a dma_device flag, not a dma_chan flag. As soon as one channel 
is allocated by __dma_request_channel() the whole device is marked with 
DMA_PRIVATE, making all channels private. What am I missing ?

> > Similarly, the DMA engine API is split in functions with different
> > prefixes (mostly dmaengine_*, dma_async_*, dma_*, and various
> > unprefixed niceties such as async_tx_ack or txd_lock. If there's a
> > rationale for that (beyond just historical reasons) it should also
> > be documented, otherwise a cleanup would help all the confused DMA
> > engine users (myself included).
> 
> dmaengine_* are generally the interface functions to the DMA engine code,
> which have been recently introduced to avoid the multiple levels of
> pointer indirection having to be typed in every driver.
> 
> dma_async_* are the DMA engine interface functions for the async_tx API.
> 
> dma_* predate the dmaengine_* naming, and are probably too generic, so
> should probably end up being renamed to dmaengine_*.

Thank you for the confirmation. I'll see if I can cook up a patch. It will 
likely be pretty large and broad though, but I guess there's no way around it. 

> txd_* are all about the DMA engine descriptors.
> 
> async_tx_* are the higher level async_tx API functions.

Thank you for the information. How about the dma_async_* functions, should 
they be renamed to dmaengine_* as well ? Or are some of them part of the 
async_tx_* API ?

-- 
Regards,

Laurent Pinchart
