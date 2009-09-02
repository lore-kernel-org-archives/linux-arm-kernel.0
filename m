From: saaguirre@ti.com (Aguirre Rodriguez, Sergio Alberto)
Date: Wed, 2 Sep 2009 07:21:47 -0500
Subject: [PATCH] ARM: request_irq() failure ignored in
	omap_uart_enable_irqs()
In-Reply-To: <4A9D5731.20909@gmail.com>
References: <4A9D3D2A.1060609@gmail.com> <4A9D4769.5060907@ru.mvista.com>
	<4A9D5731.20909@gmail.com>
Message-ID: <A24693684029E5489D1D202277BE89444BFBAEE3@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Resending to new ML)

From: Roel Kluin [mailto:roel.kluin at gmail.com]
Sent: Tuesday, September 01, 2009 12:18 PM
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index a7421a5..ed683d9 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -471,11 +471,18 @@ void omap_uart_enable_irqs(int enable)

Wouldn't it make more sense to return int, instead of void here?

The caller would never know if the call internally failed.

Just a thought...

Regards,
Sergio

>  	int ret;
>  	struct omap_uart_state *uart;
> 
> -	list_for_each_entry(uart, &uart_list, node) {
> -		if (enable)
> +	if (enable) {
> +		list_for_each_entry(uart, &uart_list, node) {
>  			ret = request_irq(uart->p->irq, omap_uart_interrupt,
>  				IRQF_SHARED, "serial idle", (void *)uart);
> -		else
> +			if (ret < 0) {
> +				printk(KERN_ERR "omap_uart_enable_irqs: failed to
> request IRQ%i (%i)\n",
> +						uart->p->irq, ret);
> +				return;
> +			}
> +		}
> +	} else {
> +		list_for_each_entry(uart, &uart_list, node)
>  			free_irq(uart->p->irq, (void *)uart);
>  	}
>  }
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-
> kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
