From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 8 Jan 2018 15:51:37 +0000
Subject: [PATCH v6 13/16] arm64: acpi: Remove __init from
 acpi_psci_use_hvc() for use by SDEI
In-Reply-To: <20180108153818.22743-14-james.morse@arm.com>
References: <20180108153818.22743-1-james.morse@arm.com>
 <20180108153818.22743-14-james.morse@arm.com>
Message-ID: <20180108155137.GB2530@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 03:38:15PM +0000, James Morse wrote:
> SDEI inherits the 'use hvc' bit that is also used by PSCI. PSCI does all
> its initialisation early, SDEI does its late.
> 
> Remove the __init annotation from acpi_psci_use_hvc().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> The function name is unchanged as this bit is named 'PSCI_USE_HVC'
> in table 5-37 of ACPIv6.2.
> 
>  arch/arm64/kernel/acpi.c | 2 +-
>  include/linux/psci.h     | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index b3162715ed78..252396a96c78 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -117,7 +117,7 @@ bool __init acpi_psci_present(void)
>  }
>  
>  /* Whether HVC must be used instead of SMC as the PSCI conduit */
> -bool __init acpi_psci_use_hvc(void)
> +bool acpi_psci_use_hvc(void)
>  {
>  	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
>  }
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index 6306ab10af18..f724fd8c78e8 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -47,10 +47,11 @@ static inline int psci_dt_init(void) { return 0; }
>  #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
>  int __init psci_acpi_init(void);
>  bool __init acpi_psci_present(void);
> -bool __init acpi_psci_use_hvc(void);
> +bool acpi_psci_use_hvc(void);
>  #else
>  static inline int psci_acpi_init(void) { return 0; }
>  static inline bool acpi_psci_present(void) { return false; }
> +static inline bool acpi_psci_use_hvc(void) {return false; }
>  #endif
>  
>  #endif /* __LINUX_PSCI_H */
> -- 
> 2.15.0
> 
