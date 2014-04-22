From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Apr 2014 15:54:50 +0100
Subject: [PATCH v2 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <20140419182528.414b9b2e@skate>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
 <20140419182528.414b9b2e@skate>
Message-ID: <20140422145450.GC10224@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 19, 2014 at 05:25:28PM +0100, Thomas Petazzoni wrote:
> On Sat, 19 Apr 2014 10:32:45 -0400, Santosh Shilimkar wrote:
> > Here is an updated version of [2] based on discussion. Series introduces
> > support for setting up dma parameters based on device tree properties
> > like 'dma-ranges' and 'dma-coherent' and also update to ARM 32 bit port.
> > Earlier version of the same series is here [1].
> > 
> > The 'dma-ranges' helps to take care of few DMAable system memory restrictions
> > by use of dma_pfn_offset which we maintain now per device. Arch code then
> > uses it for dma address translations for such cases. We update the
> > dma_pfn_offset accordingly during DT the device creation process.The
> > 'dma-coherent' property is used to setup arch's coherent dma_ops.
> > 
> > After some off-list discussion with RMK and Arnd, I have now dropped the
> > controversial dma_mask setup code from the series which actually isn't blocking
> > me as such. Considering rest of the parts of the series are already aligned,
> > am hoping to get this version merged for 3.16 merge window.
> > 
> > We agreed in last discussion that drivers have the ultimate
> > responsibility to setup the correct dma mask but then we need to have some
> > means to see if bus can support what driver has requested for a case where
> > driver request for bigger mask than what bus supports. I can follow up on
> > the mask topic if we have broken drivers.
> 
> I am not sure whether there is an intersection or not, but I wanted to
> mention that the mvebu platform (in mach-mvebu) supports hardware I/O
> coherency, which makes it a coherent DMA platform. However, we are not
> able to use arm_coherent_dma_ops for this platform, because when a
> transfer is being made DMA_FROM_DEVICE, at the end of the transfer, we
> need to perform an I/O barrier to wait for the snooping unit to
> complete its coherency work. So we're coherent, but not with
> arm_coherent_dma_ops: we have our own dma operation implementation (see
> arch/arm/mach-mvebu/coherency.c).

Ordering between I/O, DMA and CPU memory accesses is the reason we added
rmb() to the readl() macro. The mvebu ops solve the DMA streaming case
but not the dma_alloc() buffers case where you no longer have a change
of ownership between device and CPU. We could handle this via per-SoC
__io*mb() barriers as function pointers with a bit of overhead (though
we already do an outer_sync() for wmb()).

-- 
Catalin
