From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 10:34:09 +0100
Subject: [PATCH v4 3/7] arm/imx: add gic_handle_irq function
In-Reply-To: <1317200808-6275-4-git-send-email-shawn.guo@linaro.org>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
	<1317200808-6275-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110929093409.GG23944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 05:06:44PM +0800, Shawn Guo wrote:
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
> +		}
> +#endif

As I've said for similar patches. neither of these two functions are
designed to be called from another C function (because they're marked
__exception or __exception_irq_entry).  Both of these markers tell the
unwinder that a struct pt_regs is located directly above the functions
stack frame.
