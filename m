From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 27 Nov 2013 14:26:46 +0000
Subject: [PATCH 3/3] ARM32:DMI: Add smbios/dmi support on arm32
In-Reply-To: <1385397866-7524-4-git-send-email-yi.li@linaro.org>
References: <1385397866-7524-1-git-send-email-yi.li@linaro.org> <
 1385397866-7524-4-git-send-email-yi.li@linaro.org>
Message-ID: <20131127142646.5DCB7C404EC@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013 00:44:26 +0800, Yi Li <yi.li@linaro.org> wrote:
> Add smbios/dmi support on arm32 system, it depends on
> EFI boot.
> 
> Signed-off-by: Yi Li <yi.li@linaro.org>
> ---

Acked-by: Grant Likely <grant.likely@linaro.org>

> 
> efi_lookup_mapped_addr() isn't able to translate the address range
> which is reported as reserved type from UEFI. Following the UEFI
> spec 2.4, it descripts the SMBIOS data should be runtime service
> type. So it depends on a UEFI patch to convert reserved type to 
> runtime service type for SMBIOS and a linux dmi driver patch that
> has been posted for review to x86 and ia64.
> 
>  arch/arm/Kconfig           |   13 +++++++++++++
>  arch/arm/include/asm/dmi.h |   28 ++++++++++++++++++++++++++++
>  arch/arm/kernel/setup.c    |    2 ++
>  3 files changed, 43 insertions(+)
>  create mode 100644 arch/arm/include/asm/dmi.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 11367a4..623c8c5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1910,6 +1910,17 @@ config EFI_STUB
>  	  executed directly by EFI firmware.
>  	  See Documentation/efi-stub.txt for more information.
>  
> +config DMI
> +	bool "Enable support for SMBIOS (DMI) tables"
> +	depends on EFI
> +	default y
> +	help
> +	  This enables SMBIOS/DMI feature for systems.
> +
> +	  This option is only useful on systems that have UEFI firmware.
> +	  However, even with this option, the resultant kernel should
> +	  continue to boot on existing non-UEFI platforms.
> +
>  config SECCOMP
>  	bool
>  	prompt "Enable seccomp to safely compute untrusted bytecode"
> @@ -2348,6 +2359,8 @@ source "net/Kconfig"
>  
>  source "drivers/Kconfig"
>  
> +source "drivers/firmware/Kconfig"
> +
>  source "fs/Kconfig"
>  
>  source "arch/arm/Kconfig.debug"
> diff --git a/arch/arm/include/asm/dmi.h b/arch/arm/include/asm/dmi.h
> new file mode 100644
> index 0000000..428f32e
> --- /dev/null
> +++ b/arch/arm/include/asm/dmi.h
> @@ -0,0 +1,28 @@
> +/*
> + * arch/arm/include/asm/dmi.h
> + *
> + * Copyright (C) 2013 Linaro Limited.
> + * Written by: Yi Li (yi.li at linaro.org)
> + *
> + * based on arch/ia64/include/asm/dmi.h
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +
> +#ifndef _ASM_DMI_H
> +#define _ASM_DMI_H 1
> +
> +#include <linux/slab.h>
> +#include <asm/io.h>
> +
> +/* Use normal IO mappings for DMI */
> +#define dmi_early_remap(x, l)	efi_lookup_mapped_addr(x)
> +#define dmi_early_unmap(x, l)
> +#define dmi_remap(x, l)			efi_lookup_mapped_addr(x)
> +#define dmi_unmap(x)
> +#define dmi_alloc(l)			kzalloc(l, GFP_ATOMIC)
> +
> +#endif
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 0bde4e3..c9999ce 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -34,6 +34,7 @@
>  #ifdef CONFIG_ACPI
>  #include <linux/acpi.h>
>  #endif
> +#include <linux/dmi.h>
>  
>  #include <asm/unified.h>
>  #include <asm/cp15.h>
> @@ -771,6 +772,7 @@ static int __init customize_machine(void)
>  		of_platform_populate(NULL, of_default_bus_match_table,
>  					NULL, NULL);
>  #endif
> +	dmi_scan_machine();
>  	return 0;
>  }
>  arch_initcall(customize_machine);
> -- 
> 1.7.9.5
> 
