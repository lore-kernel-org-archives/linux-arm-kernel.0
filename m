From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jul 2013 08:54:31 +0200
Subject: [PATCHv5 05/11] of: pci: add registry of MSI chips
In-Reply-To: <20130728162711.32a9a21e@skate>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E41F7A.4010502@gmail.com> <20130728043310.6CF1D3E08FE@localhost>
 <20130728162711.32a9a21e@skate>
Message-ID: <20130729065431.GA1115@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 04:27:11PM +0200, Thomas Petazzoni wrote:
> Dear Grant Likely,
> 
> Thanks for your feedback! Some comments below.
> 
> On Sat, 27 Jul 2013 22:33:10 -0600, Grant Likely wrote:
> 
> > > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > 
> > > Acked-by: Rob Herring <rob.herring@calxeda.com>
> > 
> > Actually, I'm going to disagree on this one and say NAK. I don't think
> > it is a good idea to create a completely separate registry of msi_chips
> > for binding to dt nodes. I think it would be better to include the
> > msi_chip pointer directly into the irq_domain which has to be there
> > anyway. It then becomes another feature for irq controllers if it can
> > support doing MSI.
> 
> The problem that this patch tries to solve is how can the PCIe driver
> work get a pointer to the msi_chip structure from the DT device node
> pointed to by the 'msi-parent' property. I.e, we have:
> 
> 	interrupt-parent = <&mpic>;
> 
> 	mpic {
> 		reg = <...>;
> 		compatible = "...";
> 		interrupt-controller;
> 		msi-controller;
> 	};
> 
> 	pcie-controller {
> 		msi-parent = <&mpic>;
> 	};
> 
> The 'mpic' driver registers two irq_domains, one for the "normal"
> interrupts, and one for the MSI interrupts. Both irq_domain cannot be
> associated to the same &mpic node, or the irq_domain lookup for
> interrupt-parent and msi-parent is going to be confused.
> 
> In the very first version of this patch set, I was using two separate
> DT device nodes to avoid this problem:
> 
> 	interrupt-parent = <&mpic>;
> 
> 	interrupt-controller {
> 		reg = <...>;
> 		compatible = "...";
> 
> 		mpic {
> 			interrupt-controller;
> 		};
> 
> 		msi {
> 			msi-controller;
> 		};
> 	};
> 
> 	pcie-controller {
> 		msi-parent = <&msi>;
> 	};
> 
> This way, each of the two irq_domain was associated to a distinct DT
> device node, and everything was working fine. But during the review, I
> was pointed by Arnd that it wasn't the proper way of describing the
> interrupt controller, and that there should be only one DT device node
> having both the interrupt-controller and msi-controller roles.
> 
> So what is your suggestion to allow the PCIe controller to retrieve the
> correct irq_domain if we have only one DT node for the IRQ controller
> that registers two irq_domains ?

If I understand correctly, Grant isn't objecting to the introduction of
the lookup function, but rather its implementation. You could add a
pointer to a struct msi_chip within struct irq_domain and then iterate
over all irq_domain instances (see irq_find_host()) and find one which
has the correct device_node pointer and the msi_chip pointer set.

So I think that pretty much boils down to setting the (new) .msi_chip
field of armada_370_xp_msi_domain to the newly allocated MSI chip in
armada_370_xp_msi_init() and modify the lookup function to use the
irq_domain_list instead of the list of of_pci_msi_chip_list(). And a
whole lot of the infrastructure code can go away because it's already
there for irq_domain.

The good thing about it is that it couples the MSI chip more strongly
with its associated IRQ domain. And as a bonus we get to omit the list
and of_node fields from struct msi_chip. =)

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/3994fc92/attachment.sig>
