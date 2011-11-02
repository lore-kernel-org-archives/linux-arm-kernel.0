From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 13:40:24 +0000
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20110929093009.GM17204@pulham.picochip.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
Message-ID: <20111102134024.GE19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:30:09AM +0100, Jamie Iles wrote:
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +static void vic_single_handle_irq(struct vic_device *vic, struct pt_regs *regs)
> +{
> +	u32 stat, irq;
> +
> +	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> +	while (stat) {
> +		irq = ffs(stat) - 1;
> +		handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> +		stat &= ~(1 << irq);
> +	}
> +}
> +
> +asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
> +{
> +	int i;
> +
> +	for (i = 0; i < vic_id; ++i)
> +		vic_single_handle_irq(&vic_devices[i], regs);
> +}

And if we receive another interrupt after the read of the register, we'll
have to exit all the way back (possibly to userspace) before re-entering
the IRQ handling paths back to this point to process it.

Is there any particular reason folk are destroying the built-in efficiency
of the IRQ handling which is common-place in the existing assembly
approach?
