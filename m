From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:37 -0600
Subject: [PATCH v3 25/30] ARM: footbridge: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-26-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/mach-footbridge/common.c                  |   12 +++++-------
 .../arm/mach-footbridge/include/mach/debug-macro.S |    3 ++-
 arch/arm/mach-footbridge/include/mach/io.h         |   12 ++----------
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b14bf3c..f2c6727 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -430,7 +430,7 @@ config ARCH_FOOTBRIDGE
 	select FOOTBRIDGE
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
-	select NEED_MACH_IO_H
+	select NEED_MACH_IO_H if !MMU
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for systems based on the DC21285 companion chip
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 41978ee..5c3c7a7 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
- 
+
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/irq.h>
@@ -25,6 +25,7 @@
 
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
+#include <asm/mach/pci.h>
 
 #include "common.h"
 
@@ -174,11 +175,6 @@ static struct map_desc ebsa285_host_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(DC21285_PCI_IACK),
 		.length		= PCIIACK_SIZE,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= PCIO_BASE,
-		.pfn		= __phys_to_pfn(DC21285_PCI_IO),
-		.length		= PCIO_SIZE,
-		.type		= MT_DEVICE,
 	},
 #endif
 };
@@ -195,8 +191,10 @@ void __init footbridge_map_io(void)
 	 * Now, work out what we've got to map in addition on this
 	 * platform.
 	 */
-	if (footbridge_cfn_mode())
+	if (footbridge_cfn_mode()) {
+		pci_map_io_single(DC21285_PCI_IO);
 		iotable_init(ebsa285_host_io_desc, ARRAY_SIZE(ebsa285_host_io_desc));
+	}
 }
 
 void footbridge_restart(char mode, const char *cmd)
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index e5acde2..87c75c8 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -17,7 +17,8 @@
 	/* For NetWinder debugging */
 		.macro	addruart, rp, rv, tmp
 		mov	\rp, #0x000003f8
-		orr	\rv, \rp, #0xff000000	@ virtual
+		orr	\rv, \rp, #0xfe000000	@ virtual
+		orr	\rv, \rv, #0x00f00000	@ virtual
 		orr	\rp, \rp, #0x7c000000	@ physical
 		.endm
 
diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
index aba531ee..aba4638 100644
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ b/arch/arm/mach-footbridge/include/mach/io.h
@@ -14,18 +14,10 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#ifdef CONFIG_MMU
-#define MMU_IO(a, b)	(a)
-#else
-#define MMU_IO(a, b)	(b)
-#endif
-
-#define PCIO_SIZE       0x00100000
-#define PCIO_BASE       MMU_IO(0xff000000, 0x7c000000)
-
 /*
- * Translation of various region addresses to virtual addresses
+ * Translation of various i/o addresses to host addresses for !CONFIG_MMU
  */
+#define PCIO_BASE       0x7c000000
 #define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
 
 #endif
-- 
1.7.5.4
