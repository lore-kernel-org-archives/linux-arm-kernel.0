From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Mar 2012 22:02:57 -0600
Subject: [PATCH v4 1/4] ARM: provide runtime hook for ioremap/iounmap
In-Reply-To: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
Message-ID: <1331006580-3579-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

We have compile time over-ride of ioremap and iounmap, but an run-time
override is needed for multi-platform builds. This adds an extra function
pointer check, but ioremap is not peformance critical. The option for
compile time selection remains.

The caller variant is used here to provide correct caller information as
ARM can only support level 0 for __builtin_return_address.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/io.h |    7 ++++++-
 arch/arm/mm/ioremap.c     |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 9275828..6c363c1 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -83,6 +83,11 @@ extern void __iomem *__arm_ioremap_pfn(unsigned long, unsigned long, size_t, uns
 extern void __iomem *__arm_ioremap(unsigned long, size_t, unsigned int);
 extern void __iomem *__arm_ioremap_exec(unsigned long, size_t, bool cached);
 extern void __iounmap(volatile void __iomem *addr);
+extern void __arm_iounmap(volatile void __iomem *addr);
+
+extern void __iomem * (*arch_ioremap_caller)(unsigned long, size_t,
+	unsigned int, void *);
+extern void (*arch_iounmap)(volatile void __iomem *);
 
 /*
  * Bad read/write accesses...
@@ -266,7 +271,7 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  */
 #ifndef __arch_ioremap
 #define __arch_ioremap			__arm_ioremap
-#define __arch_iounmap			__iounmap
+#define __arch_iounmap			__arm_iounmap
 #endif
 
 #define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 80632e8..c37c67a 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -306,9 +306,16 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
 }
 EXPORT_SYMBOL(__arm_ioremap_pfn);
 
+void __iomem * (*arch_ioremap_caller)(unsigned long, size_t, unsigned int, void *);
+EXPORT_SYMBOL(arch_ioremap_caller);
+
 void __iomem *
 __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 {
+	if (arch_ioremap_caller)
+		return arch_ioremap_caller(phys_addr, size, mtype,
+			__builtin_return_address(0));
+
 	return __arm_ioremap_caller(phys_addr, size, mtype,
 			__builtin_return_address(0));
 }
@@ -370,3 +377,12 @@ void __iounmap(volatile void __iomem *io_addr)
 	vunmap(addr);
 }
 EXPORT_SYMBOL(__iounmap);
+
+void (*arch_iounmap)(volatile void __iomem *) = __iounmap;
+EXPORT_SYMBOL(arch_iounmap);
+
+void __arm_iounmap(volatile void __iomem *io_addr)
+{
+	arch_iounmap(io_addr);
+}
+EXPORT_SYMBOL(__arm_iounmap);
-- 
1.7.5.4
