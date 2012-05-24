From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2012 16:48:25 +0200
Subject: [PATCH] PINCTRL: SiRF: add CSR SiRFprimaII GPIO driver depending
 on pinmux APIs
In-Reply-To: <1337670845-14572-1-git-send-email-Barry.Song@csr.com>
References: <1337670845-14572-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdZOTZaVp6rfuQvZaQyk0+zxeAjwHryBMYY-C1WVABaLLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 9:14 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> In SiRFprimaII, Each GPIO pin can be configured as input or output
> independently. If a GPIO is configured as input, it can also be
> enabled as an interrupt source (either edge or level triggered).
>
> These pins must be either MUXed as GPIO or other function pads. So
> this drivers depend on pinctrl_request_gpio() API pinctrl-sirf.c
> implements.
>
> Signed-off-by: Yuping Luo <yuping.luo@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

This is actually such a nice and clean cut that it can be put into
drivers/gpio, it's just using pinctrl, not sharing code or hardware
registers with it. (If I understand correctly.)

Let's check with Grant how he wants these things.

> +#define SIRFSOC_GPIO_IRQ_START ? ? (SIRFSOC_INTENAL_IRQ_END + 1)

This is spelled wrong (inteRnal) but where is that #define coming from
anyway? And is this really used? I think this line can be simply deleted.

> +static inline struct sirfsoc_gpio_bank *sirfsoc_irq_to_bank(unsigned int irq)
> +{
> + ? ? ? return &sgpio_bank[(irq - SIRFSOC_GPIO_IRQ_START) / SIRFSOC_GPIO_BANK_SIZE];
> +}
> +
> +static inline int sirfsoc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> + ? ? ? return SIRFSOC_GPIO_IRQ_START + (chip->base + offset);
> +}

Ick! Can you please use irqdomain for this?

See the recent drivers/gpio/gpio-em.c driver for an excellent example.

> +static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
> +{
> + ? ? ? struct sirfsoc_gpio_bank *bank = sirfsoc_irq_to_bank(d->irq);
> + ? ? ? int idx = sirfsoc_irq_to_offset(d->irq);
> + ? ? ? u32 status, offset;

"status" is a real bad name for this variable since you're not
checking or changing any status by it. Use "val" or something.

> + ? ? ? unsigned long flags;
> +
> + ? ? ? offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
> +
> + ? ? ? spin_lock_irqsave(&sgpio_lock, flags);
> +
> + ? ? ? status = readl(bank->chip.regs + offset);
> + ? ? ? status &= ~SIRFSOC_GPIO_CTL_INTR_STS_MASK;
> +
> + ? ? ? switch (type) {
> + ? ? ? case IRQ_TYPE_NONE:
> + ? ? ? ? ? ? ? break;
> + ? ? ? case IRQ_TYPE_EDGE_RISING:
> + ? ? ? ? ? ? ? status |= (SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
> + ? ? ? ? ? ? ? status &= ~SIRFSOC_GPIO_CTL_INTR_LOW_MASK;
> + ? ? ? ? ? ? ? break;
> + ? ? ? case IRQ_TYPE_EDGE_FALLING:
> + ? ? ? ? ? ? ? status &= ~SIRFSOC_GPIO_CTL_INTR_HIGH_MASK;
> + ? ? ? ? ? ? ? status |= (SIRFSOC_GPIO_CTL_INTR_LOW_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
> + ? ? ? ? ? ? ? break;
> + ? ? ? case IRQ_TYPE_EDGE_BOTH:
> + ? ? ? ? ? ? ? status |=
> + ? ? ? ? ? ? ? ? ? ? ? (SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_LOW_MASK |
> + ? ? ? ? ? ? ? ? ? ? ? ?SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
> + ? ? ? ? ? ? ? break;
> + ? ? ? case IRQ_TYPE_LEVEL_LOW:
> + ? ? ? ? ? ? ? status &= ~(SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
> + ? ? ? ? ? ? ? status |= SIRFSOC_GPIO_CTL_INTR_LOW_MASK;
> + ? ? ? ? ? ? ? break;
> + ? ? ? case IRQ_TYPE_LEVEL_HIGH:
> + ? ? ? ? ? ? ? status |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK;
> + ? ? ? ? ? ? ? status &= ~(SIRFSOC_GPIO_CTL_INTR_LOW_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +
> + ? ? ? writel(status, bank->chip.regs + offset);
> +
> + ? ? ? spin_unlock_irqrestore(&sgpio_lock, flags);
> +
> + ? ? ? return 0;
> +}
(...)
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* Here we must check whether the corresponding GPIO's interrupt
> + ? ? ? ? ? ? ? ?* has been enabled, otherwise just skip it
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? if ((status & 0x1) && (ctrl & SIRFSOC_GPIO_CTL_INTR_EN_MASK)) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_debug("%s: gpio id %d idx %d happens\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, bank->id, idx);
> + ? ? ? ? ? ? ? ? ? ? ? irq =
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (SIRFSOC_GPIO_IRQ_START +
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(bank->id * SIRFSOC_GPIO_BANK_SIZE)) + idx;

So this is where irqdomain makes things simpler.

> + ? ? ? ? ? ? ? ? ? ? ? generic_handle_irq(irq);
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? idx++;
> + ? ? ? ? ? ? ? status = status >> 1;
> + ? ? ? }
> +}

> +static inline void sirfsoc_gpio_set_output(struct sirfsoc_gpio_bank *bank, unsigned offset,
> + ? ? ? int value)
> +{
> + ? ? ? u32 status;

Again what does this has to do with any status...

> +static void sirfsoc_gpio_set_value(struct gpio_chip *chip, unsigned offset,
> + ? ? ? int value)
> +{
> + ? ? ? struct sirfsoc_gpio_bank *bank = sirfsoc_irqchip_to_bank(chip);
> + ? ? ? u32 status;

Neither this.

Apart from that it looks good.

Yours,
Linus Walleij
