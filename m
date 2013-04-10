From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 10 Apr 2013 13:03:34 +0800
Subject: [PATCH] ARM: pxa: move debug uart code
In-Reply-To: <1365567243-17872-1-git-send-email-haojian.zhuang@linaro.org>
References: <1365567243-17872-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAMPhdO_prXOJA_ffNqFLy1eRxYy77qHAta8ir4kCKRe3ohK2_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 12:14 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> Move debug uart code from mach-pxa/mach-mmp to debug directory.
> Since they are similar, merge them together.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Good move,

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
>  arch/arm/Kconfig.debug                       |    9 +++++++
>  arch/arm/include/debug/pxa.S                 |   33 ++++++++++++++++++++++++++
>  arch/arm/mach-mmp/include/mach/debug-macro.S |   30 -----------------------
>  arch/arm/mach-pxa/include/mach/debug-macro.S |   23 ------------------
>  4 files changed, 42 insertions(+), 53 deletions(-)
>  create mode 100644 arch/arm/include/debug/pxa.S
>  delete mode 100644 arch/arm/mach-mmp/include/mach/debug-macro.S
>  delete mode 100644 arch/arm/mach-pxa/include/mach/debug-macro.S
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 2bf1973..2267ff7 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -330,6 +330,13 @@ choice
>                   Say Y here if you want kernel low-level debugging support
>                   on PicoXcell based platforms.
>
> +       config DEBUG_PXA_UART1
> +               depends on ARCH_PXA
> +               bool "Use PXA UAR0 for low-level debug"
> +               help
> +                 Say Y here if you want kernel low-level debugging support
> +                 on PXA UART1.
> +
>         config DEBUG_REALVIEW_STD_PORT
>                 bool "RealView Default UART"
>                 depends on ARCH_REALVIEW
> @@ -615,6 +622,8 @@ config DEBUG_LL_INCLUDE
>         default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
>         default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
>         default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
> +       default "debug/pxa.S" if DEBUG_PXA_UART1 || DEBUG_MMP_UART2 || \
> +                                DEBUG_MMP_UART3
>         default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
>         default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
>         default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
> diff --git a/arch/arm/include/debug/pxa.S b/arch/arm/include/debug/pxa.S
> new file mode 100644
> index 0000000..e1e795a
> --- /dev/null
> +++ b/arch/arm/include/debug/pxa.S
> @@ -0,0 +1,33 @@
> +/*
> + * Early serial output macro for Marvell PXA/MMP SoC
> + *
> + * Copyright (C) 1994-1999 Russell King
> + * Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
> + *
> + * Copyright (C) 2013 Haojian Zhuang
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#if defined(CONFIG_DEBUG_PXA_UART1)
> +#define PXA_UART_REG_PHYS_BASE 0x40100000
> +#define PXA_UART_REG_VIRT_BASE 0xf2100000
> +#elif defined(CONFIG_DEBUG_MMP_UART2)
> +#define PXA_UART_REG_PHYS_BASE 0xd4017000
> +#define PXA_UART_REG_VIRT_BASE 0xfe017000
> +#elif defined(CONFIG_DEBUG_MMP_UART3)
> +#define PXA_UART_REG_PHYS_BASE 0xd4018000
> +#define PXA_UART_REG_VIRT_BASE 0xfe018000
> +#else
> +#error "Select uart for DEBUG_LL"
> +#endif
> +
> +       .macro  addruart, rp, rv, tmp
> +       ldr     \rp, =PXA_UART_REG_PHYS_BASE
> +       ldr     \rv, =PXA_UART_REG_VIRT_BASE
> +       .endm
> +
> +#define UART_SHIFT     2
> +#include <asm/hardware/debug-8250.S>
> diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
> deleted file mode 100644
> index 5c3cc29..0000000
> --- a/arch/arm/mach-mmp/include/mach/debug-macro.S
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* arch/arm/mach-mmp/include/mach/debug-macro.S
> - *
> - * Debugging macro include header
> - *
> - *  Copied from arch/arm/mach-pxa/include/mach/debug.S
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#if defined(CONFIG_DEBUG_MMP_UART2)
> -#define MMP_UART_OFFSET        0x00017000
> -#elif defined(CONFIG_DEBUG_MMP_UART3)
> -#define MMP_UART_OFFSET        0x00018000
> -#else
> -#error "Select uart for DEBUG_LL"
> -#endif
> -
> -#include <mach/addr-map.h>
> -
> -               .macro  addruart, rp, rv, tmp
> -               ldr     \rp, =APB_PHYS_BASE             @ physical
> -               ldr     \rv, =APB_VIRT_BASE             @ virtual
> -               orr     \rp, \rp, #MMP_UART_OFFSET
> -               orr     \rv, \rv, #MMP_UART_OFFSET
> -               .endm
> -
> -#define UART_SHIFT     2
> -#include <asm/hardware/debug-8250.S>
> diff --git a/arch/arm/mach-pxa/include/mach/debug-macro.S b/arch/arm/mach-pxa/include/mach/debug-macro.S
> deleted file mode 100644
> index 70b112e..0000000
> --- a/arch/arm/mach-pxa/include/mach/debug-macro.S
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* arch/arm/mach-pxa/include/mach/debug-macro.S
> - *
> - * Debugging macro include header
> - *
> - *  Copyright (C) 1994-1999 Russell King
> - *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> -*/
> -
> -#include "hardware.h"
> -
> -               .macro  addruart, rp, rv, tmp
> -               mov     \rp, #0x00100000
> -               orr     \rv, \rp, #io_p2v(0x40000000)   @ virtual
> -               orr     \rp, \rp, #0x40000000           @ physical
> -               .endm
> -
> -#define UART_SHIFT     2
> -#include <asm/hardware/debug-8250.S>
> --
> 1.7.10.4
>
