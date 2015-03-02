From: joshc@ni.com (Josh Cartwright)
Date: Mon, 2 Mar 2015 12:41:34 -0600
Subject: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
References: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
Message-ID: <20150302184134.GC681@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

I looked through your driver and have some comments.

On Mon, Mar 02, 2015 at 11:25:11PM +0530, Kedareswara rao Appana wrote:
> This is the driver for the AXI Direct Memory Access (AXI DMA)
> core, which is a soft Xilinx IP core that provides high-
> bandwidth direct memory access between memory and AXI4-Stream
> type target peripherals.
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
[..]
> +++ b/drivers/dma/Kconfig
> @@ -425,6 +425,19 @@ config IMG_MDC_DMA
>  	help
>  	  Enable support for the IMG multi-threaded DMA controller (MDC).
>  
> +config XILINX_DMA
> +	tristate "Xilinx AXI DMA Engine"
> +	depends on (ARCH_ZYNQ || MICROBLAZE)

Why do you need this dependency?  I'm assuming this IP has usefulness
outside of microblaze and Zynq.

> +	select DMA_ENGINE
> +	help
> +	  Enable support for Xilinx AXI DMA Soft IP.
> +
> +	This engine provides high-bandwidth direct memory access
> +	between memory and AXI4-Stream type target peripherals.
> +	It has two stream interfaces/channels, Memory Mapped to
> +	Stream (MM2S) and Stream to Memory Mapped (S2MM) for the
> +	data transfers.

Odd indention here.  At least indent this paragraph like the sentence
above.

[..]
> +++ b/drivers/dma/xilinx/xilinx_dma.c
[..]
> +/**
> + * xilinx_dma_halt - Halt DMA channel
> + * @chan: Driver specific DMA channel
> + */
> +static void xilinx_dma_halt(struct xilinx_dma_chan *chan)
> +{
> +	int loop = XILINX_DMA_LOOP_COUNT;
> +
> +	dma_ctrl_clr(chan, XILINX_DMA_REG_CONTROL,
> +		     XILINX_DMA_CR_RUNSTOP_MASK);
> +
> +	/* Wait for the hardware to halt */
> +	do {
> +		if (dma_ctrl_read(chan, XILINX_DMA_REG_STATUS) &
> +			XILINX_DMA_SR_HALTED_MASK)
> +			break;
> +	} while (loop--);
> +
> +	if (!loop) {

Looks like a very subtle off-by-one error here.  (And elsewhere you use
this pattern).

  Josh
