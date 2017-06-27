From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 27 Jun 2017 18:11:43 -0500
Subject: [PATCH 2/4] ARM/PCI: mv78xx0: pass pci_ops correctly again
In-Reply-To: <20170622093855.GA23310@red-moon>
References: <20170621215323.3921382-1-arnd@arndb.de>
 <20170621215323.3921382-2-arnd@arndb.de>
 <20170622093855.GA23310@red-moon>
Message-ID: <20170627231143.GI17844@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 10:38:55AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Jun 21, 2017 at 11:53:00PM +0200, Arnd Bergmann wrote:
> > We used to pass the operations when calling pci_scan_root_bus, but
> > that argument was removed:
> > 
> > arch/arm/mach-mv78xx0/pcie.c:175:23: error: 'pcie_ops' defined but not used [-Werror=unused-variable]
> > 
> > Setting it in pci_hw should address this.
> 
> No unfortunately it does not. The way I structured the code the
> bridge set-up is carried out in the struct hw_pci.scan() callback and
> for mv78xx0 it was not done properly.
> 
> As said in the other thread we need a pci_fixup_irqs() removal v3 to
> address these issues, given that on some host bridges v2 it is still
> untested.
> 
> Lorenzo
> 
> > Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/mach-mv78xx0/pcie.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> > index 2b406e909a43..cb7f95c9d8eb 100644
> > --- a/arch/arm/mach-mv78xx0/pcie.c
> > +++ b/arch/arm/mach-mv78xx0/pcie.c
> > @@ -214,6 +214,7 @@ static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
> >  }
> >  
> >  static struct hw_pci mv78xx0_pci __initdata = {
> > +	.ops		= &pcie_ops,
> >  	.nr_controllers	= 8,
> >  	.preinit	= mv78xx0_pcie_preinit,
> >  	.setup		= mv78xx0_pcie_setup,

I provisionally made the following change for mv78xx0, based on similar
hunks for dove, iop13xx, and orion5x.

This is on my pci/enumeration branch:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/enumeration&id=31ddd0eab68e19cf3dfc14321c99ff0b95cda4ad

Please take a look and see if it makes sense.


diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 2b406e909a43..f793ebbd7539 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -201,6 +201,7 @@ static int __init mv78xx0_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 		return -EINVAL;
 	}
 
+	bridge->ops = &pcie_ops;
 	return pci_scan_root_bus_bridge(bridge);
 }
 
