From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 07 Feb 2013 17:17:31 +0200
Subject: [PATCH v2 07/10] gpio: pxa: remove arch related macro
In-Reply-To: <1359886551-20950-8-git-send-email-haojian.zhuang@linaro.org>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <1359886551-20950-8-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5113C58B.7030901@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/03/13 12:15, Haojian Zhuang wrote:
> Remove macro CONFIG_ARCH_PXA.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  drivers/gpio/gpio-pxa.c |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index 95561d6..8130e3b 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -568,21 +568,21 @@ static int pxa_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!use_of) {
> -#ifdef CONFIG_ARCH_PXA
> -		irq = gpio_to_irq(0);
> -		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
> -					 handle_edge_irq);
> -		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> -		irq_set_chained_handler(IRQ_GPIO0, pxa_gpio_demux_handler);
> -
> -		irq = gpio_to_irq(1);
> -		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
> -					 handle_edge_irq);
> -		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> -		irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
> -#endif
> -
> -		for (irq  = gpio_to_irq(gpio_offset);
> +		if (irq0 > 0) {
> +			irq = gpio_to_irq(0);
> +			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
> +						 handle_edge_irq);
> +			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +			irq_set_chained_handler(irq0, pxa_gpio_demux_handler);
> +		}
> +		if (irq1 > 0) {
> +			irq = gpio_to_irq(1);
> +			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
> +						 handle_edge_irq);
> +			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +			irq_set_chained_handler(irq1, pxa_gpio_demux_handler);
> +		}
> +		for (irq = gpio_to_irq(gpio_offset);
>  			irq <= gpio_to_irq(pxa_last_gpio); irq++) {
>  			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
>  						 handle_edge_irq);
> 

-- 
Regards,
Igor.
