From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 16 Jan 2013 19:31:01 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <20130116161716.GA10630@arm.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130115154038.GA11241@arm.com>
 <20130115211441.GA13139@avionic-0098.adnet.avionic-design.de>
 <201301161400.26587.arnd@arndb.de> <20130116161716.GA10630@arm.com>
Message-ID: <20130116183101.GA28660@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 04:17:16PM +0000, Andrew Murray wrote:
> On Wed, Jan 16, 2013 at 02:00:26PM +0000, Arnd Bergmann wrote:
> > On Tuesday 15 January 2013, Thierry Reding wrote:
> > > Is there actually hardware that supports this? I assumed that the MSI
> > > controller would have to be tightly coupled to the PCI host bridge in
> > > order to raise an interrupt when an MSI is received via PCI.
> > 
> > No, as long as it's guaranteed that the MSI notification won't arrive
> > at the CPU before any inbound DMA data before it, the MSI controller
> > can be anywhere. Typically, the MSI controller is actually closer to
> > the CPU core than to the PCI bridge. On X86, I believe the MSI address
> > is on normally on the the "local APIC" on each CPU.
> 
> MSIs are indistinguishable from other memory-write transactions originating
> from the RC other than the address they target. Anything that can capture
> that write in the address space (even a page fault) could be an MSI controller
> and call interrupt handlers. And so the RC / MSI controllers don't need to
> be aware of each other.

Alright, putting the functions into pci_ops doesn't sound like a very
good idea then. Or perhaps it would make sense for hardware where the
root complex and the MSI controller are handled by the same driver.
Basically it could be done as a shortcut and if those are not filled
in, the drivers could still opt to look up an MSI controller from a
phandle specified in DT.

Even another alternative would be to keep the functions within the
struct pci_ops and use generic ones if an external MSI controller is
used. Just tossing around ideas.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/a8d52504/attachment.sig>
