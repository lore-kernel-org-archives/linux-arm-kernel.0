From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 12 Oct 2015 22:09:53 +0200
Subject: [PATCH 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <1444317612-818-3-git-send-email-cedric.madianga@gmail.com>
References: <1444317612-818-1-git-send-email-cedric.madianga@gmail.com>
 <1444317612-818-3-git-send-email-cedric.madianga@gmail.com>
Message-ID: <561C1391.2000802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cedric,

On 10/08/2015 05:20 PM, M'boumba Cedric Madianga wrote:
> This patch adds support for the STM32 DMA controller.
>
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>   drivers/dma/Kconfig     |   12 +
>   drivers/dma/Makefile    |    1 +
>   drivers/dma/stm32-dma.c | 1193 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1206 insertions(+)
>   create mode 100644 drivers/dma/stm32-dma.c
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 5c931d4..4c6b37b 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -431,6 +431,18 @@ config STE_DMA40
>   	help
>   	  Support for ST-Ericsson DMA40 controller
>
> +config STM32_DMA
> +	tristate "STMicroelectronics STM32 dma support"
s/dma/DMA/ ?

> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> new file mode 100644
> index 0000000..9814ca5
> --- /dev/null
> +++ b/drivers/dma/stm32-dma.c
> @@ -0,0 +1,1193 @@

> +#define STM32_DMA_LISR			0x0000 /* DMA Low Int Status Reg */
> +#define STM32_DMA_HISR			0x0004 /* DMA High Int Status Reg */
> +#define STM32_DMA_LIFCR			0x0008 /* DMA Low Int Flag Clear Reg */
> +#define STM32_DMA_HIFCR			0x000C /* DMA High Int Flag Clear Reg */
We usually use lower case for numerical values.

> +static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
> +				    enum dma_transfer_direction direction,
> +				    enum dma_slave_buswidth *buswidth)
> +{
> +	enum dma_slave_buswidth src_addr_width, dst_addr_width;
> +	u32 src_bus_width, dst_bus_width, src_burst_size, dst_burst_size;
> +	u32 src_maxburst, dst_maxburst;
> +	dma_addr_t src_addr, dst_addr;
> +
> +	src_addr_width = chan->dma_sconfig.src_addr_width;
> +	dst_addr_width = chan->dma_sconfig.dst_addr_width;
> +	src_maxburst = chan->dma_sconfig.src_maxburst;
> +	dst_maxburst = chan->dma_sconfig.dst_maxburst;
> +	src_addr = chan->dma_sconfig.src_addr;
> +	dst_addr = chan->dma_sconfig.dst_addr;
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		dst_bus_width = stm32_get_dma_width(chan, dst_addr_width);
> +		if (dst_bus_width < 0)
> +			return -EINVAL;
dst_bus_width is a u32, so cannot be negative.
Also, you should propagate de error returned by stm32_get_dma_width().

The comment also applies below:
> +		dst_burst_size = stm32_get_dma_burst(chan, dst_maxburst);
> +		if (dst_burst_size < 0)
> +			return -EINVAL;
> +		if (!src_addr_width)
> +			src_addr_width = dst_addr_width;
> +		src_bus_width = stm32_get_dma_width(chan, src_addr_width);
> +		if (src_bus_width < 0)
> +			return -EINVAL;
> +		src_burst_size = stm32_get_dma_burst(chan, src_maxburst);
> +		if (src_burst_size < 0)
> +			return -EINVAL;
> +
> +		chan->chan_reg.dma_scr |= (chan->chan_reg.dma_scr &
> +			~(STM32_DMA_SCR_DIR_MASK | STM32_DMA_SCR_PSIZE_MASK |
> +			STM32_DMA_SCR_MSIZE_MASK | STM32_DMA_SCR_PBURST_MASK |
> +			STM32_DMA_SCR_MBURST_MASK)) |
> +			STM32_DMA_SCR_DIR(STM32_DMA_MEM_TO_DEV) |
> +			STM32_DMA_SCR_PSIZE(dst_bus_width) |
> +			STM32_DMA_SCR_MSIZE(src_bus_width) |
> +			STM32_DMA_SCR_PBURST(dst_burst_size) |
> +			STM32_DMA_SCR_MBURST(src_burst_size);
> +
> +		chan->chan_reg.dma_spar = chan->dma_sconfig.dst_addr;
> +		*buswidth = dst_addr_width;
> +		return 0;
> +
> +	case DMA_DEV_TO_MEM:
> +		src_bus_width = stm32_get_dma_width(chan, src_addr_width);
> +		if (src_bus_width < 0)
> +			return -EINVAL;
> +		src_burst_size = stm32_get_dma_burst(chan, src_maxburst);
> +		if (src_burst_size < 0)
> +			return -EINVAL;
> +		if (!dst_addr_width)
> +			dst_addr_width = src_addr_width;
> +		dst_bus_width = stm32_get_dma_width(chan, dst_addr_width);
> +		if (dst_bus_width < 0)
> +			return -EINVAL;
> +		dst_burst_size = stm32_get_dma_burst(chan, dst_maxburst);
> +		if (dst_burst_size < 0)
> +			return -EINVAL;
> +
> +		chan->chan_reg.dma_scr |= (chan->chan_reg.dma_scr &
> +			~(STM32_DMA_SCR_DIR_MASK | STM32_DMA_SCR_PSIZE_MASK |
> +			STM32_DMA_SCR_MSIZE_MASK | STM32_DMA_SCR_PBURST_MASK |
> +			STM32_DMA_SCR_MBURST_MASK)) |
> +			STM32_DMA_SCR_DIR(STM32_DMA_DEV_TO_MEM) |
> +			STM32_DMA_SCR_PSIZE(src_bus_width) |
> +			STM32_DMA_SCR_MSIZE(dst_bus_width) |
> +			STM32_DMA_SCR_PBURST(src_burst_size) |
> +			STM32_DMA_SCR_MBURST(dst_burst_size);
> +		chan->chan_reg.dma_spar = chan->dma_sconfig.src_addr;
> +		*buswidth = chan->dma_sconfig.src_addr_width;
> +		return 0;
> +
> +	default:
> +		dev_err(chan2dev(chan), "Dma direction is not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}

Thanks,
Maxime
