From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Jun 2013 12:53:11 +0200
Subject: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <000001ce68d7$ca762200$5f626600$@samsung.com>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <13685067.uPzcc2y1CU@wuerfel>
 <000001ce68d7$ca762200$5f626600$@samsung.com>
Message-ID: <20130614105310.GA19060@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:18:46PM +0900, Jingoo Han wrote:
> On Thursday, June 13, 2013 11:14 PM, Arnd Bergmann wrote:
> > On Thursday 13 June 2013 22:22:31 Jingoo Han wrote:
[...]
> > > +static int __exit exynos_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct pcie_port *pp = platform_get_drvdata(pdev);
> > > +
> > > +	clk_disable_unprepare(pp->bus_clk);
> > > +	clk_disable_unprepare(pp->clk);
> > > +
> > > +	return 0;
> > > +}
> > 
> > You also don't remove the PCI devices here, as mentioned in an earlier
> > review.
> 
> I reviewed Marvell PCIe driver and Tegra PCIe driver; however,
> I cannot know what you mean.
> 
> Could let me know which additional functions are needed?

We don't currently do that on Tegra either. pci-mvebu doesn't do that
either, but they don't implement the driver's .remove() in the first
place.

I think the biggest missing piece is pci_common_exit(), the counterpart
of pci_common_init(), to cleanup a host bridge on ARM. I haven't looked
in detail at the other architectures, but I suspect there must be some
code to call when a host bridge is removed.

Looking at drivers/pci/remove.c, it seems like pci_remove_root_bus()
might be what we're looking at. It isn't exported so it can't be used by
modules, but that can be changed. Is that how a host bridge is typically
removed from the system?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/87654f11/attachment-0001.sig>
