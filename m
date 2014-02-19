From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Feb 2014 15:17:56 +0100
Subject: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140219110718.GD28173@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <20140218191023.GG2010@mudshark.cambridge.arm.com>
 <20140219110718.GD28173@mudshark.cambridge.arm.com>
Message-ID: <2724033.O0vxCdfViQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 February 2014 11:07:19 Will Deacon wrote:
> On Tue, Feb 18, 2014 at 07:10:23PM +0000, Will Deacon wrote:
> > On Tue, Feb 18, 2014 at 01:46:44PM +0000, Arnd Bergmann wrote:
> > > On Tuesday 18 February 2014 12:20:43 Will Deacon wrote:
> > > > + /* Register our I/O and Memory resources */
> > > > + res_valid = 0;
> > > > + list_for_each_entry(win, &pci->host.windows, list) {
> > > > +         struct resource *parent;
> > > > +
> > > > +         if (resource_type(win->res) == IORESOURCE_IO) {
> > > > +                 parent = &ioport_resource;
> > > > +                 err = pci_ioremap_io(win->offset, win->res->start);
> > > 
> > > and consequently pass the pci_addr rather than the offset here. How about
> > > moving the pci_ioremap_io() call into gen_pci_alloc_io_offset()?
> 
> I've probably just confused myself, but passing the pci_addr to
> pci_ioremap_io doesn't make sense to me. 

I think the confusion is that there are two different things we call
offset here. The calculation of the offset you pass into
pci_ioremap_io() is correct AFAICT now, but it's not what you are
supposed to pass into pci_add_resource_offset() or what we normally
put into pci_host_bridge_window->offset.

> My understanding is that:
> 
>   cpu = bus + offset

Right. This would be the case for mem_offset.

> In the case of I/O, the offset is really:
> 
>   offset = (PCI_IO_VIRT_BASE - bus) + window

I can't seem to make sense of this calculation. PCI_IO_VIRT_BASE
is a pointer to the start of the virtual window. You can add offsets
to the pointer, but subtracting a number from it is not a well-defined
operation.

> where window is determined by the simple allocator I wrote.

And your allocator calls it offset, which is what confused me.

> Now, the __io macro takes care of PCI_IO_VIRT_BASE so we don't actually care
> about that when adding the PCI I/O resources, instead we'll just pass:
> 
>   offset = window - bus

Yes, this would be the io_offset that you pass into pci_add_resource_offset().

> and then pci_ioremap_io will just want the window offset, since that's added
> directly on to PCI_IO_VIRT_BASE for the ioremap_page_range.

Yes.

> If I call pci_ioremap_io(range->pci_addr, ...) then I'm going to trip a BUG_ON
> unless the pci_addr is within IO_SPACE_LIMIT.

range->pci_addr is what you call 'bus' above. Since you want 'window', you
have to pass 'bus'+'offset', or 'range->pci_addr + io_offset'. Normally, one
of the two would be zero, while the other is equal to 'window'.

	Arnd
