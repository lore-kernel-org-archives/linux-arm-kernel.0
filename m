From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 16 Jul 2013 14:05:10 -0700
Subject: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130716103351.15b0fb50@skate>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
 <20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
 <20130716103351.15b0fb50@skate>
Message-ID: <20130716210509.GA29318@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 10:33:51AM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Mon, 15 Jul 2013 09:27:10 -0700, Thierry Reding wrote:
> 
> > We need at least patches 2, 4 and 8 for Tegra.
> 
> Are you sure you don't want patch 1 ? It allows to replace the
> allocation of MSI interrupt numbers for the MSI driver by a generic
> facility based on irq domains.

Yes, I could use it to replace some of the functionality. I was just
saying that we don't absolutely need it. If it makes things easier for
the merge, it would be trivial to convert the Tegra driver to using the
new generic facility in a follow-up patch.

> > There's still the option
> > of working around patch 8 by using the custom root bus scan function
> > that we have to use anyway, so I guess we could even trim the
> > requirement down to patches 2 and 4 if we really need.
> 
> Bjorn said he didn't like having the msi chip assignment in the middle
> of the root bus scan function, because he was hoping someday to
> refactor this function. Quoting Bjorn:
> 
> """
> > +	bus->msi = pcie->msi;  
> 
> Ideally, arches could use pci_scan_root_bus(), which does the
> pci_scan_child_bus() itself, so I never like to add arch-specific code
> between pci_create_root_bus() and pci_scan_child_bus().
> 
> But you should be able to accomplish this by setting bus->msi in a
> pcibios_add_bus() hook.  There is a corresponding pcibios_remove_bus()
> hook that might be useful for deallocating the msi_chip.  I'm not too
> clear on how you manage the msi_chip lifetime -- I see the alloc in
> armada_370_xp_msi_init(), but I'm not sure whether you ever deallocate
> it or how you know when it would be safe to do so.
> """
> 
> This is from:
> 
> Subject: Re: [PATCH v2 6/8] pci: mvebu: add support for MSI
> Date: Tue, 18 Jun 2013 16:57:11 -0600

Yes, I'm aware of that discussion. However we currently need to have the
custom root bus scan implementation anyway because pci_scan_root_bus()
just doesn't work on ARM. So again, since we'll have to rework the
driver anyway in order to use pci_scan_root_bus() once the issues have
been resolved, it wouldn't hurt to postpone the transition to the new
ARM pcibios_add_bus() support until that point.

All I was trying to do was reduce the list of common dependencies in an
attempt to make merging it easier.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/917057ff/attachment.sig>
