From: robherring2@gmail.com (Rob Herring)
Date: Sat, 09 Feb 2013 14:59:55 -0600
Subject: [PATCH 16/17] xgmac: replace __raw with relaxed IO
In-Reply-To: <1360365467-25056-17-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-17-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5116B8CB.40007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 05:17 PM, Ben Dooks wrote:
> The xgmac driver is using __raw read and write functions, where it
> should be using readl_relaxed and writel_relaxed to avoid any issues
> with which endian mode the CPU is running in.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/net/ethernet/calxeda/xgmac.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

This will break on arches which don't have the _relaxed variants. David
Miller will reject restricting this to build on ARM only. See this:

http://www.spinics.net/lists/netdev/msg215457.html

Rob

> 
> diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
> index f91d9b2..08a6f9e 100644
> --- a/drivers/net/ethernet/calxeda/xgmac.c
> +++ b/drivers/net/ethernet/calxeda/xgmac.c
> @@ -1202,7 +1202,7 @@ static int xgmac_poll(struct napi_struct *napi, int budget)
>  
>  	if (work_done < budget) {
>  		napi_complete(napi);
> -		__raw_writel(DMA_INTR_DEFAULT_MASK, priv->base + XGMAC_DMA_INTR_ENA);
> +		writel_relaxed(DMA_INTR_DEFAULT_MASK, priv->base + XGMAC_DMA_INTR_ENA);
>  	}
>  	return work_done;
>  }
> @@ -1347,7 +1347,7 @@ static irqreturn_t xgmac_pmt_interrupt(int irq, void *dev_id)
>  	struct xgmac_priv *priv = netdev_priv(dev);
>  	void __iomem *ioaddr = priv->base;
>  
> -	intr_status = __raw_readl(ioaddr + XGMAC_INT_STAT);
> +	intr_status = readl_relaxed(ioaddr + XGMAC_INT_STAT);
>  	if (intr_status & XGMAC_INT_STAT_PMT) {
>  		netdev_dbg(priv->dev, "received Magic frame\n");
>  		/* clear the PMT bits 5 and 6 by reading the PMT */
> @@ -1365,9 +1365,9 @@ static irqreturn_t xgmac_interrupt(int irq, void *dev_id)
>  	struct xgmac_extra_stats *x = &priv->xstats;
>  
>  	/* read the status register (CSR5) */
> -	intr_status = __raw_readl(priv->base + XGMAC_DMA_STATUS);
> -	intr_status &= __raw_readl(priv->base + XGMAC_DMA_INTR_ENA);
> -	__raw_writel(intr_status, priv->base + XGMAC_DMA_STATUS);
> +	intr_status = readl_relaxed(priv->base + XGMAC_DMA_STATUS);
> +	intr_status &= readl_relaxed(priv->base + XGMAC_DMA_INTR_ENA);
> +	writel_relaxed(intr_status, priv->base + XGMAC_DMA_STATUS);
>  
>  	/* It displays the DMA process states (CSR5 register) */
>  	/* ABNORMAL interrupts */
> @@ -1403,7 +1403,7 @@ static irqreturn_t xgmac_interrupt(int irq, void *dev_id)
>  
>  	/* TX/RX NORMAL interrupts */
>  	if (intr_status & (DMA_STATUS_RI | DMA_STATUS_TU | DMA_STATUS_TI)) {
> -		__raw_writel(DMA_INTR_ABNORMAL, priv->base + XGMAC_DMA_INTR_ENA);
> +		writel_relaxed(DMA_INTR_ABNORMAL, priv->base + XGMAC_DMA_INTR_ENA);
>  		napi_schedule(&priv->napi);
>  	}
>  
> 
