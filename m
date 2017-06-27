From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jun 2017 10:19:43 +0100
Subject: Applied "spi: atmel: fix corrupted data issue on SAM9 family
 SoCs" to the spi tree
In-Reply-To: <f2eb4994-2cea-4ad4-58ee-24a174d53f93@microchip.com>
References: <d174da00f48503eba84dd0f4068749b968628bbb.1498231873.git.cyrille.pitchen@microchip.com>
 <E1dORFW-00037E-N8@debutante>
 <20170623171830.GV4902@n2100.armlinux.org.uk>
 <f2eb4994-2cea-4ad4-58ee-24a174d53f93@microchip.com>
Message-ID: <20170627091942.GO4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 11:05:56AM +0200, Cyrille Pitchen wrote:
> Hi Russell,
> 
> Le 23/06/2017 ? 19:18, Russell King - ARM Linux a ?crit :
> > On Fri, Jun 23, 2017 at 05:15:58PM +0100, Mark Brown wrote:
> >> +#ifdef CONFIG_SOC_SAM_V4_V5
> >> +	/*
> >> +	 * Atmel SoCs based on ARM9 (SAM9x) cores should not use spi_map_buf()
> >> +	 * since this later function tries to map buffers with dma_map_sg()
> >> +	 * even if they have not been allocated inside DMA-safe areas.
> >> +	 * On SoCs based on Cortex A5 (SAMA5Dx), it works anyway because for
> >> +	 * those ARM cores, the data cache follows the PIPT model.
> >> +	 * Also the L2 cache controller of SAMA5D2 uses the PIPT model too.
> >> +	 * In case of PIPT caches, there cannot be cache aliases.
> >> +	 * However on ARM9 cores, the data cache follows the VIVT model, hence
> >> +	 * the cache aliases issue can occur when buffers are allocated from
> >> +	 * DMA-unsafe areas, by vmalloc() for instance, where cache coherency is
> >> +	 * not taken into account or at least not handled completely (cache
> >> +	 * lines of aliases are not invalidated).
> > 
> > There is a solution to this - code (iow, callers of functions that perform
> > IO) are expected to use flush_kernel_vmap_range() and
> > invalidate_kernel_vmap_range() as documented in Documentation/cachetlb.txt
> > to ensure that their "special" views are properly handled.
> > 
> > These are no-ops for PIPT caches, but aliasing caches have to implement
> > them.
> > 
> 
> So if I understand, calling those two functions at the right places, we
> could use DMA transfer again without the need of copying data into a
> bounce buffer? It sounds great, I will study that.

Yes.  The down-side is that you don't have any idea from the higher
levels whether the driver used DMA or PIO, and in the case of PIO,
it's extra work that the CPU ends up doing.

These were introduced for XFS, since it does IO and expects to be
able to see the results via vmalloc space.  Since it's working with
the block layer, the expectation there is that PIO drivers will
always ensure that data read by PIO reaches the point of coherence,
so it can do a cache invalidate after the read in every case without
losing data.

That's not true of SPI, so you need to be extra careful about how
you're using these - I think you can only use flush_kernel_vmap_range()
before writes and flush_kernel_vmap_range() both before and after reads.
You need it before a read to ensure that any dirty cache lines from
the vmalloc mapping won't overwrite the data you're reading via the
non-vmalloc mapping, and the one after caters for any speculatively
prefetching that may have occurred.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
