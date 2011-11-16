From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:30 -0500
Subject: [PATCH 12/23] ARM: plat-iop: remove arch specific special handling for
 ioremap
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-13-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

A generic version should replace this later.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-iop32x/include/mach/io.h |    7 ----
 arch/arm/mach-iop33x/include/mach/io.h |    7 ----
 arch/arm/plat-iop/Makefile             |    2 -
 arch/arm/plat-iop/io.c                 |   59 --------------------------------
 4 files changed, 0 insertions(+), 75 deletions(-)
 delete mode 100644 arch/arm/plat-iop/io.c

diff --git a/arch/arm/mach-iop32x/include/mach/io.h b/arch/arm/mach-iop32x/include/mach/io.h
index 059c783ce0..2d88264b98 100644
--- a/arch/arm/mach-iop32x/include/mach/io.h
+++ b/arch/arm/mach-iop32x/include/mach/io.h
@@ -13,15 +13,8 @@
 
 #include <asm/hardware/iop3xx.h>
 
-extern void __iomem *__iop3xx_ioremap(unsigned long cookie, size_t size,
-	unsigned int mtype);
-extern void __iop3xx_iounmap(void __iomem *addr);
-
 #define IO_SPACE_LIMIT		0xffffffff
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
 #define __mem_pci(a)		(a)
 
-#define __arch_ioremap	__iop3xx_ioremap
-#define __arch_iounmap	__iop3xx_iounmap
-
 #endif
diff --git a/arch/arm/mach-iop33x/include/mach/io.h b/arch/arm/mach-iop33x/include/mach/io.h
index 39e893e97c..a8a66fc8fb 100644
--- a/arch/arm/mach-iop33x/include/mach/io.h
+++ b/arch/arm/mach-iop33x/include/mach/io.h
@@ -13,15 +13,8 @@
 
 #include <asm/hardware/iop3xx.h>
 
-extern void __iomem *__iop3xx_ioremap(unsigned long cookie, size_t size,
-	unsigned int mtype);
-extern void __iop3xx_iounmap(void __iomem *addr);
-
 #define IO_SPACE_LIMIT		0xffffffff
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
 #define __mem_pci(a)		(a)
 
-#define __arch_ioremap	__iop3xx_ioremap
-#define __arch_iounmap	__iop3xx_iounmap
-
 #endif
diff --git a/arch/arm/plat-iop/Makefile b/arch/arm/plat-iop/Makefile
index 69b09c1cec..90f7153a8d 100644
--- a/arch/arm/plat-iop/Makefile
+++ b/arch/arm/plat-iop/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_ARCH_IOP32X) += i2c.o
 obj-$(CONFIG_ARCH_IOP32X) += pci.o
 obj-$(CONFIG_ARCH_IOP32X) += setup.o
 obj-$(CONFIG_ARCH_IOP32X) += time.o
-obj-$(CONFIG_ARCH_IOP32X) += io.o
 obj-$(CONFIG_ARCH_IOP32X) += cp6.o
 obj-$(CONFIG_ARCH_IOP32X) += adma.o
 obj-$(CONFIG_ARCH_IOP32X) += pmu.o
@@ -21,7 +20,6 @@ obj-$(CONFIG_ARCH_IOP33X) += i2c.o
 obj-$(CONFIG_ARCH_IOP33X) += pci.o
 obj-$(CONFIG_ARCH_IOP33X) += setup.o
 obj-$(CONFIG_ARCH_IOP33X) += time.o
-obj-$(CONFIG_ARCH_IOP33X) += io.o
 obj-$(CONFIG_ARCH_IOP33X) += cp6.o
 obj-$(CONFIG_ARCH_IOP33X) += adma.o
 obj-$(CONFIG_ARCH_IOP33X) += pmu.o
diff --git a/arch/arm/plat-iop/io.c b/arch/arm/plat-iop/io.c
deleted file mode 100644
index e15bc17db9..0000000000
--- a/arch/arm/plat-iop/io.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * iop3xx custom ioremap implementation
- * Copyright (c) 2006, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
- *
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <mach/hardware.h>
-
-void * __iomem __iop3xx_ioremap(unsigned long cookie, size_t size,
-	unsigned int mtype)
-{
-	void __iomem * retval;
-
-	switch (cookie) {
-	case IOP3XX_PCI_LOWER_IO_PA ... IOP3XX_PCI_UPPER_IO_PA:
-		retval = (void *) IOP3XX_PCI_IO_PHYS_TO_VIRT(cookie);
-		break;
-	case IOP3XX_PERIPHERAL_PHYS_BASE ... IOP3XX_PERIPHERAL_UPPER_PA:
-		retval = (void *) IOP3XX_PMMR_PHYS_TO_VIRT(cookie);
-		break;
-	default:
-		retval = __arm_ioremap_caller(cookie, size, mtype,
-				__builtin_return_address(0));
-	}
-
-	return retval;
-}
-EXPORT_SYMBOL(__iop3xx_ioremap);
-
-void __iop3xx_iounmap(void __iomem *addr)
-{
-	extern void __iounmap(volatile void __iomem *addr);
-
-	switch ((u32) addr) {
-	case IOP3XX_PCI_LOWER_IO_VA ... IOP3XX_PCI_UPPER_IO_VA:
-	case IOP3XX_PERIPHERAL_VIRT_BASE ... IOP3XX_PERIPHERAL_UPPER_VA:
-		goto skip;
-	}
-	__iounmap(addr);
-
-skip:
-	return;
-}
-EXPORT_SYMBOL(__iop3xx_iounmap);
-- 
1.7.7.1.431.g10b2a
