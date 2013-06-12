From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Jun 2013 23:23:10 +0200
Subject: [PATCH v3 07/12] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <51B89D26.9070605@wwwdotorg.org>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
 <1365000318-28256-8-git-send-email-thierry.reding@avionic-design.de>
 <516C46BC.2040707@wwwdotorg.org> <20130612122959.GA32444@manwe>
 <51B89D26.9070605@wwwdotorg.org>
Message-ID: <20130612212308.GA27681@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:09:10AM -0600, Stephen Warren wrote:
> On 06/12/2013 06:30 AM, Thierry Reding wrote:
> > On Mon, Apr 15, 2013 at 12:28:12PM -0600, Stephen Warren wrote:
> >> On 04/03/2013 08:45 AM, Thierry Reding wrote:
> >>> Move the PCIe driver from arch/arm/mach-tegra into the
> >>> drivers/pci/host directory. The motivation is to collect
> >>> various host controller drivers in the same location in order
> >>> to facilitate refactoring.
> >>> 
> >>> The Tegra PCIe driver has been largely rewritten, both in order
> >>> to turn it into a proper platform driver and to add MSI (based
> >>> on code by Krishna Kishore <kthota@nvidia.com>) as well as
> >>> device tree support.
> ...
> >>> +static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
> >> ...
> >>> +	return IRQ_HANDLED;
> >> 
> >> Shouldn't this function return IRQ_NONE if no MSI status bits
> >> were found set?
> > 
> > The IRQ isn't marked IRQF_SHARED, so I don't think this is needed.
> 
> Isn't it still useful to detect unexpected/stuck interrupts?

Yes, you're right. I can't think of a nicer way to do it, though, so
I'll go with a processed IRQ counter or a flag.

> >>> +static int tegra_pcie_probe(struct platform_device *pdev)
> >> ...
> >>> +	pcibios_min_mem = 0;
> >> 
> >> What does that mean/do? I wonder if that should be set to
> >> 0x80000000 by the Tegra30 patches?
> > 
> > ARM defines PCIBIOS_MIN_MEM to that variable. That macro in turn is
> > only used by pci_bus_alloc_resource() AFAICT, which uses it to
> > override the start of a resource when allocating if res->start ==
> > 0. As such it designates a lower-bound of valid PCI memory
> > addresses, so 0 on Tegra20 and 0x80000000 on Tegra30 don't seem
> > like good values. Maybe we need to set them to the lowest of the
> > prefetchable and non-prefetchable memory areas as defined in the
> > DT?
> > 
> > It doesn't currently seem to matter at all, though, since we never
> > pass in a range that's 0, so the start address of resources can
> > never be 0 and therefore PCIBIOS_MIN_MEM is never used.
> 
> Hmmm. I guess ignore it then. If the value won't ever be used, 0 is as
> good a value as any?

Alright, I'll do that then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/328c88ca/attachment.sig>
