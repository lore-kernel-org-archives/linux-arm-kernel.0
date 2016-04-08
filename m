From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Apr 2016 11:43:12 +0200
Subject: [PATCH v2 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <1459436979-17275-7-git-send-email-mcoquelin.stm32@gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1459436979-17275-7-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdYLPWNQZgdFHVwLOZv+rS=bdERM9St5b0hVHTd_+ZJMKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 5:09 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> +static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct stm32_pinctrl *pctl = dev_get_drvdata(chip->parent);
> +       struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
> +       unsigned int irq;
> +
> +       regmap_field_write(pctl->irqmux[offset], bank->range.id);

No. You must implement the irqchip and GPIO controllers to
be orthogonal, doing things like this creates a semantic that
assumes .to_irq() is always called before using the IRQ and
that is not guaranteed at all. A consumer may very well
use an interrupt right off the irqchip without this being called
first. All this function should do is translate a number. No
other semantics.

This needs to be done from the irqchip (sorry).

Yours,
Linus Walleij
