From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 9 May 2014 10:44:28 -0500
Subject: [PATCH] ARM: socfpga: Remove static declaration for the SCU virtual
 address
Message-ID: <1399650268-30964-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Use common scu_a9_get_base() to get the SCU base address and just
use what scu_a9_get_base() returns as the virtual address.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/mach-socfpga/core.h    |    2 --
 arch/arm/mach-socfpga/socfpga.c |   15 +++++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 572b8f7..6e2560c 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -42,6 +42,4 @@ extern char secondary_trampoline, secondary_trampoline_end;
 
 extern unsigned long cpu1start_addr;
 
-#define SOCFPGA_SCU_VIRT_BASE   0xfffec000
-
 #endif
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index d86231e..5d65b41 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -23,16 +23,16 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/smp_scu.h>
 
 #include "core.h"
 
-void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
+void __iomem *socfpga_scu_base_addr;
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
 unsigned long cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
-	.virtual	= SOCFPGA_SCU_VIRT_BASE,
 	.pfn		= 0, /* run-time */
 	.length		= SZ_8K,
 	.type		= MT_DEVICE,
@@ -49,11 +49,14 @@ static void __init socfpga_scu_map_io(void)
 {
 	unsigned long base;
 
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+	if (scu_a9_has_base()) {
+		base = scu_a9_get_base();
 
-	scu_io_desc.pfn = __phys_to_pfn(base);
-	iotable_init(&scu_io_desc, 1);
+		scu_io_desc.pfn = __phys_to_pfn(base);
+		scu_io_desc.virtual = base;
+		iotable_init(&scu_io_desc, 1);
+		socfpga_scu_base_addr = (void __iomem *)base;
+	}
 }
 
 static void __init socfpga_map_io(void)
-- 
1.7.9.5
