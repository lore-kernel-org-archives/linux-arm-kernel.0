From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 19 Sep 2014 10:25:22 -0700
Subject: [PATCH resend] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1411146032-5771-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1411146032-5771-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9xDEZ7ujpExBTP5_5VFCyutOzZSyf7XjT6ac5jvc4AWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 September 2014 10:00, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
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


@WIll, Catalin:

Yi just informed me that this is *not* the patch he tested, and that
it needs to be changed to work correctly.

Apologies for adding yet more to the confusion around this, but please
DO NOT merge this.

-- 
Ard.


>  arch/arm64/Kconfig           | 11 +++++++++++
>  arch/arm64/include/asm/dmi.h | 31 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/setup.c    |  2 ++
>  3 files changed, 44 insertions(+)
>  create mode 100644 arch/arm64/include/asm/dmi.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd4e81a4e1ce..c69ab5a3a321 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -368,6 +368,17 @@ config EFI
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
> index 000000000000..69d37d87b159
> --- /dev/null
> +++ b/arch/arm64/include/asm/dmi.h
> @@ -0,0 +1,31 @@
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
> + * According to section 2.3.6 of the UEFI spec, the firmware should not
> + * request a virtual mapping for configuration tables such as SMBIOS.
> + * This means we have to map them before use.
> + */
> +#define dmi_early_remap(x, l)          ioremap_cache(x, l)
> +#define dmi_early_unmap(x, l)          iounmap(x)
> +#define dmi_remap(x, l)                        ioremap_cache(x, l)
> +#define dmi_unmap(x)                   iounmap(x)
> +#define dmi_alloc(l)                   kzalloc(l, GFP_KERNEL)
> +
> +#endif
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index edb146d01857..87e2e5419a51 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -43,6 +43,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
>  #include <linux/efi.h>
> +#include <linux/dmi.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/cpu.h>
> @@ -416,6 +417,7 @@ void __init setup_arch(char **cmdline_p)
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
