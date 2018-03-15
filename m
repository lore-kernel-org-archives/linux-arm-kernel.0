From: tmaimon77@gmail.com (Tomer Maimon)
Date: Fri, 16 Mar 2018 01:10:11 +0200
Subject: [PATCH v1 1/2] arm: npcm: modify configuration for the NPCM7xx BMC.
In-Reply-To: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
Message-ID: <1521155412-29229-2-git-send-email-tmaimon77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify configuration and MakeFile
for the Nuvoton NPCM and NPCM7xx BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/mach-npcm/Kconfig  | 40 +++++++++++-----------------------------
 arch/arm/mach-npcm/Makefile |  4 +++-
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
index 6ff9df2636be..684c9c9a32bd 100644
--- a/arch/arm/mach-npcm/Kconfig
+++ b/arch/arm/mach-npcm/Kconfig
@@ -1,48 +1,30 @@
 menuconfig ARCH_NPCM
 	bool "Nuvoton NPCM Architecture"
-	select ARCH_REQUIRE_GPIOLIB
-	select USE_OF
+	depends on ARCH_MULTI_V7
 	select PINCTRL
-	select PINCTRL_NPCM7XX
 
 if ARCH_NPCM
 
-comment "NPCM7XX CPU type"
-
-config ARCH_NPCM750
-	depends on ARCH_NPCM && ARCH_MULTI_V7
-	bool "Support for NPCM750 BMC CPU (Poleg)"
+config ARCH_NPCM7XX
+	bool "Support for NPCM7xx BMC (Poleg)"
+	depends on ARCH_MULTI_V7
+	select PINCTRL_NPCM7XX
+	select NPCM7XX_TIMER
+	select ARCH_REQUIRE_GPIOLIB
 	select CACHE_L2X0
-	select CPU_V7
 	select ARM_GIC
-	select HAVE_SMP
-	select SMP
-	select SMP_ON_UP
-	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU if SMP
+	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_754322
-	select ARM_ERRATA_764369
 	select ARM_ERRATA_794072
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
-	select USB_EHCI_ROOT_HUB_TT
-	select USB_ARCH_HAS_HCD
-	select USB_ARCH_HAS_EHCI
-	select USB_EHCI_HCD
-	select USB_ARCH_HAS_OHCI
-	select USB_OHCI_HCD
-	select USB
-	select FIQ
-	select CPU_USE_DOMAINS
-	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select COMMON_CLK if OF
-	select NPCM750_TIMER
 	select MFD_SYSCON
 	help
-	  Support for NPCM750 BMC CPU (Poleg).
+	  General support for NPCM7xx BMC (Poleg).
 
-	  Nuvoton NPCM750 BMC based on the Cortex A9.
+	  Nuvoton NPCM7xx BMC based on the Cortex A9.
 
 endif
diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
index c7a1316d27c1..0839e8926a84 100644
--- a/arch/arm/mach-npcm/Makefile
+++ b/arch/arm/mach-npcm/Makefile
@@ -1,3 +1,5 @@
 AFLAGS_headsmp.o		+= -march=armv7-a
 
-obj-$(CONFIG_ARCH_NPCM750)	+= npcm7xx.o platsmp.o headsmp.o
+obj-$(CONFIG_ARCH_NPCM7XX)	+= npcm7xx.o
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+
-- 
2.14.1
