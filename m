From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 15:45:29 +0200
Subject: [PATCH v2] gpio: omap: implement get_direction
In-Reply-To: <1398173505-28193-1-git-send-email-yegorslists@googlemail.com>
References: <1398173505-28193-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <CACRpkdbTq+UHVsZ-mYYPs7mZoVbv8wUctiCcgH9AKzQZ5O1aNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 3:31 PM,  <yegorslists@googlemail.com> wrote:

> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch implements gpio_chip's get_direction() routine, that
> lets other drivers get particular GPIOs direction using
> struct gpio_desc.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> Changes:
>         v2: rework return value calculation
(...)

I don't see why this need to be a broken-out function? Can it not
be factored into gpio_get_direction?

> +static int _get_gpio_direction(struct gpio_bank *bank, int gpio)
> +{
> +       void __iomem *reg = bank->base;
> +       u32 l;
> +
> +       reg += bank->regs->direction;
> +       l = (readl_relaxed(reg) >> gpio);
> +
> +       return (l & 0x00000001);

Rewrite the last two statements like this:

#include <linux/bitops.h>

return !!(readl_relaxed(reg) & BIT(gpio));

> +static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct gpio_bank *bank;
> +       unsigned long flags;
> +       int dir;
> +
> +       bank = container_of(chip, struct gpio_bank, chip);
> +       spin_lock_irqsave(&bank->lock, flags);
> +       dir = _get_gpio_direction(bank, offset);
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +       return dir;
> +}

So since _get_gpio_direction is never called from unlocked context,
can it not just be part of this function then?

(I make a mental note to prefix all functions in this driver
with omap_*....)

Yours,
Linus Walleij
