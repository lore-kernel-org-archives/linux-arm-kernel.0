From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 17:46:39 +0000
Subject: [PATCH v2 2/2] dma/imx-sdma: add wmb before enable a channel
In-Reply-To: <1325428692-11473-3-git-send-email-richard.zhao@linaro.org>
References: <1325428692-11473-1-git-send-email-richard.zhao@linaro.org>
 <1325428692-11473-3-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120103174639.GF2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 01, 2012 at 10:38:12PM +0800, Richard Zhao wrote:
> dma_alloc_coherent memory may be bufferable. We need to add
> nececcary memory barrier.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  drivers/dma/imx-sdma.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f8e87b5..9301bff 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -394,6 +394,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
>  
>  static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
>  {
> +	wmb();
>  	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);

Use writel().  That's what it's there for:

#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
#define __iowmb()               wmb()
#endif
#define writel_relaxed(v,c)     ((void)__raw_writel((__force u32) \
                                        cpu_to_le32(v),__mem_pci(c)))
#define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
