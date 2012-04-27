From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 16:39:10 +0800
Subject: [PATCH 2/9] ARM: mmp: distinguish mmp and mmp2 in Kconfig
In-Reply-To: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1335515957-1798-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append four CONFIG_* MACRO to distinguish boards in arch-mmp.

CONFIG_MMP_LEGACY and CONFIG_MMP2_LEGACY are used to support boards
without device tree.

CONFIG_MMP_DT and CONFIG_MMP2_DT are used to support boards with
device tree.

At the same time, only one of these four macro could be selected.
It's used to miss compiling all boards file together.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/configs/mmp2_defconfig   |    1 +
 arch/arm/configs/pxa168_defconfig |    1 +
 arch/arm/configs/pxa910_defconfig |    1 +
 arch/arm/mach-mmp/Kconfig         |   37 ++++++++++++++++++++++++++++++++++---
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 5a58452..8c309d1 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -8,6 +8,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
+CONFIG_MMP2_LEGACY=y
 CONFIG_MACH_BROWNSTONE=y
 CONFIG_MACH_FLINT=y
 CONFIG_MACH_MARVELL_JASPER=y
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 74d7e01..2abaa9f 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -8,6 +8,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
+CONFIG_MMP_LEGACY=y
 CONFIG_MACH_ASPENITE=y
 CONFIG_MACH_ZYLONITE2=y
 CONFIG_MACH_AVENGERS_LITE=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 1cd381e..1e95263 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -9,6 +9,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
+CONFIG_MMP_LEGACY=y
 CONFIG_MACH_TAVOREVB=y
 CONFIG_MACH_TTC_DKB=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 5a90b9a..5d49913 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -2,6 +2,9 @@ if ARCH_MMP
 
 menu "Marvell PXA168/910/MMP2 Implmentations"
 
+choice
+	prompt "Support Machines for MMP series"
+
 config MACH_MMP_DT
 	bool "Support MMP2 platforms from device tree"
 	select CPU_PXA168
@@ -12,8 +15,30 @@ config MACH_MMP_DT
 	  the device tree. Needn't select any other machine while
 	  MACH_MMP_DT is enabled.
 
+config MACH_MMP2_DT
+	bool "Support MMP2 platforms from device tree"
+	select CPU_MMP2
+	select USE_OF
+	help
+	  Include support for Marvell MMP2 based platforms using
+	  the device tree.
+
+config MMP_LEGACY
+	bool "Support MMP platform without device tree"
+	help
+	  Include support for Marvell MMP based platforms in legacy
+	  mode without device tree.
+
+config MMP2_LEGACY
+	bool "Support MMP2 platform without device tree"
+	help
+	  Include support for Marvell MMP2 based platforms in legacy
+	  mode without device tree.
+endchoice
+
 config MACH_ASPENITE
 	bool "Marvell's PXA168 Aspenite Development Board"
+	depends on MMP_LEGACY
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -21,6 +46,7 @@ config MACH_ASPENITE
 
 config MACH_ZYLONITE2
 	bool "Marvell's PXA168 Zylonite2 Development Board"
+	depends on MMP_LEGACY
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -28,6 +54,7 @@ config MACH_ZYLONITE2
 
 config MACH_AVENGERS_LITE
 	bool "Marvell's PXA168 Avengers Lite Development Board"
+	depends on MMP_LEGACY
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -35,6 +62,7 @@ config MACH_AVENGERS_LITE
 
 config MACH_TAVOREVB
 	bool "Marvell's PXA910 TavorEVB Development Board"
+	depends on MMP_LEGACY
 	select CPU_PXA910
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
@@ -42,6 +70,7 @@ config MACH_TAVOREVB
 
 config MACH_TTC_DKB
 	bool "Marvell's PXA910 TavorEVB Development Board"
+	depends on MMP_LEGACY
 	select CPU_PXA910
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
@@ -49,7 +78,7 @@ config MACH_TTC_DKB
 
 config MACH_BROWNSTONE
 	bool "Marvell's Brownstone Development Platform"
-	depends on !CPU_MOHAWK
+	depends on MMP2_LEGACY && !CPU_MOHAWK
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-based
@@ -60,7 +89,7 @@ config MACH_BROWNSTONE
 
 config MACH_FLINT
 	bool "Marvell's Flint Development Platform"
-	depends on !CPU_MOHAWK
+	depends on MMP2_LEGACY && !CPU_MOHAWK
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-based
@@ -71,7 +100,7 @@ config MACH_FLINT
 
 config MACH_MARVELL_JASPER
 	bool "Marvell's Jasper Development Platform"
-	depends on !CPU_MOHAWK
+	depends on MMP2_LEGACY && !CPU_MOHAWK
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-base
@@ -82,6 +111,7 @@ config MACH_MARVELL_JASPER
 
 config MACH_TETON_BGA
 	bool "Marvell's PXA168 Teton BGA Development Board"
+	depends on MMP_LEGACY
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -89,6 +119,7 @@ config MACH_TETON_BGA
 
 config MACH_GPLUGD
 	bool "Marvell's PXA168 GuruPlug Display (gplugD) Board"
+	depends on MMP_LEGACY
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
-- 
1.7.5.4
