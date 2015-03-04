From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:12 +0100
Subject: [RFC PATCH 18/18] ARM: msm: enable multiplatform support
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-19-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All prerequisites are complete now, so we can finally move
msm into multiplatform. This also rearranges the Kconfig file
for msm to look more like the other platforms, and we enable
all msm boards in the msm_defconfig file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig               | 14 -------
 arch/arm/configs/msm_defconfig |  7 ++++
 arch/arm/mach-msm/Kconfig      | 91 ++++++++++++++----------------------------
 arch/arm/mach-msm/Makefile     |  2 +
 4 files changed, 40 insertions(+), 74 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ef94bccbe137..8d2a0ba7cb05 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -554,20 +554,6 @@ config ARCH_PXA
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-config ARCH_MSM
-	bool "Qualcomm MSM (non-multiplatform)"
-	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	help
-	  Support for Qualcomm MSM/QSD based systems.  This runs on the
-	  apps processor of the MSM/QSD and depends on a shared memory
-	  interface to the modem processor which runs the baseband
-	  stack and controls some vital subsystems
-	  (clock and power control, etc).
-
 config ARCH_SHMOBILE_LEGACY
 	bool "Renesas ARM SoCs (non-multiplatform)"
 	select ARCH_SHMOBILE
diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index dd18c9e527d6..6d1e5830e081 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -17,7 +17,14 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARCH_MULTI_V6=y
+CONFIG_ARCH_MULTI_V7=y
 CONFIG_ARCH_MSM=y
+CONFIG_MACH_HALIBUT=y
+CONFIG_MACH_TROUT=y
+CONFIG_MACH_MSM7X30_SURF=y
+CONFIG_MACH_QSD8X50_SURF=y
+CONFIG_MACH_QSD8X50A_ST1_5=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index a6b50e62a495..9ae3e59c0fdc 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -1,109 +1,81 @@
-if ARCH_MSM
+menuconfig ARCH_MSM
+	bool "Qualcomm MSM (legacy)"
+	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKSRC_QCOM
+	select MSM_PROC_COMM
+	select MSM_SMD
+	help
+	  Support for Qualcomm MSM/QSD based systems.  This runs on the
+	  apps processor of the MSM/QSD and depends on a shared memory
+	  interface to the modem processor which runs the baseband
+	  stack and controls some vital subsystems
+	  (clock and power control, etc).
 
-choice
-	prompt "Qualcomm MSM SoC Type"
-	default ARCH_MSM7X00A
-	depends on ARCH_MSM
+if ARCH_MSM
 
 config ARCH_MSM7X00A
-	bool "MSM7x00A / MSM7x01A"
-	select ARCH_MSM_ARM11
-	select CPU_V6
-	select GPIO_MSM_V1
-	select MACH_TROUT if !MACH_HALIBUT
-	select MSM_PROC_COMM
-	select MSM_SMD
-	select CLKSRC_QCOM
-	select MSM_SMD_PKG3
+	bool
 
 config ARCH_MSM7X30
-	bool "MSM7x30"
-	select ARCH_MSM_SCORPION
-	select CPU_V7
-	select GPIO_MSM_V1
-	select MACH_MSM7X30_SURF # if !
+	bool
 	select MSM_GPIOMUX
-	select MSM_PROC_COMM
-	select MSM_SMD
-	select CLKSRC_QCOM
 	select MSM_VIC
 
 config ARCH_QSD8X50
-	bool "QSD8X50"
-	select ARCH_MSM_SCORPION
-	select CPU_V7
-	select GPIO_MSM_V1
-	select MACH_QSD8X50_SURF if !MACH_QSD8X50A_ST1_5
+	bool
 	select MSM_GPIOMUX
-	select MSM_PROC_COMM
-	select MSM_SMD
-	select CLKSRC_QCOM
 	select MSM_VIC
 
-endchoice
-
 config MSM_SOC_REV_A
 	bool
 
-config  ARCH_MSM_ARM11
+config MSM_VIC
 	bool
 
-config  ARCH_MSM_SCORPION
+config MSM_PROC_COMM
 	bool
 
-config  MSM_VIC
+config MSM_SMD
 	bool
 
-menu "Qualcomm MSM Board Type"
-	depends on ARCH_MSM
+config MSM_GPIOMUX
+	bool
 
 config MACH_HALIBUT
-	depends on ARCH_MSM
-	depends on ARCH_MSM7X00A
+	depends on ARCH_MULTI_V6
+	select ARCH_MSM7X00A
 	bool "Halibut Board (QCT SURF7201A)"
 	help
 	  Support for the Qualcomm SURF7201A eval board.
 
 config MACH_TROUT
-	depends on ARCH_MSM
-	depends on ARCH_MSM7X00A
+	depends on ARCH_MULTI_V6
+	select ARCH_MSM7X00A
 	bool "HTC Dream (aka trout)"
 	help
 	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
 
 config MACH_MSM7X30_SURF
-	depends on ARCH_MSM7X30
+	depends on ARCH_MULTI_V7
+	select ARCH_MSM7X30
 	bool "MSM7x30 SURF"
 	help
 	  Support for the Qualcomm MSM7x30 SURF eval board.
 
 config MACH_QSD8X50_SURF
-	depends on ARCH_QSD8X50
+	depends on ARCH_MULTI_V7
+	select ARCH_QSD8X50
 	bool "QSD8x50 SURF"
 	help
 	  Support for the Qualcomm QSD8x50 SURF eval board.
 
 config MACH_QSD8X50A_ST1_5
-	depends on ARCH_QSD8X50
+	depends on ARCH_MULTI_V7
+	select ARCH_QSD8X50
 	bool "QSD8x50A ST1.5"
 	select MSM_SOC_REV_A
 	help
 	  Support for the Qualcomm ST1.5.
 
-endmenu
-
-config MSM_SMD_PKG3
-	bool
-
-config MSM_PROC_COMM
-	bool
-
-config MSM_SMD
-	bool
-
-config MSM_GPIOMUX
-	bool
-	help
-	  Support for MSM V1 TLMM GPIOMUX architecture.
-
 endif
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 59ef46a881ea..d0f74d2d5be4 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include
+
 obj-$(CONFIG_MSM_PROC_COMM) += clock.o
 
 obj-$(CONFIG_MSM_VIC) += irq-vic.o
-- 
2.1.0.rc2
