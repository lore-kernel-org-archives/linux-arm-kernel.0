From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 Jul 2015 18:47:36 +0530
Subject: [PATCH] dmaengine: sirf: fix kernel panic under one race condition
In-Reply-To: <1436833705-6550-1-git-send-email-21cnbao@gmail.com>
References: <1436833705-6550-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150716131736.GV5086@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 12:28:25AM +0000, Barry Song wrote:
> From: Yanchang Li <yl22@csr.com>

patch title should alos say what is changed. "panic under one race" is not
an apt description for this

Can you fix that up, otherwise it looks okay

-- 
~Vinod

> 
> If DMA interrupt comes and is latched by IRQ controller during the
> execution of dma_terminate_all(), dma_irq routine will be executed
> after dma terminated, and it will cause kernel panic.
> We clear DMA interrupts in dma_terminate_all() to avoid this useless
> interrupt.
> 
> Signed-off-by: Yanchang Li <yl22@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/dma/sirf-dma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 8c5186c..7d5598d 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -455,6 +455,7 @@ static int sirfsoc_dma_terminate_all(struct dma_chan *chan)
>  	switch (sdma->type) {
>  	case SIRFSOC_DMA_VER_A7V1:
>  		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_INT_EN_CLR);
> +		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_INT);
>  		writel_relaxed((1 << cid) | 1 << (cid + 16),
>  			       sdma->base +
>  			       SIRFSOC_DMA_CH_LOOP_CTRL_CLR_ATLAS7);
> @@ -462,6 +463,8 @@ static int sirfsoc_dma_terminate_all(struct dma_chan *chan)
>  		break;
>  	case SIRFSOC_DMA_VER_A7V2:
>  		writel_relaxed(0, sdma->base + SIRFSOC_DMA_INT_EN_ATLAS7);
> +		writel_relaxed(SIRFSOC_DMA_INT_ALL_ATLAS7,
> +			       sdma->base + SIRFSOC_DMA_INT_ATLAS7);
>  		writel_relaxed(0, sdma->base + SIRFSOC_DMA_LOOP_CTRL_ATLAS7);
>  		writel_relaxed(0, sdma->base + SIRFSOC_DMA_VALID_ATLAS7);
>  		break;
> -- 
> 2.3.5
> 

-- 
