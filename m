From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Apr 2014 15:13:04 +0200
Subject: [PATCH v3] gpio: omap: implement get_direction
In-Reply-To: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
References: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 8:57 AM,  <yegorslists@googlemail.com> wrote:

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
>         v3: get rid of _get_gpio_direction() (Linus Walleij)
>         v2: rework return value calculation

Looks good to me, Kevin, Santosh?

Part of me wants to list Javier as maintainer for this driver.

> +static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct gpio_bank *bank;
> +       unsigned long flags;
> +       void __iomem *reg;
> +       int dir;

That is a bool, actually. But no big deal.

> +
> +       bank = container_of(chip, struct gpio_bank, chip);
> +       reg = bank->base + bank->regs->direction;
> +       spin_lock_irqsave(&bank->lock, flags);
> +       dir = !!(readl_relaxed(reg) & BIT(offset));
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +       return dir;
> +}

Yours,
Linus Walleij
