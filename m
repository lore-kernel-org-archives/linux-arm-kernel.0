From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Nov 2018 12:51:01 +0000
Subject: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
In-Reply-To: <1542889465.26115.54.camel@atviedlbe741.rss.d3s.at.thales>
References: <1542872133.26115.4.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122092928.GF30658@n2100.armlinux.org.uk>
 <1542889465.26115.54.camel@atviedlbe741.rss.d3s.at.thales>
Message-ID: <20181122125100.GG30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 12:25:18PM +0000, JABLONSKY Jan wrote:
> After DMA transaction is complete, content of the DMA buffer is stored in the main memory.
> 
> outer_inv_range invalidates cache lines only in L2 level.

Correct.

> outer_cache is dedicated to L2 cache, but CPU must also clean L1 dcache to avoid possible L1 hit

Correct, except we _do_ handle the L1 cache.  See dmac_*_area functions
that are already being called via dma_cache_maint_page().  You did
analyse the code before proposing these modifications? ;)

Given that we already handle the L1 cache, why do we need more L1 cache
maintanence?

In any case, in your patch, using phys_to_virt() on the addresses is
utterly wrong, and will lead to hitting the wrong memory if the physical
address is a highmem page (this is why we have dma_cache_maint_page(),
which has the necessary code to handle this case.)  The physical to
virtual translation functions and macros are only valid for lowmem.

So, I think your patch actually ends up breaking stuff by doing cache
maintanence on unexpected memory locations.

Given, also, that we have shed-loads of Cortex A9 systems out there,
using DMA with MMC, some using it for the rootfs, I doubt that the
problem lies here but elsewhere - which MMC host controller are you
using?  Has that driver been properly reviewed - does it use the DMA
API correctly?  Does it use the correct DMA direction (which should
always be the same for all DMA API operations on the buffer.)

It could also be a hardware bug (which is suggested with your
modifications to disable preemption).  As cache maintanence is
broadcasted across all cores in a SMP system with Cortex A9, it should
not matter whether we are pre-empted during cache handling for DMA.  If
disabling preemption makes a difference for that, it probably means you
have bigger coherency issues on your SoC.

Yes, you may have found a rare corner case, but we really need to fully
understand the details of what is going on here _before_ making radical
changes to code that has been proven by probably billions of users over
the course of the last nine years.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
