From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue,  3 May 2011 00:13:23 +0200
Subject: [PATCH 3/3] at91: make PLAT_PHYS_OFFSET depending on
	!ARM_PATCH_PHYS_VIRT or XIP_KERNEL
In-Reply-To: <1304374403-28513-1-git-send-email-plagnioj@jcrosoft.com>
References: <1304374403-28513-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1304374403-28513-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Andrew Victor <linux@maxim.org.za>
---
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 --
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 --
 arch/arm/mach-at91/include/mach/hardware.h    |    7 -------
 arch/arm/mach-at91/include/mach/memory.h      |   11 ++++++++++-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index a043bce..6659938 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -121,6 +121,4 @@
 #define AT91CAP9_UDPHS_FIFO	0x00600000	/* USB High Speed Device Port */
 #define AT91CAP9_UHP_BASE	0x00700000	/* USB Host controller */
 
-#define CONFIG_DRAM_BASE	AT91_CHIPSELECT_6
-
 #endif
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 520b14b..659304a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -129,8 +129,6 @@
 #define AT91SAM9G45_EHCI_BASE	0x00800000	/* USB Host controller (EHCI) */
 #define AT91SAM9G45_VDEC_BASE	0x00900000	/* Video Decoder Controller */
 
-#define CONFIG_DRAM_BASE	AT91_CHIPSELECT_6
-
 #define CONSISTENT_DMA_SIZE	SZ_4M
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 3522464..469d3af 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -88,13 +88,6 @@
 #define AT91_CHIPSELECT_6	0x70000000
 #define AT91_CHIPSELECT_7	0x80000000
 
-/* SDRAM */
-#ifdef CONFIG_DRAM_BASE
-#define AT91_SDRAM_BASE		CONFIG_DRAM_BASE
-#else
-#define AT91_SDRAM_BASE		AT91_CHIPSELECT_1
-#endif
-
 /* Clocks */
 #define AT91_SLOW_CLOCK		32768		/* slow clock */
 
diff --git a/arch/arm/mach-at91/include/mach/memory.h b/arch/arm/mach-at91/include/mach/memory.h
index c2cfe50..a643b4e 100644
--- a/arch/arm/mach-at91/include/mach/memory.h
+++ b/arch/arm/mach-at91/include/mach/memory.h
@@ -23,6 +23,15 @@
 
 #include <mach/hardware.h>
 
-#define PLAT_PHYS_OFFSET	(AT91_SDRAM_BASE)
+#define AT91_SDRAM_BASE		AT91_CHIPSELECT_1
+#define AT91SAM9G45_SDRAM_BASE	AT91_CHIPSELECT_6
+
+#if !defined(CONFIG_ARM_PATCH_PHYS_VIRT) || defined(CONFIG_XIP_KERNEL)
+# if defined CONFIG_ARCH_AT91SAM9G45
+#  define PLAT_PHYS_OFFSET		AT91SAM9G45_SDRAM_BASE
+# else
+#  define PLAT_PHYS_OFFSET		AT91_SDRAM_BASE
+# endif
+#endif
 
 #endif
-- 
1.7.4.1
