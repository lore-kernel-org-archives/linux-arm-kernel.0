From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 10:59:39 -0700
Subject: [PATCH 09/14] pinctrl/abx500: use direct IRQ defines
In-Reply-To: <CAF2Aj3jHe+mP0dU_BHThBV-va_iJLcFQedmWQOTaYafAZM1Yxg@mail.gmail.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-10-git-send-email-linus.walleij@stericsson.com>
 <5112F1B9.6010700@wwwdotorg.org>
 <CAF2Aj3jHe+mP0dU_BHThBV-va_iJLcFQedmWQOTaYafAZM1Yxg@mail.gmail.com>
Message-ID: <5113EB8B.4060002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 02:01 AM, Lee Jones wrote:
> I don't see myself on cc. Was that intentional?

The original patch was that way; I assume git send-email only CC'd you
on patches written by you.

> I quite like the idea of this.
> 
> Stephen,
> 
> It doesn't mean the other patch was wrong, it just transfers the math.

Ah, I see. The issue is that the code below clearly calculates the hwirq
differently, and it wasn't immediately obvious that this part of the
patch for example:

>  struct abx500_gpio_irq_cluster ab8500_gpio_irq_cluster[] = {
> -	GPIO_IRQ_CLUSTER(6,  13, 34),
> -	GPIO_IRQ_CLUSTER(24, 25, 24),
> -	GPIO_IRQ_CLUSTER(36, 41, 14),
> +	GPIO_IRQ_CLUSTER(6,  13, AB8500_INT_GPIO6R),
> +	GPIO_IRQ_CLUSTER(24, 25, AB8500_INT_GPIO24R),
> +	GPIO_IRQ_CLUSTER(36, 41, AB8500_INT_GPIO36R),
>  };

... actually changes the values in the table (AB8500_INT_GPIO6R is 40,
so when using that value, you need to subtract of the value 6 for the
base to get the original 34).

> I wouldn't squash it into mine. I like the transition and the
> possibility to revert it if there's been some mistake.
> 
> (not to say there is one, but just in case.)
> 
> Sent from my mobile Linux device.
> 
> On Feb 7, 2013 12:14 AM, "Stephen Warren" <swarren@wwwdotorg.org
> <mailto:swarren@wwwdotorg.org>> wrote:
> 
>     On 02/05/2013 12:48 PM, Linus Walleij wrote:
>     > From: Linus Walleij <linus.walleij@linaro.org
>     <mailto:linus.walleij@linaro.org>>
>     >
>     > Make it harder to do mistakes by introducing the actual
>     > defined ABx500 IRQ number into the IRQ cluster definitions.
>     > Deduct cluster offset from the GPIO offset to make each
>     > cluster coherent.
> 
>     Shouldn't this patch be squashed into the previous patch to avoid churn?
> 
>     >  static struct abx500_pinctrl_soc_data ab9540_soc = {
> 
>     > @@ -273,8 +273,7 @@ static int abx500_gpio_to_irq(struct gpio_chip
>     *chip, unsigned offset)
> 
>     > -                     hwirq = gpio + cluster->to_irq;
>     > -
>     > +                     hwirq = gpio - cluster->start + cluster->to_irq;
>     >                       return
>     irq_create_mapping(pct->parent->domain, hwirq);
> 
>     In particular, this change implies that the previous patch was simply
>     incorrect, although I haven't really thought about it in detail.
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-kernel" in
>     the body of a message to majordomo at vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     Please read the FAQ at  http://www.tux.org/lkml/
> 
