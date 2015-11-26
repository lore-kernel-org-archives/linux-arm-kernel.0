From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 17:19:07 +0000
Subject: [Xen-devel] [PATCH v3 42/62] arm/acpi: Prepare FADT table for Dom0
In-Reply-To: <1447753261-7552-43-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-43-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261710350.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Copy and modify FADT table before passing it to Dom0. Set PSCI_COMPLIANT
> and PSCI_USE_HVC.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>
>  xen/arch/arm/domain_build.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index b5ed44c..5d03dc0 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -1357,6 +1357,46 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
>  }
>  
>  #ifdef CONFIG_ACPI
> +#define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */

This needs to be documented somewhere. A new doc under docs/ might be
enough.


> +static int acpi_create_fadt(struct domain *d, struct membank tbl_add[])
> +{
> +    struct acpi_table_header *table = NULL;
> +    struct acpi_table_fadt *fadt = NULL;
> +    u64 table_size;
> +    acpi_status status;
> +    u8 *base_ptr;
> +    u8 checksum;
> +
> +    status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
> +
> +    if ( ACPI_FAILURE(status) )
> +    {
> +        const char *msg = acpi_format_exception(status);
> +
> +        printk("Failed to get FADT table, %s\n", msg);
> +        return -EINVAL;
> +    }
> +
> +    table_size = table->length;
> +    base_ptr = d->arch.efi_acpi_table
> +               + acpi_get_table_offset(tbl_add, TBL_FADT);
> +    ACPI_MEMCPY(base_ptr, table, table_size);
> +    fadt = (struct acpi_table_fadt *)base_ptr;
> +
> +    /* Set PSCI_COMPLIANT and PSCI_USE_HVC */
> +    fadt->arm_boot_flags |= (ACPI_FADT_PSCI_COMPLIANT | ACPI_FADT_PSCI_USE_HVC);
> +    fadt->hypervisor_id = XEN_HYPERVISOR_ID;
> +    checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, fadt), table_size);
> +    fadt->header.checksum -= checksum;
> +
> +    tbl_add[TBL_FADT].start = d->arch.efi_acpi_gpa
> +                              + acpi_get_table_offset(tbl_add, TBL_FADT);
> +    tbl_add[TBL_FADT].size = table_size;
> +
> +    return 0;
> +}
> +
>  static int estimate_acpi_efi_size(struct domain *d, struct kernel_info *kinfo)
>  {
>      u64 efi_size, acpi_size = 0, addr;
> @@ -1400,6 +1440,7 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>  {
>      int rc = 0;
>      int order;
> +    struct membank tbl_add[TBL_MMAX] = {};
>  
>      rc = estimate_acpi_efi_size(d, kinfo);
>      if ( rc != 0 )
> @@ -1418,6 +1459,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>       * region. So we use it as the ACPI table mapped address. */
>      d->arch.efi_acpi_gpa = kinfo->gnttab_start;
>  
> +    rc = acpi_create_fadt(d, tbl_add);
> +    if ( rc != 0 )
> +        return rc;
> +
>      return 0;
>  }
>  #else
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
