From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 01:29:29 +0200
Subject: [PATCH 9/9] at91: add arch specific ioremap support
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305070169-30303-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/include/mach/io.h |   16 +++++++++++++++-
 arch/arm/mach-at91/setup.c           |   19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
index 0b0cccc..6ffc53b 100644
--- a/arch/arm/mach-at91/include/mach/io.h
+++ b/arch/arm/mach-at91/include/mach/io.h
@@ -21,14 +21,28 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
+#include <mach/hardware.h>
+
 #define IO_SPACE_LIMIT		0xFFFFFFFF
 
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-
 #ifndef __ASSEMBLY__
 
+#ifndef CONFIG_ARCH_AT91X40
+#define __arch_ioremap	at91_ioremap
+#define __arch_iounmap	at91_iounmap
+#endif
+
+void __iomem *at91_ioremap(unsigned long phys, size_t size, unsigned int type);
+void at91_iounmap(volatile void __iomem *addr);
+
+static inline unsigned int at91_readl(unsigned int pa)
+{
+	return __raw_readl((void __iomem *)AT91_IO_P2V(pa));
+}
+
 static inline unsigned int at91_sys_read(unsigned int reg_offset)
 {
 	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index d2b1a06..308794d 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 
 #include <asm/mach/map.h>
 
@@ -72,6 +73,24 @@ static struct map_desc at91_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
+void __iomem *at91_ioremap(unsigned long p, size_t size, unsigned int type)
+{
+	if (p >= AT91_BASE_SYS && p <= (AT91_BASE_SYS + SZ_16K - 1))
+		return (void __iomem *)AT91_IO_P2V(p);
+
+	return __arm_ioremap_caller(p, size, type, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(at91_ioremap);
+
+void at91_iounmap(volatile void __iomem *addr)
+{
+	unsigned long virt = (unsigned long)addr;
+
+	if (virt >= VMALLOC_START && virt < VMALLOC_END)
+		__iounmap(addr);
+}
+EXPORT_SYMBOL(at91_iounmap);
+
 #define AT91_DBGU0	0xfffff200
 #define AT91_DBGU1	0xffffee00
 
-- 
1.7.4.1
