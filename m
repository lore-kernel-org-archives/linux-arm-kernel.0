From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 12:42:09 +0000
Subject: [PATCH v3 13/62] arm/acpi: Parse FADT table and get PSCI flags
In-Reply-To: <1447753261-7552-14-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-14-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231233260.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
> the former signals to the OS that the hardware is PSCI compliant.
> The latter selects the appropriate conduit for PSCI calls by
> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
> (SMC).
> 
> FADT table contains such information, parse FADT to get the flags
> for furture usage. At the same time, only ACPI 5.1 or higher verison
> supports PSCI, and FADT Major.Minor version was introduced in ACPI
> 5.1, but for Xen it needs FADT hypervisor_id introduced by ACPI 6.0 to
> tell Dom0 that it runs on Xen hypervisor, so we will check the version
> and only parse FADT table with version >= 6.0.
> 
> If firmware provides ACPI tables with ACPI version less than 6.0,
> OS will be messed up with those information, so disable ACPI if we
> get an FADT table with version less that 6.0.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/acpi/boot.c   | 31 +++++++++++++++++++++++++++++++
>  xen/arch/arm/acpi/lib.c    | 12 ++++++++++++
>  xen/include/asm-arm/acpi.h |  9 +++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/xen/arch/arm/acpi/boot.c b/xen/arch/arm/acpi/boot.c
> index ad51afc..0fabe7d 100644
> --- a/xen/arch/arm/acpi/boot.c
> +++ b/xen/arch/arm/acpi/boot.c
> @@ -27,9 +27,33 @@
>  
>  #include <xen/init.h>
>  #include <xen/acpi.h>
> +#include <xen/errno.h>
> +#include <acpi/actables.h>
> +#include <xen/mm.h>
>  
>  #include <asm/acpi.h>
>  
> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
> +{
> +    struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> +
> +    /*
> +     * Revision in table header is the FADT Major revision, and there
> +     * is a minor revision of FADT which was introduced by ACPI 6.0,
> +     * we only deal with ACPI 6.0 or newer revision to get GIC and SMP
> +     * boot protocol configuration data, or we will disable ACPI.
> +     */
> +    if ( table->revision > 6
> +         || (table->revision == 6 && fadt->minor_revision >= 0) )
> +        return 0;
> +
> +    printk("Unsupported FADT revision %d.%d, should be 6.0+, will disable ACPI\n",
> +            table->revision, fadt->minor_revision);
> +    disable_acpi();

This call to disable_acpi is redundant, given the other call below


> +    return -EINVAL;
> +}
> +
>  /*
>   * acpi_boot_table_init() called from setup_arch(), always.
>   *      1. find RSDP and get its address, and then find XSDT
> @@ -58,5 +82,12 @@ int __init acpi_boot_table_init(void)
>          return error;
>      }
>  
> +    if ( acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt) )
> +    {
> +        /* disable ACPI if no FADT is found */
> +        disable_acpi();
> +        printk("Can't find FADT\n");
> +    }
> +
>      return 0;
>  }
> diff --git a/xen/arch/arm/acpi/lib.c b/xen/arch/arm/acpi/lib.c
> index b68623b..d8b7635 100644
> --- a/xen/arch/arm/acpi/lib.c
> +++ b/xen/arch/arm/acpi/lib.c
> @@ -31,3 +31,15 @@ arch_acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
>  {
>      return __va(phys);
>  }
> +
> +/* 1 to indicate PSCI 0.2+ is implemented */
> +bool_t __init acpi_psci_present(void)
> +{
> +    return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT;
> +}
> +
> +/* 1 to indicate HVC is present instead of SMC as the PSCI conduit */
> +bool_t __init acpi_psci_hvc_present(void)
> +{
> +    return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
> +}
> diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
> index e41e03b..65f80b1 100644
> --- a/xen/include/asm-arm/acpi.h
> +++ b/xen/include/asm-arm/acpi.h
> @@ -29,6 +29,15 @@
>  #define COMPILER_DEPENDENT_UINT64  unsigned long long
>  
>  extern bool_t acpi_disabled;
> +
> +#ifdef CONFIG_ACPI
> +bool_t __init acpi_psci_present(void);
> +bool_t __init acpi_psci_hvc_present(void);
> +#else
> +static inline bool_t acpi_psci_present(void) { return false; }
> +static inline bool_t acpi_psci_hvc_present(void) {return false; }
> +#endif /* CONFIG_ACPI */

It doesn't look like this is necessary on x86, acpi_gbl_FADT is used in
a few places, including xen/arch/x86/time.c, without checking for
CONFIG_ACPI or HAS_ACPI. Is the x86 code wrong?


>  /* Basic configuration for ACPI */
>  static inline void disable_acpi(void)
>  {
> -- 
> 2.1.0
> 
