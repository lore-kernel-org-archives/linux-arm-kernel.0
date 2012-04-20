From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 20 Apr 2012 15:45:21 +0530
Subject: [PATCH] dmaengine: at_hdmac: remove clear-on-read in atc_dostart()
In-Reply-To: <1334580390-16303-1-git-send-email-nicolas.ferre@atmel.com>
References: <1334580390-16303-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1334916921.31825.41.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-04-16 at 14:46 +0200, Nicolas Ferre wrote:
> This loop on EBCISR register was designed to clear IRQ sources before enabling
> a DMA channel. This register is clear-on-read so a race condition can appear if
> another channel is already active and has just finished its transfer.
> Removing this read on EBCISR is fixing the issue as there is no case where an IRQ
> could be pending: we already make sure that this register is drained at probe()
> time and during resume.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: stable <stable@vger.kernel.org>
Applied thanks.

> ---
>  drivers/dma/at_hdmac.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 7aa58d2..445fdf8 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -221,10 +221,6 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
>  
>  	vdbg_dump_regs(atchan);
>  
> -	/* clear any pending interrupt */
> -	while (dma_readl(atdma, EBCISR))
> -		cpu_relax();
> -
>  	channel_writel(atchan, SADDR, 0);
>  	channel_writel(atchan, DADDR, 0);
>  	channel_writel(atchan, CTRLA, 0);


-- 
~Vinod
