From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 May 2011 15:52:39 +0800
Subject: [PATCH] arm: introduce arch_ioremap and arch_iounmap function pointer
Message-ID: <mailman.0.1306063052.23796.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

today we define it at runtime via __arch_ioremap and __arch_iounmap

this PATH will allow to overwrite the default ioremap at runtime
to be able to compile multiple soc in the same kernel

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/include/asm/io.h |   12 ++++++++++--
 arch/arm/mm/ioremap.c     |   22 ++++++++++++++++++++++
 arch/arm/mm/nommu.c       |    4 ++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d66605d..3067f00 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -242,10 +242,13 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  *
  */
 #ifndef __arch_ioremap
-#define __arch_ioremap			__arm_ioremap
-#define __arch_iounmap			__iounmap
+#define __arch_ioremap			arm_ioremap
+#define __arch_iounmap			arm_iounmap
 #endif
 
+extern void __iomem* (*arch_ioremap)(unsigned long p, size_t size, unsigned int type);
+extern void (*arch_iounmap)(volatile void __iomem *addr);
+
 #define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_nocache(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_cached(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE_CACHED)
@@ -274,6 +277,11 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
 extern void ioport_unmap(void __iomem *addr);
+
+extern void __iomem *
+arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype);
+extern void arm_iounmap(volatile void __iomem *io_addr);
+
 #endif
 
 struct pci_dev;
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..ee53d08 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -281,6 +281,28 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
 }
 EXPORT_SYMBOL(__arm_ioremap_pfn);
 
+void __iomem* (*arch_ioremap)(unsigned long p, size_t size, unsigned int type);
+void (*arch_iounmap)(volatile void __iomem *addr);
+
+void __iomem *
+arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
+{
+	if (arch_ioremap)
+		return arch_ioremap(phys_addr, size, mtype);
+	else
+		return __arm_ioremap(phys_addr, size, mtype);
+}
+EXPORT_SYMBOL(arm_ioremap);
+
+void arm_iounmap(volatile void __iomem *io_addr)
+{
+	if (arch_iounmap) {
+		arch_iounmap(io_addr);
+	else
+		__iounmap(io_addr);
+}
+EXPORT_SYMBOL(arm_iounmap);
+
 void __iomem *
 __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 {
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 687d023..561f19f 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -73,6 +73,10 @@ void __iomem *__arm_ioremap_pfn_caller(unsigned long pfn, unsigned long offset,
 	return __arm_ioremap_pfn(pfn, offset, size, mtype);
 }
 
+/* declare to just avoid the ifdef in nommu case */
+void __iomem* (*arch_ioremap)(unsigned long p, size_t size, unsigned int type);
+void (*arch_iounmap)(volatile void __iomem *addr);
+
 void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
 			    unsigned int mtype)
 {
-- 
1.7.4.1


--LpQ9ahxlCli8rRTG--
