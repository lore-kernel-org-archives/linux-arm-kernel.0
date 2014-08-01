From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 01 Aug 2014 10:51:26 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <20140724045248.GB8181@intel.com>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <28702317.aD0C1Ga3DS@avalon> <20140724045248.GB8181@intel.com>
Message-ID: <18522523.T2zy7HfoJ2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Thursday 24 July 2014 10:22:48 Vinod Koul wrote:
> On Wed, Jul 23, 2014 at 01:07:43PM +0200, Laurent Pinchart wrote:
> > > The rsnd_soc_dai_trigger() function takes a spinlock, making the context
> > > atomic, which regmap doesn't like as it locks a mutex.
> > > 
> > > It might be possible to fix this by setting the fast_io field in both
> > > the regmap_config and regmap_bus structures in sound/soc/sh/rcar/gen.c.
> > > regmap will then use a spinlock instead of a mutex. However, even if I
> > > believe that change makes sense and should be done, another atomic
> > > context issue will come from the rcar-dmac driver which allocates memory
> > > in the prep_dma_cyclic function, called by rsnd_dma_start() from
> > > rsnd_soc_dai_trigger() with the spinlock help.
> > > 
> > > What context is the rsnd_soc_dai_trigger() function called in by the
> > > alsa core ? If it's guaranteed to be a sleepable context, would it make
> > > sense to replace the rsnd_priv spinlock with a mutex ?
> > 
> > Answering myself here, that's not an option, as the trigger function is
> > called in atomic context (replacing the spinlock with a mutex produced a
> > clear BUG) due to snd_pcm_lib_write1() taking a spinlock.
> > 
> > Now we have a core issue. On one side there's rsnd_soc_dai_trigger() being
> > called in atomic context, and on the other side the function ends up
> > calling dmaengine_prep_dma_cyclic() which needs to allocate memory. To
> > make this more func the DMA engine API is undocumented and completely
> > silent on whether the prep functions are allowed to sleep. The question
> > is, who's wrong ?
> > 
> > Now, if you're tempted to say that I'm wrong by allocating memory with
> > GFP_KERNEL in the DMA engine driver, please read on first :-) I've tried
> > replacing GFP_KERNEL with GFP_ATOMIC allocations, and then ran into a
> > problem more complex to solve.
> > 
> > The rcar-dmac DMA engine driver uses runtime PM. When not used, the device
> > is suspended. The driver calls pm_runtime_get_sync() to resume the
> > device, and needs to do so when a descriptor is submitted. This
> > operation, currently performed in the tx_submit handler, could be moved
> > to the prep_dma_cyclic or issue_pending handler, but the three operations
> > are called in a row from rsnd_dma_start(), itself ultimately called from
> > snd_pcm_lib_write1() with the spinlock held. This means I have no place
> > in my DMA engine driver where I can resume the device.
> > 
> > One could argue that the rcar-dmac driver could use a work queue to handle
> > power management. That's correct, but the additional complexity, which
> > would be required in *all* DMA engine drivers, seem too high to me. If we
> > need to go that way, this is really a task that the DMA engine core
> > should handle.
> > 
> > Let's start by answering the background question and updating the DMA
> > engine API documentation once and for good : in which context are drivers
> > allowed to call the prep, tx_submit and issue_pending functions ?
> 
> I think this was bought up sometime back and we have cleared that all _prep
> functions can be invoked in atomic context.
> 
> This is the reason why we have been pushing folks to use GFP_NOWAIT is
> memory allocations during prepare.

>From the replies I've received it's pretty clear that the prep functions need 
to be callable from atomic context. I'll respond to this in more depth in a 
reply to Russell's e-mail.

> Thanks for pointing out documentation doesn't say so, will send a patch for
> that.

I wish that was all that is missing from the documentation ;-) Luckily Maxime 
Ripard has sent a patch that documents DMA engine from a DMA engine driver's 
point of view. While not perfect (I'm going to review it), it's a nice 
starting point to (hopefully) get to a properly documented framework.

> On issue_pending and tx_submit, yes these should be allowed to be called
> from atomic context too.

I'll take this opportunity to question why we have a separation between 
tx_submit and issue_pending. What's the rationale for that, especially given 
that dma_issue_pending_all() might kick in at any point and issue pending 
transfers for all devices. A driver could thus see its submitted but not 
issued transactions being issued before it explicitly calls 
dma_async_issue_pending().

The DMA_PRIVATE capability flag seems to play a role here, but it's far from 
being clear how that mechanism is supposed to work. This should be documented 
as well, and any light you could shed on this dark corner of the API would 
help.

Similarly, the DMA engine API is split in functions with different prefixes 
(mostly dmaengine_*, dma_async_*, dma_*, and various unprefixed niceties such 
as async_tx_ack or txd_lock. If there's a rationale for that (beyond just 
historical reasons) it should also be documented, otherwise a cleanup would 
help all the confused DMA engine users (myself included). I might be able to 
find a bit of time to work on that, but I'll first need to correctly 
understand where we come from and where we are. Again, information would be 
welcome and fully appreciated.

> Lastly, just to clarify the callback invoked after descriptor is complete
> can also be used to submit new descriptors, so folks are dropping locking
> before invoking the callback

-- 
Regards,

Laurent Pinchart
