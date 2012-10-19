From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Oct 2012 10:22:27 -0600
Subject: [PATCH] pinctrl/nomadik: use irq_create_mapping()
In-Reply-To: <1350659375-7335-1-git-send-email-linus.walleij@stericsson.com>
References: <1350659375-7335-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50817E43.8000804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2012 09:09 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Since in the DT case, the linear domain path will not allocate
> descriptors for the IRQs, we need to use irq_create_mapping()
> for mapping hwirqs to Linux IRQs, so these descriptors get
> created on-the-fly in this case.

> @@ -931,7 +931,7 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
>  	while (status) {
>  		int bit = __ffs(status);
>  
> -		generic_handle_irq(irq_find_mapping(nmk_chip->domain, bit));
> +		generic_handle_irq(irq_create_mapping(nmk_chip->domain, bit));

Surely this one can remain as irq_find_mapping() since isn't
nmk_gpio_to_irq() guaranteed to have been called first for this GPIO/IRQ?
