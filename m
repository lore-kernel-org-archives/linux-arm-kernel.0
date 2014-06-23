From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:24 +0900
Subject: [PATCH 11/24] ARM: shmobile: Remove non-multiplatform Marzen
 reference support
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <1ece7f7bb014485b13faf9504b238ff891a9088a.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that r8a7779 has CCF support remove the legacy Marzen reference
Kconfig bits CONFIG_MACH_MARZEN_REFERENCE for the non-multiplatform
case.

Starting from this commit Marzen board support is always enabled via
CONFIG_MACH_MARZEN, and CONFIG_ARCH_MULTIPLATFORM is used to select
between board-marzen.c and board-marzen-reference.c

The file board-marzen-reference.c can no longer be used together with
the legacy sh-clk clock framework, instead CCF is used.

Based on work for the Koelsch board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile           |  1 -
 arch/arm/mach-shmobile/Kconfig       | 13 -------------
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/Makefile.boot |  1 -
 4 files changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f44df11..e666d13 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -327,7 +327,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
 	r8a7779-marzen.dtb \
-	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
 	sh73a0-kzm9g.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index d7f8285..8a054dd 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -245,19 +245,6 @@ config MACH_MARZEN
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
-config MACH_MARZEN_REFERENCE
-	bool "MARZEN board - Reference Device Tree Implementation"
-	depends on ARCH_R8A7779
-	select ARCH_REQUIRE_GPIOLIB
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select USE_OF
-	---help---
-	   Use reference implementation of Marzen board support
-	   which makes use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 2309906..0d6a04c 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -68,7 +68,6 @@ obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
-obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 918fccf..ebf97d4 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -13,7 +13,6 @@ loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
 loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
 loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
-loadaddr-$(CONFIG_MACH_MARZEN_REFERENCE) += 0x60008000
 
 __ZRELADDR	:= $(sort $(loadaddr-y))
    zreladdr-y   += $(__ZRELADDR)
-- 
2.0.0.rc2
