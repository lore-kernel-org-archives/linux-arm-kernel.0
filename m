From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:33:33 +0900
Subject: [PATCH v3 17/20] ARM: shmobile: Remove non-multiplatform Marzen
 reference support
In-Reply-To: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1393400016-23433-18-git-send-email-horms+renesas@verge.net.au>
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
index cac7179..ad09142 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -252,7 +252,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
 	r8a7779-marzen.dtb \
-	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
 	sh73a0-kzm9g.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8ba4172..a141fb4 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -258,19 +258,6 @@ config MACH_MARZEN
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
index b02dac5..0aaceef 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -70,7 +70,6 @@ obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
 obj-$(CONFIG_MACH_GENMAI_REFERENCE)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
-obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 99455ec..4200b94 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -14,7 +14,6 @@ loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
 loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
 loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
-loadaddr-$(CONFIG_MACH_MARZEN_REFERENCE) += 0x60008000
 
 __ZRELADDR	:= $(sort $(loadaddr-y))
    zreladdr-y   += $(__ZRELADDR)
-- 
1.8.5.2
