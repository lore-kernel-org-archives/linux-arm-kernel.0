From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 22:40:35 +0200
Subject: [PATCH V6 08/13] PCI: generic,
 thunder: update to use generic ECAM API
In-Reply-To: <20160428201439.GD25125@localhost>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <8950494.UV8UrWiFbx@wuerfel> <20160428201439.GD25125@localhost>
Message-ID: <5813591.CkzahFEfSl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 15:14:39 Bjorn Helgaas wrote:
> On Thu, Apr 21, 2016 at 11:36:53AM +0200, Arnd Bergmann wrote:
> > On Thursday 21 April 2016 11:28:15 Tomasz Nowicki wrote:
> > > On 19.04.2016 15:06, Arnd Bergmann wrote:
> > > > On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
> > > >>
> > > >> Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.
> > > >>
> > > >> pci-thunder-ecam.c contains config space accessors. Similar for
> > > >> pci-thunder-pem.c but it also has extra init call (it is now called
> > > >> thunder_pem_init) which finds and maps related registers.
> > > >
> > > > They seem to do much more than just override the accessors, they actually
> > > > change the contents of the config space as well. Is that really necessary
> > > > on ACPI based systems as well?
> > > 
> > > Yes, the pci-thunder-ecam.c accessors are meant to emulate config space 
> > > capabilities. They are necessary to synthesize EA capabilities (fixed 
> > > PCI BARs), it wont work without this, for ACPI boot as well.
> > 
> > Why is that? I thought the BARs never get reassigned when using ACPI,
> 
> In general, there's no reason we can't reassign BARs, whether we're
> using DT, ACPI, or whatever.  In many cases, systems with ACPI also
> assign all the BARs in firmware, and Linux doesn't reassign them
> unless it needs to.  But that's just a coincidence.  There's no
> requirement that Linux leave BARs as firmware programmed them.

I'm thought I've seen systems in which the ACPI BIOS assumes that
certain PCI devices never move around, because it pokes the registers
from AML, and changing them would require never using the same device
through ACPI. It's likely that this is against some standard, but that
won't help you if you have to deal with the system anyway.

	Arnd
