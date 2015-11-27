From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 12:10:30 +0000
Subject: [PATCH v3 48/62] arm/acpi: Prepare RSDP table for Dom0
In-Reply-To: <1447753261-7552-49-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-49-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271206210.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Copy RSDP table and replace rsdp->xsdt_physical_address with new address
> of XSDT table, so it can point to the right XSDT table.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/arch/arm/domain_build.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index 894328f..6ae5761 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -1359,6 +1359,38 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
>  #ifdef CONFIG_ACPI
>  #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
>  
> +static int acpi_create_rsdp(struct domain *d, struct membank tbl_add[])
> +{
> +
> +    struct acpi_table_rsdp *rsdp = NULL;
> +    u64 addr;
> +    u64 table_size = sizeof(struct acpi_table_rsdp);
> +    u8 *base_ptr;
> +    u8 checksum;
> +
> +    addr = acpi_os_get_root_pointer();
> +    if( !addr )
> +        panic("Unable to get acpi root pointer\n");
> +
> +    rsdp = acpi_os_map_memory(addr, table_size);
> +    base_ptr = d->arch.efi_acpi_table
> +               + acpi_get_table_offset(tbl_add, TBL_RSDP);
> +    ACPI_MEMCPY(base_ptr, rsdp, table_size);
> +    acpi_os_unmap_memory(rsdp, table_size);
> +
> +    rsdp = (struct acpi_table_rsdp *)base_ptr;
> +    /* Replace xsdt_physical_address */
> +    rsdp->xsdt_physical_address = tbl_add[TBL_XSDT].start;
> +    checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, rsdp), table_size);
> +    rsdp->checksum = rsdp->checksum - checksum;

You always did -= checksum in the other functions, let's keep a
consistent style.


> +
> +    tbl_add[TBL_RSDP].start = d->arch.efi_acpi_gpa
> +                              + acpi_get_table_offset(tbl_add, TBL_RSDP);
> +    tbl_add[TBL_RSDP].size = table_size;
> +
> +    return 0;
> +}
> +
>  static void acpi_xsdt_modify_entry(u64 entry[], unsigned long entry_count,
>                                     char *signature, u64 addr)
>  {
> @@ -1675,6 +1707,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>      if ( rc != 0 )
>          return rc;
>  
> +    rc = acpi_create_rsdp(d, tbl_add);
> +    if ( rc != 0 )
> +        return rc;
> +
>      return 0;
>  }
>  #else
> -- 
> 2.1.0
> 
