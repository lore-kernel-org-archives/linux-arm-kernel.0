From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:32:17 +0900
Subject: [PATCH RFC v2 15/17] ARM: shmobile: Remove non-multiplatform Marzen
 reference support
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385451139-29686-16-git-send-email-horms+renesas@verge.net.au>
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
v2
* Correct changelog to refer to marzen instead of koelsch
* Do not add typo to Makefile
---
 arch/arm/boot/dts/Makefile           |  1 -
 arch/arm/mach-shmobile/Kconfig       | 13 -------------
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/Makefile.boot |  1 -
 4 files changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 723fe71..166e3dd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -205,7 +205,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
 	r8a7779-marzen.dtb \
-	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4216baa..a27d60c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -239,19 +239,6 @@ config MACH_MARZEN
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
index 6d75ae8..e7f586c 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -69,7 +69,6 @@ obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
 obj-$(CONFIG_MACH_GENMAI_REFERENCE)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
-obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_LAGER_REFERENCE)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 759e4f8f..6f761b4 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -16,7 +16,6 @@ loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
 loadaddr-$(CONFIG_MACH_LAGER_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
 loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
-loadaddr-$(CONFIG_MACH_MARZEN_REFERENCE) += 0x60008000
 
 __ZRELADDR	:= $(sort $(loadaddr-y))
    zreladdr-y   += $(__ZRELADDR)
-- 
1.8.4
