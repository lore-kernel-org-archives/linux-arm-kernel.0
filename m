From: davidb@codeaurora.org (David Brown)
Date: Fri, 6 Jan 2012 10:52:49 -0800
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <4F0720A9.8070400@gmail.com>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <20120106160744.GA7687@codeaurora.org> <4F0720A9.8070400@gmail.com>
Message-ID: <20120106185249.GA10668@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 10:26:17AM -0600, Rob Herring wrote:
> On 01/06/2012 10:07 AM, David Brown wrote:
> > On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
> >> diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
> >> index 0a11342..a50c7e2 100644
> >> --- a/arch/arm/mach-msm/board-msm8x60.c
> >> +++ b/arch/arm/mach-msm/board-msm8x60.c
> >> @@ -84,8 +84,11 @@ static void __init msm8x60_dt_init(void)
> >>  
> >>  	node = of_find_matching_node_by_address(NULL, msm_dt_gic_match,
> >>  			MSM8X60_QGIC_DIST_PHYS);
> >> -	if (node)
> >> -		irq_domain_add_simple(node, GIC_SPI_START);
> >> +	if (node) {
> >> +		struct irq_domain *domain = irq_domain_add_simple(node,
> >> +				GIC_SPI_START, NR_MSM_IRQS);
> >> +		WARN_ON(IS_ERR(domain));
> >> +	}
> >>  
> >>  	if (of_machine_is_compatible("qcom,msm8660-surf")) {
> >>  		printk(KERN_INFO "Init surf UART registers\n");
> > 
> > This is probably a consequence of MSM not really being "simple", but
> > just using that.  However, NR_MSM_IRQS is only the number of IRQs on
> > the MSM core.  There are also GPIO irqs, and potentially board IRQs
> > (the board has an I2C-based chip with a bunch of IRQ lines on it).
> > 
> > The only define that captures this now is 'NR_IRQS', even though we're
> > trying to get rid of that.
> > 
> > Ultimately, the correct answer will be to get the various interrupt
> > controllers using their own domains, but for now, this needs to be a
> > larger value to avoid missing a bunch of the interrupts.
> 
> No. This should only be the number of interrupts for a controller as the
> interrupt numbers in the device tree should be relative to a controller
> and not the Linux virq number. The numbering in the dts needs to be
> correct. You don't need a domain until you start getting the interrupts
> from the dts.

Yes, _should only be_.  And, you're probably right that we shouldn't
change this, and should use the NR_MSM_IRQS.  When a DTS device needs
to use a GPIO IRQ, the GPIO controller should properly register its
own domain.  The only IRQ in the DT is an MSM IRQ, so this doesn't
actually break anything.

So, Thierry, please leave it as NR_MSM_IRQS as in your original
patch.  In that form.

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
