From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 8 Jul 2014 16:37:37 -0600
Subject: [PATCH v8 8/9] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <20140708222738.GA4980@e106497-lin.cambridge.arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-9-git-send-email-Liviu.Dudau@arm.com>
 <20140708010103.GD22939@google.com>
 <20140708102940.GZ6501@e106497-lin.cambridge.arm.com>
 <20140708213305.GB4555@google.com>
 <20140708222738.GA4980@e106497-lin.cambridge.arm.com>
Message-ID: <20140708223737.GA19512@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 11:27:38PM +0100, Liviu Dudau wrote:
> On Tue, Jul 08, 2014 at 10:33:05PM +0100, Bjorn Helgaas wrote:
> > On Tue, Jul 08, 2014 at 11:29:40AM +0100, Liviu Dudau wrote:
> > > On Tue, Jul 08, 2014 at 02:01:04AM +0100, Bjorn Helgaas wrote:
> > > > On Tue, Jul 01, 2014 at 07:43:33PM +0100, Liviu Dudau wrote:
> > > > > ...
> > > > > +int __weak pcibios_fixup_bridge_ranges(struct list_head *resources)
> > > > > +{
> > > > > +     return 0;
> > > > > +}
> > > > 
> > > > I'd wait to add this until there's a platform that needs to implement it.
> > > > Splitting it out will make this patch that much smaller and easier to
> > > > understand.
> > > 
> > > I need this as this is the default implementation (i.e. do nothing). Otherwise the
> > > link phase will give errors. 
> > 
> > I meant that you could remove the default implementation *and* the call of
> > it, since it currently does nothing.
> 
> True. But it looks like converting Will's pci-host-generic.c driver will make use of this.

I think we should move this part of the patch to the conversion of
that driver.  That will keep related changes grouped together, which 
makes them easier to review and easier to backport, e.g., to distro
kernels.

> > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > index 7e7b939..556dc5f 100644
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -402,6 +402,7 @@ struct pci_host_bridge {
> > > > >       struct device dev;
> > > > >       struct pci_bus *bus;            /* root bus */
> > > > >       int domain_nr;
> > > > > +     resource_size_t io_base;        /* physical address for the start of I/O area */
> > > > 
> > > > I don't see where this is used yet.
> > > 
> > > It's used in pci_host_bridge_of_get_ranges() (earlier in this patch).
> > 
> > of_create_pci_host_bridge() fills in bridge->io_base, but I don't see
> > anything that ever *reads* bridge->io_base.
> 
> Ah, understood. It is used by the host bridge drivers to set their ATR registers to the
> correct CPU address values.

Same applies here.

Bjorn
