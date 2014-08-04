From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 04 Aug 2014 18:50:17 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <20140801170744.GD8181@intel.com>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <18522523.T2zy7HfoJ2@avalon> <20140801170744.GD8181@intel.com>
Message-ID: <1621896.RqTTnmY7rK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Friday 01 August 2014 22:37:44 Vinod Koul wrote:
> On Fri, Aug 01, 2014 at 10:51:26AM +0200, Laurent Pinchart wrote:
> > On Thursday 24 July 2014 10:22:48 Vinod Koul wrote:
> >> On Wed, Jul 23, 2014 at 01:07:43PM +0200, Laurent Pinchart wrote:
> >>>> The rsnd_soc_dai_trigger() function takes a spinlock, making the
> >>>> context atomic, which regmap doesn't like as it locks a mutex.
> >>>> 
> >>>> It might be possible to fix this by setting the fast_io field in
> >>>> both the regmap_config and regmap_bus structures in
> >>>> sound/soc/sh/rcar/gen.c.
> >>>> regmap will then use a spinlock instead of a mutex. However, even if
> >>>> I believe that change makes sense and should be done, another atomic
> >>>> context issue will come from the rcar-dmac driver which allocates
> >>>> memory in the prep_dma_cyclic function, called by rsnd_dma_start()
> >>>> from rsnd_soc_dai_trigger() with the spinlock help.
> >>>> 
> >>>> What context is the rsnd_soc_dai_trigger() function called in by the
> >>>> alsa core ? If it's guaranteed to be a sleepable context, would it
> >>>> make sense to replace the rsnd_priv spinlock with a mutex ?
> >>> 
> >>> Answering myself here, that's not an option, as the trigger function
> >>> is called in atomic context (replacing the spinlock with a mutex
> >>> produced a clear BUG) due to snd_pcm_lib_write1() taking a spinlock.
> >>> 
> >>> Now we have a core issue. On one side there's rsnd_soc_dai_trigger()
> >>> being called in atomic context, and on the other side the function
> >>> ends up calling dmaengine_prep_dma_cyclic() which needs to allocate
> >>> memory. To make this more func the DMA engine API is undocumented and
> >>> completely silent on whether the prep functions are allowed to sleep.
> >>> The question is, who's wrong ?
> >>> 
> >>> Now, if you're tempted to say that I'm wrong by allocating memory with
> >>> GFP_KERNEL in the DMA engine driver, please read on first :-) I've
> >>> tried replacing GFP_KERNEL with GFP_ATOMIC allocations, and then ran
> >>> into a problem more complex to solve.
> >>> 
> >>> The rcar-dmac DMA engine driver uses runtime PM. When not used, the
> >>> device is suspended. The driver calls pm_runtime_get_sync() to resume
> >>> the device, and needs to do so when a descriptor is submitted. This
> >>> operation, currently performed in the tx_submit handler, could be
> >>> moved to the prep_dma_cyclic or issue_pending handler, but the three
> >>> operations are called in a row from rsnd_dma_start(), itself
> >>> ultimately called from snd_pcm_lib_write1() with the spinlock held.
> >>> This means I have no place in my DMA engine driver where I can resume
> >>> the device.
> >>> 
> >>> One could argue that the rcar-dmac driver could use a work queue to
> >>> handle power management. That's correct, but the additional
> >>> complexity, which would be required in *all* DMA engine drivers, seem
> >>> too high to me. If we need to go that way, this is really a task that
> >>> the DMA engine core should handle.
> >>> 
> >>> Let's start by answering the background question and updating the DMA
> >>> engine API documentation once and for good : in which context are
> >>> drivers allowed to call the prep, tx_submit and issue_pending
> >>> functions ?
> >> 
> >> I think this was bought up sometime back and we have cleared that all
> >> _prep functions can be invoked in atomic context.
> >> 
> >> This is the reason why we have been pushing folks to use GFP_NOWAIT is
> >> memory allocations during prepare.
> > 
> > From the replies I've received it's pretty clear that the prep functions
> > need to be callable from atomic context. I'll respond to this in more
> > depth in a reply to Russell's e-mail.
> > 
> > > Thanks for pointing out documentation doesn't say so, will send a patch
> > > for that.
> > 
> > I wish that was all that is missing from the documentation ;-) Luckily
> > Maxime Ripard has sent a patch that documents DMA engine from a DMA
> > engine driver's point of view. While not perfect (I'm going to review
> > it), it's a nice starting point to (hopefully) get to a properly
> > documented framework.
>
> Sure, please do point out any other instance.

Don't worry, I will :-)

> Russell did improve it a lot. But then Documentation gets not so quick
> updates. Yes new users like you can list issues far more easily than others.
> 
> Also now commit log provides a very valuable source of why a particular
> thing was done.

Come on. That's the theory (and we should of course aim for it). We all know 
the difference between theory and practice : in theory they're the same.

More seriously speaking, I've dived into the git history more times than I 
should have to retain some mental sanity, and it leaves way too many questions 
unanswered.

> > > from atomic context too.
> > 
> > I'll take this opportunity to question why we have a separation between
> > tx_submit and issue_pending. What's the rationale for that, especially
> > given that dma_issue_pending_all() might kick in at any point and issue
> > pending transfers for all devices. A driver could thus see its submitted
> > but not issued transactions being issued before it explicitly calls
> > dma_async_issue_pending().
> 
> The  API states that you need to get a channel, then prepare a descriptor
> and submit it back. Prepare can be in any order. The submit order is the one
> which is run on dmaengine. The submit marks the descriptor as pending.
> Typically you should have a pending_list which the descriptor should be
> pushed to.
> 
> And lastly invoke dma_async_issue_pending() to start the pending ones.
> 
> You have the flexibility to prepare descriptors and issue in the order you
> like. You can also attach the callback required for descriptors here.

The question was why is there a dma_async_issue_pending() operation at all ? 
Why can't dmaengine_submit() triggers the transfer start ? The only 
explanation is a small comment in dmaengine.h that states

 * This allows drivers to push copies to HW in batches,
 * reducing MMIO writes where possible.

I don't think that's applicable for DMA slave transfers. Is it still 
applicable for anything else ?

Quoting git log, the reason is

commit c13c8260da3155f2cefb63b0d1b7dcdcb405c644
Author: Chris Leech <christopher.leech@intel.com>
Date:   Tue May 23 17:18:44 2006 -0700

    [I/OAT]: DMA memcpy subsystem
    
    Provides an API for offloading memory copies to DMA devices
    
    Signed-off-by: Chris Leech <christopher.leech@intel.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

;-)

> > The DMA_PRIVATE capability flag seems to play a role here, but it's far
> > from being clear how that mechanism is supposed to work. This should be
> > documented as well, and any light you could shed on this dark corner of
> > the API would help.
> 
> Ah it is not so dark.
> 
> if you look closely at dmaengine channel allocation it is only for marking
> if channel is privately to be used or for async_tx.
> Thus slave devices must set DMA_PRIVATE

In order to avoid scattering one topic across multiple mails, I'll pursue this 
one in a reply to Russell.

> > Similarly, the DMA engine API is split in functions with different
> > prefixes (mostly dmaengine_*, dma_async_*, dma_*, and various unprefixed
> > niceties such as async_tx_ack or txd_lock. If there's a rationale for that
> > (beyond just historical reasons) it should also be documented, otherwise a
> > cleanup would help all the confused DMA engine users (myself included). I
> > might be able to find a bit of time to work on that, but I'll first need
> > to correctly understand where we come from and where we are. Again,
> > information would be welcome and fully appreciated.
> 
> History. DMA engine was developed for async_tx. (hence async_tx)
> 
> I think most of dmaengine APIs are dmaengine_. the async_ ones are
> specifically for async_tx usage.
> txd ones are descriptor related.

Ditto here.

-- 
Regards,

Laurent Pinchart
