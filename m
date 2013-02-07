From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Feb 2013 17:13:45 -0700
Subject: [PATCH 09/14] pinctrl/abx500: use direct IRQ defines
In-Reply-To: <1360093715-6348-10-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-10-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5112F1B9.6010700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 12:48 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Make it harder to do mistakes by introducing the actual
> defined ABx500 IRQ number into the IRQ cluster definitions.
> Deduct cluster offset from the GPIO offset to make each
> cluster coherent.

Shouldn't this patch be squashed into the previous patch to avoid churn?

>  static struct abx500_pinctrl_soc_data ab9540_soc = {

> @@ -273,8 +273,7 @@ static int abx500_gpio_to_irq(struct gpio_chip *chip, unsigned offset)

> -			hwirq = gpio + cluster->to_irq;
> -
> +			hwirq = gpio - cluster->start + cluster->to_irq;
>  			return irq_create_mapping(pct->parent->domain, hwirq);

In particular, this change implies that the previous patch was simply
incorrect, although I haven't really thought about it in detail.
