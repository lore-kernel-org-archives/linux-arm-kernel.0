From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 6 Jan 2012 17:12:12 +0100
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <20120106160744.GA7687@codeaurora.org>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <20120106160744.GA7687@codeaurora.org>
Message-ID: <20120106161212.GA5593@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* David Brown wrote:
> On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
> > diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
> > index 0a11342..a50c7e2 100644
> > --- a/arch/arm/mach-msm/board-msm8x60.c
> > +++ b/arch/arm/mach-msm/board-msm8x60.c
> > @@ -84,8 +84,11 @@ static void __init msm8x60_dt_init(void)
> >  
> >  	node = of_find_matching_node_by_address(NULL, msm_dt_gic_match,
> >  			MSM8X60_QGIC_DIST_PHYS);
> > -	if (node)
> > -		irq_domain_add_simple(node, GIC_SPI_START);
> > +	if (node) {
> > +		struct irq_domain *domain = irq_domain_add_simple(node,
> > +				GIC_SPI_START, NR_MSM_IRQS);
> > +		WARN_ON(IS_ERR(domain));
> > +	}
> >  
> >  	if (of_machine_is_compatible("qcom,msm8660-surf")) {
> >  		printk(KERN_INFO "Init surf UART registers\n");
> 
> This is probably a consequence of MSM not really being "simple", but
> just using that.  However, NR_MSM_IRQS is only the number of IRQs on
> the MSM core.  There are also GPIO irqs, and potentially board IRQs
> (the board has an I2C-based chip with a bunch of IRQ lines on it).
> 
> The only define that captures this now is 'NR_IRQS', even though we're
> trying to get rid of that.
> 
> Ultimately, the correct answer will be to get the various interrupt
> controllers using their own domains,

Yes.

> but for now, this needs to be a larger value to avoid missing a bunch of
> the interrupts.

Okay, I'll make it NR_IRQS then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/337e705a/attachment.sig>
