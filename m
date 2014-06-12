From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Jun 2014 09:20:23 -0400
Subject: [PATCH V2 11/19] irqchip: crossbar: fix memory leak incase of
 invalid entry
In-Reply-To: <1402574007-13987-12-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-12-git-send-email-r.sricharan@ti.com>
Message-ID: <20140612132023.GX8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 05:23:19PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> When the provided unused skip list entry is greater than max irqs
> possible, we go to err3, but we fail to free register_offsets,
> should have returned to err4 instead which ensures that allocated

s/returned/jumped/

> register_offsets are freed as well.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/irqchip/irq-crossbar.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 42a2e62..fea3e5d 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -225,7 +225,7 @@ static int __init crossbar_of_init(struct device_node *node,
>  
>  			if (entry > max) {
>  				pr_err("Invalid skip entry\n");
> -				goto err3;
> +				goto err4;

This would be a good opportunity to reduce the possibility of future
errors.  Please consider renaming err{1,2,3,4} to something more
recognizable while you are here.

thx,

Jason.

>  			}
>  			cb->irq_map[entry] = IRQ_SKIP;
>  		}
> -- 
> 1.7.9.5
> 
