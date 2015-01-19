From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Jan 2015 23:34:30 +0100
Subject: [PATCH 4/6] bus: mvebu-mbus: make sure SDRAM CS for DMA don't
 overlap the MBus bridge window
In-Reply-To: <1419943428-18491-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1419943428-18491-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150119223430.GH2938@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 01:43:45PM +0100, Thomas Petazzoni wrote:
> The mvebu-mbus driver reads the SDRAM window registers, and make the
> information about the DRAM CS configuration available to device
> drivers using the mv_mbus_dram_info() API. This information is used by
> the DMA-capable device drivers to program their address decoding
> windows.
> 
> Until now, we were basically providing the SDRAM window register
> details as is. However, it turns out that the DMA capability of the
> CESA cryptographic engine consists in doing DMA being the DRAM and the
> crypto SRAM mapped as a MBus window. For this case, it is very
> important that the SDRAM CS information does not overlap with the MBus
> bridge window.
> 
> Therefore, this commit improves the mvebu-mbus driver to make sure we
> adjust the SDRAM CS information so that it doesn't overlap with the
> MBus bridge window. This problem was reported by Boris Brezillon,
> while working on the mv_cesa driver for Armada 37x/38x/XP. We use the
> memblock memory information to know where the usable RAM is located,
> as this information is guaranteed to be correct on all SoC variants.
> 
> We could have used the MBus bridge window registers on Armada 370/XP,
> but they are not really used on Armada 375/38x (Cortex-A9 based),
> since the PL310 L2 filtering is used instead to discriminate between
> RAM accesses and I/O accesses. Therefore, using the memblock
> information is more generic and works accross the different platforms.
> 
> Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> We have decided to not backport this commit to stable. Even though it
> is really fixing the DRAM CS information exposed to device drivers,
> there is no way in mainline for the current situation to cause any
> problem.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Added to mvebu/soc

      Andrew

> ---
>  drivers/bus/mvebu-mbus.c | 105 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 89 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index b6694df..bb0dd21 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -58,6 +58,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/log2.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/memblock.h>
>  
>  /*
>   * DDR target is the same on all platforms.
> @@ -97,7 +98,9 @@
>  
>  /* Relative to mbusbridge_base */
>  #define MBUS_BRIDGE_CTRL_OFF	0x0
> +#define  MBUS_BRIDGE_SIZE_MASK  0xffff0000
>  #define MBUS_BRIDGE_BASE_OFF	0x4
> +#define  MBUS_BRIDGE_BASE_MASK  0xffff0000
>  
>  /* Maximum number of windows, for all known platforms */
>  #define MBUS_WINS_MAX           20
> @@ -567,36 +570,106 @@ static unsigned int armada_xp_mbus_win_remap_offset(int win)
>  		return MVEBU_MBUS_NO_REMAP;
>  }
>  
> +/*
> + * Use the memblock information to find the MBus bridge hole in the
> + * physical address space.
> + */
> +static void __init
> +mvebu_mbus_find_bridge_hole(uint64_t *start, uint64_t *end)
> +{
> +	struct memblock_region *r;
> +	uint64_t s = 0;
> +
> +	for_each_memblock(memory, r) {
> +		/*
> +		 * This part of the memory is above 4 GB, so we don't
> +		 * care for the MBus bridge hole.
> +		 */
> +		if (r->base >= 0x100000000)
> +			continue;
> +
> +		/*
> +		 * The MBus bridge hole is at the end of the RAM under
> +		 * the 4 GB limit.
> +		 */
> +		if (r->base + r->size > s)
> +			s = r->base + r->size;
> +	}
> +
> +	*start = s;
> +	*end = 0x100000000;
> +}
> +
>  static void __init
>  mvebu_mbus_default_setup_cpu_target(struct mvebu_mbus_state *mbus)
>  {
>  	int i;
>  	int cs;
> +	uint64_t mbus_bridge_base, mbus_bridge_end;
>  
>  	mvebu_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
>  
> +	mvebu_mbus_find_bridge_hole(&mbus_bridge_base, &mbus_bridge_end);
> +
>  	for (i = 0, cs = 0; i < 4; i++) {
> -		u32 base = readl(mbus->sdramwins_base + DDR_BASE_CS_OFF(i));
> -		u32 size = readl(mbus->sdramwins_base + DDR_SIZE_CS_OFF(i));
> +		u64 base = readl(mbus->sdramwins_base + DDR_BASE_CS_OFF(i));
> +		u64 size = readl(mbus->sdramwins_base + DDR_SIZE_CS_OFF(i));
> +		u64 end;
> +		struct mbus_dram_window *w;
> +
> +		/* Ignore entries that are not enabled */
> +		if (!(size & DDR_SIZE_ENABLED))
> +			continue;
>  
>  		/*
> -		 * We only take care of entries for which the chip
> -		 * select is enabled, and that don't have high base
> -		 * address bits set (devices can only access the first
> -		 * 32 bits of the memory).
> +		 * Ignore entries whose base address is above 2^32,
> +		 * since devices cannot DMA to such high addresses
>  		 */
> -		if ((size & DDR_SIZE_ENABLED) &&
> -		    !(base & DDR_BASE_CS_HIGH_MASK)) {
> -			struct mbus_dram_window *w;
> +		if (base & DDR_BASE_CS_HIGH_MASK)
> +			continue;
>  
> -			w = &mvebu_mbus_dram_info.cs[cs++];
> -			w->cs_index = i;
> -			w->mbus_attr = 0xf & ~(1 << i);
> -			if (mbus->hw_io_coherency)
> -				w->mbus_attr |= ATTR_HW_COHERENCY;
> -			w->base = base & DDR_BASE_CS_LOW_MASK;
> -			w->size = (size | ~DDR_SIZE_MASK) + 1;
> +		base = base & DDR_BASE_CS_LOW_MASK;
> +		size = (size | ~DDR_SIZE_MASK) + 1;
> +		end = base + size;
> +
> +		/*
> +		 * Adjust base/size of the current CS to make sure it
> +		 * doesn't overlap with the MBus bridge hole. This is
> +		 * particularly important for devices that do DMA from
> +		 * DRAM to a SRAM mapped in a MBus window, such as the
> +		 * CESA cryptographic engine.
> +		 */
> +
> +		/*
> +		 * The CS is fully enclosed inside the MBus bridge
> +		 * area, so ignore it.
> +		 */
> +		if (base >= mbus_bridge_base && end <= mbus_bridge_end)
> +			continue;
> +
> +		/*
> +		 * Beginning of CS overlaps with end of MBus, raise CS
> +		 * base address, and shrink its size.
> +		 */
> +		if (base >= mbus_bridge_base && end > mbus_bridge_end) {
> +			size -= mbus_bridge_end - base;
> +			base = mbus_bridge_end;
>  		}
> +
> +		/*
> +		 * End of CS overlaps with beginning of MBus, shrink
> +		 * CS size.
> +		 */
> +		if (base < mbus_bridge_base && end > mbus_bridge_base)
> +			size -= end - mbus_bridge_base;
> +
> +		w = &mvebu_mbus_dram_info.cs[cs++];
> +		w->cs_index = i;
> +		w->mbus_attr = 0xf & ~(1 << i);
> +		if (mbus->hw_io_coherency)
> +			w->mbus_attr |= ATTR_HW_COHERENCY;
> +		w->base = base;
> +		w->size = size;
>  	}
>  	mvebu_mbus_dram_info.num_cs = cs;
>  }
> -- 
> 2.1.0
> 
