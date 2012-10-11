From: alchark@gmail.com (Alexey Charkov)
Date: Thu, 11 Oct 2012 11:25:33 +0400
Subject: [RFC PATCH] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <1349939831-12939-1-git-send-email-linux@prisktech.co.nz>
References: <1349939831-12939-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CABjd4YzdwXmAeTrULWOGdFBg8xKXK4FN7fGJegjFZYmmxhrP2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/11 Tony Prisk <linux@prisktech.co.nz>:
> This patch completes the conversion to ARCH_MULTI_V5 for arch-vt8500.
> Removed /mach/include/ and remaining unneeded files.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/Kconfig                                |   18 ++----------
>  arch/arm/mach-vt8500/include/mach/debug-macro.S |   31 -------------------
>  arch/arm/mach-vt8500/include/mach/timex.h       |   26 ----------------
>  arch/arm/mach-vt8500/include/mach/uncompress.h  |   36 -----------------------
>  4 files changed, 2 insertions(+), 109 deletions(-)
>  delete mode 100644 arch/arm/mach-vt8500/include/mach/debug-macro.S
>  delete mode 100644 arch/arm/mach-vt8500/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-vt8500/include/mach/uncompress.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 32b62ac..e71ad2c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -938,22 +938,6 @@ config PLAT_SPEAR
>         help
>           Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
>
> -config ARCH_VT8500
> -       bool "VIA/WonderMedia 85xx"
> -       select CPU_ARM926T
> -       select GENERIC_GPIO
> -       select ARCH_HAS_CPUFREQ
> -       select GENERIC_CLOCKEVENTS
> -       select ARCH_REQUIRE_GPIOLIB
> -       select USE_OF
> -       select COMMON_CLK
> -       select HAVE_CLK
> -       select CLKDEV_LOOKUP
> -       select MULTI_IRQ_HANDLER
> -       select SPARSE_IRQ
> -       help
> -         Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
> -
>  config ARCH_ZYNQ
>         bool "Xilinx Zynq ARM Cortex A9 Platform"
>         select CPU_V7
> @@ -1125,6 +1109,8 @@ source "arch/arm/mach-versatile/Kconfig"
>  source "arch/arm/mach-vexpress/Kconfig"
>  source "arch/arm/plat-versatile/Kconfig"
>
> +source "arch/arm/mach-vt8500/Kconfig"
> +
>  source "arch/arm/mach-w90x900/Kconfig"
>
>  # Definitions to make life easier
> diff --git a/arch/arm/mach-vt8500/include/mach/debug-macro.S b/arch/arm/mach-vt8500/include/mach/debug-macro.S
> deleted file mode 100644
> index ca292f2..0000000
> --- a/arch/arm/mach-vt8500/include/mach/debug-macro.S
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/*
> - * arch/arm/mach-vt8500/include/mach/debug-macro.S
> - *
> - *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> - *
> - * Debugging macro include header
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> -*/
> -
> -       .macro  addruart, rp, rv, tmp
> -       mov     \rp,      #0x00200000
> -       orr     \rv, \rp, #0xf8000000
> -       orr     \rp, \rp, #0xd8000000
> -       .endm
> -
> -       .macro  senduart,rd,rx
> -       strb    \rd, [\rx, #0]
> -       .endm
> -
> -       .macro  busyuart,rd,rx
> -1001:  ldr     \rd, [\rx, #0x1c]
> -       ands    \rd, \rd, #0x2
> -       bne     1001b
> -       .endm
> -
> -       .macro  waituart,rd,rx
> -       .endm

Does this imply that early printk won't be supported any longer, or am
I missing something?

Thanks,
Alexey
