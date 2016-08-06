From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  6 Aug 2016 07:56:26 +0300
Subject: [PATCH v2 4/4] ARM: i.MX: Move SOC_IMX1 into 'Device tree only'
In-Reply-To: <1470459386-5197-1-git-send-email-shc_work@mail.ru>
References: <1470459386-5197-1-git-send-email-shc_work@mail.ru>
Message-ID: <1470459386-5197-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves SOC_IMX1 into 'Device tree only' category and renames
imx1-dt.c to mach-imx1.c to align with the name schema of other
i.MX DT only platforms.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/imx_v4_v5_defconfig         |  1 +
 arch/arm/configs/multi_v4t_defconfig         |  2 +-
 arch/arm/mach-imx/Kconfig                    | 31 +++++++++++-----------------
 arch/arm/mach-imx/Makefile                   |  4 +---
 arch/arm/mach-imx/{imx1-dt.c => mach-imx1.c} |  0
 5 files changed, 15 insertions(+), 23 deletions(-)
 rename arch/arm/mach-imx/{imx1-dt.c => mach-imx1.c} (100%)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index e70032c..5f013c9f 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -28,6 +28,7 @@ CONFIG_MACH_MX27_3DS=y
 CONFIG_MACH_IMX27_VISSTRIM_M10=y
 CONFIG_MACH_PCA100=y
 CONFIG_MACH_IMX27_DT=y
+CONFIG_SOC_IMX1=y
 CONFIG_SOC_IMX25=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 141492a..9a6390c 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -20,7 +20,7 @@ CONFIG_INTEGRATOR_CM720T=y
 CONFIG_INTEGRATOR_CM920T=y
 CONFIG_INTEGRATOR_CM922T_XA10=y
 CONFIG_ARCH_MXC=y
-CONFIG_MACH_IMX1_DT=y
+CONFIG_SOC_IMX1=y
 CONFIG_ARCH_NSPIRE=y
 CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ca7db32..9da3284 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -64,12 +64,6 @@ config IMX_HAVE_IOMUX_V1
 config ARCH_MXC_IOMUX_V3
 	bool
 
-config SOC_IMX1
-	bool
-	select CPU_ARM920T
-	select MXC_AVIC
-	select PINCTRL_IMX1
-
 config SOC_IMX21
 	bool
 	select CPU_ARM926T
@@ -97,19 +91,6 @@ config SOC_IMX35
 	select PINCTRL_IMX35
 	select SMP_ON_UP if SMP
 
-if ARCH_MULTI_V4T
-
-comment "MX1 platforms:"
-
-config MACH_IMX1_DT
-	bool "Support i.MX1 platforms from device tree"
-	select SOC_IMX1
-	help
-	  Include support for Freescale i.MX1 based platforms
-	  using the device tree for discovery.
-
-endif
-
 if ARCH_MULTI_V5
 
 comment "MX21 platforms:"
@@ -445,6 +426,18 @@ endif
 
 comment "Device tree only"
 
+if ARCH_MULTI_V4T
+
+config SOC_IMX1
+	bool "i.MX1 support"
+	select CPU_ARM920T
+	select MXC_AVIC
+	select PINCTRL_IMX1
+	help
+	  This enables support for Freescale i.MX1 processor
+
+endif
+
 if ARCH_MULTI_V5
 
 config SOC_IMX25
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 3fa087d..2636adf 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -34,9 +34,6 @@ obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
 
-# i.MX1 based machines
-obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
-
 # i.MX21 based machines
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 
@@ -90,6 +87,7 @@ obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
+obj-$(CONFIG_SOC_IMX1) += mach-imx1.o
 obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
 obj-$(CONFIG_SOC_IMX51) += mach-imx51.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
diff --git a/arch/arm/mach-imx/imx1-dt.c b/arch/arm/mach-imx/mach-imx1.c
similarity index 100%
rename from arch/arm/mach-imx/imx1-dt.c
rename to arch/arm/mach-imx/mach-imx1.c
-- 
2.7.3
