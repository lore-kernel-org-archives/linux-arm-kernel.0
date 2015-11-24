From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Nov 2015 08:28:01 +0000
Subject: [PATCH v2 3/5] pinctrl: meson: enable GPIO IRQs
In-Reply-To: <1448273816-11290-4-git-send-email-carlo@caione.org>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
 <1448273816-11290-4-git-send-email-carlo@caione.org>
Message-ID: <20151124082801.09139a93@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov 2015 11:16:54 +0100
Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
> 
> On Meson8 and Meson8b SoCs there are 8 independent filtered GPIO
> interrupt modules that can be programmed to use any of the GPIOs in the
> chip as an interrupt source.
> 
> For each GPIO IRQ we have:
> 
> GPIOs --> [mux]--> [polarity]--> [filter]--> [edge select]--> GIC
> 
> The eight GPIO interrupts respond to mask/unmask/clear/etc.. just like
> any other interrupt in the chip. The difference for the GPIO interrupts
> is that they can be filtered and conditioned.
> 
> This patch adds support for the external GPIOs interrupts and enables
> them for Meson8 and Meson8b SoCs.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> 
> ---

[...]

> +	for (i = 0; i < pc->num_gic_irqs; i++) {
> +		struct of_phandle_args oirq;
> +
> +		of_irq_parse_one(node, i, &oirq);
> +		irq_of_phandle_args_to_fwspec(&oirq, &pc->gic_irqs[i]);
> +
> +		pc->irq_map[i] = IRQ_FREE;
> +	}

The whole thing feels weird. Why do you need to keep a set of fwspecs?
All you need is a range of interrupts that would be conveniently
represented by a bitmap (assuming your interrupts space is a mostly
contiguous range).

Overall, this patch is quite hard to review. Can you please split the
GPIO management from the irqchip side?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
