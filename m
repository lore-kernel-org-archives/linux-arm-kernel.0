From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Sep 2011 21:18:02 +0100
Subject: [RFC PATCH 01/14] ARM: GIC: Add global gic_handle_irq() function
In-Reply-To: <1316796692-15964-2-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
	<1316796692-15964-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110923201802.GS17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 05:51:19PM +0100, Marc Zyngier wrote:
> +		if (irqnr < 16) {
> +			writel_relaxed(irqstat, gic_cpu_base_addr + GIC_CPU_EOI);
> +#ifdef CONFIG_SMP
> +			do_IPI(irqnr, regs);
> +#endif

This doesn't work.  do_IPI is marked as an entry function, and so expects
to be called with the precondition that the pt_regs are stored immediately
above its stack frame, without another function's stack frame in the way.
