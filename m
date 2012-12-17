From: bhutchings@solarflare.com (Ben Hutchings)
Date: Mon, 17 Dec 2012 13:52:25 +0000
Subject: [PATCH 3/3 v2] net/macb: Try to optimize struct macb layout
In-Reply-To: <cd54582850d50ec7ae391aae423b8982875a123a.1355748676.git.nicolas.ferre@atmel.com>
References: <cover.1355748676.git.nicolas.ferre@atmel.com>
 <cd54582850d50ec7ae391aae423b8982875a123a.1355748676.git.nicolas.ferre@atmel.com>
Message-ID: <1355752345.2676.2.camel@bwh-desktop.uk.solarflarecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-12-17 at 14:01 +0100, Nicolas Ferre wrote:
> From: Havard Skinnemoen <havard@skinnemoen.net>
> 
> Move TX-related fields to the top of the struct so that they end up on
> the same cache line. Move the NAPI struct below that since it is used
> from the interrupt handler. RX-related fields go below those.

> Move the spinlock before regs since they are usually used together.
>
> Signed-off-by: Havard Skinnemoen <havard@skinnemoen.net>
> [nicolas.ferre at atmel.com: adapt to newer kernel]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/net/ethernet/cadence/macb.h | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index cef146f..aeeb729 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -548,38 +548,39 @@ struct macb_or_gem_ops {
>  };
>  
>  struct macb {
> +	spinlock_t		lock;
>  	void __iomem		*regs;
>  
> +	unsigned int		tx_head;
> +	unsigned int		tx_tail;
> +	struct macb_dma_desc	*tx_ring;
> +	struct macb_tx_skb	*tx_skb;
> +	dma_addr_t		tx_ring_dma;
> +	struct work_struct	tx_error_task;
> +
> +	struct napi_struct	napi;
[...]

If this driver may be used on SMP systems them 'napi' should be declared
with the suffix ___cacheline_aligned_in_smp.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
