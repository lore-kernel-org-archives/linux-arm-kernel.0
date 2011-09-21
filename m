From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Sep 2011 12:55:59 -0500
Subject: [PATCH 3/3] ARM: gic: add OF based initialization
In-Reply-To: <4E7A1BCA.1090006@ti.com>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
	<1316550244-3655-4-git-send-email-robherring2@gmail.com>
	<4E7A1BCA.1090006@ti.com>
Message-ID: <4E7A252F.2000402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On 09/21/2011 12:15 PM, Cousson, Benoit wrote:
> Hi Rob,
> 
> I'm testing that series with OMAP4 but have some issues for the moment :-(
> 
> [    0.000000] WARNING: at kernel/irq/irqdomain.c:34 gic_of_init+0x10c/0x180()
> [    0.000000] error: irq_desc already assigned to a domain
> [    0.000000] Modules linked in:
> [    0.000000] [<c001b284>] (unwind_backtrace+0x0/0xf0) from [<c0051c34>] (warn_slowpath_common+0x4c/0x64)
> [    0.000000] [<c0051c34>] (warn_slowpath_common+0x4c/0x64) from [<c0051ce0>] (warn_slowpath_fmt+0x30/0x40)
> [    0.000000] [<c0051ce0>] (warn_slowpath_fmt+0x30/0x40) from [<c05f6874>] (gic_of_init+0x10c/0x180)
> [    0.000000] [<c05f6874>] (gic_of_init+0x10c/0x180) from [<c05fa2e0>] (omap_gic_of_init+0x8/0x28)
> [    0.000000] [<c05fa2e0>] (omap_gic_of_init+0x8/0x28) from [<c0616b44>] (of_irq_init+0x148/0x28c)
> [    0.000000] [<c0616b44>] (of_irq_init+0x148/0x28c) from [<c05f3074>] (init_IRQ+0x14/0x1c)
> [    0.000000] [<c05f3074>] (init_IRQ+0x14/0x1c) from [<c05f0650>] (start_kernel+0x184/0x2fc)
> [    0.000000] [<c05f0650>] (start_kernel+0x184/0x2fc) from [<80008040>] (0x80008040)
>  
> I'm not super familiar with all the irq stuff but I'm wondering if there is not something wrong with the test that print that message:
> 
> void irq_domain_add(struct irq_domain *domain)
> {
> 	struct irq_data *d;
> 	int hwirq;
> 
> 	/*
> 	 * This assumes that the irq_domain owner has already allocated
> 	 * the irq_descs.  This block will be removed when support for dynamic
> 	 * allocation of irq_descs is added to irq_domain.
> 	 */
> 	for (hwirq = 0; hwirq < domain->nr_irq; hwirq++) {
> 		d = irq_get_irq_data(irq_domain_to_irq(domain, hwirq));
> 		if (d || d->domain) {
> 			/* things are broken; just report, don't clean up */
> 			WARN(1, "error: irq_desc already assigned to a domain");
> 			return;
> 		}
> [...]
> 
> Is the (d || d->domain) correct? Shouldn't it be (d && d->domain)?
> 
> But since that used to work properly, I have some doubt. Moreover the driver will not even get the proper interrupt later...
> 
> Do you have any clue?

I fixed that in the prior series and tglx picked it up, so I did not
repost. It should hit mainline for 3.1, but I haven't verified if it is
in yet. Sorry for the confusion, I should have mentioned that.

Rob
