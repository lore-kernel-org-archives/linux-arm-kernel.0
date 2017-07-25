From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 25 Jul 2017 14:16:36 +0100
Subject: [PATCH v3] irqchip/tango: Don't use incorrect irq_mask_ack
 callback
In-Reply-To: <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com> (Marc
 Gonzalez's message of "Tue, 25 Jul 2017 15:08:49 +0200")
References: <20170719190734.18566-1-opendmb@gmail.com>
 <20170719190734.18566-3-opendmb@gmail.com>
 <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
 <8d29fec9-35b8-c33b-3091-3e9a51c99ed7@gmail.com>
 <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com>
Message-ID: <yw1xfudkodvv.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> irq_gc_mask_disable_reg_and_ack() is not equivalent to
> irq_gc_mask_disable_reg() and irq_gc_ack_set_bit().
>
> Leave the irq_mask_ack callback undefined, and let the irqchip
> framework use irq_mask and irq_ack instead.
>
> Reported-by: Doug Berger <opendmb@gmail.com>
> Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86xx/SMP87xx interrupt controller")
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: stable at vger.kernel.org
> ---
> As discussed previously, it is acceptable for tango to rely
> on mask_ack_irq() doing the right thing(TM).
> ---
>  drivers/irqchip/irq-tango.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
> index bdbb5c0ff7fe..825085cdab99 100644
> --- a/drivers/irqchip/irq-tango.c
> +++ b/drivers/irqchip/irq-tango.c
> @@ -141,7 +141,6 @@ static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
>  	for (i = 0; i < 2; i++) {
>  		ct[i].chip.irq_ack = irq_gc_ack_set_bit;
>  		ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
> -		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_reg_and_ack;
>  		ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
>  		ct[i].chip.irq_set_type = tangox_irq_set_type;
>  		ct[i].chip.name = gc->domain->name;
> -- 

What happened to the patch adding the proper combined function?

-- 
M?ns Rullg?rd
