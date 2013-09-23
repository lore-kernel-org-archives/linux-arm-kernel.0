From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 23 Sep 2013 10:20:33 -0700
Subject: [PATCH v2 1/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mach-bcm)
In-Reply-To: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
Message-ID: <1379956836-5866-2-git-send-email-bcm@fixthebug.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ARCH_BCM has been used for Broadcom
Mobile V7 based SoCs. In order to allow other Broadcom
SoCs to also use mach-bcm directory and files, this patch
renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
uses ARCH_BCM to define any Broadcom chip residing
in mach-bcm directory.

Signed-off-by: Christian Daudt <bcm@fixthebug.org>
Acked-by: Olof Johansson <olof@lixom.net>

Changes from v1:
 - fix alpha ordering in dts/Makefile
 - break into 4 patches for separate subsys

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 6e49310..efb0132 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -27,6 +27,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_EFI_PARTITION=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_743622=y
 CONFIG_PREEMPT=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e572c6..89a5064 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_KEYSTONE=y
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 69d67f7..af86cda 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -1,5 +1,17 @@
 config ARCH_BCM
-	bool "Broadcom SoC" if ARCH_MULTI_V7
+	bool "Broadcom SoC Support"
+	select ARCH_MULTIPLATFORM
+	help
+	  This enables support for Broadcom ARM based SoC
+          chips
+
+if ARCH_BCM
+
+menu "Broadcom SoC Selection"
+
+config ARCH_BCM_MOBILE
+	bool "Broadcom Mobile SoC" if ARCH_MULTI_V7
+	default y
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
@@ -14,7 +26,11 @@ config ARCH_BCM
 	select TICK_ONESHOT
 	select CACHE_L2X0
 	help
-	  This enables support for system based on Broadcom SoCs.
+	  This enables support for systems based on Broadcom mobile SoCs.
 	  It currently supports the 'BCM281XX' family, which includes
 	  BCM11130, BCM11140, BCM11351, BCM28145 and
 	  BCM28155 variants.
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index e3d0303..c2ccd5a 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -10,6 +10,6 @@
 # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-obj-$(CONFIG_ARCH_BCM)		:= board_bcm281xx.o bcm_kona_smc.o bcm_kona_smc_asm.o kona.o
+obj-$(CONFIG_ARCH_BCM_MOBILE)	:= board_bcm281xx.o bcm_kona_smc.o bcm_kona_smc_asm.o kona.o
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
-- 
1.7.10.4
