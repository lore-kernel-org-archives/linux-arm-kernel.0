From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Dec 2012 09:54:02 +0000
Subject: [PATCH] DMAEngine: sirf: add DMA pause/resume support
In-Reply-To: <1355478282-27908-1-git-send-email-Barry.Song@csr.com>
References: <1355478282-27908-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20121214095402.GH14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 05:44:42PM +0800, Barry Song wrote:
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 212f69f..ffe05bb 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -313,6 +313,38 @@ static int sirfsoc_dma_terminate_all(struct sirfsoc_dma_chan *schan)
>  	return 0;
>  }
>  
> +static int sirfsoc_dma_pause_chan(struct sirfsoc_dma_chan *schan)
> +{
> +	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(&schan->chan);
> +	int cid = schan->chan.chan_id;
> +
> +	if (!sdma->is_marco)
> +		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
> +			& ~((1 << cid) | 1 << (cid + 16)),
> +			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
> +	else
> +		writel_relaxed((1 << cid) | 1 << (cid + 16),
> +			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR);

You're doing a read-modify-write to what looks like a shared register.
What makes this code safe in a preempt or SMP environment?
