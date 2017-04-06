From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 6 Apr 2017 12:38:05 +0530
Subject: [PATCH 2/2] dmaengine: Add STM32 MDMA driver
In-Reply-To: <1489417599-31308-3-git-send-email-cedric.madianga@gmail.com>
References: <1489417599-31308-1-git-send-email-cedric.madianga@gmail.com>
 <1489417599-31308-3-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20170406070805.GG4094@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 04:06:39PM +0100, M'boumba Cedric Madianga wrote:
> This patch adds the driver for the STM32 MDMA controller.

Again pls do describe the controller

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/list.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/sched.h>

why do you need sched.h, i am sure many of these may not be required, pls
check

> +static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
> +				enum dma_slave_buswidth width)
> +{
> +	switch (width) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		return STM32_MDMA_BYTE;
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		return STM32_MDMA_HALF_WORD;
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		return STM32_MDMA_WORD;
> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +		return STM32_MDMA_DOUBLE_WORD;

IIUC we can do this with ffs()


> +	default:
> +		dev_err(chan2dev(chan), "Dma bus width not supported\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len, u32 tlen)
> +{
> +	enum dma_slave_buswidth max_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +
> +	while ((buf_len <= max_width || buf_len % max_width ||
> +		tlen < max_width) && max_width > DMA_SLAVE_BUSWIDTH_1_BYTE)
> +		max_width = max_width >> 1;

1. this is hard to read
2. sound like this can be optimized :)

> +
> +	return max_width;
> +}
> +
> +static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
> +				     enum dma_slave_buswidth width)
> +{
> +	u32 best_burst = max_burst;
> +	u32 burst_len = best_burst * width;
> +
> +	if (buf_len % tlen)
> +		return 0;
> +
> +	while ((tlen < burst_len && best_burst > 1) ||
> +	       (burst_len > 0 && tlen % burst_len)) {
> +		best_burst = best_burst >> 1;
> +		burst_len = best_burst * width;

same thing here too

> +
> +	return (best_burst > 1) ? best_burst : 0;
> +}
> +
> +static int stm32_mdma_disable_chan(struct stm32_mdma_chan *chan)
> +{
> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> +	u32 ccr, cisr, id, reg;
> +	int ret;
> +
> +	id = chan->id;
> +	reg = STM32_MDMA_CCR(id);
> +
> +	/* Disable interrupts */
> +	stm32_mdma_clr_bits(dmadev, reg, STM32_MDMA_CCR_IRQ_MASK);
> +
> +	ccr = stm32_mdma_read(dmadev, reg);
> +	if (ccr & STM32_MDMA_CCR_EN) {
> +		stm32_mdma_clr_bits(dmadev, reg, STM32_MDMA_CCR_EN);
> +
> +		/* Ensure that any ongoing transfer has been completed */
> +		ret = readl_relaxed_poll_timeout_atomic(

why not simple readl
> +static void stm32_mdma_set_dst_bus(struct stm32_mdma_device *dmadev, u32 *ctbr,
> +				   u32 dst_addr)
> +{
> +	u32 mask;
> +	int i;
> +
> +	/* Check if memory device is on AHB or AXI */
> +	*ctbr &= ~STM32_MDMA_CTBR_DBUS;
> +	mask = dst_addr & 0xF0000000;
> +	for (i = 0; i < dmadev->nr_ahb_addr_masks; i++) {
> +		if (mask == dmadev->ahb_addr_masks[i]) {
> +			*ctbr |= STM32_MDMA_CTBR_DBUS;
> +			break;
> +		}
> +	}
> +}
> +
> +static void stm32_mdma_set_src_bus(struct stm32_mdma_device *dmadev, u32 *ctbr,
> +				   u32 src_addr)
> +{
> +	u32 mask;
> +	int i;
> +
> +	/* Check if memory device is on AHB or AXI */
> +	*ctbr &= ~STM32_MDMA_CTBR_SBUS;
> +	mask = src_addr & 0xF0000000;
> +	for (i = 0; i < dmadev->nr_ahb_addr_masks; i++) {
> +		if (mask == dmadev->ahb_addr_masks[i]) {
> +			*ctbr |= STM32_MDMA_CTBR_SBUS;
> +			break;
> +		}
> +	}

these too look awfully same..

> +static int __init stm32_mdma_init(void)
> +{
> +	return platform_driver_probe(&stm32_mdma_driver, stm32_mdma_probe);
> +}
> +
> +subsys_initcall(stm32_mdma_init);

why subsys?

> -- 
> 1.9.1
> 

-- 
~Vinod
