From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Jun 2014 08:56:15 -0400
Subject: [PATCH V2 05/19] irqchip: crossbar: Change allocation logic by
 reversing search for free irqs
In-Reply-To: <1402574007-13987-6-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-6-git-send-email-r.sricharan@ti.com>
Message-ID: <20140612125615.GT8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 05:23:13PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> Reverse the search algorithm to ensure that address mapping and IRQ
> allocation logics are proper. This can open up new bugs which are
> easily fixable rather than wait till allocation logic approaches
> the limit to find new bugs.

Could you expand on this logic some more?  What class of bugs are you
hoping to discover more easily?

thx,

Jason.

> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/irqchip/irq-crossbar.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 287d3ce..de021638 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -68,7 +68,7 @@ static inline int get_prev_map_irq(int cb_no)
>  {
>  	int i;
>  
> -	for (i = 0; i < cb->int_max; i++)
> +	for (i = cb->int_max - 1; i >= 0; i--)
>  		if (cb->irq_map[i] == cb_no)
>  			return i;
>  
> @@ -79,7 +79,7 @@ static inline int allocate_free_irq(int cb_no)
>  {
>  	int i;
>  
> -	for (i = 0; i < cb->int_max; i++) {
> +	for (i = cb->int_max - 1; i >= 0; i--) {
>  		if (cb->irq_map[i] == IRQ_FREE) {
>  			cb->irq_map[i] = cb_no;
>  			return i;
> -- 
> 1.7.9.5
> 
