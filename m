From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Jul 2014 10:55:53 +0200
Subject: [PATCH resend] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1404297277-28295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1404297277-28295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9QuHcV4+8Sx--HEXOCfFDqZw0JWvJJjHYAHS6Y1xF9qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 July 2014 12:34, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> From: Yi Li <yi.li@linaro.org>
>
> SMbios is important for server hardware vendors. It implements a spec for
> providing descriptive information about the platform. Things like serial
> numbers, physical layout of the ports, build configuration data, and the like.
>
> This has been tested by dmidecode and lshw tools.
>
> Signed-off-by: Yi Li <yi.li@linaro.org>
> [ardb: whitespace, commit log tweaks]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> Resending on behalf of Yi.
> Please consider for 3.17.
>

Ping?

>  arch/arm64/Kconfig           | 10 ++++++++++
>  arch/arm64/include/asm/dmi.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/setup.c    |  2 ++
>  3 files changed, 40 insertions(+)
>  create mode 100644 arch/arm64/include/asm/dmi.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a474de346be6..560996c4a172 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -307,6 +307,16 @@ config EFI
>           allow the kernel to be booted as an EFI application. This
>           is only useful on systems that have UEFI firmware.
>
> +config DMI
> +       bool "Enable support for SMBIOS (DMI) tables"
> +       depends on EFI
> +       default y
> +       help
> +         This enables SMBIOS/DMI feature for systems.
> +
> +         This option is only useful on systems that have UEFI firmware.
> +         However, even with this option, the resultant kernel should
> +         continue to boot on existing non-UEFI platforms.
>  endmenu
>
>  menu "Userspace binary formats"
> diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
> new file mode 100644
> index 000000000000..b8758f46fb42
> --- /dev/null
> +++ b/arch/arm64/include/asm/dmi.h
> @@ -0,0 +1,28 @@
> +/*
> + * arch/arm64/include/asm/dmi.h
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
> +#include <linux/efi.h>
> +
> +/* Use efi mappings for DMI */
> +#define dmi_early_remap(x, l)          efi_lookup_mapped_addr(x)
> +#define dmi_early_unmap(x, l)
> +#define dmi_remap(x, l)                        efi_lookup_mapped_addr(x)
> +#define dmi_unmap(x)
> +#define dmi_alloc(l)                   kzalloc(l, GFP_ATOMIC)
> +
> +#endif
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 46d1125571f6..4075e46282b1 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -43,6 +43,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
>  #include <linux/efi.h>
> +#include <linux/dmi.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/cputype.h>
> @@ -413,6 +414,7 @@ void __init setup_arch(char **cmdline_p)
>  static int __init arm64_device_init(void)
>  {
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +       dmi_scan_machine();
>         return 0;
>  }
>  arch_initcall_sync(arm64_device_init);
> --
> 1.8.3.2
>
