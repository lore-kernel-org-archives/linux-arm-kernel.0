From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jul 2015 15:03:10 +0200
Subject: [PATCH v3 4/4] gpio: brcmstb: support wakeup from S5 cold boot
In-Reply-To: <1434589243-502-5-git-send-email-gregory.0xf0@gmail.com>
References: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
 <1434589243-502-5-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdZSUUk-giwckxSyV8ZvAZcQUD7KaCnjq=_hiO7k9=jVMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 3:00 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> For wake from S5, we need to:
> - register a reboot handler
> - set wakeup capability before requesting IRQ so wakeup count is
>   incremented
> - mask all GPIO IRQs and clear any pending interrupts during driver
>   probe to since no driver will yet be registered to handle any IRQs
>   carried over from boot at that time, and it's possible that the
>   booted kernel does not request the same IRQ anyway.
>
> This means that /sys/.../power/wakeup_count is valid at boot time, and
> we can properly account for S5 wakeup stats. e.g.:
>
>   ### After waking from S5 from a GPIO key
>   # cat /sys/bus/platform/drivers/brcmstb-gpio/f04172c0.gpio/power/wakeup
>   enabled
>   # cat /sys/bus/platform/drivers/brcmstb-gpio/f04172c0.gpio/power/wakeup_count
>   1
>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>

(...)
> -static int brcmstb_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
> +static int __brcmstb_gpio_irq_set_wake(struct brcmstb_gpio_priv *priv,
> +               unsigned int enable)
>  {
> -       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> -       struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
>         int ret = 0;

I don't usually like to refactor code with __foo wrapper functions with
underscores or double underscores in front of them.

Is it possible to give this a more unique name?

> +               /*
> +                * Mask all interrupts by default, since wakeup interrupts may
> +                * be retained from S5 cold boot
> +                */
> +               bank->bgc.write_reg(reg_base + GIO_MASK(bank->id), 0);

Aha I see, that's some clever code, nice.

Yours,
Linus Walleij
