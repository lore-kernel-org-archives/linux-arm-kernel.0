From: srplsnh@gmail.com (Surinder P Singh)
Date: Thu, 24 Sep 2009 20:13:14 +0530
Subject: [PATCH 1/3] [ARM]: U8500 core machine support
In-Reply-To: <1253572622.21542.45.camel@vinay-desktop>
References: <1253572622.21542.45.camel@vinay-desktop>
Message-ID: <f2235a630909240743t1fddabbct7c8ea0c4f77dbf73@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some review comments:

> diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
> +
> +#include <linux/amba/serial.h>
> +               .macro  addruart,rx
> +               mrc     p15, 0, \rx, c1, c0
> +               tst     \rx, #1                 @MMU enabled?
> +               moveq   \rx, #0x80007000        @MMU off, Physical address
> +               movne   \rx, #0xF0007000        @MMU on, Virtual address
> +               .endm
> +

It looks like the constants used here will break compilation. You
could instead use 0x80000000 and 0xf0000000 and add an 'orr \rx, \rx,
#0x7000' after the 'movne' to fix this.


> diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
> +
> +#include <asm/setup.h>
> +#include <linux/io.h>
> +#include <mach/hardware.h>
> +
> +#define U8500_UART_DR          0x101FB000
> +#define U8500_UART_LCRH                0x101FB02c
> +#define U8500_UART_CR          0x101FB030
> +#define U8500_UART_FR          0x101FB018
> +

Just wondering if the UART addresses used here are valid ? since they
do not seem to correspond to the ones listed in hardware.h.

Cheers,
surinder
