From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Apr 2016 11:38:40 +0200
Subject: [PATCH v2 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <1459436979-17275-3-git-send-email-mcoquelin.stm32@gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1459436979-17275-3-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdaiE1cJM6uq_bQuRS2NJTwniPREBsgwuxEjRjB5yTfc9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 5:09 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> +static void stm32_irq_handler(struct irq_desc *desc)
> +{
> +       struct irq_domain *domain = irq_desc_get_handler_data(desc);
> +       struct irq_chip_generic *gc = domain->gc->gc[0];
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       unsigned long pending;
> +       int n;
> +
> +       chained_irq_enter(chip, desc);
> +
> +       pending = irq_reg_readl(gc, EXTI_PR);
> +       for_each_set_bit(n, &pending, BITS_PER_LONG) {
> +               generic_handle_irq(irq_find_mapping(domain, n));
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}

Is this one of those cases where you should re-read the status register
on every iteration, so as to avoid exiting and immediately re-entering
the irq handler?

C.g irq-vic.c:

static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
{
        u32 stat, irq;
        int handled = 0;

        while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
                irq = ffs(stat) - 1;
                handle_domain_irq(vic->domain, irq, regs);
                handled = 1;
        }

        return handled;
}

Yours,
Linus Walleij
