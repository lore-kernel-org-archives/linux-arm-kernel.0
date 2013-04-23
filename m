From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 23 Apr 2013 16:51:38 -0700
Subject: [PATCH] arm: mm: Use phys_addr_t properly for ioremap functions
Message-ID: <1366761098-4485-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several of the ioremap functions use unsigned long in places
resulting in truncation if physical addresses greater than
4G are passed in. Change the types appropriately.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/io.h |    8 ++++----
 arch/arm/mm/ioremap.c     |   12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c1295c4..70d82ec 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -119,16 +119,16 @@ extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
  */
 extern void __iomem *__arm_ioremap_pfn_caller(unsigned long, unsigned long,
 	size_t, unsigned int, void *);
-extern void __iomem *__arm_ioremap_caller(unsigned long, size_t, unsigned int,
+extern void __iomem *__arm_ioremap_caller(phys_addr_t, size_t, unsigned int,
 	void *);
 
 extern void __iomem *__arm_ioremap_pfn(unsigned long, unsigned long, size_t, unsigned int);
-extern void __iomem *__arm_ioremap(unsigned long, size_t, unsigned int);
-extern void __iomem *__arm_ioremap_exec(unsigned long, size_t, bool cached);
+extern void __iomem *__arm_ioremap(phys_addr_t, size_t, unsigned int);
+extern void __iomem *__arm_ioremap_exec(phys_addr_t, size_t, bool cached);
 extern void __iounmap(volatile void __iomem *addr);
 extern void __arm_iounmap(volatile void __iomem *addr);
 
-extern void __iomem * (*arch_ioremap_caller)(unsigned long, size_t,
+extern void __iomem * (*arch_ioremap_caller)(phys_addr_t, size_t,
 	unsigned int, void *);
 extern void (*arch_iounmap)(volatile void __iomem *);
 
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 8df41e2..07b6f6c 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -280,11 +280,11 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	return (void __iomem *) (offset + addr);
 }
 
-void __iomem *__arm_ioremap_caller(unsigned long phys_addr, size_t size,
+void __iomem *__arm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 	unsigned int mtype, void *caller)
 {
-	unsigned long last_addr;
- 	unsigned long offset = phys_addr & ~PAGE_MASK;
+	phys_addr_t last_addr;
+	phys_addr_t offset = phys_addr & ~PAGE_MASK;
  	unsigned long pfn = __phys_to_pfn(phys_addr);
 
  	/*
@@ -316,12 +316,12 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
 }
 EXPORT_SYMBOL(__arm_ioremap_pfn);
 
-void __iomem * (*arch_ioremap_caller)(unsigned long, size_t,
+void __iomem * (*arch_ioremap_caller)(phys_addr_t, size_t,
 				      unsigned int, void *) =
 	__arm_ioremap_caller;
 
 void __iomem *
-__arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
+__arm_ioremap(phys_addr_t phys_addr, size_t size, unsigned int mtype)
 {
 	return arch_ioremap_caller(phys_addr, size, mtype,
 		__builtin_return_address(0));
@@ -336,7 +336,7 @@ EXPORT_SYMBOL(__arm_ioremap);
  * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
  */
 void __iomem *
-__arm_ioremap_exec(unsigned long phys_addr, size_t size, bool cached)
+__arm_ioremap_exec(phys_addr_t phys_addr, size_t size, bool cached)
 {
 	unsigned int mtype;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
