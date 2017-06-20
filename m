From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Jun 2017 15:46:31 +0200
Subject: [PATCH v3 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <2934dbf3-e1f0-3997-ba70-3b6a7a2973d9@arm.com>
References: <20170616141923.31226-1-thomas.petazzoni@free-electrons.com>
 <20170616141923.31226-5-thomas.petazzoni@free-electrons.com>
 <2934dbf3-e1f0-3997-ba70-3b6a7a2973d9@arm.com>
Message-ID: <20170620154631.77a1f192@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 19 Jun 2017 18:40:53 +0100, Marc Zyngier wrote:

> > +	if (msg->address_lo) {  
> 
> This should probably test both _lo and _hi.

Not sure what test you want to do on _hi. Since the physical address
I'm using is below the 4 GB boundary, the high bits are all zeroes,
even for a valid address. So to distinguish whether we're configuring
or de-configuring the MSI, I don't see how the address_hi value is
useful.

Am I missing something obvious here?

> > +	*hwirq = fwspec->param[1];
> > +	if (*hwirq < 0 || *hwirq >= ICU_MAX_IRQS) {  
> 
> *hwirq is unlikely to become negative...

Fixed. Weird that gcc didn't complain here. hwirq is a unsigned long*,
so I would have expected gcc to complain when looking at *hwirq < 0.

Anyway, fixed, will be in v4.

> > +	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> > +					    &icu->irq_chip, icu_irqd);
> > +	if (err) {
> > +		dev_err(icu->dev, "failed to set the data to IRQ domain\n");
> > +		goto free_msi;
> > +	}  
> 
> I think you may want to issue a irq_set_type here, because it is not
> completely clear to me if the core code will be doing it by default for
> you...

It's not needed I believe. I've added some trace in gic_set_type(), and
it's really called for every ICU interrupt as expected, as soon as the
interrupt is configured. And indeed, if you look at __setup_irq(), it
calls __irq_set_trigger(), see
http://elixir.free-electrons.com/linux/latest/source/kernel/irq/manage.c#L1309.
I've added a dump_stack() in git_set_type() to make sure when I was
getting called for the SPI interrupts corresponding to the GICP/ICU
stuff. Here is one example, from the XHCI driver:

[    1.815712] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc1 #613
[    1.822180] Hardware name: Marvell Armada 8040 DB board (DT)
[    1.827863] Call trace:
[    1.830329] [<ffff000008088528>] dump_backtrace+0x0/0x228
[    1.835752] [<ffff00000808881c>] show_stack+0x14/0x20
[    1.840828] [<ffff00000838fd80>] dump_stack+0x90/0xb0
[    1.845903] [<ffff0000083bf13c>] gic_set_type+0x94/0x98
[    1.851154] [<ffff00000810e734>] irq_chip_set_type_parent+0x1c/0x30
[    1.857449] [<ffff00000810e734>] irq_chip_set_type_parent+0x1c/0x30
[    1.863743] [<ffff00000810e734>] irq_chip_set_type_parent+0x1c/0x30
[    1.870037] [<ffff00000810d0a0>] __irq_set_trigger+0x60/0x178
[    1.875808] [<ffff00000810d764>] __setup_irq+0x5ac/0x690
[    1.881143] [<ffff00000810da1c>] request_threaded_irq+0xec/0x1c0
[    1.887177] [<ffff0000086a84dc>] usb_add_hcd+0x50c/0x800
[    1.892513] [<ffff0000087052ec>] xhci_plat_probe+0x584/0x768
[    1.898199] [<ffff00000854cc28>] platform_drv_probe+0x58/0xc0
[    1.903969] [<ffff00000854ad74>] driver_probe_device+0x214/0x2d0
[    1.910002] [<ffff00000854aedc>] __driver_attach+0xac/0xb0
[    1.915511] [<ffff000008548ef8>] bus_for_each_dev+0x60/0xa0
[    1.921107] [<ffff00000854a690>] driver_attach+0x20/0x28
[    1.926442] [<ffff00000854a1e0>] bus_add_driver+0x110/0x230
[    1.932038] [<ffff00000854b858>] driver_register+0x60/0xf8
[    1.937547] [<ffff00000854cb5c>] __platform_driver_register+0x44/0x50
[    1.944019] [<ffff000008d41a60>] xhci_plat_init+0x2c/0x34
[    1.949441] [<ffff0000080830f8>] do_one_initcall+0x38/0x120
[    1.955038] [<ffff000008d00ce8>] kernel_init_freeable+0x198/0x238
[    1.961159] [<ffff0000088fe470>] kernel_init+0x10/0x100
[    1.966406] [<ffff000008082ec0>] ret_from_fork+0x10/0x50

So, whenever you do the request_irq(), __setup_irq() calls
__irq_set_trigger(), which ends in the ICU ->irq_set_type(), calling
the GICP MSI domain ->irq_set_type(), calling the GICP inner domain
->irq_set_type(), itself calling the GIC ->irq_set_type().

> > +	icu->gicp = platform_get_drvdata(gicp_pdev);
> > +
> > +	/* Set Clear/Set ICU SPI message address in AP */
> > +	setspi = mvebu_gicp_setspi_phys_addr(icu->gicp);  
> 
> 
> I must say that I find this quite horrible. The idea of digging into the
> internals of another driver and forcing it to blindly dereference a
> pointer feels just wrong.
> 
> Instead, why don't you directly pass the device node, and kindly ask the
> GICP driver to give you the two addresses? Something along the lines of:
> 
> 	err = mvebu_gicp_get_doorbells(gicp_dn, &setspi, &clrspi);
> 	if (err)
> 		[...]
> 
> which at least gives a the GICP driver chance to check that this is
> something it knows about. And you can then drop the icu->gicp field.

ACK, fixed for the next version.

> > +	/*
> > +	 * Clean all ICU interrupts with type SPI_NSR, required to
> > +	 * avoid unpredictable SPI assignments done by firmware.
> > +	 */
> > +	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
> > +		icu_int = readl(icu->base + ICU_INT_CFG(i));
> > +		if ((icu_int >> ICU_GROUP_SHIFT) == ICU_GRP_NSR)
> > +			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
> > +	}  
> 
> I had questions about the safety of this in a previous review. Do you
> have any update? Also, shouldn't you check that same thing in the
> translate callback (so that you detect clashes between firmware and DT)?

I'm still waiting for feedback from Hannah and Yehuda in Cc on this
question. They should answer soon, hopefully.

> Otherwise looking pretty neat.

Thanks again for the review. You can expect v4 today.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
