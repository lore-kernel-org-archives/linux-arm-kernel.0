From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 8 Aug 2017 15:19:12 -0500
Subject: [PATCH v2 4/5] PCI: mediatek: Add new generation controller
 support
In-Reply-To: <20170804131808.GA16580@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
 <824c61d13fe2731d812df8a0a878ca1a36399e76.1501122135.git.honghui.zhang@mediatek.com>
 <20170803224206.GN20308@bhelgaas-glaptop.roam.corp.google.com>
 <1501835976.24341.21.camel@mtksdaap41>
 <20170804131808.GA16580@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170808201912.GJ16580@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 08:18:09AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 04, 2017 at 04:39:36PM +0800, Honghui Zhang wrote:
> > On Thu, 2017-08-03 at 17:42 -0500, Bjorn Helgaas wrote:

> > > > +	port->irq_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
> > > > +						 &intx_domain_ops, port);
> > > 
> > > I think there's an issue here with a 4-element IRQ domain and the
> > > hwirq numbers 1-4 from the of_irq_parse_and_map_pci() path, so INTD
> > > may not work correctly.
> > > 
> > > See
> > > http://lkml.kernel.org/r/20170801212931.GA26498 at bhelgaas-glaptop.roam.corp.google.com
> > > and related discussion.
> > 
> > Sorry, I did not get this,
> > I do some test with an intel E350T4 PCIe NICs, it's a x1 lane
> > multi-function device.
> > What I got from the log is below:
> > ->of_irq_parse_and_map_pci
> > 	->of_irq_parse_pci
> > 		->irq_create_of_mapping
> > 			->irq_create_fwspec_mapping
> > 				->irq_domain_translate
> > 				which will go through
> > 				d->ops->translate #the hwirq really start from 0
> > 
> > And I tested every NIC port of the Intel E350T4 with tftp transfer data,
> > seems all are OK with this code.
> 
> OK.  I don't know what d->ops->translate is involved here, but if it
> works, I guess this is OK for now.  We're trying to clean this up and
> make it consistent across all the drivers.  Many of them allocate a
> 5-element IRQ domain, some make a 4-element domain, and on some of
> them INTD doesn't work.  It's a mess.

Paul Burton is cleaning this up.  Can you point out the d->ops->translate
function that's involved here?
