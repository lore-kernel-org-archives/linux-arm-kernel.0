From: rric@kernel.org (Robert Richter)
Date: Mon, 22 Sep 2014 17:29:48 +0200
Subject: [PATCH v11 10/10] PCI: Introduce pci_remap_iospace() for
 remapping PCI I/O bus resources into CPU space
In-Reply-To: <201409200420.31433.arnd@arndb.de>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-11-git-send-email-Liviu.Dudau@arm.com>
 <20140919215400.GA30239@google.com>
 <201409200420.31433.arnd@arndb.de>
Message-ID: <20140922152948.GB20256@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.09.14 04:20:31, Arnd Bergmann wrote:
> On Friday 19 September 2014, Bjorn Helgaas wrote:
> > On Thu, Sep 18, 2014 at 02:30:25AM +0100, Liviu Dudau wrote:
> 
> > PCI_IOBASE is a virtual address.  So PCI_IOBASE + res->start is also a
> > virtual address (only for IORESOURCE_IO).
> > 
> > Since res->start is normally a *physical* address, I think it would be less
> > confusing to do something like this:
> > 
> >     vaddr = PCI_IOBASE + res->start;
> >     ioremap_page_range(vaddr, vaddr + resource_size(res), ...);
> > 
> > so we have a hint that the first two ioremap_page_range() parameters are
> > virtual addresses.  It's also confusing that it uses "unsigned long" for
> > the virtual addresses, when we usually use "void *".  But that's out of
> > scope for this patch.
> 
> Good idea. I think it will have to be (unsigned long)PCI_IOBASE above then,
> since ioremap_page_range takes a 'unsigned long' virtual address and PCI_IOBASE
> should really remain an __iomem pointer.

Right, I see this warning here:

drivers/pci/pci.c: In function ?pci_remap_iospace?:
drivers/pci/pci.c:2728:8: warning: assignment makes integer from pointer without a cast [enabled by default]

-Robert
