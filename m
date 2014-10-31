From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 08:48:35 +0100
Subject: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
In-Reply-To: <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 1:01 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Add gpiolib driver for gpio pins placed on the LoCoMo GA.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

(...)
> +static int locomo_gpio_get(struct gpio_chip *chip,
> +               unsigned offset)
> +{
> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +
> +       return readw(lg->regs + LOCOMO_GPL) & (1 << offset);

Do this:

#include <linux/bitops.h>

return !!(readw(lg->regs + LOCOMO_GPL) & BIT(offset));

So you clamp the returned value to a bool.

> +static void __locomo_gpio_set(struct gpio_chip *chip,
> +               unsigned offset, int value)
> +{
> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +       u16  r;
> +
> +       r = readw(lg->regs + LOCOMO_GPO);
> +       if (value)
> +               r |= 1 << offset;

r |= BIT(offset);

> +       else
> +               r &= ~(1 << offset);

r &= BIT(offset);

(etc, everywhere this pattern occurs).
> +static void locomo_gpio_set(struct gpio_chip *chip,
> +               unsigned offset, int value)
> +{
> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&lg->lock, flags);
> +
> +       __locomo_gpio_set(chip, offset, value);
> +
> +       spin_unlock_irqrestore(&lg->lock, flags);

If you actually always have to be getting and releasing a spin lock around
the register writes, contemplate using regmap-mmio because that
is part of what it does.

But is this locking really necessary?

> +static int locomo_gpio_remove(struct platform_device *pdev)
> +{
> +       struct locomo_gpio *lg = platform_get_drvdata(pdev);
> +       int ret;
> +
> +       ret = gpiochip_remove(&lg->gpio);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Can't remove gpio chip: %d\n", ret);
> +               return ret;
> +       }

The return value from gpiochip_remove() has been removed in v3.18-rc1
so this will not compile.

Yours,
Linus Walleij
