From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jun 2015 11:59:23 +0100
Subject: [PATCH 2/9] ARM: sa1100: convert SA11x0 related code to use new
 chained handler helper
In-Reply-To: <E1Z4yzx-0002S6-7p@rmk-PC.arm.linux.org.uk>
References: <E1Z4yzx-0002S6-7p@rmk-PC.arm.linux.org.uk>
Message-ID: <20150622105923.GE19061@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Jun 2015, Russell King wrote:

> Convert SA11x0 (Neponset, SA1111, and UCB1x00 code) to use the new
> irq_set_chained_handler_and_data() helper.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Depends on patch 1.
> 
>  arch/arm/common/sa1111.c        | 7 +++----
>  arch/arm/mach-sa1100/neponset.c | 3 +--
>  drivers/mfd/ucb1x00-core.c      | 3 +--

Acked-by: Lee Jones <lee.jones@linaro.org>

>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 5cc779c8e9c6..93ee70dbbdd3 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -501,8 +501,8 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
>  	 * Register SA1111 interrupt
>  	 */
>  	irq_set_irq_type(sachip->irq, IRQ_TYPE_EDGE_RISING);
> -	irq_set_handler_data(sachip->irq, sachip);
> -	irq_set_chained_handler(sachip->irq, sa1111_irq_handler);
> +	irq_set_chained_handler_and_data(sachip->irq, sa1111_irq_handler,
> +					 sachip);
>  
>  	dev_info(sachip->dev, "Providing IRQ%u-%u\n",
>  		sachip->irq_base, sachip->irq_base + SA1111_IRQ_NR - 1);
> @@ -836,8 +836,7 @@ static void __sa1111_remove(struct sa1111 *sachip)
>  	clk_unprepare(sachip->clk);
>  
>  	if (sachip->irq != NO_IRQ) {
> -		irq_set_chained_handler(sachip->irq, NULL);
> -		irq_set_handler_data(sachip->irq, NULL);
> +		irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
>  		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
>  
>  		release_mem_region(sachip->phys + SA1111_INTC, 512);
> diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
> index af868d258e66..99d9a3b1bf34 100644
> --- a/arch/arm/mach-sa1100/neponset.c
> +++ b/arch/arm/mach-sa1100/neponset.c
> @@ -327,8 +327,7 @@ static int neponset_probe(struct platform_device *dev)
>  	irq_set_chip(d->irq_base + NEP_IRQ_SA1111, &nochip);
>  
>  	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
> -	irq_set_handler_data(irq, d);
> -	irq_set_chained_handler(irq, neponset_irq_handler);
> +	irq_set_chained_handler_and_data(irq, neponset_irq_handler, d);
>  
>  	/*
>  	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but unfortunately
> diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
> index 58ea9fdd3a15..3591550598ad 100644
> --- a/drivers/mfd/ucb1x00-core.c
> +++ b/drivers/mfd/ucb1x00-core.c
> @@ -566,8 +566,7 @@ static int ucb1x00_probe(struct mcp *mcp)
>  	}
>  
>  	irq_set_irq_type(ucb->irq, IRQ_TYPE_EDGE_RISING);
> -	irq_set_handler_data(ucb->irq, ucb);
> -	irq_set_chained_handler(ucb->irq, ucb1x00_irq);
> +	irq_set_chained_handler_and_data(ucb->irq, ucb1x00_irq, ucb);
>  
>  	if (pdata && pdata->gpio_base) {
>  		ucb->gpio.label = dev_name(&ucb->dev);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
