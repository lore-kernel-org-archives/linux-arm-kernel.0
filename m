From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jul 2014 08:47:40 +0200
Subject: [PATCH v8 8/9] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <20140708225755.GE4980@e106497-lin.cambridge.arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <20140708223737.GA19512@google.com>
 <20140708225755.GE4980@e106497-lin.cambridge.arm.com>
Message-ID: <201407090847.41303.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 July 2014, Liviu Dudau wrote:
> On Tue, Jul 08, 2014 at 11:37:37PM +0100, Bjorn Helgaas wrote:
> > On Tue, Jul 08, 2014 at 11:27:38PM +0100, Liviu Dudau wrote:
> > > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > > > index 7e7b939..556dc5f 100644
> > > > > > > --- a/include/linux/pci.h
> > > > > > > +++ b/include/linux/pci.h
> > > > > > > @@ -402,6 +402,7 @@ struct pci_host_bridge {
> > > > > > >       struct device dev;
> > > > > > >       struct pci_bus *bus;            /* root bus */
> > > > > > >       int domain_nr;
> > > > > > > +     resource_size_t io_base;        /* physical address for the start of I/O area */
> > > > > > 
> > > > > > I don't see where this is used yet.
> > > > > 
> > > > > It's used in pci_host_bridge_of_get_ranges() (earlier in this patch).
> > > > 
> > > > of_create_pci_host_bridge() fills in bridge->io_base, but I don't see
> > > > anything that ever reads bridge->io_base.
> > > 
> > > Ah, understood. It is used by the host bridge drivers to set their ATR registers to the
> > > correct CPU address values.

Actually, as we just discovered with one of the pci_dw drivers, it may
be the wrong number: what you program in the ATR registers is not
necessarily the same as the address visible to the CPU. What you need
instead is the address at the bus immediately above the PCI host bridge.

I think for now we can leave out this part from common code and add
the infrastructure later. Host drivers can have their own loop
around the ranges if they need to set up these registers. Ideally
at least on arm64, they should be set up by the firmware already.

	Arnd
