From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Dec 2013 10:32:42 +0000
Subject: [PATCH 07/10] mfd: menelaus: Start to use irqdomain
In-Reply-To: <1387238904-7843-7-git-send-email-balbi@ti.com>
References: <20131216153936.GQ18769@lee--X1>
 <1387238904-7843-1-git-send-email-balbi@ti.com>
 <1387238904-7843-7-git-send-email-balbi@ti.com>
Message-ID: <20131217103242.GB19810@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Dec 2013, Felipe Balbi wrote:

> Introduce an irq_chip and irq_domain for menelaus driver. Following
> patches will convert uses to traditional request_threaded_irq().
> 
> While at that, some better error handling had to be added, so we could
> free irq descs we allocated.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 119 insertions(+), 4 deletions(-)
> 

<snip>

> +static void menelaus_irq_ack(struct irq_data *data)
> +{
> +	struct menelaus_chip *m = irq_data_get_irq_chip_data(data);
> +	int irq = data->irq - m->irq_base;

Shoudn't this now be?
  int irq = data->hwirq;

> +	if (irq > 7) {
> +		m->ack2 |= BIT(irq);
> +		m->ack2_pending = true;
> +	} else {
> +		m->ack1 |= BIT(irq);
> +		m->ack1_pending = true;
> +	}
> +}
> +
> +static void menelaus_irq_mask(struct irq_data *data)
> +{
> +	struct menelaus_chip *m = irq_data_get_irq_chip_data(data);
> +	int irq = data->irq - m->irq_base;

Same for here, and all the others.

<snip>

> +	irq_domain_add_legacy(node, MENELAUS_NR_IRQS, irq_base, 0,
> +			&irq_domain_simple_ops, m);

Please use irq_domain_add_simple() here.

> +	m->irq_base = irq_base;

I don't think you need this.

> +	for (i = irq_base; i < irq_base + MENELAUS_NR_IRQS; i++) {
> +		irq_set_chip_data(i, m);
> +		irq_set_chip_and_handler(i, &menelaus_irq_chip,
> +				handle_simple_irq);
> +		irq_set_nested_thread(i, 1);
> +		set_irq_flags(i, IRQF_VALID);
> +	}

You should put this in the .map() operation and the reverse in .unmap().

>  fail:
> +	irq_free_descs(irq_base, MENELAUS_NR_IRQS);

I don't think you need to do this.

>  
>  static int menelaus_remove(struct i2c_client *client)
>  {
> +	struct menelaus_chip	*m = i2c_get_clientdata(client);
> +
> +	irq_free_descs(m->irq_base, MENELAUS_NR_IRQS);

Nor here.

>  	the_menelaus = NULL;

Shouldn't this have been removed in patch 6?

>  	return 0;
>  }
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
