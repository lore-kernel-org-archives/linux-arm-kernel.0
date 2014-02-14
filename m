From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Feb 2014 11:29:31 +0100
Subject: [PATCH 6/6] RFC: ARM: integrator: get rid of <mach/memory.h>
In-Reply-To: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
References: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1392373771-17303-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator has a custom <mach/memory.h> header defining the
BUS_OFFSET for *_to_bus and bus_to_* operations as offset from
0x80000000.

I have searched the documentation and cannot find any clue to
this set-up. The Integrators have no intrinsic DMA engine(s)
that need to perform any bus translations. The only thing I can
think of is the PCIv3 host found in the Integrator/AP. After
searching its documentation I cannot find any hint whatsoever
saying that it would perform DMA operations to memory offset
to 0x80000000. The PCIv3 driver does not configure anything
for DMA, and the hardware contains registers to configure
the local (CPU) side address translation. When I dump the
default values of these registers (the Linux driver does not
touch them) they contain zeroes meaning a 1-to-1 mapping to
the bus.

So patch the mapping to use the kernel default.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Admittedly I'm not certain about how DMA works in PCI scenarios
(only experienced with DMA engines) so some input here would be
appreciated. Like if DMA support is compulory for PCI hosts or
if it's somehow even unused on the PCIv3. And if someone has
ever tested some DMA:ing PCI card on this machine.
---
 arch/arm/Kconfig                               |  1 -
 arch/arm/mach-integrator/include/mach/memory.h | 34 --------------------------
 2 files changed, 35 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e25419817791..c4094131314e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -325,7 +325,6 @@ config ARCH_INTEGRATOR
 	select HAVE_TCM
 	select ICST
 	select MULTI_IRQ_HANDLER
-	select NEED_MACH_MEMORY_H
 	select PLAT_VERSATILE
 	select SPARSE_IRQ
 	select USE_OF
diff --git a/arch/arm/mach-integrator/include/mach/memory.h b/arch/arm/mach-integrator/include/mach/memory.h
deleted file mode 100644
index 334d5e271889..000000000000
--- a/arch/arm/mach-integrator/include/mach/memory.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- *  arch/arm/mach-integrator/include/mach/memory.h
- *
- *  Copyright (C) 1999 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#define BUS_OFFSET	UL(0x80000000)
-#define __virt_to_bus(x)	((x) - PAGE_OFFSET + BUS_OFFSET)
-#define __bus_to_virt(x)	((x) - BUS_OFFSET + PAGE_OFFSET)
-#define __pfn_to_bus(x)		(__pfn_to_phys(x) + (BUS_OFFSET - PHYS_OFFSET))
-#define __bus_to_pfn(x)		__phys_to_pfn((x) - (BUS_OFFSET - PHYS_OFFSET))
-
-#endif
-- 
1.8.5.3
