From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 23 Jul 2015 10:10:18 -0500
Subject: [RFT PATCH] ARM: pci: kill pcibios_msi_controller
In-Reply-To: <20150722124929.GA537@red-moon>
References: <1436784206-14414-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150722090248.GA344@red-moon> <55AF6149.4000601@arm.com>
 <20150722124929.GA537@red-moon>
Message-ID: <20150723151018.GY21967@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 01:49:29PM +0100, Lorenzo Pieralisi wrote:

> > >> @@ -483,14 +471,25 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> > >>  				break;
> > >>  			}
> > >>  
> > >> -			if (hw->scan)
> > >> +			if (hw->scan) {
> > >>  				sys->bus = hw->scan(nr, sys);
> > >> -			else
> > >> -				sys->bus = pci_scan_root_bus(parent, sys->busnr,
> > >> -						hw->ops, sys, &sys->resources);
> > >> +				if (!sys->bus)
> > >> +					panic("PCI: unable to scan bus!");
> > 
> > This was in the original code, but I have to ask: Do we really want to
> > panic the kernel if we couldn't scan the bus? Worse case, the system
> > won't be able to boot at all and will panic somewhere else anyway, but
> > we should give the user a chance to understand what's happening...
> 
> No, it was in the original code but I was very tempted to remove it
> or merge the error paths and make it a warning, and that's what I am
> going to do, unless someone complains (that panic statement has been there
> forever).

I agree the panic should be removed.  I would do it in a separate patch
since it's not related to your main objective here.

Bjorn
