From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 13:36:56 -0500
Subject: [PATCH 07/10] ARM: mvebu: implement Armada 375 coherency
 workaround
In-Reply-To: <1394124395-20030-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1394124395-20030-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140306183656.GE1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thu, Mar 06, 2014 at 05:46:32PM +0100, Thomas Petazzoni wrote:
> The early revisions of Armada 375 SOCs (Z1 stepping) have a bug in the

Do we have a way to determine that we are on a Z1 at runtime?  It seems
like we're consuming an XOR engine unconditionally.  I presume that
Marvell is going to fix this with the next stepping?

thx,

Jason.

> I/O coherency unit that prevents using the normal method for the I/O
> coherency barrier. The recommended workaround is to use a XOR memset
> transfer to act as the I/O coherency barrier.
> 
> This involves "borrowing" a XOR engine, which gets disabled in the
> Device Tree so the normal XOR driver doesn't use it. Note also that
> the mvebu-mbus driver must be initialized prior to the coherency unit,
> because the DRAM windows of the XOR engine must be configured during
> the coherency unit initialization, due to this workaround.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c  |   2 +-
>  arch/arm/mach-mvebu/coherency.c | 150 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 256e6f6..6260cb8 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -80,8 +80,8 @@ static void __init mvebu_timer_and_clk_init(void)
>  	of_clk_init(NULL);
>  	clocksource_of_init();
>  	mvebu_scu_enable();
> -	coherency_init();
>  	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
> +	coherency_init();
>  #ifdef CONFIG_CACHE_L2X0
>  	l2x0_of_init(0, ~0UL);
>  #endif
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index f63c868..73d56f2 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -24,6 +24,9 @@
>  #include <linux/smp.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mbus.h>
> +#include <linux/clk.h>
>  #include <asm/smp_plat.h>
>  #include <asm/cacheflush.h>
>  #include "armada-370-xp.h"
> @@ -66,8 +69,154 @@ int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
>  	return ll_set_cpu_coherent(coherency_base, hw_cpu_id);
>  }
>  
> +/*
> + * The below code implements the I/O coherency workaround on Armada
> + * 375. This workaround consists in using the two channels of the
> + * first XOR engine to trigger a XOR transaction that serves as the
> + * I/O coherency barrier.
> + */
> +
> +static void __iomem *xor_base, *xor_high_base;
> +static dma_addr_t coherency_wa_buf_phys[CONFIG_NR_CPUS];
> +static void *coherency_wa_buf[CONFIG_NR_CPUS];
> +static bool coherency_wa_enabled;
> +
> +#define XOR_CONFIG(chan)            (0x10 + (chan * 4))
> +#define XOR_ACTIVATION(chan)        (0x20 + (chan * 4))
> +#define WINDOW_BAR_ENABLE(chan)     (0x240 + ((chan) << 2))
> +#define WINDOW_BASE(w)              (0x250 + ((w) << 2))
> +#define WINDOW_SIZE(w)              (0x270 + ((w) << 2))
> +#define WINDOW_REMAP_HIGH(w)        (0x290 + ((w) << 2))
> +#define WINDOW_OVERRIDE_CTRL(chan)  (0x2A0 + ((chan) << 2))
> +#define XOR_DEST_POINTER(chan)      (0x2B0 + (chan * 4))
> +#define XOR_BLOCK_SIZE(chan)        (0x2C0 + (chan * 4))
> +#define XOR_INIT_VALUE_LOW           0x2E0
> +#define XOR_INIT_VALUE_HIGH          0x2E4
> +
> +static inline void mvebu_hwcc_armada375_sync_io_barrier_wa(void)
> +{
> +	int idx = smp_processor_id();
> +
> +	/* Write '1' to the first word of the buffer */
> +	writel(0x1, coherency_wa_buf[idx]);
> +
> +	/* Wait until the engine is idle */
> +	while ((readl(xor_base + XOR_ACTIVATION(idx)) >> 4) & 0x3)
> +		;
> +
> +	dmb();
> +
> +	/* Trigger channel */
> +	writel(0x1, xor_base + XOR_ACTIVATION(idx));
> +
> +	/* Poll the data until it is cleared by the XOR transaction */
> +	while (readl(coherency_wa_buf[idx]))
> +		;
> +}
> +
> +static void __init armada_375_coherency_init_wa(void)
> +{
> +	const struct mbus_dram_target_info *dram;
> +	struct device_node *xor_node;
> +	struct property *xor_status;
> +	struct clk *xor_clk;
> +	u32 win_enable = 0;
> +	int i;
> +
> +	/*
> +	 * Since the workaround uses one XOR engine, we grab a
> +	 * reference to its Device Tree node first.
> +	 */
> +	xor_node = of_find_compatible_node(NULL, NULL, "marvell,orion-xor");
> +	BUG_ON(!xor_node);
> +
> +	/*
> +	 * Then we mark it as disabled so that the real XOR driver
> +	 * will not use it.
> +	 */
> +	xor_status = kzalloc(sizeof(struct property), GFP_KERNEL);
> +	BUG_ON(!xor_status);
> +
> +	xor_status->value = kstrdup("disabled", GFP_KERNEL);
> +	BUG_ON(!xor_status->value);
> +
> +	xor_status->length = 8;
> +	xor_status->name = kstrdup("status", GFP_KERNEL);
> +	BUG_ON(!xor_status->name);
> +
> +	of_update_property(xor_node, xor_status);
> +
> +	/*
> +	 * And we remap the registers, get the clock, and do the
> +	 * initial configuration of the XOR engine.
> +	 */
> +	xor_base = of_iomap(xor_node, 0);
> +	xor_high_base = of_iomap(xor_node, 1);
> +
> +	xor_clk = of_clk_get_by_name(xor_node, NULL);
> +	BUG_ON(!xor_clk);
> +
> +	clk_prepare_enable(xor_clk);
> +
> +	dram = mv_mbus_dram_info();
> +
> +	for (i = 0; i < 8; i++) {
> +		writel(0, xor_base + WINDOW_BASE(i));
> +		writel(0, xor_base + WINDOW_SIZE(i));
> +		if (i < 4)
> +			writel(0, xor_base + WINDOW_REMAP_HIGH(i));
> +	}
> +
> +	for (i = 0; i < dram->num_cs; i++) {
> +		const struct mbus_dram_window *cs = dram->cs + i;
> +		writel((cs->base & 0xffff0000) |
> +		       (cs->mbus_attr << 8) |
> +		       dram->mbus_dram_target_id, xor_base + WINDOW_BASE(i));
> +		writel((cs->size - 1) & 0xffff0000, xor_base + WINDOW_SIZE(i));
> +
> +		win_enable |= (1 << i);
> +		win_enable |= 3 << (16 + (2 * i));
> +	}
> +
> +	writel(win_enable, xor_base + WINDOW_BAR_ENABLE(0));
> +	writel(win_enable, xor_base + WINDOW_BAR_ENABLE(1));
> +	writel(0, xor_base + WINDOW_OVERRIDE_CTRL(0));
> +	writel(0, xor_base + WINDOW_OVERRIDE_CTRL(1));
> +
> +	for (i = 0; i < CONFIG_NR_CPUS; i++) {
> +		coherency_wa_buf[i] = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +		BUG_ON(!coherency_wa_buf[i]);
> +
> +		/*
> +		 * We can't use the DMA mapping API, since we don't
> +		 * have a valid 'struct device' pointer
> +		 */
> +		coherency_wa_buf_phys[i] =
> +			virt_to_phys(coherency_wa_buf[i]);
> +		BUG_ON(!coherency_wa_buf_phys[i]);
> +
> +		/*
> +		 * Configure the XOR engine for memset operation, with
> +		 * a 128 bytes block size
> +		 */
> +		writel(0x444, xor_base + XOR_CONFIG(i));
> +		writel(128, xor_base + XOR_BLOCK_SIZE(i));
> +		writel(coherency_wa_buf_phys[i], xor_base + XOR_DEST_POINTER(i));
> +	}
> +
> +	writel(0x0, xor_base + XOR_INIT_VALUE_LOW);
> +	writel(0x0, xor_base + XOR_INIT_VALUE_HIGH);
> +
> +	coherency_wa_enabled = true;
> +}
> +
>  static inline void mvebu_hwcc_sync_io_barrier(void)
>  {
> +	if (coherency_wa_enabled) {
> +		mvebu_hwcc_armada375_sync_io_barrier_wa();
> +		return;
> +	}
> +
>  	writel(0x1, coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET);
>  	while (readl(coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET) & 0x1);
>  }
> @@ -150,6 +299,7 @@ static void __init armada_370_coherency_init(struct device_node *np)
>  static void __init armada_375_coherency_init(struct device_node *np)
>  {
>  	coherency_cpu_base = of_iomap(np, 0);
> +	armada_375_coherency_init_wa();
>  }
>  
>  static int coherency_type(void)
> -- 
> 1.8.3.2
> 
