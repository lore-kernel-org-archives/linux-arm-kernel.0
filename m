From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 14:44:53 +0000
Subject: [Xen-devel] [PATCH v3 54/62] arm/acpi: Create min DT stub for Dom0
In-Reply-To: <1447753261-7552-55-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-55-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271436570.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Create a DT for Dom0 for ACPI-case only. DT contains minimal required
> informations such as Dom0 bootargs, initrd, efi description table and
> address of uefi memory table.
> 
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

We should add a document under docs/misc/arm/device-tree for these
bindings.  This is an external interface maintained by Xen for
compatibility.


>  xen/arch/arm/domain_build.c | 142 ++++++++++++++++++++++++++++++++++++++++++++
>  xen/common/efi/boot.c       |  47 +++++++++++++++
>  xen/include/asm-arm/setup.h |   2 +
>  3 files changed, 191 insertions(+)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index 55f85b4..6d8536b 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -1358,6 +1358,144 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
>  
>  #ifdef CONFIG_ACPI
>  #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
> +#define ACPI_DOM0_FDT_MIN_SIZE 4096
> +
> +static int make_chosen_node(const struct kernel_info *kinfo,
> +                            struct membank tbl_add[])
> +{
> +    int res;
> +    const char *bootargs = NULL;
> +    const struct bootmodule *mod = kinfo->kernel_bootmodule;
> +    void *fdt = kinfo->fdt;
> +
> +    DPRINT("Create chosen node\n");
> +    res = fdt_begin_node(fdt, "chosen");
> +    if ( res )
> +        return res;
> +
> +    if ( mod && mod->cmdline[0] )
> +    {
> +        bootargs = &mod->cmdline[0];
> +        res = fdt_property(fdt, "bootargs", bootargs, strlen(bootargs) + 1);
> +        if ( res )
> +           return res;
> +    }
> +
> +    /*
> +     * If the bootloader provides an initrd, we must create a placeholder
> +     * for the initrd properties. The values will be replaced later.
> +     */
> +    if ( mod && mod->size )
> +    {
> +        u64 a = 0;
> +        res = fdt_property(kinfo->fdt, "linux,initrd-start", &a, sizeof(a));
> +        if ( res )
> +            return res;
> +
> +        res = fdt_property(kinfo->fdt, "linux,initrd-end", &a, sizeof(a));
> +        if ( res )
> +            return res;
> +    }
> +
> +    res = fdt_end_node(fdt);
> +
> +    return res;
> +}
> +
> +static int acpi_make_hypervisor_node(const struct kernel_info *kinfo,
> +                                     struct membank tbl_add[])
> +{
> +    const char compat[] =
> +        "xen,xen-"__stringify(XEN_VERSION)"."__stringify(XEN_SUBVERSION)"\0"
> +        "xen,xen";
> +    int res;
> +    /* Convenience alias */
> +    void *fdt = kinfo->fdt;
> +
> +    DPRINT("Create hypervisor node\n");
> +
> +    /* See linux Documentation/devicetree/bindings/arm/xen.txt */
> +    res = fdt_begin_node(fdt, "hypervisor");
> +    if ( res )
> +        return res;
> +
> +    /* Cannot use fdt_property_string due to embedded nulls */
> +    res = fdt_property(fdt, "compatible", compat, sizeof(compat));
> +    if ( res )
> +        return res;
> +
> +    res = arm_acpi_make_efi_nodes(fdt, tbl_add);
> +    if ( res )
> +        return res;
> +
> +    res = fdt_end_node(fdt);
> +
> +    return res;
> +}
> +
> +/*
> + * Prepare a minimal DTB for Dom0 which contains bootargs, initrd, memory
> + * information, EFI table.
> + */
> +static int create_acpi_dtb(struct kernel_info *kinfo, struct membank tbl_add[])
> +{
> +    int new_size;
> +    int ret;
> +
> +    DPRINT("Prepare a min DTB for DOM0\n");
> +
> +    /* Allocate min size for DT */
> +    new_size = ACPI_DOM0_FDT_MIN_SIZE;
> +    kinfo->fdt = xmalloc_bytes(new_size);
> +
> +    if ( kinfo->fdt == NULL )
> +        return -ENOMEM;
> +
> +    /* Create a new empty DT for DOM0 */
> +    ret = fdt_create(kinfo->fdt, new_size);
> +    if ( ret < 0 )
> +        goto err;
> +
> +    ret = fdt_finish_reservemap(kinfo->fdt);
> +    if ( ret < 0 )
> +        goto err;
> +
> +    ret = fdt_begin_node(kinfo->fdt, "/");
> +    if ( ret < 0 )
> +        goto err;
> +
> +    ret = fdt_property_cell(kinfo->fdt, "#address-cells", 2);
> +    if ( ret )
> +        return ret;
> +
> +    ret = fdt_property_cell(kinfo->fdt, "#size-cells", 1);
> +    if ( ret )
> +        return ret;
> +
> +    /* Create a chosen node for DOM0 */
> +    ret = make_chosen_node(kinfo, tbl_add);
> +    if ( ret )
> +        goto err;
> +
> +    ret = acpi_make_hypervisor_node(kinfo, tbl_add);
> +    if ( ret )
> +        goto err;
> +
> +    ret = fdt_end_node(kinfo->fdt);
> +    if ( ret < 0 )
> +        goto err;
> +
> +    ret = fdt_finish(kinfo->fdt);
> +    if ( ret < 0 )
> +        goto err;
> +
> +    return 0;
> +
> +  err:
> +    printk("Device tree generation failed (%d).\n", ret);
> +    xfree(kinfo->fdt);
> +    return -EINVAL;
> +}
>  
>  static void acpi_map_rest_tables(struct domain *d)
>  {
> @@ -1755,6 +1893,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>          return rc;
>      }
>  
> +    rc = create_acpi_dtb(kinfo, tbl_add);
> +    if ( rc != 0 )
> +        return rc;
> +
>      return 0;
>  }
>  #else
> diff --git a/xen/common/efi/boot.c b/xen/common/efi/boot.c
> index ff2faed..d233cef 100644
> --- a/xen/common/efi/boot.c
> +++ b/xen/common/efi/boot.c
> @@ -1304,6 +1304,53 @@ void __init acpi_create_efi_mmap_table(paddr_t paddr, void *efi_acpi_table,
>          memory_map[offset].Attribute = EFI_MEMORY_WB;
>      }
>  }
> +
> +/* Create place holder for efi values. */
> +int __init arm_acpi_make_efi_nodes(void *fdt, struct membank tbl_add[])
> +{
> +    u64 fdt_val64;
> +    u32 fdt_val32;
> +    int desc_ver = mdesc_ver;
> +    int res;
> +
> +    res = fdt_begin_node(fdt, "uefi");
> +    if ( res )
> +        return res;
> +
> +    fdt_val64 = cpu_to_fdt64(tbl_add[TBL_EFIT].start);
> +    res = fdt_property(fdt, "xen,uefi-system-table",
> +                       &fdt_val64, sizeof(fdt_val64));
> +    if ( res )
> +        return res;
> +
> +    fdt_val64 = cpu_to_fdt64(tbl_add[TBL_MMAP].start);
> +    res = fdt_property(fdt, "xen,uefi-mmap-start",
> +                       &fdt_val64,  sizeof(fdt_val64));
> +    if ( res )
> +        return res;
> +
> +    fdt_val32 = cpu_to_fdt32(tbl_add[TBL_MMAP].size);
> +    res = fdt_property(fdt, "xen,uefi-mmap-size",
> +                       &fdt_val32,  sizeof(fdt_val32));
> +    if ( res )
> +        return res;
> +
> +    fdt_val32 = cpu_to_fdt32(sizeof(EFI_MEMORY_DESCRIPTOR));
> +    res = fdt_property(fdt, "xen,uefi-mmap-desc-size",
> +                         &fdt_val32, sizeof(fdt_val32));
> +    if ( res )
> +        return res;
> +
> +    fdt_val32 = cpu_to_fdt32(desc_ver);
> +    res = fdt_property(fdt, "xen,uefi-mmap-desc-ver",
> +                         &fdt_val32, sizeof(fdt_val32));
> +    if ( res )
> +        return res;
> +
> +    res = fdt_end_node(fdt);
> +
> +    return res;
> +}

This function shouldn't be in this file.


>  #endif
>  
>  #ifndef CONFIG_ARM /* TODO - runtime service support */
> diff --git a/xen/include/asm-arm/setup.h b/xen/include/asm-arm/setup.h
> index 35447ee..c4cf5ea 100644
> --- a/xen/include/asm-arm/setup.h
> +++ b/xen/include/asm-arm/setup.h
> @@ -60,6 +60,8 @@ void acpi_create_efi_mmap_table(paddr_t paddr, void *efi_acpi_table,
>                                  const struct meminfo *mem,
>                                  struct membank tbl_add[]);
>  
> +int arm_acpi_make_efi_nodes(void *fdt, struct membank tbl_add[]);
> +
>  int construct_dom0(struct domain *d);
>  
>  void discard_initial_modules(void);
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
