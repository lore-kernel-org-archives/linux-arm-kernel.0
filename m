From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 8 Jun 2013 21:18:59 +0100
Subject: [PATCH] irqchip: Return -EPERM for reserved IRQs
In-Reply-To: <1370696686-1666-1-git-send-email-grant.likely@linaro.org>
References: <1370696686-1666-1-git-send-email-grant.likely@linaro.org>
Message-ID: <CACxGe6v7H35eA1Ry0VqQaxezaeT=TMQnxe+f_WQmroroombeZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 8, 2013 at 2:04 PM, Grant Likely <grant.likely@linaro.org> wrote:
> The irqdomain core will report a log message for any attempted map call
> that fails unless the error code is -EPERM. This patch changes the
> Versatile irq controller drivers to use -EPERM because it is normal for
> a subset of the IRQ inputs to be marked as reserved on the various
> Versatile platforms.
>
> Signed-off-by: Grant Likely <grant.likely@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

I'm going to go ahead and take this one through the irqdomain tree
since it is really an irqdomain bug fix. I'll be sending the pull
request to Linus shortly.

g.

> ---
>  drivers/irqchip/irq-versatile-fpga.c | 2 +-
>  drivers/irqchip/irq-vic.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
> index 065b7a3..47a52ab 100644
> --- a/drivers/irqchip/irq-versatile-fpga.c
> +++ b/drivers/irqchip/irq-versatile-fpga.c
> @@ -119,7 +119,7 @@ static int fpga_irqdomain_map(struct irq_domain *d, unsigned int irq,
>
>         /* Skip invalid IRQs, only register handlers for the real ones */
>         if (!(f->valid & BIT(hwirq)))
> -               return -ENOTSUPP;
> +               return -EPERM;
>         irq_set_chip_data(irq, f);
>         irq_set_chip_and_handler(irq, &f->chip,
>                                 handle_level_irq);
> diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
> index 884d11c..2bbb004 100644
> --- a/drivers/irqchip/irq-vic.c
> +++ b/drivers/irqchip/irq-vic.c
> @@ -197,7 +197,7 @@ static int vic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>
>         /* Skip invalid IRQs, only register handlers for the real ones */
>         if (!(v->valid_sources & (1 << hwirq)))
> -               return -ENOTSUPP;
> +               return -EPERM;
>         irq_set_chip_and_handler(irq, &vic_chip, handle_level_irq);
>         irq_set_chip_data(irq, v->base);
>         set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> --
> 1.8.1.2
>
