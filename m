From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jun 2017 18:18:30 +0100
Subject: Applied "spi: atmel: fix corrupted data issue on SAM9 family
 SoCs" to the spi tree
In-Reply-To: <E1dORFW-00037E-N8@debutante>
References: <d174da00f48503eba84dd0f4068749b968628bbb.1498231873.git.cyrille.pitchen@microchip.com>
 <E1dORFW-00037E-N8@debutante>
Message-ID: <20170623171830.GV4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 05:15:58PM +0100, Mark Brown wrote:
> +#ifdef CONFIG_SOC_SAM_V4_V5
> +	/*
> +	 * Atmel SoCs based on ARM9 (SAM9x) cores should not use spi_map_buf()
> +	 * since this later function tries to map buffers with dma_map_sg()
> +	 * even if they have not been allocated inside DMA-safe areas.
> +	 * On SoCs based on Cortex A5 (SAMA5Dx), it works anyway because for
> +	 * those ARM cores, the data cache follows the PIPT model.
> +	 * Also the L2 cache controller of SAMA5D2 uses the PIPT model too.
> +	 * In case of PIPT caches, there cannot be cache aliases.
> +	 * However on ARM9 cores, the data cache follows the VIVT model, hence
> +	 * the cache aliases issue can occur when buffers are allocated from
> +	 * DMA-unsafe areas, by vmalloc() for instance, where cache coherency is
> +	 * not taken into account or at least not handled completely (cache
> +	 * lines of aliases are not invalidated).

There is a solution to this - code (iow, callers of functions that perform
IO) are expected to use flush_kernel_vmap_range() and
invalidate_kernel_vmap_range() as documented in Documentation/cachetlb.txt
to ensure that their "special" views are properly handled.

These are no-ops for PIPT caches, but aliasing caches have to implement
them.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
