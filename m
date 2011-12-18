From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 18 Dec 2011 23:01:38 +0100
Subject: [PATCH 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
References: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
Message-ID: <CACRpkdYu7HCBdAzqNr1pwZMgvZFyBYpcJXYo-RUx5R-U3CJ1BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 11:13 AM, Jamie Iles <jamie@jamieiles.com> wrote:

> The Synopsys DesignWare block is used in some ARM devices (picoxcell)
> and can be configured to provide multiple banks of GPIO pins. ?The first
> bank (A) can also provide IRQ capabilities.

Overall this is looking good.

Here is a problem (I think):

> +static int dwapb_irq_set_type(struct irq_data *d, u32 type)
> +{
> + ? ? ? struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> + ? ? ? struct dwapb_gpio *gpio = gc->private;
> + ? ? ? int bit = d->hwirq;
> + ? ? ? unsigned long level, polarity;
> +
> + ? ? ? if (type & ~(IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING |
> + ? ? ? ? ? ? ? ? ? ?IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? level = readl(gpio->regs + INT_TYPE_REG_OFFS);
> + ? ? ? polarity = readl(gpio->regs + INT_POLARITY_REG_OFFS);
> +
> + ? ? ? if (type & IRQ_TYPE_EDGE_RISING) {
> + ? ? ? ? ? ? ? level |= (1 << bit);
> + ? ? ? ? ? ? ? polarity |= (1 << bit);
> + ? ? ? } else if (type & IRQ_TYPE_EDGE_FALLING) {
> + ? ? ? ? ? ? ? level |= (1 << bit);
> + ? ? ? ? ? ? ? polarity &= ~(1 << bit);

So what if you get request for *both* falling and rising edges?

This is not uncommon@all, for example a GPIO which detecs
MMC card insertions and removals like drivers/host/mmc/mmci.c
will want interrupts on both edges since we want to change state
whenever the card is inserted *or* removed.

If you check drivers/gpio/gpio-u300.c you can see how I handled
this on another hardware where triggering on falling and rising
edges was a binary choice and thus mutually exclusive: I toggle
for each interrupt.

See u300_toggle_trigger(), u300_gpio_irq_type().

So either you do something like that, or you detect both set
and return an error, else the poor caller will just get falling
edges in this driver...

> + ? ? ? } else if (type & IRQ_TYPE_LEVEL_HIGH) {
> + ? ? ? ? ? ? ? level &= ~(1 << bit);
> + ? ? ? ? ? ? ? polarity |= (1 << bit);
> + ? ? ? } else if (type & IRQ_TYPE_LEVEL_LOW) {
> + ? ? ? ? ? ? ? level &= ~(1 << bit);
> + ? ? ? ? ? ? ? polarity &= ~(1 << bit);
> + ? ? ? }

This is OK though, these are mutually exclusive.

Yours,
Linus Walleij
