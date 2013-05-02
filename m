From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 19:23:22 +0200
Subject: [PATCH 2/4] ARM: fix prototypes for arch_ioremap_caller functions
In-Reply-To: <1367515404-512212-1-git-send-email-arnd@arndb.de>
References: <1367515404-512212-1-git-send-email-arnd@arndb.de>
Message-ID: <1367515404-512212-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch "ARM: 7704/1: mm: Use phys_addr_t properly for ioremap
functions" changes the prototype for the arch_ioremap_caller()
function, a change which was evidently never tested, because
all functions that get assigned to this pointer still have
an unchanged prototype:

arch/arm/mach-ebsa110/core.c: In function 'ebsa110_init_early':
arch/arm/mach-ebsa110/core.c:130:22: warning: assignment from incompatible pointer type [enabled by default]
  arch_ioremap_caller = ebsa110_ioremap_caller;
                      ^
arch/arm/mach-iop13xx/io.c: In function 'iop13xx_init_early':
arch/arm/mach-iop13xx/io.c:88:22: warning: assignment from incompatible pointer type [enabled by default]
  arch_ioremap_caller = __iop13xx_ioremap_caller;
                      ^

This does the trivial change to all the respective functions
to avoid the build warnings.

Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ebsa110/core.c  | 2 +-
 arch/arm/mach-imx/mm-imx3.c   | 2 +-
 arch/arm/mach-iop13xx/io.c    | 2 +-
 arch/arm/mach-ixp4xx/common.c | 2 +-
 arch/arm/mach-msm/common.h    | 2 +-
 arch/arm/mach-msm/io.c        | 2 +-
 arch/arm/mm/nommu.c           | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

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
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index dd3a6c6..e9f2e44 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -95,7 +95,7 @@ void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
-void __iomem * (*arch_ioremap_caller)(unsigned long, size_t, unsigned int, void *);
+void __iomem * (*arch_ioremap_caller)(phys_addr_t, size_t, unsigned int, void *);
 
 void __iomem *__arm_ioremap_caller(unsigned long phys_addr, size_t size,
 				   unsigned int mtype, void *caller)
-- 
1.8.1.2
