From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Sep 2011 22:08:05 +0800
Subject: [PATCH v4 3/7] arm/imx: add gic_handle_irq function
In-Reply-To: <20110929093409.GG23944@n2100.arm.linux.org.uk>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
	<1317200808-6275-4-git-send-email-shawn.guo@linaro.org>
	<20110929093409.GG23944@n2100.arm.linux.org.uk>
Message-ID: <20110929140804.GJ19318@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:34:09AM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 28, 2011 at 05:06:44PM +0800, Shawn Guo wrote:
> > +#ifdef CONFIG_SMP
> > +		else if (irqnr < 16) {
> > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > +						GIC_CPU_EOI);
> > +			do_IPI(irqnr, regs);
> > +		}
> > +#endif
> > +#ifdef CONFIG_LOCAL_TIMERS
> > +		else if (irqnr == 29) {
> > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > +						GIC_CPU_EOI);
> > +			do_local_timer(regs);
> > +		}
> > +#endif
> 
> As I've said for similar patches. neither of these two functions are
> designed to be called from another C function (because they're marked
> __exception or __exception_irq_entry).  Both of these markers tell the
> unwinder that a struct pt_regs is located directly above the functions
> stack frame.
> 
Can you please share your position on Marc's PPI and GIC
MULTI_IRQ_HANDLER series?  Are you possibly going to merge them in the
coming merge window?  If you are, I would directly move my imx6q onto
those series and save the local gic_handle_irq().  Otherwise, I may
have to add a wrapper for do_IPI() and do_local_timer() to work around
the pt_regs issue you pointed out here.

-- 
Regards,
Shawn
