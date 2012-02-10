From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 10 Feb 2012 21:01:48 +0100
Subject: [PATCH] ARM: S5P: Can handle edge interrupt handler
In-Reply-To: <017401cce7f4$4623f5a0$d26be0e0$@samsung.com>
References: <017401cce7f4$4623f5a0$d26be0e0$@samsung.com>
Message-ID: <1683433.XtZk95zyY3@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I wonder if same thing wouldn't be also needed for s3c64xx.

Also please see my comments inline.

On Friday 10 of February 2012 22:02:42 Huisung Kang wrote:
> From: KeyYoung Park <keyyoung.park@samsung.com>
> 
> While wake up, if external interrupt uses handle_level_irq
> as handle_irq (it actually uses edge type irq), That interrupt is missed.
> So, if external uses edge type irq, it should use handle_edge_irq.
> 
> Signed-off-by: KeyYoung Park <keyyoung.park@samsung.com>
> Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
> ---
>  arch/arm/plat-s5p/irq-eint.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> index c496b35..6ed395e 100644
> --- a/arch/arm/plat-s5p/irq-eint.c
> +++ b/arch/arm/plat-s5p/irq-eint.c
> @@ -65,6 +65,7 @@ static int s5p_irq_eint_set_type(struct irq_data *data,
> unsigned int type) int shift;
>  	u32 ctrl, mask;
>  	u32 newvalue = 0;
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> 
>  	switch (type) {
>  	case IRQ_TYPE_EDGE_RISING:
> @@ -115,6 +116,11 @@ static int s5p_irq_eint_set_type(struct irq_data
> *data, unsigned int type) else
>  		printk(KERN_ERR "No such irq number %d", offs);
> 
> +	if (type & IRQ_TYPE_EDGE_BOTH)
> +		desc->handle_irq = handle_edge_irq;
> +	else
> +		desc->handle_irq = handle_level_irq;

Maybe it would be better to use __irq_set_handler_locked here instead of 
touching irq_desc directly?

> +
>  	return 0;
>  }

Regards,
Tom
