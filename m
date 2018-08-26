From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 26 Aug 2018 20:01:19 +0100
Subject: [PATCH] irqchip/gic-v3-its: add allocation max order limitation
 for lpi_id_bits
In-Reply-To: <1535274051-2418-1-git-send-email-jia.he@hxt-semitech.com>
References: <1535274051-2418-1-git-send-email-jia.he@hxt-semitech.com>
Message-ID: <868t4tx88w.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[I'm travelling, so expect some major delays in responding to email]

Hi Jia,

On Sun, 26 Aug 2018 10:00:51 +0100,
Jia He <hejianet@gmail.com> wrote:
> 
> There is a WARN_ON when my QDF2400 server boots up (pagesize is 4k)

[snip]

> In its_alloc_lpi_tables, lpi_id_bits is 24, without this patch,
> its_allocate_prop_table will try to allocate 16M(order 12 if
> pagesize=4k). Thus it causes the WARN_ON.

Gah! QDF and its 24bit INTIDs... Making life hell for everyone ;-)

Sorry for breaking it.

> 
> This patch fixes it by limiting the lpi_id_bits.
> 
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 316a575..79e6993 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1624,8 +1624,11 @@ static void its_free_prop_table(struct page *prop_page)
>  static int __init its_alloc_lpi_tables(void)
>  {
>  	phys_addr_t paddr;
> +	u32 max_bits;	 /*max order limitation in alloc_page*/
>  
> -	lpi_id_bits = GICD_TYPER_ID_BITS(gic_rdists->gicd_typer);
> +	max_bits = PAGE_SHIFT + MAX_ORDER - 1;
> +	lpi_id_bits = min_t(u32, max_bits,
> +			GICD_TYPER_ID_BITS(gic_rdists->gicd_typer));
>  	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
>  	if (!gic_rdists->prop_page) {
>  		pr_err("Failed to allocate PROPBASE\n");
> -- 
> 1.8.3.1
> 

I find it rather odd that we end-up with different interrupt ranges
depending on the CPU page size. Also, allocating that much memory for
LPIs is rather pointless, as we actually have a pretty low limit of
interrupts the system can deal with (see IRQ_BITMAP_BITS, which is
slightly more than 8k). I've so far seen *one* request to push it up,
but I doubt that it is a real use case.

Capping lpi_id_bits at 16 (which is what we had before) is plenty,
will save a some memory, and gives some margin before we need to push
it up again.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
