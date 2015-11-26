From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 16:39:14 +0000
Subject: [PATCH v3 40/62] arm/acpi: Estimate memory required for acpi/efi
 tables
In-Reply-To: <1447753261-7552-41-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-41-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261622080.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Estimate the memory required for loading acpi/efi tables in Dom0. Alloc
> the pages to store the new created EFI and ACPI tables and free these
> pages when destroying domain.

Could you please explain what you are page aligning exactly and why?


> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/domain.c       |  4 +++
>  xen/arch/arm/domain_build.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-
>  xen/common/efi/boot.c       | 21 ++++++++++++
>  xen/include/asm-arm/setup.h |  2 ++
>  4 files changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/xen/arch/arm/domain.c b/xen/arch/arm/domain.c
> index 880d0a6..10c58c4 100644
> --- a/xen/arch/arm/domain.c
> +++ b/xen/arch/arm/domain.c
> @@ -638,6 +638,10 @@ void arch_domain_destroy(struct domain *d)
>      domain_vgic_free(d);
>      domain_vuart_free(d);
>      free_xenheap_page(d->shared_info);
> +#ifdef CONFIG_ACPI
> +    free_xenheap_pages(d->arch.efi_acpi_table,
> +                       get_order_from_bytes(d->arch.efi_acpi_len));
> +#endif
>  }
>  
>  void arch_domain_shutdown(struct domain *d)
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index 0c3441a..b5ed44c 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -12,6 +12,8 @@
>  #include <xen/libfdt/libfdt.h>
>  #include <xen/guest_access.h>
>  #include <xen/iocap.h>
> +#include <xen/acpi.h>
> +#include <acpi/actables.h>
>  #include <asm/device.h>
>  #include <asm/setup.h>
>  #include <asm/platform.h>
> @@ -1354,6 +1356,78 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
>      return -EINVAL;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static int estimate_acpi_efi_size(struct domain *d, struct kernel_info *kinfo)
> +{
> +    u64 efi_size, acpi_size = 0, addr;
> +    u32 madt_size;
> +    struct acpi_table_rsdp *rsdp_tbl;
> +    struct acpi_table_header *table = NULL;
> +
> +    efi_size = estimate_efi_size(kinfo->mem.nr_banks);
> +
> +    acpi_size += PAGE_ALIGN(sizeof(struct acpi_table_fadt));
> +    acpi_size += PAGE_ALIGN(sizeof(struct acpi_table_stao));
> +
> +    madt_size = sizeof(struct acpi_table_madt)
> +                + sizeof(struct acpi_madt_generic_interrupt) * d->max_vcpus
> +                + sizeof(struct acpi_madt_generic_distributor);
> +    if ( d->arch.vgic.version == GIC_V3 )
> +        madt_size += sizeof(struct acpi_madt_generic_redistributor)
> +                     * d->arch.vgic.nr_regions;
> +    acpi_size += PAGE_ALIGN(madt_size);

are the MADT and FADT tables guaranteed to be on separate pages or is it
just an estimate?


> +    addr = acpi_os_get_root_pointer();
> +    if ( !addr )
> +    {
> +        printk("Unable to get acpi root pointer\n");
> +        return -EINVAL;
> +    }
> +    rsdp_tbl = acpi_os_map_memory(addr, sizeof(struct acpi_table_rsdp));
> +    table = acpi_os_map_memory(rsdp_tbl->xsdt_physical_address,
> +                               sizeof(struct acpi_table_header));
> +    acpi_size += PAGE_ALIGN(table->length + sizeof(u64));
> +    acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
> +    acpi_os_unmap_memory(rsdp_tbl, sizeof(struct acpi_table_rsdp));
> +
> +    acpi_size += PAGE_ALIGN(sizeof(struct acpi_table_rsdp));
> +    d->arch.efi_acpi_len = PAGE_ALIGN(efi_size) + PAGE_ALIGN(acpi_size);
> +
> +    return 0;
> +}
> +
> +static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
> +{
> +    int rc = 0;
> +    int order;
> +
> +    rc = estimate_acpi_efi_size(d, kinfo);
> +    if ( rc != 0 )
> +        return rc;
> +
> +    order = get_order_from_bytes(d->arch.efi_acpi_len);
> +    d->arch.efi_acpi_table = alloc_xenheap_pages(order, 0);
> +    if ( d->arch.efi_acpi_table == NULL )
> +    {
> +        printk("unable to allocate memory!\n");
> +        return -1;

ENOMEM


> +    }
> +    memset(d->arch.efi_acpi_table, 0, d->arch.efi_acpi_len);
> +
> +    /* For ACPI, Dom0 doesn't use kinfo->gnttab_start to get the grant table
> +     * region. So we use it as the ACPI table mapped address. */
> +    d->arch.efi_acpi_gpa = kinfo->gnttab_start;
> +
> +    return 0;
> +}
> +#else
> +static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
> +{
> +    /* Only booting with ACPI will hit here */
> +    BUG_ON(1);
> +    return -EINVAL;
> +}
> +#endif
>  static void dtb_load(struct kernel_info *kinfo)
>  {
>      void * __user dtb_virt = (void * __user)(register_t)kinfo->dtb_paddr;
> @@ -1540,7 +1614,11 @@ int construct_dom0(struct domain *d)
>      allocate_memory(d, &kinfo);
>      find_gnttab_region(d, &kinfo);
>  
> -    rc = prepare_dtb(d, &kinfo);
> +    if ( acpi_disabled )
> +        rc = prepare_dtb(d, &kinfo);
> +    else
> +        rc = prepare_acpi(d, &kinfo);
> +
>      if ( rc < 0 )
>          return rc;
>  
> diff --git a/xen/common/efi/boot.c b/xen/common/efi/boot.c
> index 53c7452..78d8ae9 100644
> --- a/xen/common/efi/boot.c
> +++ b/xen/common/efi/boot.c
> @@ -13,6 +13,7 @@
>  #include <xen/multiboot.h>
>  #include <xen/pci_regs.h>
>  #include <xen/pfn.h>
> +#include <asm/acpi.h>
>  #if EFI_PAGE_SIZE != PAGE_SIZE
>  # error Cannot use xen/pfn.h here!
>  #endif
> @@ -1171,6 +1172,26 @@ efi_start(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
>      for( ; ; ); /* not reached */
>  }
>  
> +#ifdef CONFIG_ACPI
> +/* Constant to indicate "Xen" in unicode u16 format */
> +static const u16 XEN_EFI_FW_VENDOR[] ={0x0058,0x0065,0x006E,0x0000};
> +
> +int __init estimate_efi_size(int mem_nr_banks)
> +{
> +    int size;
> +    int est_size = sizeof(EFI_SYSTEM_TABLE);
> +    int ect_size = sizeof(EFI_CONFIGURATION_TABLE);
> +    int emd_size = sizeof(EFI_MEMORY_DESCRIPTOR);
> +    int fw_vendor_size = sizeof(XEN_EFI_FW_VENDOR);
> +
> +    size = PAGE_ALIGN(est_size + ect_size + fw_vendor_size)
> +           + PAGE_ALIGN(emd_size *
> +                        (mem_nr_banks + acpi_mem.nr_banks + TBL_MMAX));

Why are they on two separate pages? Is it mandated by the EFI spec?
Why are you adding TBL_MMAX to the multiplicand here?

I don't like that we are passing mem_nr_banks as argument but we are
accessing acpi_mem.nr_banks from the global variable. I would prefer if
they were both passed as arguments.


> +    return size;
> +}
> +#endif
> +
>  #ifndef CONFIG_ARM /* TODO - runtime service support */
>  
>  static bool_t __initdata efi_rs_enable = 1;
> diff --git a/xen/include/asm-arm/setup.h b/xen/include/asm-arm/setup.h
> index 30ac53b..b759813 100644
> --- a/xen/include/asm-arm/setup.h
> +++ b/xen/include/asm-arm/setup.h
> @@ -51,6 +51,8 @@ void arch_init_memory(void);
>  
>  void copy_from_paddr(void *dst, paddr_t paddr, unsigned long len);
>  
> +int estimate_efi_size(int mem_nr_banks);
> +
>  int construct_dom0(struct domain *d);
>  
>  void discard_initial_modules(void);
> -- 
> 2.1.0
> 
