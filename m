From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 19 Nov 2015 17:39:50 +0100
Subject: [PATCH v2] pinctrl: at91-pio4: use %pr format string for resource
In-Reply-To: <5199877.GVYeflqET9@wuerfel>
References: <5199877.GVYeflqET9@wuerfel>
Message-ID: <20151119163950.GD23317@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 04:21:17PM +0100, Arnd Bergmann wrote:
> resource_size_t may be defined as 32 or 64 bit depending on configuration,
> so it cannot be printed using the normal format strings, as gcc correctly
> warns:
> 
> pinctrl-at91-pio4.c: In function 'atmel_pinctrl_probe':
> pinctrl-at91-pio4.c:1003:41: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
>    dev_dbg(dev, "bank %i: hwirq=%u\n", i, res->start);
> 
> This changes the format string to use the special "%pr" format
> string that prints a resource, and changes the arguments so we
> the resource structure directly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks.

> ---
> v2: don't break ordering of arguments, that part was correct already, unlike
> what I said in v1.
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 33edd07d9149..abdc16e5a970 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -1000,7 +1000,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
>  		atmel_pioctrl->irqs[i] = res->start;
>  		irq_set_chained_handler(res->start, atmel_gpio_irq_handler);
>  		irq_set_handler_data(res->start, atmel_pioctrl);
> -		dev_dbg(dev, "bank %i: hwirq=%u\n", i, res->start);
> +		dev_dbg(dev, "bank %i: irq=%pr\n", i, res);
>  	}
>  
>  	atmel_pioctrl->irq_domain = irq_domain_add_linear(dev->of_node,
> 
