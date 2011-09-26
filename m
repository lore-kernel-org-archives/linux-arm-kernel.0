From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 14:10:36 +0100
Subject: [PATCH] ARM i.MX gic: add handle_irq function
In-Reply-To: <1316797284-21010-1-git-send-email-shawn.guo@linaro.org>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
	<1316797284-21010-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110926131036.GI22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 01:01:24AM +0800, Shawn Guo wrote:
> +#ifdef CONFIG_SMP
> +		else if (irqnr < 16) {
> +			writel_relaxed(irqstat, gic_cpu_base_addr +
> +						GIC_CPU_EOI);
> +			do_IPI(irqnr, regs);
> +		}
> +#endif
> +#ifdef CONFIG_LOCAL_TIMERS
> +		else if (irqnr == 29) {
> +			writel_relaxed(irqstat, gic_cpu_base_addr +
> +						GIC_CPU_EOI);
> +			do_local_timer(regs);

Neither of these two functions are designed to be called from C code.
Notice that they are marked __exception or __exception_irq_entry, and
thus they expect to have a pt_regs structure directly above themselves.
