From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 19 Oct 2018 10:38:54 +0000
Subject: [PATCH v2 4/4] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
In-Reply-To: <1538241480-13844-5-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-5-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <DM5PR02MB218754E3827458E08060DDF2DCF90@DM5PR02MB2187.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Sent: Saturday, September 29, 2018 10:48 PM
> To: vkoul at kernel.org; dan.j.williams at intel.com; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: [PATCH v2 4/4] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
> transfer
> 
> In AXI CDMA simple mode also pass MSB bits of source and destination
> address to xilinx_write function. This fixes simple CDMA operation mode using
> 64-bit addressing.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>

Regards,
Kedar.

> ---
> Changes for v2:
> Use helper macro for preparing dma_addr_t.
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index c27ab64..d04ef85 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1247,8 +1247,10 @@ static void xilinx_cdma_start_transfer(struct
> xilinx_dma_chan *chan)
> 
>  		hw = &segment->hw;
> 
> -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> >src_addr);
> -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> >dest_addr);
> +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> +			     xilinx_prep_dma_addr_t(hw->src_addr));
> +		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR,
> +			     xilinx_prep_dma_addr_t(hw->dest_addr));
> 
>  		/* Start the transfer */
>  		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> --
> 1.7.1
