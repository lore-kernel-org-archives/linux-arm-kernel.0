From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Jul 2010 10:10:19 -0400 (EDT)
Subject: [PATCH 0/6] debug macro fixups, v2
In-Reply-To: <1279092586.619523.10182482328.0.gpush@pororo>
References: <1279092586.619523.10182482328.0.gpush@pororo>
Message-ID: <alpine.LFD.2.00.1007140930070.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Jul 2010, Jeremy Kerr wrote:

> As part of the DEBUG_LL mapping changes, I ran all of the defconfigs
> with DEBUG_LL=y. Some of the configs are broken, so I'm posting the
> fixups.
> 
> mx1 is still broken, as IMX_IO_ADDRESS() (used by the mx1 debug macros)
> uses C syntax, and so it not suitable for asm.

arch/arm/plat-mxc/include/mach/debug-macro.S:

#ifdef CONFIG_ARCH_MX1
#include <mach/mx1.h>
#define UART_PADDR      UART1_BASE_ADDR
#define UART_VADDR      IO_ADDRESS(UART1_BASE_ADDR)
#endif

arch/arm/plat-mxc/include/mach/mx1.h:

#define IO_ADDRESS(x) MX1_IO_ADDRESS(x)
#define MX1_IO_ADDRESS(x) (IMX_IO_ADDRESS(x, MX1_IO))
#define UART1_BASE_ADDR MX1_UART1_BASE_ADDR
#define MX1_UART1_BASE_ADDR (0x06000 + MX1_IO_BASE_ADDR)
#define MX1_IO_SIZE SZ_1M

arch/arm/plat-mxc/include/mach/hardware.h:

#define IMX_IO_ADDRESS(addr, module)                                    \
        ((void __force __iomem *)                                       \
         (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
         (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))

So... given that 0x06000 is smaller than SZ_1M, you could simply do:

#define UART_PADDR      MX1_UART1_BASE_ADDR
#define UART_VADDR      (UART_PADDR - MX1_IO_BASE_ADDR + MX1_IO_BASE_ADDR_VIRT)

or add an assembly friendly version in hardware.h:

#ifndef __ASSEMBLY__
#define IMX_IO_ADDRESS(addr, module)                                    \
        ((void __force __iomem *)                                       \
         (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
         (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))
#else
#define IMX_IO_ADDRESS(addr, module)                                    \
        ((addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT))
#endif

The later is probably preferable.


Nicolas
