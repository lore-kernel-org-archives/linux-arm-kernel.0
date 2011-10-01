From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 1 Oct 2011 21:30:03 +0800
Subject: [PATCH v4 3/7] arm/imx: add gic_handle_irq function
In-Reply-To: <20110929142729.GM19318@S2100-06.ap.freescale.net>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
	<1317200808-6275-4-git-send-email-shawn.guo@linaro.org>
	<20110929093409.GG23944@n2100.arm.linux.org.uk>
	<20110929142729.GM19318@S2100-06.ap.freescale.net>
Message-ID: <20111001133002.GK19807@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:27:30PM +0800, Shawn Guo wrote:
> On Thu, Sep 29, 2011 at 10:34:09AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Sep 28, 2011 at 05:06:44PM +0800, Shawn Guo wrote:
> > > +#ifdef CONFIG_SMP
> > > +		else if (irqnr < 16) {
> > > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > > +						GIC_CPU_EOI);
> > > +			do_IPI(irqnr, regs);
> > > +		}
> > > +#endif
> > > +#ifdef CONFIG_LOCAL_TIMERS
> > > +		else if (irqnr == 29) {
> > > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > > +						GIC_CPU_EOI);
> > > +			do_local_timer(regs);
> > > +		}
> > > +#endif
> > 
> > As I've said for similar patches. neither of these two functions are
> > designed to be called from another C function (because they're marked
> > __exception or __exception_irq_entry).  Both of these markers tell the
> > unwinder that a struct pt_regs is located directly above the functions
> > stack frame.
> > 
> I'm also wondering the consequence of not doing so, because we are
> seeing icip_handle_irq() and ichp_handle_irq() (arch/arm/mach-pxa/irq.c)
> are doing the same thing, and we are not running into any problem with
> above code.
> 
Sorry.  Please ignore the above.

-- 
Regards,
Shawn
