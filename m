From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 May 2011 11:04:39 +0200
Subject: [RFC PATCH 1/2] arm: introduce arch_ioremap and arch_iounmap function
	pointer
Message-ID: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

today we define it at runtime via __arch_ioremap and __arch_iounmap

this PATH will allow to overwrite the default ioremap at runtime
to be able to compile multiple soc in the same kernel

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/include/asm/io.h |    3 +++
 arch/arm/mm/ioremap.c     |   16 +++++++++++++++-
 arch/arm/mm/nommu.c       |    4 ++++
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d66605d..0c0cfe0 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -246,6 +246,9 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define __arch_iounmap			__iounmap
 #endif
 
+extern void __iomem* (*arch_ioremap)(unsigned long p, size_t size, unsigned int type);
+extern void (*arch_iounmap)(volatile void __iomem *addr);
+
 #define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_nocache(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_cached(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE_CACHED)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..40ef390 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -281,9 +281,15 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
 }
 EXPORT_SYMBOL(__arm_ioremap_pfn);
 
+void __iomem* (*arch_ioremap)(unsigned long p, size_t size, unsigned int type);
+void (*arch_iounmap)(volatile void __iomem *addr);
+
 void __iomem *
 __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 {
+	if (arch_ioremap)
+		return arch_ioremap(phys_addr, size, mtype);
+
 	return __arm_ioremap_caller(phys_addr, size, mtype,
 			__builtin_return_address(0));
 }
@@ -291,10 +297,18 @@ EXPORT_SYMBOL(__arm_ioremap);
 
 void __iounmap(volatile void __iomem *io_addr)
 {
-	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
+	void *addr;
 #ifndef CONFIG_SMP
 	struct vm_struct **p, *tmp;
+#endif
 
+	if (arch_iounmap) {
+		arch_iounmap(io_addr);
+		return;
+	}
+
+	addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
+#ifndef CONFIG_SMP
 	/*
 	 * If this is a section based mapping we need to handle it
 	 * specially as the VM subsystem does not know how to handle
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
