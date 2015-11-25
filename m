From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 11:27:09 -0800
Subject: [PATCH 7/7] ARM: mmp: move into ARCH_MULTIPLATFORM
In-Reply-To: <1448465875-435039-8-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
 <1448465875-435039-8-git-send-email-arnd@arndb.de>
Message-ID: <20151125192709.GC11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25, Arnd Bergmann wrote:
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index fdbfadf00c84..4773fe1d8b3f 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -1,9 +1,24 @@
> +menuconfig ARCH_MMP
> +	bool "Marvell PXA168/910/MMP2"
> +	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
> +	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_ALLOCATOR
> +	select GENERIC_CLOCKEVENTS

ARCH_MULTIPLATFORM already selects this.

> +	select GPIO_PXA
> +	select PINCTRL
> +	select PLAT_PXA
> +	help
> +	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
> diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
> deleted file mode 100644
> index 8890fa8fa771..000000000000
> --- a/arch/arm/mach-mmp/include/mach/uncompress.h
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/*
> - * arch/arm/mach-mmp/include/mach/uncompress.h
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/serial_reg.h>
> -#include <mach/addr-map.h>
> -#include <asm/mach-types.h>
> -
> -#define UART1_BASE	(APB_PHYS_BASE + 0x36000)
> -#define UART2_BASE	(APB_PHYS_BASE + 0x17000)
> -#define UART3_BASE	(APB_PHYS_BASE + 0x18000)
> -
> -volatile unsigned long *UART;

Doesn't this file need to be ported over to
arch/arm/include/debug/?

> -
> -static inline void putc(char c)
> -{
> -	/* UART enabled? */
> -	if (!(UART[UART_IER] & UART_IER_UUE))
> -		return;
> -
> -	while (!(UART[UART_LSR] & UART_LSR_THRE))
> -		barrier();
> -

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
