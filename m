From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 15 Aug 2012 02:22:50 +0300
Subject: [PATCH v2 11/31] arm64: IRQ handling
In-Reply-To: <1344966752-16102-12-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-12-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120814232250.GB747@harshnoise.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 14, 2012 at 06:52:12PM +0100, Catalin Marinas wrote:
> +void handle_IRQ(unsigned int irq, struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	irq_enter();
> +
> +	/*
> +	 * Some hardware gives randomly wrong interrupts.  Rather
> +	 * than crashing, do something sensible.
> +	 */
> +	if (unlikely(irq >= nr_irqs)) {
> +		if (printk_ratelimit())
> +			pr_warning("Bad IRQ%u\n", irq);

I guess pr_warn_ratelimited() should be used for new code.

(See include/linux/printk.h, "Please don't use printk_ratelimit()...")

A.
