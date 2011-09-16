From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:17 -0400
Subject: [PATCH 06/19] ARM: mach-at91: remove arch specific special handling
	for ioremap
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-7-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

A generic version should replace this later.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-at91/include/mach/io.h |    8 --------
 arch/arm/mach-at91/setup.c           |   18 ------------------
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
index 4298e7806c..4ca09ef7ca 100644
--- a/arch/arm/mach-at91/include/mach/io.h
+++ b/arch/arm/mach-at91/include/mach/io.h
@@ -30,14 +30,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifndef CONFIG_ARCH_AT91X40
-#define __arch_ioremap	at91_ioremap
-#define __arch_iounmap	at91_iounmap
-#endif
-
-void __iomem *at91_ioremap(unsigned long phys, size_t size, unsigned int type);
-void at91_iounmap(volatile void __iomem *addr);
-
 static inline unsigned int at91_sys_read(unsigned int reg_offset)
 {
 	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index aa64294c7d..cf98a8f94d 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -73,24 +73,6 @@ static struct map_desc at91_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
-void __iomem *at91_ioremap(unsigned long p, size_t size, unsigned int type)
-{
-	if (p >= AT91_BASE_SYS && p <= (AT91_BASE_SYS + SZ_16K - 1))
-		return (void __iomem *)AT91_IO_P2V(p);
-
-	return __arm_ioremap_caller(p, size, type, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(at91_ioremap);
-
-void at91_iounmap(volatile void __iomem *addr)
-{
-	unsigned long virt = (unsigned long)addr;
-
-	if (virt >= VMALLOC_START && virt < VMALLOC_END)
-		__iounmap(addr);
-}
-EXPORT_SYMBOL(at91_iounmap);
-
 #define AT91_DBGU0	0xfffff200
 #define AT91_DBGU1	0xffffee00
 
-- 
1.7.7-rc0
