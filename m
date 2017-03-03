From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 3 Mar 2017 09:46:28 -0600
Subject: Using the generic host PCIe driver
In-Reply-To: <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
 <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
 <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
Message-ID: <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 01:44:54PM +0100, Mason wrote:
> For now, I have "hidden" the root's BAR0 from the system with:
> 
> 	if (bus->number == 0 && where == PCI_BASE_ADDRESS_0) {
> 		*val = 0;
> 		return PCIBIOS_SUCCESSFUL;
> 	}

I'm scratching my head about this a little.  Here's what your dmesg
log contained originally:

  pci 0000:00:00.0: [1105:8758] type 01 class 0x048000
  pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
  pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
  pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
  pci 0000:00:00.0: PCI bridge to [bus 01]
  pcieport 0000:00:00.0: enabling device (0140 -> 0142)

This device is a bridge (a Root Port, per your lspci output).  With a
BAR, which is legal but unusual.  We couldn't assign space for the
BAR, which means we can't use whatever vendor-specific functionality
it provides.

What's puzzling me is that pcieport was able to enable the device and
turn on PCI_COMMAND_MEMORY (the 0x2 bit).  It seems like this should
have failed because pci_enable_resources() checks to see that all the
BARs have been assigned.

Since this is a bridge, we really *have* to turn on PCI_COMMAND_MEMORY
in order for the bridge to forward memory transactions to its
secondary bus (bus 01).  But we can't safely enable PCI_COMMAND_MEMORY
unless all its memory BARs are assigned.

So it's not safe to hide BAR0 from the PCI core.  That makes Linux
think the BAR doesn't exist, but of course it still exists in the
hardware itself, and it will respond at whatever address it happens to
contain.  In this case, that address happens to be zero, and the host
bridge does not advertise a window that maps to bus address zero, so
you probably won't see a conflict right away, but it's a latent issue
that may come back to bite you some day.

The easiest fix would be for you to increase the host bridge memory
window size.  It's currently [mem 0xa0000000-0xa03fffff], which is
only 4MB, which is *tiny*.  You need 16MB just to contain the bridge
BAR, plus at least 8K for the USB controller.

If you can't make space for a bigger window, it's possible the Root
Port has some device-specific way to disable BAR0 in hardware, e.g.,
some register your firmware or an early Linux quirk could write.  That
would be much safer than enabling an unassigned BAR.

Bjorn
