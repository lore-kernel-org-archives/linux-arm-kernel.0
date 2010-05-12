From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:44 -0700
Subject: [PATCH 15/25] msm: 8x50 Kconfig changes
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-16-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_ARCH_QSD8X50.  This is the first SOC with the
Scorpion processor.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig  |   58 +++++++++++++++++++++++++++++++------------
 arch/arm/mach-msm/Makefile |    4 +++
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index b983d78..3dbad24 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -11,16 +11,56 @@ config ARCH_MSM7X00A
 	select MSM_SMD_PKG3
 	select CPU_V6
 
+config ARCH_QSD8X50
+	bool "QSD8X50"
+	select ARCH_MSM_SCORPION
+	select MSM_SMD
+	select MSM_VIC
+	select CPU_V7
+	select MSM_REMOTE_SPINLOCK_LDREX
 endchoice
 
-config ARCH_MSM_ARM11
+config MSM_SOC_REV_A
+	bool
+
+config  ARCH_MSM_ARM11
+	bool
+config  ARCH_MSM_SCORPION
 	bool
 
 config  MSM_VIC
 	bool
 
-comment "MSM Board Type"
+menu "Qualcomm MSM Board Type"
+
+config MACH_HALIBUT
 	depends on ARCH_MSM
+	depends on ARCH_MSM7X00A
+	bool "Halibut Board (QCT SURF7201A)"
+	help
+	  Support for the Qualcomm SURF7201A eval board.
+
+config MACH_TROUT
+	depends on ARCH_MSM
+	depends on ARCH_MSM7X00A
+	bool "HTC Dream (aka trout)"
+	help
+	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
+
+config MACH_QSD8X50_SURF
+	depends on ARCH_QSD8X50
+	bool "QSD8x50 SURF"
+	help
+	  Support for the Qualcomm QSD8x50 SURF eval board.
+
+config MACH_QSD8X50A_ST1_5
+	depends on ARCH_QSD8X50
+	select MSM_SOC_REV_A
+	bool "QSD8x50A ST1.5"
+	help
+	  Support for the Qualcomm ST1.5.
+
+endmenu
 
 config MSM_DEBUG_UART
 	int
@@ -46,20 +86,6 @@ choice
 		bool "UART3"
 endchoice
 
-config MACH_HALIBUT
-	depends on ARCH_MSM7X00A
-	default y
-	bool "Halibut Board (QCT SURF7201A)"
-	help
-	  Support for the Qualcomm SURF7201A eval board.
-
-config MACH_TROUT
-	depends on ARCH_MSM7X00A
-	default y
-	bool "HTC Dream (aka trout)"
-	help
-	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
-
 config MSM_SMD_PKG3
 	bool
 
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 48a5faf..df95f57 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -3,6 +3,7 @@ obj-y += io.o idle.o timer.o dma.o
 obj-y += vreg.o
 obj-y += acpuclock-arm11.o
 obj-y += clock.o clock-pcom.o
+obj-y += gpio.o
 
 ifdef CONFIG_MSM_VIC
 obj-y += irq-vic.o
@@ -10,8 +11,11 @@ else
 obj-y += irq.o
 endif
 
+obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 
 obj-$(CONFIG_MACH_TROUT) += board-trout.o devices-msm7x00.o
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
+obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
+
-- 
1.6.2.3
