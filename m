From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Oct 2014 14:14:43 +0200
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <1412779948-28769-2-git-send-email-yvo@apm.com>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <1412779948-28769-2-git-send-email-yvo@apm.com>
Message-ID: <CACRpkdY3-Y0eA_o2enfxbqWUpwPoo_5oM9t=uU=QSTAw4MPf9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 8, 2014 at 4:52 PM, Y Vo <yvo@apm.com> wrote:

> Add APM X-Gene standby GPIO controller driver.
>
> Signed-off-by: Y Vo <yvo@apm.com>

That's a very terse commit message. Please tell us a bit about the
hardware and what platforms it is used on, etc.

For example that is uses ACPI, as seems to be the case.

> +config GPIO_XGENE_SB
> +       tristate "APM X-Gene GPIO standby controller support"
> +       depends on ARCH_XGENE && OF_GPIO

If this platform uses ACPI (as is implied below), why is it depending on
OF_GPIO but not GPIO_ACPI...

(...)
> +#include <linux/of_gpio.h>
> +#include <linux/of_irq.h>
> +#include <linux/acpi.h>

So this platform uses some interesting combination of ACPI and device tree
at the same time? Or alternatively?


> +struct xgene_gpio_sb {
> +       struct of_mm_gpio_chip mm;
> +       u32 *irq;
> +       u32 nirq;
> +       void __iomem *gic_regs;
> +       spinlock_t lock; /* mutual exclusion */
> +};

Document this struct using kerneldoc instead.

> +       apm_gc->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
> +                                  GFP_KERNEL);
> +       if (!apm_gc->irq)
> +               return -ENOMEM;
> +       memset(apm_gc->irq, 0, sizeof(u32) * XGENE_MAX_GPIO_DS);
(...)
> +       for (i = 0; i < apm_gc->nirq; i++) {
> +               apm_gc->irq[default_pins[i]] = platform_get_irq(pdev, i);

So the IRQs for all the GPIO pins are handled somewhere else instead
of being a cascaded IRQ controller.

This means that the IRQ lines from each individual GPIO pin is
connected to a unique IRQ line on a secondary interrupt controller,
instead of the GPIO block being a cascaded interrupt controller
in its own right.

Is this correct?

Usually there is a single IRQ line out from a GPIO block... not
one per GPIO.

I really want to look at the code for that interrupt controller to see
what's going on here, please provide me a pointer to the
relevant code.

> +static int xgene_gpio_sb_remove(struct platform_device *pdev)
> +{
> +       struct of_mm_gpio_chip *mm = platform_get_drvdata(pdev);
> +
> +       return gpiochip_remove(&mm->gc);

This function has changed signature and doesn't return a value
anymore.

Yours,
Linus Walleij
