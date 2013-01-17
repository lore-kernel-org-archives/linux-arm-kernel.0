From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 17 Jan 2013 17:05:02 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <20130117154236.GA25943@arm.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130115154038.GA11241@arm.com>
 <20130115211441.GA13139@avionic-0098.adnet.avionic-design.de>
 <201301161400.26587.arnd@arndb.de> <20130116161716.GA10630@arm.com>
 <20130116183101.GA28660@avionic-0098.adnet.avionic-design.de>
 <20130117154236.GA25943@arm.com>
Message-ID: <20130117160501.GC2186@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 03:42:36PM +0000, Andrew Murray wrote:
> On Wed, Jan 16, 2013 at 06:31:01PM +0000, Thierry Reding wrote:
> > Alright, putting the functions into pci_ops doesn't sound like a very
> > good idea then. Or perhaps it would make sense for hardware where the
> > root complex and the MSI controller are handled by the same driver.
> > Basically it could be done as a shortcut and if those are not filled
> > in, the drivers could still opt to look up an MSI controller from a
> > phandle specified in DT.
> > 
> > Even another alternative would be to keep the functions within the
> > struct pci_ops and use generic ones if an external MSI controller is
> > used. Just tossing around ideas.
> 
> I think an ideal solution would be for additional logic in drivers/msi.c
> (e.g. in functions like msi_capability_init) to determine (based on the
> passed in pci_dev) which MSI controller ops to use. I'm not sure the best
> way to implement an association between an MSI controller and PCI busses
> (I believe arch/sparc does something like this - perhaps there will be
> inspiration there).
> 
> As you've pointed out, most RCs will have their own MSI controllers - so
> it should be easy to register and associate both together.
> 
> I've submitted my previous work on MSI controller registration, but it
> doesn't quite solve this problem - perhaps it can be a starting point?

We basically have two cases:

  - The PCI host bridge contains registers for MSI support. In that case
    it makes little sense to uncouple the MSI implementation from the
    host bridge driver.

  - An MSI controller exists outside of the PCI host bridge. The PCI
    host bridge would in that case have to lookup an MSI controller (via
    DT phandle or some other method).

In either of those cases, does it make sense to use the MSI support
outside the scope of the PCI infrastructure? That is, would devices
other than PCI devices be able to generate an MSI?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/4b916113/attachment.sig>
