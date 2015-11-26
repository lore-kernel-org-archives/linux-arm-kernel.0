From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 17:48:07 +0000
Subject: [PATCH v3 43/62] arm/acpi: Prepare MADT table for Dom0
In-Reply-To: <1447753261-7552-44-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-44-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261731240.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Copy and modify MADT table before passing it to Dom0. Copy
> dom0_max_vcpus of GICCs and GICD as well.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/domain_build.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index 5d03dc0..4591955 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -1359,6 +1359,100 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
>  #ifdef CONFIG_ACPI
>  #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
>  
> +static int acpi_create_madt(struct domain *d, struct membank tbl_add[])
> +{
> +    struct acpi_table_header *table = NULL;
> +    struct acpi_table_madt *madt = NULL;
> +    struct acpi_madt_generic_distributor gicd;
> +    u64 table_size = sizeof(struct acpi_table_madt);
> +    acpi_status status;
> +    int i;
> +    u8 *base_ptr;
> +    u8 checksum;
> +
> +    status = acpi_get_table(ACPI_SIG_MADT, 0, &table);
> +
> +    if ( ACPI_FAILURE(status) )
> +    {
> +        const char *msg = acpi_format_exception(status);
> +
> +        printk("Failed to get MADT table, %s\n", msg);
> +        return -EINVAL;
> +    }
> +
> +    base_ptr = d->arch.efi_acpi_table
> +               + acpi_get_table_offset(tbl_add, TBL_MADT);
> +    ACPI_MEMCPY(base_ptr, table, table_size);
> +
> +    /* Add Generic Distributor */
> +    memset(&gicd, 0, sizeof(gicd));
> +    gicd.header.type = ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR;
> +    gicd.header.length = sizeof(gicd);
> +    gicd.base_address = d->arch.vgic.dbase;
> +    if ( d->arch.vgic.version == GIC_V2 )
> +        gicd.version = ACPI_MADT_GIC_VERSION_V2;
> +    else if ( d->arch.vgic.version == GIC_V3 )
> +        gicd.version = ACPI_MADT_GIC_VERSION_V3;
> +    else
> +        gicd.version = ACPI_MADT_GIC_VERSION_NONE;
> +    ACPI_MEMCPY(base_ptr + table_size, &gicd, sizeof(gicd));
> +
> +    table_size += sizeof(gicd);
> +
> +    if ( d->arch.vgic.version == GIC_V3 ) {
> +        /* Add Generic Redistributor */
> +        for ( i = 0; i < d->arch.vgic.nr_regions; i++ ) {

Coding style


> +            struct acpi_madt_generic_redistributor gicr;
> +
> +            memset(&gicr, 0, sizeof(gicr));
> +            gicr.header.type = ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR;
> +            gicr.header.length = sizeof(gicr);
> +            gicr.base_address = d->arch.vgic.rdist_regions[i].base;
> +            gicr.length = d->arch.vgic.rdist_regions[i].size;
> +            ACPI_MEMCPY(base_ptr + table_size, &gicr, sizeof(gicr));
> +            table_size += sizeof(gicr);
> +        }
> +    } else {
> +        /* Add Generic Interrupt */
> +        for ( i = 0; i < d->max_vcpus; i++ )
> +        {
> +            struct acpi_madt_generic_interrupt gicc;
> +            u64 mpidr = 0;
> +            u32 id = i, j = 0;
> +
> +            memset(&gicc, 0, sizeof(gicc));
> +            gicc.header.type = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
> +            gicc.header.length = sizeof(gicc);
> +            gicc.cpu_interface_number = i;
> +            gicc.uid = i;
> +            gicc.flags = ACPI_MADT_ENABLED;
> +            gicc.base_address = d->arch.vgic.cbase;
> +
> +            do {
> +                mpidr |= (id % 4) << (8 * j);
> +                j++;
> +                if ( j ==3 )
> +                    j++;
> +                id = id / 4;
> +            } while(id > 0);

You should be able to use vcpuid_to_vaffinity to calculate the vmpidr.


> +            gicc.arm_mpidr = mpidr;

We should probably copy the native value of "Processor Power Efficiency
Class" ?


> +            ACPI_MEMCPY(base_ptr + table_size, &gicc, sizeof(gicc));
> +            table_size += sizeof(gicc);
> +        }
> +    }
> +
> +    madt = (struct acpi_table_madt *)base_ptr;
> +    madt->header.length = table_size;
> +    checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, madt), table_size);
> +    madt->header.checksum -= checksum;
> +
> +    tbl_add[TBL_MADT].start = d->arch.efi_acpi_gpa
> +                              + acpi_get_table_offset(tbl_add, TBL_MADT);
> +    tbl_add[TBL_MADT].size = table_size;
> +
> +    return 0;
> +}
> +
>  static int acpi_create_fadt(struct domain *d, struct membank tbl_add[])
>  {
>      struct acpi_table_header *table = NULL;
> @@ -1463,6 +1557,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>      if ( rc != 0 )
>          return rc;
>  
> +    rc = acpi_create_madt(d, tbl_add);
> +    if ( rc != 0 )
> +        return rc;
> +
>      return 0;
>  }
>  #else
> -- 
> 2.1.0
> 
