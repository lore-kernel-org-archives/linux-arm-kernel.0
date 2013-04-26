From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 26 Apr 2013 13:46:46 +0530
Subject: [PATCH 6/9] crypto: ux500/cryp - Set DMA configuration though
 dma_slave_config()
In-Reply-To: <CACRpkdaBf++gy3sghC-t33uio2+eHp1MrQ2FM0XXBazZTtm3kA@mail.gmail.com>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdbFgW6bGYt59WtN4r2izuN09AJw4J1cqir82uzFsuMmWQ@mail.gmail.com>
 <20130425134402.GN4623@gmail.com>
 <201304251611.39667.arnd@arndb.de>
 <CACRpkdaBf++gy3sghC-t33uio2+eHp1MrQ2FM0XXBazZTtm3kA@mail.gmail.com>
Message-ID: <20130426081646.GD24632@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 10:28:39AM +0200, Linus Walleij wrote:
> On Thu, Apr 25, 2013 at 4:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The dma engine driver must know the address in its dma space, while the
> > slave driver has it available in physical space. These two are often the
> > same, but there is no generic way to convert between the two, especially
> > if the dma engine resides behind an IOMMU.
> >
> > The best assumption we can make is that the dma engine driver knows
> > how to convert between the two. Interestingly the documentation for
> > dma_slave_config talks about "physical address", while the structure
> > itself uses a dma_addr_t. Linus Walleij introduced the structure in
> > c156d0a5b0 "DMAENGINE: generic slave channel control v3", so I assume
> > he can shed some light on what he was thinking. I assume the documentation
> > is right but the structure is not and should be converted to use
> > phys_add_t or resource_size_t.
> 
> OK I could cook a patch for that, but I think I need some input from
> Vinod and/or Russell on this.
the dma_slave_config is physical address that should be passed directly to the
controller. Obviosuly it should phys_addr_t :)

The mapping & unmapping of dma buffer (memcpy and memory buffer in this txn) is
required to be performed by the client driver. The dmanegine or dmaengine driver
will not do that for you...

This is true for slave usage and not for async case.
> 
> It does make sense to me that if anything knows how to map a physical
> address into the DMA address space it'll be the DMA engine.
> 
> However this rings a bell that there may be a possible relation to
> DMA-API, since that API syncs memory buffers to the DMA
> address space if there is some MMU inbetween the DMA and the
> (ordinary, non-device) memory.
> 
> So if we think one step ahead, assuming the DMAC is actually behind
> an MMU making it see the device in some other address than the
> physical (bus) space, where would the address be resolved?
> 
> Yours,
> Linus Walleij
