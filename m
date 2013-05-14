From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 14 May 2013 12:33:50 -0700
Subject: [PATCHv2] arm: mm: Use phys_addr_t properly for ioremap functions
Message-ID: <1368560031-19367-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several of the ioremap functions use unsigned long in places
resulting in truncation if physical addresses greater than
4G are passed in. Change the types of the functions and the
callers accordingly.

Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/io.h     |    8 ++++----
 arch/arm/mach-ebsa110/core.c  |    2 +-
 arch/arm/mach-imx/mm-imx3.c   |    2 +-
 arch/arm/mach-iop13xx/io.c    |    2 +-
 arch/arm/mach-ixp4xx/common.c |    2 +-
 arch/arm/mach-msm/common.h    |    2 +-
 arch/arm/mach-msm/io.c        |    2 +-
 arch/arm/mm/ioremap.c         |   10 +++++-----
 arch/arm/mm/nommu.c           |    6 +++---
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 652b560..d070741 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -130,16 +130,16 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
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
 
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index b13cc74..8a53f34 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -116,7 +116,7 @@ static void __init ebsa110_map_io(void)
 	iotable_init(ebsa110_io_desc, ARRAY_SIZE(ebsa110_io_desc));
 }
 
-static void __iomem *ebsa110_ioremap_caller(unsigned long cookie, size_t size,
+static void __iomem *ebsa110_ioremap_caller(phys_addr_t cookie, size_t size,
 					    unsigned int flags, void *caller)
 {
 	return (void __iomem *)cookie;
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index e0e69a6..eed32ca 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -65,7 +65,7 @@ static void imx3_idle(void)
 		: "=r" (reg));
 }
 
-static void __iomem *imx3_ioremap_caller(unsigned long phys_addr, size_t size,
+static void __iomem *imx3_ioremap_caller(phys_addr_t phys_addr, size_t size,
 					 unsigned int mtype, void *caller)
 {
 	if (mtype == MT_DEVICE) {
diff --git a/arch/arm/mach-iop13xx/io.c b/arch/arm/mach-iop13xx/io.c
index 183dc8b..faaf7d4 100644
--- a/arch/arm/mach-iop13xx/io.c
+++ b/arch/arm/mach-iop13xx/io.c
@@ -23,7 +23,7 @@
 
 #include "pci.h"
 
-static void __iomem *__iop13xx_ioremap_caller(unsigned long cookie,
+static void __iomem *__iop13xx_ioremap_caller(phys_addr_t cookie,
 	size_t size, unsigned int mtype, void *caller)
 {
 	void __iomem * retval;
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 6600cff..d7223b3 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -559,7 +559,7 @@ void ixp4xx_restart(char mode, const char *cmd)
  * fallback to the default.
  */
 
-static void __iomem *ixp4xx_ioremap_caller(unsigned long addr, size_t size,
+static void __iomem *ixp4xx_ioremap_caller(phys_addr_t addr, size_t size,
 					   unsigned int mtype, void *caller)
 {
 	if (!is_pci_memory(addr))
diff --git a/arch/arm/mach-msm/common.h b/arch/arm/mach-msm/common.h
index ce8215a..421cf77 100644
--- a/arch/arm/mach-msm/common.h
+++ b/arch/arm/mach-msm/common.h
@@ -23,7 +23,7 @@ extern void msm_map_msm8x60_io(void);
 extern void msm_map_msm8960_io(void);
 extern void msm_map_qsd8x50_io(void);
 
-extern void __iomem *__msm_ioremap_caller(unsigned long phys_addr, size_t size,
+extern void __iomem *__msm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 					  unsigned int mtype, void *caller);
 
 extern struct smp_operations msm_smp_ops;
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 123ef9c..fd65b6d 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -172,7 +172,7 @@ void __init msm_map_msm7x30_io(void)
 }
 #endif /* CONFIG_ARCH_MSM7X30 */
 
-void __iomem *__msm_ioremap_caller(unsigned long phys_addr, size_t size,
+void __iomem *__msm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 				   unsigned int mtype, void *caller)
 {
 	if (mtype == MT_DEVICE) {
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 04d9006..f123d6e 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -331,10 +331,10 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	return (void __iomem *) (offset + addr);
 }
 
-void __iomem *__arm_ioremap_caller(unsigned long phys_addr, size_t size,
+void __iomem *__arm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 	unsigned int mtype, void *caller)
 {
-	unsigned long last_addr;
+	phys_addr_t last_addr;
  	unsigned long offset = phys_addr & ~PAGE_MASK;
  	unsigned long pfn = __phys_to_pfn(phys_addr);
 
@@ -367,12 +367,12 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
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
@@ -387,7 +387,7 @@ EXPORT_SYMBOL(__arm_ioremap);
  * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
  */
 void __iomem *
-__arm_ioremap_exec(unsigned long phys_addr, size_t size, bool cached)
+__arm_ioremap_exec(phys_addr_t phys_addr, size_t size, bool cached)
 {
 	unsigned int mtype;
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d51225f..31bd77b 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -81,16 +81,16 @@ void __iomem *__arm_ioremap_pfn_caller(unsigned long pfn, unsigned long offset,
 	return __arm_ioremap_pfn(pfn, offset, size, mtype);
 }
 
-void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
+void __iomem *__arm_ioremap(phys_addr_t phys_addr, size_t size,
 			    unsigned int mtype)
 {
 	return (void __iomem *)phys_addr;
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
-void __iomem * (*arch_ioremap_caller)(unsigned long, size_t, unsigned int, void *);
+void __iomem * (*arch_ioremap_caller)(phys_addr_t, size_t, unsigned int, void *);
 
-void __iomem *__arm_ioremap_caller(unsigned long phys_addr, size_t size,
+void __iomem *__arm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 				   unsigned int mtype, void *caller)
 {
 	return __arm_ioremap(phys_addr, size, mtype);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
