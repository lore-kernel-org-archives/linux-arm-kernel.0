From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 14:40:27 +0200
Subject: [PATCH 2/5] ARM: realview: reduce the RealView Kconfig
In-Reply-To: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
References: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1470832830-10274-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We select all we need to the device tree boot and and do not
really need all the sub-options to get this running smoothly.
We will support the ARMv5, ARMv6, ARMv7 or ARMv6+ARMv7
build depending on what the user selects.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/Kconfig | 127 +++--------------------------------------
 1 file changed, 8 insertions(+), 119 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 70ab4a25a5f8..a52b35aeca86 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -17,9 +17,13 @@ config REALVIEW_DT
 	bool "Support RealView(R) Device Tree based boot"
 	select ARM_GIC
 	select CLK_SP810
-	select HAVE_SMP
+	select CPU_ARM926T if ARCH_MULTI_V5
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select HAVE_PATA_PLATFORM
+	select HAVE_SMP if ARCH_MULTI_V6
+	select HAVE_TCM
 	select ICST
-	select MACH_REALVIEW_EB if ARCH_MULTI_V5
 	select MFD_SYSCON
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
@@ -27,129 +31,14 @@ config REALVIEW_DT
 	select SMP_ON_UP if SMP
 	select SOC_REALVIEW
 	select USE_OF
+	select ZONE_DMA
 	help
 	  Include support for booting the ARM(R) RealView(R) evaluation
 	  boards using a device tree machine description.
 
-config MACH_REALVIEW_EB
-	bool "Support RealView(R) Emulation Baseboard"
-	select ARM_GIC
-	select CPU_ARM926T if ARCH_MULTI_V5
-	help
-	  Include support for the ARM(R) RealView(R) Emulation Baseboard
-	  platform. On an ARMv5 kernel, this will include support for
-	  the ARM926EJ-S core tile, while on an ARMv6/v7 kernel, at least
-	  one of the ARM1136, ARM1176, ARM11MPCore or Cortex-A9MPCore
-	  core tile options should be enabled.
-
-config REALVIEW_EB_ARM1136
-	bool "Support ARM1136J(F)-S Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
-	select CPU_V6
-	help
-	  Enable support for the ARM1136 tile fitted to the
-	  Realview(R) Emulation Baseboard platform.
-
-config REALVIEW_EB_ARM1176
-	bool "Support ARM1176JZ(F)-S Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
-	help
-	  Enable support for the ARM1176 tile fitted to the
-	  Realview(R) Emulation Baseboard platform.
-
-config REALVIEW_EB_A9MP
-	bool "Support Multicore Cortex-A9 Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V7
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	help
-	  Enable support for the Cortex-A9MPCore tile fitted to the
-	  Realview(R) Emulation Baseboard platform.
-
-config REALVIEW_EB_ARM11MP
-	bool "Support ARM11MPCore Tile"
-	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	help
-	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
-	  Emulation Baseboard platform.
-
-config REALVIEW_EB_ARM11MP_REVB
-	bool "Support ARM11MPCore RevB Tile"
-	depends on REALVIEW_EB_ARM11MP && ARCH_MULTI_V6
-	help
-	  Enable support for the ARM11MPCore Revision B tile on the
-	  Realview(R) Emulation Baseboard platform. Since there are device
-	  address differences, a kernel built with this option enabled is
-	  not compatible with other revisions of the ARM11MPCore tile.
-
-config MACH_REALVIEW_PB11MP
-	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
-	depends on ARCH_MULTI_V6
-	select ARM_GIC
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_PATA_PLATFORM
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	help
-	  Include support for the ARM(R) RealView(R) Platform Baseboard for
-	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
-	  support for PCI-E and Compact Flash.
-
-# ARMv6 CPU without K extensions, but does have the new exclusive ops
-config MACH_REALVIEW_PB1176
-	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
-	depends on ARCH_MULTI_V6
-	select ARM_GIC
-	select CPU_V6
-	select HAVE_TCM
-	select MIGHT_HAVE_CACHE_L2X0
-	help
-	  Include support for the ARM(R) RealView(R) Platform Baseboard for
-	  ARM1176JZF-S.
-
-config REALVIEW_PB1176_SECURE_FLASH
-	bool "Allow access to the secure flash memory block"
-	depends on MACH_REALVIEW_PB1176
-	default n
-	help
-	  Select this option if Linux will only run in secure mode on the
-	  RealView PB1176 platform and access to the secure flash memory
-	  block (64MB @ 0x3c000000) is required.
-
-config MACH_REALVIEW_PBA8
-	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
-	depends on ARCH_MULTI_V7
-	select ARM_GIC
-	select HAVE_PATA_PLATFORM
-	help
-	  Include support for the ARM(R) RealView Platform Baseboard for
-	  Cortex(tm)-A8.  This platform has an on-board Cortex-A8 and has
-	  support for PCI-E and Compact Flash.
-
-config MACH_REALVIEW_PBX
-	bool "Support RealView(R) Platform Baseboard Explore for Cortex-A9"
-	depends on ARCH_MULTI_V7
-	select ARM_GIC
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_PATA_PLATFORM
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	select ZONE_DMA
-	help
-	  Include support for the ARM(R) RealView(R) Platform Baseboard
-	  Explore.
-
 config REALVIEW_HIGH_PHYS_OFFSET
 	bool "High physical base address for the RealView platform"
-	depends on MMU && !MACH_REALVIEW_PB1176
+	depends on MMU
 	default y
 	help
 	  RealView boards other than PB1176 have the RAM available at
-- 
2.7.4
