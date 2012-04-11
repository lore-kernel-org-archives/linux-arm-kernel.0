From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Apr 2012 00:03:20 +0100
Subject: [PATCH 2/3] plat-versatile: modernize FPGA IRQ controller
In-Reply-To: <1334184240-18898-1-git-send-email-linus.walleij@linaro.org>
References: <1334184240-18898-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120411230319.GE24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 12:44:00AM +0200, Linus Walleij wrote:
> @@ -12,10 +15,14 @@
>  #define IRQ_ENABLE_SET		0x08
>  #define IRQ_ENABLE_CLEAR	0x0c
>  
> +/* we cannot allocate memory when VICs are initially registered */

They aren't VICs.  A VIC is a totally different interrupt controller.

> +static struct fpga_irq_data fpga_irq_devices[CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR];
> +static int fpga_irq_id;
> +
>  static void fpga_irq_mask(struct irq_data *d)
>  {
>  	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
> -	u32 mask = 1 << (d->irq - f->irq_start);
> +	u32 mask = (1 << d->hwirq);

1 << d->hwirq will do, no need for excessive parens here.

> +/*
> + * Handle each interrupt in a single FPGA IRQ controller.  Returns non-zero
> + * if we've handled at least one interrupt.  This does a single read of the
> + * status register and handles all interrupts in order from LSB first.
> + */
> +static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
>  {
> +	int handled = 0;
> +	int irq;
> +	u32 status = readl(f->base + IRQ_STATUS);
> +
> +	while (status) {
> +		irq = ffs(status) - 1;
> +		handle_IRQ(irq_find_mapping(f->domain, irq), regs);
> +		status &= ~(1 << irq);
> +		handled = 1;
> +	}
> +
> +	return handled;

Buggy.  See what happens when you cache the status register, and
handle_IRQ enables interrupts after processing the first IRQ to do
soft IRQ processing.
