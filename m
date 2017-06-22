From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Jun 2017 10:38:55 +0100
Subject: [PATCH 2/4] ARM/PCI: mv78xx0: pass pci_ops correctly again
In-Reply-To: <20170621215323.3921382-2-arnd@arndb.de>
References: <20170621215323.3921382-1-arnd@arndb.de>
 <20170621215323.3921382-2-arnd@arndb.de>
Message-ID: <20170622093855.GA23310@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 11:53:00PM +0200, Arnd Bergmann wrote:
> We used to pass the operations when calling pci_scan_root_bus, but
> that argument was removed:
> 
> arch/arm/mach-mv78xx0/pcie.c:175:23: error: 'pcie_ops' defined but not used [-Werror=unused-variable]
> 
> Setting it in pci_hw should address this.

No unfortunately it does not. The way I structured the code the
bridge set-up is carried out in the struct hw_pci.scan() callback and
for mv78xx0 it was not done properly.

As said in the other thread we need a pci_fixup_irqs() removal v3 to
address these issues, given that on some host bridges v2 it is still
untested.

Lorenzo

> Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-mv78xx0/pcie.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> index 2b406e909a43..cb7f95c9d8eb 100644
> --- a/arch/arm/mach-mv78xx0/pcie.c
> +++ b/arch/arm/mach-mv78xx0/pcie.c
> @@ -214,6 +214,7 @@ static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
>  }
>  
>  static struct hw_pci mv78xx0_pci __initdata = {
> +	.ops		= &pcie_ops,
>  	.nr_controllers	= 8,
>  	.preinit	= mv78xx0_pcie_preinit,
>  	.setup		= mv78xx0_pcie_setup,
> -- 
> 2.9.0
> 
