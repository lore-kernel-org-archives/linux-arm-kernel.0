From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 27 Mar 2015 17:24:20 +0100
Subject: [PATCH 1/4] net/macb: only probe queues once and use stored values
In-Reply-To: <09960ba7389058e026b73409018fe1ee61d6dc57.1427469791.git.nicolas.ferre@atmel.com>
References: <cover.1427469791.git.nicolas.ferre@atmel.com>
 <09960ba7389058e026b73409018fe1ee61d6dc57.1427469791.git.nicolas.ferre@atmel.com>
Message-ID: <55158434.2090708@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

There is a little mistake in this patch, which will prevent the GEM from 
working properly:

Le 27/03/2015 16:34, Nicolas Ferre a ?crit :
> When merging at91_ether and macb driver during 421d9df0628b (net/macb: merge
> at91_ether driver into macb driver) the probe function has been split. The code
> dealing with initialization of queues is now moved in macb_init() which needs
> information computed in the parent macb_probe() function.
> So, add the queue_mask information to the private structure and use it when
> needed in macb_init().
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/net/ethernet/cadence/macb.c | 9 ++++-----
>  drivers/net/ethernet/cadence/macb.h | 1 +
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
> index a0a04b3638e6..b710768172d9 100644
> --- a/drivers/net/ethernet/cadence/macb.c
> +++ b/drivers/net/ethernet/cadence/macb.c
> @@ -2180,7 +2180,7 @@ static void macb_probe_queues(void __iomem *mem,
>  static int macb_init(struct platform_device *pdev)
>  {
>  	struct net_device *dev = platform_get_drvdata(pdev);
> -	unsigned int hw_q, queue_mask, q, num_queues;
> +	unsigned int hw_q, q;
>  	struct macb *bp = netdev_priv(dev);
>  	struct macb_queue *queue;
>  	int err;
> @@ -2226,10 +2226,8 @@ static int macb_init(struct platform_device *pdev)
>  	 * register mapping but we don't want to test the queue index then
>  	 * compute the corresponding register offset at run time.
>  	 */
> -	macb_probe_queues(bp->regs, &queue_mask, &num_queues);
> -
> -	for (hw_q = 0, q = 0; hw_q < MACB_MAX_QUEUES; ++hw_q) {
> -		if (!(queue_mask & (1 << hw_q)))
> +	for (hw_q = 0, q = 0; hw_q < bp->num_queues; ++hw_q) {
> +		if (!(bp->queue_mask & (1 << hw_q)))
>  			continue;

The exit condition of the for loop must remain "hw_q < MACB_MAX_QUEUES" and 
should not be replaced by "hw_q < bp->num_queues".
Indeed there can be only 2 queues, for instance queue0 and queue7. So if you
change the exit conditon of the loop, queue7 won't be initialized and HRESP 
errors will occur.
>  
>  		queue = &bp->queues[q];
> @@ -2715,6 +2713,7 @@ static int macb_probe(struct platform_device *pdev)
>  	bp->dev = dev;
>  	bp->regs = mem;
>  	bp->num_queues = num_queues;
> +	bp->queue_mask = queue_mask;
>  	spin_lock_init(&bp->lock);
>  
>  	platform_set_drvdata(pdev, dev);
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index bc6e35c40822..0b6afac91bfe 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -785,6 +785,7 @@ struct macb {
>  	size_t			rx_buffer_size;
>  
>  	unsigned int		num_queues;
> +	unsigned int		queue_mask;
>  	struct macb_queue	queues[MACB_MAX_QUEUES];
>  
>  	spinlock_t		lock;
> 

Best Regards,

Cyrille
