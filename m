From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Tue, 21 Jul 2015 11:26:27 +0800
Subject: [PATCH v3 1/5] ARM/PCI: remove align_resource callback in
 pcibios_align_resource
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D5F503@lhreml503-mbs>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
 <1435743817-19083-2-git-send-email-wangzhou1@hisilicon.com>
 <20150702175056.GX944@e106497-lin.cambridge.arm.com>
 <559B6721.4080305@hisilicon.com>
 <20150707092220.GA980@e106497-lin.cambridge.arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D5F503@lhreml503-mbs>
Message-ID: <55ADBBE3.70204@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/7/17 18:02, Gabriele Paoloni wrote:
> The following patch is maybe a better solution
> 
> Gab
>

Hi Gab,

Many thanks for your patch, I think this patch is cleaner than 1/4 in v2 patchset.
I will merge this one in my new series.

Thanks?
Zhou

> -----------------------
> This patch is needed in order to unify the PCIe designware
> framework for ARM and ARM64 architectures.
> In the PCIe designware unification process we are calling
> pci_create_root_bus() passing a "sysdata" parameter
> that is the same for both ARM and ARM64 and is of type
> "struct pcie_port*". In the ARM case this will cause
> a problem with the function pcibios_align_resource();
> in fact this will cast "dev->sysdata" to "struct pci_sys_data*",
> whereas designware had passed a "struct pcie_port*" pointer.
> 
> This patch solves the issue by removing "align_resource" from
> "pci_sys_data" struct and defining a static global function pointer
> in "bios32.c"
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
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
> 
