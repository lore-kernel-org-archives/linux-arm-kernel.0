From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  6 Aug 2012 11:42:18 +0200
Subject: [PATCH 2/5] arm: plat-orion: introduce PLAT_ORION_LEGACY hidden
 config option
In-Reply-To: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1344246141-23931-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, the PLAT_ORION configuration option was common to all the
Marvell EBU SoCs, and selecting this option had the effect of enabling
the MPP code, GPIO code, address decoding and PCIe code from
plat-orion, as well as providing access to driver-specific header
files from plat-orion/include.

However, the Armada 370 and XP SoCs will not use the MPP and GPIO code
(instead some proper pinctrl and gpio drivers are in preparation), and
generally, we want to move away from plat-orion and instead have
everything in mach-mvebu.

That said, in the mean time, we want to leverage the driver-specific
headers as well as the address decoding code, so we introduce
PLAT_ORION_LEGACY. The older Marvell SoCs need to select
PLAT_ORION_LEGACY, while the newer Marvell SoCs need to select
PLAT_ORION. Of course, when PLAT_ORION_LEGACY is selected, it
automatically selects PLAT_ORION.

Then, with just PLAT_ORION, you have the address decoding code plus
the driver-specific headers. If you add PLAT_ORION_LEGACY to this, you
gain the old MPP, GPIO and PCIe code.

Again, this is only a temporary solution until we make all Marvell EBU
platforms converge into the mach-mvebu directory. This solution avoids
duplicating the existing address decoding code into mach-mvebu.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig             |   13 +++++++++----
 arch/arm/plat-orion/Makefile |    9 ++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..a2b6f74 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -573,6 +573,7 @@ config ARCH_MVEBU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select COMMON_CLK
+	select PLAT_ORION
 	help
 	  Support for the Marvell SoC Family with device tree support
 
@@ -583,7 +584,7 @@ config ARCH_DOVE
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select PLAT_ORION_LEGACY
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
@@ -594,7 +595,7 @@ config ARCH_KIRKWOOD
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
 	  88F6180, 88F6192 and 88F6281.
@@ -621,7 +622,7 @@ config ARCH_MV78XX0
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
 	  MV781x0, MV782x0.
@@ -634,7 +635,7 @@ config ARCH_ORION5X
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
@@ -1154,6 +1155,10 @@ config PLAT_ORION
 	select IRQ_DOMAIN
 	select COMMON_CLK
 
+config PLAT_ORION_LEGACY
+	bool
+	select PLAT_ORION
+
 config PLAT_PXA
 	bool
 
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index c20ce0f..1251e5b 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -2,9 +2,8 @@
 # Makefile for the linux kernel.
 #
 
-obj-y	:= irq.o pcie.o time.o common.o mpp.o addr-map.o
-obj-m	:=
-obj-n	:=
-obj-	:=
+obj-y                             += addr-map.o
 
-obj-$(CONFIG_GENERIC_GPIO) += gpio.o
+orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
+obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
+obj-$(CONFIG_PLAT_ORION_LEGACY)   += $(orion-gpio-y)
-- 
1.7.9.5
