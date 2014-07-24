From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 24 Jul 2014 10:23:56 +0530
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <87vbqna699.wl%kuninori.morimoto.gx@gmail.com>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87d2cwvmxa.wl%kuninori.morimoto.gx@gmail.com>
 <3361994.F0HgAeJkR9@avalon> <28702317.aD0C1Ga3DS@avalon>
 <87wqb3a8jd.wl%kuninori.morimoto.gx@gmail.com>
 <87vbqna699.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <20140724045356.GC8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 06:35:17PM -0700, Kuninori Morimoto wrote:
> 
> Hi Laurent again
> 
> > > > The rsnd_soc_dai_trigger() function takes a spinlock, making the context
> > > > atomic, which regmap doesn't like as it locks a mutex.
> > > > 
> > > > It might be possible to fix this by setting the fast_io field in both the
> > > > regmap_config and regmap_bus structures in sound/soc/sh/rcar/gen.c. regmap
> > > > will then use a spinlock instead of a mutex. However, even if I believe that
> > > > change makes sense and should be done, another atomic context issue will
> > > > come from the rcar-dmac driver which allocates memory in the
> > > > prep_dma_cyclic function, called by rsnd_dma_start() from
> > > > rsnd_soc_dai_trigger() with the spinlock help.
> > > > 
> > > > What context is the rsnd_soc_dai_trigger() function called in by the alsa
> > > > core ? If it's guaranteed to be a sleepable context, would it make sense to
> > > > replace the rsnd_priv spinlock with a mutex ?
> > > 
> > > Answering myself here, that's not an option, as the trigger function is called 
> > > in atomic context (replacing the spinlock with a mutex produced a clear BUG) 
> > > due to snd_pcm_lib_write1() taking a spinlock.
> > > 
> > > Now we have a core issue. On one side there's rsnd_soc_dai_trigger() being 
> > > called in atomic context, and on the other side the function ends up calling 
> > > dmaengine_prep_dma_cyclic() which needs to allocate memory. To make this more 
> > > func the DMA engine API is undocumented and completely silent on whether the 
> > > prep functions are allowed to sleep. The question is, who's wrong ?
> > > 
> > > Now, if you're tempted to say that I'm wrong by allocating memory with 
> > > GFP_KERNEL in the DMA engine driver, please read on first :-) I've tried 
> > > replacing GFP_KERNEL with GFP_ATOMIC allocations, and then ran into a problem 
> > > more complex to solve.
> > > 
> > > The rcar-dmac DMA engine driver uses runtime PM. When not used, the device is 
> > > suspended. The driver calls pm_runtime_get_sync() to resume the device, and 
> > > needs to do so when a descriptor is submitted. This operation, currently 
> > > performed in the tx_submit handler, could be moved to the prep_dma_cyclic or 
> > > issue_pending handler, but the three operations are called in a row from 
> > > rsnd_dma_start(), itself ultimately called from snd_pcm_lib_write1() with the 
> > > spinlock held. This means I have no place in my DMA engine driver where I can 
> > > resume the device.
> > > 
> > > One could argue that the rcar-dmac driver could use a work queue to handle 
> > > power management. That's correct, but the additional complexity, which would 
> > > be required in *all* DMA engine drivers, seem too high to me. If we need to go 
> > > that way, this is really a task that the DMA engine core should handle.
> > > 
> > > Let's start by answering the background question and updating the DMA engine 
> > > API documentation once and for good : in which context are drivers allowed to 
> > > call the prep, tx_submit and issue_pending functions ?
> > 
> > rsnd driver (and sound/soc/sh/fsi driver too) is using prep_dma_cyclic() now,
> > but, it had been used prep_slave_single() before.
> > Then, it used work queue in dai_trigger function.
> > How about to use same method in prep_dma_cyclic() ?
> > Do you think your issue will be solved if sound driver calls prep_dma_cyclic()
> > from work queue ?
> 
> Sorry, this doesn't solve issue.
> dmaengine_prep_dma_cyclic() is used in
> ${LINUX}/sound/core/pcm_dmaengine.c,
> and the situation is same as ours.
> 
> Hmm..
> In my quick check, other DMAEngine drivers are using GFP_ATOMIC
> in cyclic/prep_slave_sg functions...
And thats partially right. You need to use GFP_NOWAIT.

-- 
~Vinod
