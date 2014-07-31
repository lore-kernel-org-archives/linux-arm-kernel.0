From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Jul 2014 14:48:36 +0200
Subject: [PATCH] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1406810830-6099-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1406810830-6099-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9hwupNAxuOTNnsY8Spxkh3J6DwYF7Ym493PuZ-6phzXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2014 14:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> From: Yi Li <yi.li@linaro.org>
>
> SMbios is important for server hardware vendors. It implements a spec for
> providing descriptive information about the platform. Things like serial
> numbers, physical layout of the ports, build configuration data, and the like.
>
> This has been tested by dmidecode and lshw tools.
>
> Signed-off-by: Yi Li <yi.li@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> It turns out that efi_lookup_mapped_addr() is not appropriate after all for
> remapping the address of the SMBIOS tables. The reason is that the UEFI spec
> forbids virtual mappings being requested for configuration tables (which is not
> currently honored by Tianocore/EDK2)
>

@Yi: could you retest yet again, please?

@Will; this superseded the patch that is already queued up in
for-next/core, so perhaps you could drop that while we get this
tested?

>
>  arch/arm64/Kconfig           | 11 +++++++++++
>  arch/arm64/include/asm/dmi.h | 33 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/setup.c    |  2 ++
>  3 files changed, 46 insertions(+)
>  create mode 100644 arch/arm64/include/asm/dmi.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 839f48c26ef0..0b2350470ac9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -308,6 +308,17 @@ config EFI
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
> +
>  endmenu
>
>  menu "Userspace binary formats"
> diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
> new file mode 100644
> index 000000000000..0a07357bb776
> --- /dev/null
> +++ b/arch/arm64/include/asm/dmi.h
> @@ -0,0 +1,33 @@
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
> +#ifndef __ASM_DMI_H
> +#define __ASM_DMI_H
> +
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +/*
> + * According to section 2.3.6 of the UEFI spec, the firmware must not request
> + * a virtual mapping for configuration tables such as SMBIOS. This means we have
> + * to map them before use. As SMBIOS tables are typed as EfiRuntimeServicesData,
> + * they should always reside in DRAM, so we can use ioremap_cache() here, which
> + * will give us the existing linear mapping if the address is covered by it.
> + */
> +#define dmi_early_remap(x, l)          ioremap_cache(x, l)
> +#define dmi_early_unmap(x, l)          iounmap(x)
> +#define dmi_remap(x, l)                        ioremap_cache(x, l)
> +#define dmi_unmap(x)                   iounmap(x)
> +#define dmi_alloc(l)                   kzalloc(l, GFP_KERNEL)
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
