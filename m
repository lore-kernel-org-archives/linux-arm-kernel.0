From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 11:58:42 +0000
Subject: [Xen-devel] [PATCH v3 46/62] arm/acpi: Prepare XSDT table for Dom0
In-Reply-To: <1447753261-7552-47-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-47-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271129240.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Copy and modify XSDT table before passing it to Dom0. Repalce the entry
> value of the copied table. Add a new entry for STAO table as well. And
> keep entry value of other reused tables unchanged.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/domain_build.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index fb3f150..894328f 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -1359,6 +1359,73 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
>  #ifdef CONFIG_ACPI
>  #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
>  
> +static void acpi_xsdt_modify_entry(u64 entry[], unsigned long entry_count,
> +                                   char *signature, u64 addr)
> +{
> +    int i;
> +    struct acpi_table_header *table;
> +    u64 size = sizeof(struct acpi_table_header);
> +
> +    for( i = 0; i < entry_count; i++ )
> +    {
> +        table = acpi_os_map_memory(entry[i], size);
> +	if ( ACPI_COMPARE_NAME(table->signature, signature) )

coding style


> +        {
> +            entry[i] = addr;
> +            acpi_os_unmap_memory(table, size);
> +            break;
> +        }
> +        acpi_os_unmap_memory(table, size);
> +    }
> +}
> +
> +static int acpi_create_xsdt(struct domain *d, struct membank tbl_add[])
> +{
> +    struct acpi_table_header *table = NULL;
> +    struct acpi_table_rsdp *rsdp_tbl;
> +    struct acpi_table_xsdt *xsdt = NULL;
> +    u64 table_size, addr;
> +    unsigned long entry_count;
> +    u8 *base_ptr;
> +    u8 checksum;
> +
> +    addr = acpi_os_get_root_pointer();
> +    if ( !addr )
> +    {
> +        printk("Unable to get acpi root pointer\n");
> +        return -EINVAL;
> +    }
> +    rsdp_tbl = acpi_os_map_memory(addr, sizeof(struct acpi_table_rsdp));
> +    table = acpi_os_map_memory(rsdp_tbl->xsdt_physical_address,
> +                               sizeof(struct acpi_table_header));
> +
> +    table_size = table->length + sizeof(u64); /* Add place for STAO table */

Please move the comment above the line.
It looks like you took into account this additional u64 in
estimate_acpi_efi_size. Please add a comment there too.

For this patch, provided you fix the minor style issues:

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>



> +    entry_count = (table->length - sizeof(struct acpi_table_header))
> +                  / sizeof(u64);
> +    base_ptr = d->arch.efi_acpi_table
> +               + acpi_get_table_offset(tbl_add, TBL_XSDT);
> +    ACPI_MEMCPY(base_ptr, table, table->length);
> +    acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
> +    acpi_os_unmap_memory(rsdp_tbl, sizeof(struct acpi_table_rsdp));
> +
> +    xsdt = (struct acpi_table_xsdt *)base_ptr;
> +    acpi_xsdt_modify_entry(xsdt->table_offset_entry, entry_count,
> +                           ACPI_SIG_FADT, tbl_add[TBL_FADT].start);
> +    acpi_xsdt_modify_entry(xsdt->table_offset_entry, entry_count,
> +                           ACPI_SIG_MADT, tbl_add[TBL_MADT].start);
> +    xsdt->table_offset_entry[entry_count] = tbl_add[TBL_STAO].start;
> +
> +    xsdt->header.length = table_size;
> +    checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, xsdt), table_size);
> +    xsdt->header.checksum -= checksum;
> +
> +    tbl_add[TBL_XSDT].start = d->arch.efi_acpi_gpa
> +                              + acpi_get_table_offset(tbl_add, TBL_XSDT);
> +    tbl_add[TBL_XSDT].size = table_size;
> +
> +    return 0;
> +}
> +
>  static int acpi_create_stao(struct domain *d, struct membank tbl_add[])
>  {
>      struct acpi_table_header *table = NULL;
> @@ -1604,6 +1671,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>      if ( rc != 0 )
>          return rc;
>  
> +    rc = acpi_create_xsdt(d, tbl_add);
> +    if ( rc != 0 )
> +        return rc;
> +
>      return 0;
>  }
>  #else
