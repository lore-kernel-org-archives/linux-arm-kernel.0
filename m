From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Mar 2017 09:57:50 +0100
Subject: [RFC PATCH 14/33] irqchip/gic-v3-its: Generalize LPI configuration
In-Reply-To: <1484648454-21216-15-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <1bcfddd4-1e87-856d-284b-d23c111086f8@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 17/01/2017 11:20, Marc Zyngier wrote:
> We're are going to need to change a bit more than just the enable
s/We're are/We're
> bit in the LPI property table in the future. So let's change the
> LPI configuration funtion to take a set of bits to be cleared,
s/funtion/function
> and a set of bits to be set.
> 
> This way, we'll be able to use it when a guest updates an LPI
> property (priority, for example).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index dcd4771..0dbc8b0 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -672,17 +672,18 @@ static inline u32 its_get_event_id(struct irq_data *d)
>  	return d->hwirq - its_dev->event_map.lpi_base;
>  }
>  
> -static void lpi_set_config(struct irq_data *d, bool enable)
> +static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
>  {
>  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>  	irq_hw_number_t hwirq = d->hwirq;
> -	u32 id = its_get_event_id(d);
> -	u8 *cfg = page_address(gic_rdists->prop_page) + hwirq - 8192;
> +	struct page *prop_page;
> +	u8 *cfg;
>  
> -	if (enable)
> -		*cfg |= LPI_PROP_ENABLED;
> -	else
> -		*cfg &= ~LPI_PROP_ENABLED;
> +	prop_page = gic_rdists->prop_page;
> +
> +	cfg = page_address(prop_page) + hwirq - 8192;
> +	*cfg &= ~clr;
> +	*cfg |= set;
>  
>  	/*
>  	 * Make the above write visible to the redistributors.
> @@ -693,17 +694,17 @@ static void lpi_set_config(struct irq_data *d, bool enable)
>  		gic_flush_dcache_to_poc(cfg, sizeof(*cfg));
>  	else
>  		dsb(ishst);
> -	its_send_inv(its_dev, id);
> +	its_send_inv(its_dev, its_get_event_id(d));
>  }
>  
>  static void its_mask_irq(struct irq_data *d)
>  {
> -	lpi_set_config(d, false);
> +	lpi_update_config(d, LPI_PROP_ENABLED, 0);
>  }
>  
>  static void its_unmask_irq(struct irq_data *d)
>  {
> -	lpi_set_config(d, true);
> +	lpi_update_config(d, 0, LPI_PROP_ENABLED);
>  }
>  
>  static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> 
