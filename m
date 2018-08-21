From: vkoul@kernel.org (Vinod)
Date: Tue, 21 Aug 2018 21:25:53 +0530
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer
In-Reply-To: <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20180821155553.GI2388@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> In AXI CDMA simple mode also pass MSB bits of source and destination
> address to xilinx_write function. This fixes simple CDMA operation
> mode using 64-bit addressing.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index a37871e..2e15d86 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
>  
>  		hw = &segment->hw;
>  
> -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw->src_addr);
> -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw->dest_addr);
> +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, (dma_addr_t)
> +			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));

so this is:
        (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)

what is src_addr data type? I think its u32. It would be better to
update xilinx_write() to take u64 and not dma_addr_t.


> +		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, (dma_addr_t)
> +			     ((u64)hw->dest_addr_msb << 32 | hw->dest_addr));
>  
>  		/* Start the transfer */
>  		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
