From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 18 Oct 2012 16:24:05 -0700
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
In-Reply-To: <20121018225540.GB28061@n2100.arm.linux.org.uk>
References: <20121018222046.GA28541@animalcreek.com>
 <20121018225540.GB28061@n2100.arm.linux.org.uk>
Message-ID: <20121018232405.GA29064@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 11:55:40PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 18, 2012 at 03:20:46PM -0700, Mark A. Greer wrote:
> > This patch seems fairly stable but I've only tested omap-sham (crypto)
> > and omap_hsmmc (mmc) on an am37x EVM.  I also enabled burst mode but
> > that made the system unstable when exercising either omap-sham or
> > omap_hsmmc.  I'm unaware of any errata that would make this an unwanted
> > modification but I haven't checked all of the SoCs.  Are there other
> > reasons that this should be applied??
> 
> It definitely needs checking with audio, because it will affect the
> pointer position in relation to audio output, and it will have an
> effect on how much audio data is lost over a pause/resume event.
> 
> Unfortunately, the OMAP DMA hardware has no way to do a proper "pause",
> it can only do a "stop" which involves dumping its FIFOs on the floor
> in the case of anything but a DEV->MEM transfer.  So the more data
> held in the DMA hardware, the more is lost on pause.

Hmm, interesting.

Is there a way to tweak DMA params like this on a per logical channel
basis using the dmaengine API?  I don't see any but I could have missed it.

If not, are you open to adding such a thing (e.g., extend 'enum dma_ctrl_flags'
with DMA_ENABL_PREFETCH)?

Mark
--
