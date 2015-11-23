From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 12:15:38 +0000
Subject: [PATCH v3 12/62] ACPICA: ACPI 6.0: Add changes for FADT table
In-Reply-To: <1447753261-7552-13-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-13-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231214490.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:

> From: Bob Moore <robert.moore@intel.com>
> 
> ACPICA commit 72b0b6741990f619f6aaa915302836b7cbb41ac4
> 
> One new 64-bit field at the end of the table.
> FADT version is now 6.
> 
> Link: https://github.com/acpica/acpica/commit/72b0b674
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [Linux commit aeb823bbacc2a3aaee29eda5875b58a049fa1f78]
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/include/acpi/actbl.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/xen/include/acpi/actbl.h b/xen/include/acpi/actbl.h
> index 66e29c3..3079176 100644
> --- a/xen/include/acpi/actbl.h
> +++ b/xen/include/acpi/actbl.h
> @@ -258,6 +258,7 @@ struct acpi_table_fadt {
>  	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
>  	struct acpi_generic_address sleep_control;	/* 64-bit Sleep Control register */
>  	struct acpi_generic_address sleep_status;	/* 64-bit Sleep Status register */
> +	u64 hypervisor_id;      /* Hypervisor Vendor ID (ACPI 6.0) */
>  };
>  
>  /* Masks for FADT IA-PC Boot Architecture Flags (boot_flags) */
> @@ -315,7 +316,7 @@ enum acpi_prefered_pm_profiles {
>  	PM_TABLET = 8
>  };
>  
> -/* Values for sleep_status and sleep_control registers (V5 FADT) */
> +/* Values for sleep_status and sleep_control registers (V5+ FADT) */
>  
>  #define ACPI_X_WAKE_STATUS          0x80
>  #define ACPI_X_SLEEP_TYPE_MASK      0x1C
> @@ -344,15 +345,17 @@ enum acpi_prefered_pm_profiles {
>   * FADT is the bottom line as to what the version really is.
>   *
>   * For reference, the values below are as follows:
> - *     FADT V1  size: 0x074
> - *     FADT V2  size: 0x084
> - *     FADT V3  size: 0x0F4
> - *     FADT V4  size: 0x0F4
> - *     FADT V5  size: 0x10C
> + *     FADT V1 size: 0x074
> + *     FADT V2 size: 0x084
> + *     FADT V3 size: 0x0F4
> + *     FADT V4 size: 0x0F4
> + *     FADT V5 size: 0x10C
> + *     FADT V6 size: 0x114
>   */
>  #define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
>  #define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (minor_revision) + 1)
>  #define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
> -#define ACPI_FADT_V5_SIZE       (u32) (sizeof (struct acpi_table_fadt))
> +#define ACPI_FADT_V5_SIZE       (u32) (ACPI_FADT_OFFSET (hypervisor_id))
> +#define ACPI_FADT_V6_SIZE       (u32) (sizeof (struct acpi_table_fadt))
>  
>  #endif				/* __ACTBL_H__ */
> -- 
> 2.1.0
> 
