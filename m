From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 23 Jul 2015 19:06:04 +0100
Subject: [PATCH v4 1/5] ARM/PCI: remove align_resource in pci_sys_data
In-Reply-To: <1437461323-3531-2-git-send-email-wangzhou1@hisilicon.com>
References: <1437461323-3531-1-git-send-email-wangzhou1@hisilicon.com>
 <1437461323-3531-2-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <20150723180604.GD23324@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ing Thomas and Jason for pci-mvebu]

On Tue, Jul 21, 2015 at 07:48:39AM +0100, Zhou Wang wrote:
> This patch is needed in order to unify the PCIe designware framework for ARM and
> ARM64 architectures. In the PCIe designware unification process we are calling
> pci_create_root_bus() passing a "sysdata" parameter that is the same for both
> ARM and ARM64 and is of type "struct pcie_port*". In the ARM case this will
> cause a problem with the function pcibios_align_resource(); in fact this will
> cast "dev->sysdata" to "struct pci_sys_data*", whereas designware had passed a
> "struct pcie_port*" pointer.
> 
> This patch solves the issue by removing "align_resource" from "pci_sys_data"
> struct and defining a static global function pointer in "bios32.c"
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Arnd, Rob any opinion on this ? It is really the last blocking bit
to having common ARM/ARM64 drivers (and get rid of pci_sys_data) so I
would like to get this sorted asap (having a global function pointer
might be a temporary solution before moving it to the host bridge
structure).

Comments welcome.

Thanks !
Lorenzo

> ---
>  arch/arm/include/asm/mach/pci.h |  5 -----
>  arch/arm/kernel/bios32.c        | 12 ++++++++----
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 28b9bb3..8a4e4de 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -58,11 +58,6 @@ struct pci_sys_data {
>  					/* IRQ mapping				*/
>  	int		(*map_irq)(const struct pci_dev *, u8, u8);
>  					/* Resource alignement requirements	*/
> -	resource_size_t (*align_resource)(struct pci_dev *dev,
> -					  const struct resource *res,
> -					  resource_size_t start,
> -					  resource_size_t size,
> -					  resource_size_t align);
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index fcbbbb1..4cdc64d 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -17,6 +17,11 @@
>  #include <asm/mach/pci.h>
>  
>  static int debug_pci;
> +static resource_size_t (*align_resource)(struct pci_dev *dev,
> +		  const struct resource *res,
> +		  resource_size_t start,
> +		  resource_size_t size,
> +		  resource_size_t align) = NULL;
>  
>  #ifdef CONFIG_PCI_MSI
>  struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
> @@ -468,7 +473,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> -		sys->align_resource = hw->align_resource;
> +		align_resource = hw->align_resource;
>  		INIT_LIST_HEAD(&sys->resources);
>  
>  		if (hw->private_data)
> @@ -589,7 +594,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				resource_size_t size, resource_size_t align)
>  {
>  	struct pci_dev *dev = data;
> -	struct pci_sys_data *sys = dev->sysdata;
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO && start & 0x300)
> @@ -597,8 +601,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  
>  	start = (start + align - 1) & ~(align - 1);
>  
> -	if (sys->align_resource)
> -		return sys->align_resource(dev, res, start, size, align);
> +	if (align_resource)
> +		return align_resource(dev, res, start, size, align);
>  
>  	return start;
>  }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
