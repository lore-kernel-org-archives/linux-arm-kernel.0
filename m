From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:49 +0000
Subject: [PATCH 06/13] ARM: spear: move spear.h and misc_regs.h into plat-spear
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spear13xx version of spear.h is completely different from
the newly combined spear3xx/spear6xx version, but we can never
build ARMv5 and ARMv7 platforms together, so there is no
harm in putting all the contents into a single file and adding
appropriate ifdefs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear13xx/include/mach/spear.h       | 54 --------------------
 arch/arm/mach-spear3xx/include/mach/spear.h        | 59 ----------------------
 arch/arm/mach-spear6xx/include/mach/misc_regs.h    | 22 --------
 .../include/mach/misc_regs.h                       |  0
 .../include/mach/spear.h                           | 42 +++++++++++++++
 5 files changed, 42 insertions(+), 135 deletions(-)
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/misc_regs.h
 rename arch/arm/{mach-spear3xx => plat-spear}/include/mach/misc_regs.h (100%)
 rename arch/arm/{mach-spear6xx => plat-spear}/include/mach/spear.h (62%)

diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
deleted file mode 100644
index 7cfa681..0000000
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * arch/arm/mach-spear13xx/include/mach/spear.h
- *
- * spear13xx Machine family specific definition
- *
- * Copyright (C) 2012 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_SPEAR13XX_H
-#define __MACH_SPEAR13XX_H
-
-#include <asm/memory.h>
-
-#define PERIP_GRP2_BASE				UL(0xB3000000)
-#define VA_PERIP_GRP2_BASE			IOMEM(0xFE000000)
-#define MCIF_SDHCI_BASE				UL(0xB3000000)
-#define SYSRAM0_BASE				UL(0xB3800000)
-#define VA_SYSRAM0_BASE				IOMEM(0xFE800000)
-#define SYS_LOCATION				(VA_SYSRAM0_BASE + 0x600)
-
-#define PERIP_GRP1_BASE				UL(0xE0000000)
-#define VA_PERIP_GRP1_BASE			IOMEM(0xFD000000)
-#define UART_BASE				UL(0xE0000000)
-#define VA_UART_BASE				IOMEM(0xFD000000)
-#define SSP_BASE				UL(0xE0100000)
-#define MISC_BASE				UL(0xE0700000)
-#define VA_MISC_BASE				IOMEM(0xFD700000)
-
-#define A9SM_AND_MPMC_BASE			UL(0xEC000000)
-#define VA_A9SM_AND_MPMC_BASE			IOMEM(0xFC000000)
-
-/* A9SM peripheral offsets */
-#define A9SM_PERIP_BASE				UL(0xEC800000)
-#define VA_A9SM_PERIP_BASE			IOMEM(0xFC800000)
-#define VA_SCU_BASE				(VA_A9SM_PERIP_BASE + 0x00)
-
-#define L2CC_BASE				UL(0xED000000)
-#define VA_L2CC_BASE				IOMEM(UL(0xFB000000))
-
-/* others */
-#define DMAC0_BASE				UL(0xEA800000)
-#define DMAC1_BASE				UL(0xEB000000)
-#define MCIF_CF_BASE				UL(0xB2800000)
-
-/* Debug uart for linux, will be used for debug and uncompress messages */
-#define SPEAR_DBG_UART_BASE			UART_BASE
-#define VA_SPEAR_DBG_UART_BASE			VA_UART_BASE
-
-#endif /* __MACH_SPEAR13XX_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear.h b/arch/arm/mach-spear3xx/include/mach/spear.h
deleted file mode 100644
index ee5a774..0000000
--- a/arch/arm/mach-spear3xx/include/mach/spear.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * SPEAr3xx/6xx Machine family specific definition
- *
- * Copyright (C) 2009,2012 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_SPEAR_H
-#define __MACH_SPEAR_H
-
-#include <asm/memory.h>
-
-/* ICM1 - Low speed connection */
-#define SPEAR_ICM1_2_BASE		UL(0xD0000000)
-#define VA_SPEAR_ICM1_2_BASE		UL(0xFD000000)
-#define SPEAR_ICM1_UART_BASE		UL(0xD0000000)
-#define VA_SPEAR_ICM1_UART_BASE		(VA_SPEAR_ICM1_2_BASE | SPEAR_ICM1_UART_BASE)
-#define SPEAR3XX_ICM1_SSP_BASE		UL(0xD0100000)
-
-/* ML-1, 2 - Multi Layer CPU Subsystem */
-#define SPEAR_ICM3_ML1_2_BASE		UL(0xF0000000)
-#define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
-
-/* ICM3 - Basic Subsystem */
-#define SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define VA_SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define SPEAR_ICM3_DMA_BASE		UL(0xFC400000)
-#define SPEAR_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
-#define VA_SPEAR_ICM3_SYS_CTRL_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_SYS_CTRL_BASE)
-#define SPEAR_ICM3_MISC_REG_BASE	UL(0xFCA80000)
-#define VA_SPEAR_ICM3_MISC_REG_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_MISC_REG_BASE)
-
-/* Debug uart for linux, will be used for debug and uncompress messages */
-#define SPEAR_DBG_UART_BASE		SPEAR_ICM1_UART_BASE
-#define VA_SPEAR_DBG_UART_BASE		VA_SPEAR_ICM1_UART_BASE
-
-/* Sysctl base for spear platform */
-#define SPEAR_SYS_CTRL_BASE		SPEAR_ICM3_SYS_CTRL_BASE
-#define VA_SPEAR_SYS_CTRL_BASE		VA_SPEAR_ICM3_SYS_CTRL_BASE
-
-/* SPEAr320 Macros */
-#define SPEAR320_SOC_CONFIG_BASE	UL(0xB3000000)
-#define VA_SPEAR320_SOC_CONFIG_BASE	UL(0xFE000000)
-#define SPEAR320_CONTROL_REG		IOMEM(VA_SPEAR320_SOC_CONFIG_BASE)
-#define SPEAR320_EXT_CTRL_REG		IOMEM(VA_SPEAR320_SOC_CONFIG_BASE + 0x0018)
-	#define SPEAR320_UARTX_PCLK_MASK		0x1
-	#define SPEAR320_UART2_PCLK_SHIFT		8
-	#define SPEAR320_UART3_PCLK_SHIFT		9
-	#define SPEAR320_UART4_PCLK_SHIFT		10
-	#define SPEAR320_UART5_PCLK_SHIFT		11
-	#define SPEAR320_UART6_PCLK_SHIFT		12
-	#define SPEAR320_RS485_PCLK_SHIFT		13
-
-#endif /* __MACH_SPEAR_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/misc_regs.h b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
deleted file mode 100644
index 28aa508..0000000
--- a/arch/arm/mach-spear6xx/include/mach/misc_regs.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/misc_regs.h
- *
- * Miscellaneous registers definitions for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_MISC_REGS_H
-#define __MACH_MISC_REGS_H
-
-#include <mach/spear.h>
-
-#define MISC_BASE		IOMEM(VA_SPEAR_ICM3_MISC_REG_BASE)
-#define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
-
-#endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/misc_regs.h b/arch/arm/plat-spear/include/mach/misc_regs.h
similarity index 100%
rename from arch/arm/mach-spear3xx/include/mach/misc_regs.h
rename to arch/arm/plat-spear/include/mach/misc_regs.h
diff --git a/arch/arm/mach-spear6xx/include/mach/spear.h b/arch/arm/plat-spear/include/mach/spear.h
similarity index 62%
rename from arch/arm/mach-spear6xx/include/mach/spear.h
rename to arch/arm/plat-spear/include/mach/spear.h
index ee5a774..2198ab9 100644
--- a/arch/arm/mach-spear6xx/include/mach/spear.h
+++ b/arch/arm/plat-spear/include/mach/spear.h
@@ -15,6 +15,8 @@
 
 #include <asm/memory.h>
 
+#if defined(CONFIG_ARCH_SPEAR3XX) || defined (CONFIG_ARCH_SPEAR6XX)
+
 /* ICM1 - Low speed connection */
 #define SPEAR_ICM1_2_BASE		UL(0xD0000000)
 #define VA_SPEAR_ICM1_2_BASE		UL(0xFD000000)
@@ -55,5 +57,45 @@
 	#define SPEAR320_UART5_PCLK_SHIFT		11
 	#define SPEAR320_UART6_PCLK_SHIFT		12
 	#define SPEAR320_RS485_PCLK_SHIFT		13
+#endif /* SPEAR3xx || SPEAR6XX */
+
+#ifdef CONFIG_ARCH_SPEAR13XX
+
+#define PERIP_GRP2_BASE				UL(0xB3000000)
+#define VA_PERIP_GRP2_BASE			IOMEM(0xFE000000)
+#define MCIF_SDHCI_BASE				UL(0xB3000000)
+#define SYSRAM0_BASE				UL(0xB3800000)
+#define VA_SYSRAM0_BASE				IOMEM(0xFE800000)
+#define SYS_LOCATION				(VA_SYSRAM0_BASE + 0x600)
+
+#define PERIP_GRP1_BASE				UL(0xE0000000)
+#define VA_PERIP_GRP1_BASE			IOMEM(0xFD000000)
+#define UART_BASE				UL(0xE0000000)
+#define VA_UART_BASE				IOMEM(0xFD000000)
+#define SSP_BASE				UL(0xE0100000)
+#define MISC_BASE				UL(0xE0700000)
+#define VA_MISC_BASE				IOMEM(0xFD700000)
+
+#define A9SM_AND_MPMC_BASE			UL(0xEC000000)
+#define VA_A9SM_AND_MPMC_BASE			IOMEM(0xFC000000)
+
+/* A9SM peripheral offsets */
+#define A9SM_PERIP_BASE				UL(0xEC800000)
+#define VA_A9SM_PERIP_BASE			IOMEM(0xFC800000)
+#define VA_SCU_BASE				(VA_A9SM_PERIP_BASE + 0x00)
+
+#define L2CC_BASE				UL(0xED000000)
+#define VA_L2CC_BASE				IOMEM(UL(0xFB000000))
+
+/* others */
+#define DMAC0_BASE				UL(0xEA800000)
+#define DMAC1_BASE				UL(0xEB000000)
+#define MCIF_CF_BASE				UL(0xB2800000)
+
+/* Debug uart for linux, will be used for debug and uncompress messages */
+#define SPEAR_DBG_UART_BASE			UART_BASE
+#define VA_SPEAR_DBG_UART_BASE			VA_UART_BASE
+
+#endif /* SPEAR13XX */
 
 #endif /* __MACH_SPEAR_H */
-- 
1.8.0
