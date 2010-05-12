From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:38 -0700
Subject: [PATCH 09/25] msm: add msm_iomap-8x50.h for QSD8x50 support
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-10-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a header describing the io regions for QSD8x50.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |  147 +++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/msm_iomap.h      |    4 +
 2 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h

diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
new file mode 100644
index 0000000..acc819e
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
@@ -0,0 +1,147 @@
+/*
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2008-2010, Code Aurora Forum. All rights reserved.
+ * Author: Brian Swetland <swetland@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * The MSM peripherals are spread all over across 768MB of physical
+ * space, which makes just having a simple IO_ADDRESS macro to slide
+ * them into the right virtual location rough.  Instead, we will
+ * provide a master phys->virt mapping for peripherals here.
+ *
+ */
+
+#ifndef __ASM_ARCH_MSM_IOMAP_8X50_H
+#define __ASM_ARCH_MSM_IOMAP_8X50_H
+
+/* Physical base address and size of peripherals.
+ * Ordered by the virtual base addresses they will be mapped at.
+ *
+ * MSM_VIC_BASE must be an value that can be loaded via a "mov"
+ * instruction, otherwise entry-macro.S will not compile.
+ *
+ * If you add or remove entries here, you'll want to edit the
+ * msm_io_desc array in arch/arm/mach-msm/io.c to reflect your
+ * changes.
+ *
+ */
+
+#define MSM_VIC_BASE          IOMEM(0xE0000000)
+#define MSM_VIC_PHYS          0xAC000000
+#define MSM_VIC_SIZE          SZ_4K
+
+#define MSM_CSR_BASE          IOMEM(0xE0001000)
+#define MSM_CSR_PHYS          0xAC100000
+#define MSM_CSR_SIZE          SZ_4K
+
+#define MSM_TMR_PHYS          MSM_CSR_PHYS
+#define MSM_TMR_BASE          MSM_CSR_BASE
+#define MSM_TMR_SIZE          SZ_4K
+
+#define MSM_GPT_BASE          MSM_TMR_BASE
+#define MSM_DGT_BASE          (MSM_TMR_BASE + 0x10)
+
+#define MSM_DMOV_BASE         IOMEM(0xE0002000)
+#define MSM_DMOV_PHYS         0xA9700000
+#define MSM_DMOV_SIZE         SZ_4K
+
+#define MSM_GPIO1_BASE        IOMEM(0xE0003000)
+#define MSM_GPIO1_PHYS        0xA9000000
+#define MSM_GPIO1_SIZE        SZ_4K
+
+#define MSM_GPIO2_BASE        IOMEM(0xE0004000)
+#define MSM_GPIO2_PHYS        0xA9100000
+#define MSM_GPIO2_SIZE        SZ_4K
+
+#define MSM_CLK_CTL_BASE      IOMEM(0xE0005000)
+#define MSM_CLK_CTL_PHYS      0xA8600000
+#define MSM_CLK_CTL_SIZE      SZ_4K
+
+#define MSM_SIRC_BASE         IOMEM(0xE1006000)
+#define MSM_SIRC_PHYS         0xAC200000
+#define MSM_SIRC_SIZE         SZ_4K
+
+#define MSM_SCPLL_BASE        IOMEM(0xE1007000)
+#define MSM_SCPLL_PHYS        0xA8800000
+#define MSM_SCPLL_SIZE        SZ_4K
+
+#ifdef CONFIG_MSM_SOC_REV_A
+#define MSM_SMI_BASE 0xE0000000
+#else
+#define MSM_SMI_BASE 0x00000000
+#endif
+
+#define MSM_SHARED_RAM_BASE   IOMEM(0xE0100000)
+#define MSM_SHARED_RAM_PHYS (MSM_SMI_BASE + 0x00100000)
+#define MSM_SHARED_RAM_SIZE   SZ_1M
+
+#define MSM_UART1_PHYS        0xA9A00000
+#define MSM_UART1_SIZE        SZ_4K
+
+#define MSM_UART2_PHYS        0xA9B00000
+#define MSM_UART2_SIZE        SZ_4K
+
+#define MSM_UART3_PHYS        0xA9C00000
+#define MSM_UART3_SIZE        SZ_4K
+
+#ifdef CONFIG_MSM_DEBUG_UART
+#define MSM_DEBUG_UART_BASE   0xE1000000
+#if CONFIG_MSM_DEBUG_UART == 1
+#define MSM_DEBUG_UART_PHYS   MSM_UART1_PHYS
+#elif CONFIG_MSM_DEBUG_UART == 2
+#define MSM_DEBUG_UART_PHYS   MSM_UART2_PHYS
+#elif CONFIG_MSM_DEBUG_UART == 3
+#define MSM_DEBUG_UART_PHYS   MSM_UART3_PHYS
+#endif
+#define MSM_DEBUG_UART_SIZE   SZ_4K
+#endif
+
+#define MSM_MDC_BASE	      IOMEM(0xE0200000)
+#define MSM_MDC_PHYS	      0xAA500000
+#define MSM_MDC_SIZE	      SZ_1M
+
+#define MSM_AD5_BASE          IOMEM(0xE0300000)
+#define MSM_AD5_PHYS          0xAC000000
+#define MSM_AD5_SIZE          (SZ_1M*13)
+
+
+#define MSM_I2C_SIZE          SZ_4K
+#define MSM_I2C_PHYS          0xA9900000
+
+#define MSM_HSUSB_PHYS        0xA0800000
+#define MSM_HSUSB_SIZE        SZ_1K
+
+#define MSM_NAND_PHYS           0xA0A00000
+
+
+#define MSM_TSIF_PHYS        (0xa0100000)
+#define MSM_TSIF_SIZE        (0x200)
+
+#define MSM_TSSC_PHYS         0xAA300000
+
+#define MSM_UART1DM_PHYS      0xA0200000
+#define MSM_UART2DM_PHYS      0xA0900000
+
+
+#define MSM_SDC1_PHYS          0xA0400000
+#define MSM_SDC1_SIZE          SZ_4K
+
+#define MSM_SDC2_PHYS          0xA0500000
+#define MSM_SDC2_SIZE          SZ_4K
+
+#define MSM_SDC3_PHYS          0xA0600000
+#define MSM_SDC3_SIZE           SZ_4K
+
+#define MSM_SDC4_PHYS          0xA0700000
+#define MSM_SDC4_SIZE          SZ_4K
+
+#endif
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/include/mach/msm_iomap.h
index 81da6b8..7043d7a 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap.h
@@ -43,6 +43,10 @@
 #define IOMEM(x)	((void __force __iomem *)(x))
 #endif
 
+#if defined(CONFIG_ARCH_QSD8X50)
+#include "msm_iomap-8x50.h"
+#else
 #include "msm_iomap-7x00.h"
+#endif
 
 #endif
-- 
1.6.2.3
