From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 18:22:46 +0800
Subject: [PATCH 7/8] ARM: sirf: enable multiplatform support
In-Reply-To: <1363779679-16880-8-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-8-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4ySCncEh8_03B_CXBuS=h-N=CN5LezVRGoMhME78YPaWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h
> b/arch/arm/mach-prima2/include/mach/uncompress.h
> deleted file mode 100644
> index d1513a3..0000000
> --- a/arch/arm/mach-prima2/include/mach/uncompress.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - * arch/arm/mach-prima2/include/mach/uncompress.h
> - *
> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group
> company.
> - *
> - * Licensed under GPLv2 or later.
> - */
> -
> -#ifndef __ASM_ARCH_UNCOMPRESS_H
> -#define __ASM_ARCH_UNCOMPRESS_H
> -
> -#include <linux/io.h>
> -#include <mach/hardware.h>
> -#include <mach/uart.h>
> -
> -void arch_decomp_setup(void)
> -{
> -}
> -
> -static __inline__ void putc(char c)
> -{
> -	/*
> -	 * during kernel decompression, all mappings are flat:
> -	 *  virt_addr == phys_addr
> -	 */
> -	if (!SIRFSOC_UART1_PA_BASE)
> -		return;
> -
> -	while (__raw_readl((void __iomem *)SIRFSOC_UART1_PA_BASE +
> SIRFSOC_UART_TXFIFO_STATUS)
> -		& SIRFSOC_UART1_TXFIFO_FULL)
> -		barrier();
> -
> -	__raw_writel(c, (void __iomem *)SIRFSOC_UART1_PA_BASE +
> SIRFSOC_UART_TXFIFO_DATA);
> -}
> -
> -static inline void flush(void)
> -{
> -}
> -
> -#endif

will this mean we will don't support "uncompress ..." printed in the
early uncompress stage before lluart work?

-barry
