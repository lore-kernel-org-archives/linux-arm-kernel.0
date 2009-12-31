From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Dec 2009 15:36:56 +1100
Subject: [PATCH] PCI Domains Support
In-Reply-To: <4B3C1C66.5050203@ms1.techarea.org>
References: <4B28EB0F.3070409@ms1.techarea.org>
	<20091217000620.GC22449@verge.net.au>
	<4B2A2B92.6020809@ms1.techarea.org>
	<20091220012728.GD12578@verge.net.au>
	<4B2F0EF9.101@ms1.techarea.org>
	<20091222045540.GB4411@verge.net.au>
	<4B35356D.7090604@ms1.techarea.org>
	<20091223040710.GA3352@verge.net.au>
	<4B3C1C66.5050203@ms1.techarea.org>
Message-ID: <20091231043656.GB30174@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2009 at 11:37:10AM +0800, Richard Liu wrote:
> Dear Simon:
> 
>     Regenerate the patch.

Thanks, looks good.

Acked-by: Simon Horman <horms@verge.net.au>

> 
> --
>  arch/arm/Kconfig                |    3 +++
>  arch/arm/include/asm/mach/pci.h |    6 ++++++
>  arch/arm/include/asm/pci.h      |    5 +++++
>  arch/arm/kernel/bios32.c        |   17 +++++++++++++++++
>  4 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 233a222..cd3756c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -957,6 +957,9 @@ config PCI
>        your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
>        VESA. If you have PCI, say Y, otherwise N.
>  
> +config PCI_DOMAINS
> +        depends on PCI
> +
>  config PCI_SYSCALL
>      def_bool PCI
>  
> diff --git a/arch/arm/include/asm/mach/pci.h
> b/arch/arm/include/asm/mach/pci.h
> index a38bdc7..e6f3ad7 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -20,6 +20,9 @@ struct hw_pci {
>      void        (*postinit)(void);
>      u8        (*swizzle)(struct pci_dev *dev, u8 *pin);
>      int        (*map_irq)(struct pci_dev *dev, u8 slot, u8 pin);
> +#ifdef CONFIG_PCI_DOMAINS
> +    int        nr_domains;
> +#endif
>  };
>  
>  /*
> @@ -37,6 +40,9 @@ struct pci_sys_data {
>                      /* IRQ mapping                */
>      int        (*map_irq)(struct pci_dev *, u8, u8);
>      struct hw_pci    *hw;
> +#ifdef CONFIG_PCI_DOMAINS
> +    int        domain;
> +#endif
>  };
>  
>  /*
> diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
> index 226cddd..6937d58 100644
> --- a/arch/arm/include/asm/pci.h
> +++ b/arch/arm/include/asm/pci.h
> @@ -23,6 +23,11 @@ static inline void pcibios_penalize_isa_irq(int irq,
> int active)
>      /* We don't do dynamic PCI IRQ allocation */
>  }
>  
> +#ifdef CONFIG_PCI_DOMAINS
> +int pci_domain_nr(struct pci_bus *bus);
> +int pci_proc_domain(struct pci_bus *bus);
> +#endif
> +
>  /*
>   * The PCI address space does equal the physical memory address space.
>   * The networking and block device layers use this boolean for bounce
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 8096819..3a784a1 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -531,6 +531,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
>          sys->busnr   = busnr;
>          sys->swizzle = hw->swizzle;
>          sys->map_irq = hw->map_irq;
> +        sys->domain  = hw->nr_domains;
>          sys->resource[0] = &ioport_resource;
>          sys->resource[1] = &iomem_resource;
>  
> @@ -694,3 +695,19 @@ int pci_mmap_page_range(struct pci_dev *dev, struct
> vm_area_struct *vma,
>  
>      return 0;
>  }
> +#ifdef CONFIG_PCI_DOMAINS
> +int pci_domain_nr(struct pci_bus *bus)
> +{
> +
> +        struct pci_sys_data *sd = bus->sysdata;
> +        return sd->domain;
> +
> +}
> +EXPORT_SYMBOL(pci_domain_nr);
> +
> +int pci_proc_domain(struct pci_bus *bus)
> +{
> +        return pci_domain_nr(bus);
> +}
> +EXPORT_SYMBOL(pci_proc_domain);
> +#endif
> 
