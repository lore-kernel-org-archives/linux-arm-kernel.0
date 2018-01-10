From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 9 Jan 2018 19:11:36 -0600
Subject: [PATCH v2 1/7] PCI: aardvark: fix logic in PCI configuration
 read/write functions
In-Reply-To: <20180109174918.5c4b9ee6@windsurf.lan>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-2-thomas.petazzoni@free-electrons.com>
 <20171005172330.GP25517@bhelgaas-glaptop.roam.corp.google.com>
 <20180109174918.5c4b9ee6@windsurf.lan>
Message-ID: <20180110011136.GB157182@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Lorenzo, since he takes care of this now]

On Tue, Jan 09, 2018 at 05:49:18PM +0100, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> Again, reviving this very old thread :-)
> 
> On Thu, 5 Oct 2017 12:23:30 -0500, Bjorn Helgaas wrote:
> 
> > > -	if (PCI_SLOT(devfn) != 0) {
> > > +	if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {  
> > 
> > I'm fine with this, but please take a look at these:
> > 
> >   8e7ca8ca5fd8 PCI: xilinx: Relax device number checking to allow SR-IOV
> >   e18934b5e9c7 PCI: designware: Relax device number checking to allow SR-IOV
> >   d99e30b7936a PCI: altera: Relax device number checking to allow SR-IOV
> > 
> > and make sure that reasoning doesn't apply here, too.
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8e7ca8ca5fd8
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e18934b5e9c7
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d99e30b7936a
> 
> The original code for xilinx/designware/altera was doing:
> 
>  	if (bus->number == port->root_busno && devfn > 0)
>  		return false;
>  
> 	if (bus->primary == port->root_busno && devfn > 0)
> 		return false;
> 
> I.e, it was checking both if bus->number *and* bus->primary were equal
> to port->root_busno.
> 
> The commit you points removed the check on bus->primary, keeping the
> check on bus->number.
> 
> Your patch for the Aadvark driver only adds a check on bus->number, i.e
> exactly what the xilinx/designware/altera code is still doing today:

This is a long time ago and I could have forgotten, but I don't think
this is *my* patch, is it?  

> Altera:
> 
>         /* access only one slot on each root port */
>         if (bus->number == pcie->root_bus_nr && dev > 0)
>                 return false;
> 
> Designware:
> 
>         /* access only one slot on each root port */
>         if (bus->number == pp->root_bus_nr && dev > 0)
>                 return 0;
> 
> Xilinx:
> 
>         /* Only one device down on each root port */
>         if (bus->number == port->root_busno && devfn > 0)
>                 return false;
> 
> Aardvark (with our patch):
> 
>         if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {
>                 *val = 0xffffffff;
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>         }
> 
> So we're doing exactly the same thing.
> 
> Do you agree ?

I do agree.  I can't remember what I was thinking when I first
responded.

I *would* suggest making an advk_pcie_valid_device() so your structure
matches the other drivers.  I know it seems trivial when you're mostly
looking at one driver, but it really helps those who pay attention to
all of them.

Bjorn
