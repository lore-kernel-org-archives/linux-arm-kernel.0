From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:55:41 +0530
Subject: [PATCH V5 02/63] SPEAr: Defining IOMEM(x) and updating declaration of
	MISC_BASE
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <7e8d39de6c0dee0fc35057410853f76255df1271.1295499394.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds IOMEM(x) to implementation of MISC_BASE for SPEAr platform. With this
there is no need to typecast misc macro's iinto (unsigned int *).

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/hardware.h  |    2 +
 arch/arm/mach-spear3xx/include/mach/misc_regs.h |  136 +++++++++++-----------
 arch/arm/mach-spear6xx/include/mach/hardware.h  |    3 +-
 arch/arm/mach-spear6xx/include/mach/misc_regs.h |  136 +++++++++++-----------
 arch/arm/plat-spear/include/plat/hardware.h     |   23 ++++
 5 files changed, 163 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/hardware.h

diff --git a/arch/arm/mach-spear3xx/include/mach/hardware.h b/arch/arm/mach-spear3xx/include/mach/hardware.h
index 4a86e6a..490e86a 100644
--- a/arch/arm/mach-spear3xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear3xx/include/mach/hardware.h
@@ -14,6 +14,8 @@
 #ifndef __MACH_HARDWARE_H
 #define __MACH_HARDWARE_H
 
+#include <plat/hardware.h>
+
 /* Vitual to physical translation of statically mapped space */
 #define IO_ADDRESS(x)		(x | 0xF0000000)
 
diff --git a/arch/arm/mach-spear3xx/include/mach/misc_regs.h b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
index 38d767a..6c919e1 100644
--- a/arch/arm/mach-spear3xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
@@ -16,14 +16,14 @@
 
 #include <mach/spear.h>
 
-#define MISC_BASE		VA_SPEAR3XX_ICM3_MISC_REG_BASE
+#define MISC_BASE		IOMEM(VA_SPEAR3XX_ICM3_MISC_REG_BASE)
 
-#define SOC_CFG_CTR		((unsigned int *)(MISC_BASE + 0x000))
-#define DIAG_CFG_CTR		((unsigned int *)(MISC_BASE + 0x004))
-#define PLL1_CTR		((unsigned int *)(MISC_BASE + 0x008))
-#define PLL1_FRQ		((unsigned int *)(MISC_BASE + 0x00C))
-#define PLL1_MOD		((unsigned int *)(MISC_BASE + 0x010))
-#define PLL2_CTR		((unsigned int *)(MISC_BASE + 0x014))
+#define SOC_CFG_CTR		(MISC_BASE + 0x000)
+#define DIAG_CFG_CTR		(MISC_BASE + 0x004)
+#define PLL1_CTR		(MISC_BASE + 0x008)
+#define PLL1_FRQ		(MISC_BASE + 0x00C)
+#define PLL1_MOD		(MISC_BASE + 0x010)
+#define PLL2_CTR		(MISC_BASE + 0x014)
 /* PLL_CTR register masks */
 #define PLL_ENABLE		2
 #define PLL_MODE_SHIFT		4
@@ -33,7 +33,7 @@
 #define PLL_MODE_DITH_DSB	2
 #define PLL_MODE_DITH_SSB	3
 
-#define PLL2_FRQ		((unsigned int *)(MISC_BASE + 0x018))
+#define PLL2_FRQ		(MISC_BASE + 0x018)
 /* PLL FRQ register masks */
 #define PLL_DIV_N_SHIFT		0
 #define PLL_DIV_N_MASK		0xFF
@@ -44,16 +44,16 @@
 #define PLL_DITH_FDBK_M_SHIFT	16
 #define PLL_DITH_FDBK_M_MASK	0xFFFF
 
-#define PLL2_MOD		((unsigned int *)(MISC_BASE + 0x01C))
-#define PLL_CLK_CFG		((unsigned int *)(MISC_BASE + 0x020))
-#define CORE_CLK_CFG		((unsigned int *)(MISC_BASE + 0x024))
+#define PLL2_MOD		(MISC_BASE + 0x01C)
+#define PLL_CLK_CFG		(MISC_BASE + 0x020)
+#define CORE_CLK_CFG		(MISC_BASE + 0x024)
 /* CORE CLK CFG register masks */
 #define PLL_HCLK_RATIO_SHIFT	10
 #define PLL_HCLK_RATIO_MASK	0x3
 #define HCLK_PCLK_RATIO_SHIFT	8
 #define HCLK_PCLK_RATIO_MASK	0x3
 
-#define PERIP_CLK_CFG		((unsigned int *)(MISC_BASE + 0x028))
+#define PERIP_CLK_CFG		(MISC_BASE + 0x028)
 /* PERIP_CLK_CFG register masks */
 #define UART_CLK_SHIFT		4
 #define UART_CLK_MASK		0x1
@@ -66,7 +66,7 @@
 #define AUX_CLK_PLL3_MASK	0
 #define AUX_CLK_PLL1_MASK	1
 
-#define PERIP1_CLK_ENB		((unsigned int *)(MISC_BASE + 0x02C))
+#define PERIP1_CLK_ENB		(MISC_BASE + 0x02C)
 /* PERIP1_CLK_ENB register masks */
 #define UART_CLK_ENB		3
 #define SSP_CLK_ENB		5
@@ -85,33 +85,33 @@
 #define USBH_CLK_ENB		25
 #define C3_CLK_ENB		31
 
-#define SOC_CORE_ID		((unsigned int *)(MISC_BASE + 0x030))
-#define RAS_CLK_ENB		((unsigned int *)(MISC_BASE + 0x034))
-#define PERIP1_SOF_RST		((unsigned int *)(MISC_BASE + 0x038))
+#define SOC_CORE_ID		(MISC_BASE + 0x030)
+#define RAS_CLK_ENB		(MISC_BASE + 0x034)
+#define PERIP1_SOF_RST		(MISC_BASE + 0x038)
 /* PERIP1_SOF_RST register masks */
 #define JPEG_SOF_RST		8
 
-#define SOC_USER_ID		((unsigned int *)(MISC_BASE + 0x03C))
-#define RAS_SOF_RST		((unsigned int *)(MISC_BASE + 0x040))
-#define PRSC1_CLK_CFG		((unsigned int *)(MISC_BASE + 0x044))
-#define PRSC2_CLK_CFG		((unsigned int *)(MISC_BASE + 0x048))
-#define PRSC3_CLK_CFG		((unsigned int *)(MISC_BASE + 0x04C))
+#define SOC_USER_ID		(MISC_BASE + 0x03C)
+#define RAS_SOF_RST		(MISC_BASE + 0x040)
+#define PRSC1_CLK_CFG		(MISC_BASE + 0x044)
+#define PRSC2_CLK_CFG		(MISC_BASE + 0x048)
+#define PRSC3_CLK_CFG		(MISC_BASE + 0x04C)
 /* gpt synthesizer register masks */
 #define GPT_MSCALE_SHIFT	0
 #define GPT_MSCALE_MASK		0xFFF
 #define GPT_NSCALE_SHIFT	12
 #define GPT_NSCALE_MASK		0xF
 
-#define AMEM_CLK_CFG		((unsigned int *)(MISC_BASE + 0x050))
-#define EXPI_CLK_CFG		((unsigned int *)(MISC_BASE + 0x054))
-#define CLCD_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x05C))
-#define FIRDA_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x060))
-#define UART_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x064))
-#define GMAC_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x068))
-#define RAS1_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x06C))
-#define RAS2_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x070))
-#define RAS3_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x074))
-#define RAS4_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x078))
+#define AMEM_CLK_CFG		(MISC_BASE + 0x050)
+#define EXPI_CLK_CFG		(MISC_BASE + 0x054)
+#define CLCD_CLK_SYNT		(MISC_BASE + 0x05C)
+#define FIRDA_CLK_SYNT		(MISC_BASE + 0x060)
+#define UART_CLK_SYNT		(MISC_BASE + 0x064)
+#define GMAC_CLK_SYNT		(MISC_BASE + 0x068)
+#define RAS1_CLK_SYNT		(MISC_BASE + 0x06C)
+#define RAS2_CLK_SYNT		(MISC_BASE + 0x070)
+#define RAS3_CLK_SYNT		(MISC_BASE + 0x074)
+#define RAS4_CLK_SYNT		(MISC_BASE + 0x078)
 /* aux clk synthesiser register masks for irda to ras4 */
 #define AUX_EQ_SEL_SHIFT	30
 #define AUX_EQ_SEL_MASK		1
@@ -122,42 +122,42 @@
 #define AUX_YSCALE_SHIFT	0
 #define AUX_YSCALE_MASK		0xFFF
 
-#define ICM1_ARB_CFG		((unsigned int *)(MISC_BASE + 0x07C))
-#define ICM2_ARB_CFG		((unsigned int *)(MISC_BASE + 0x080))
-#define ICM3_ARB_CFG		((unsigned int *)(MISC_BASE + 0x084))
-#define ICM4_ARB_CFG		((unsigned int *)(MISC_BASE + 0x088))
-#define ICM5_ARB_CFG		((unsigned int *)(MISC_BASE + 0x08C))
-#define ICM6_ARB_CFG		((unsigned int *)(MISC_BASE + 0x090))
-#define ICM7_ARB_CFG		((unsigned int *)(MISC_BASE + 0x094))
-#define ICM8_ARB_CFG		((unsigned int *)(MISC_BASE + 0x098))
-#define ICM9_ARB_CFG		((unsigned int *)(MISC_BASE + 0x09C))
-#define DMA_CHN_CFG		((unsigned int *)(MISC_BASE + 0x0A0))
-#define USB2_PHY_CFG		((unsigned int *)(MISC_BASE + 0x0A4))
-#define GMAC_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0A8))
-#define EXPI_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0AC))
-#define PRC1_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0C0))
-#define PRC2_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0C4))
-#define PRC3_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0C8))
-#define PRC4_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0CC))
-#define PRC1_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0D0))
-#define PRC2_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0D4))
-#define PRC3_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0D8))
-#define PRC4_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0DC))
-#define PWRDOWN_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0E0))
-#define COMPSSTL_1V8_CFG	((unsigned int *)(MISC_BASE + 0x0E4))
-#define COMPSSTL_2V5_CFG	((unsigned int *)(MISC_BASE + 0x0E8))
-#define COMPCOR_3V3_CFG		((unsigned int *)(MISC_BASE + 0x0EC))
-#define SSTLPAD_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0F0))
-#define BIST1_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0F4))
-#define BIST2_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0F8))
-#define BIST3_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0FC))
-#define BIST4_CFG_CTR		((unsigned int *)(MISC_BASE + 0x100))
-#define BIST5_CFG_CTR		((unsigned int *)(MISC_BASE + 0x104))
-#define BIST1_STS_RES		((unsigned int *)(MISC_BASE + 0x108))
-#define BIST2_STS_RES		((unsigned int *)(MISC_BASE + 0x10C))
-#define BIST3_STS_RES		((unsigned int *)(MISC_BASE + 0x110))
-#define BIST4_STS_RES		((unsigned int *)(MISC_BASE + 0x114))
-#define BIST5_STS_RES		((unsigned int *)(MISC_BASE + 0x118))
-#define SYSERR_CFG_CTR		((unsigned int *)(MISC_BASE + 0x11C))
+#define ICM1_ARB_CFG		(MISC_BASE + 0x07C)
+#define ICM2_ARB_CFG		(MISC_BASE + 0x080)
+#define ICM3_ARB_CFG		(MISC_BASE + 0x084)
+#define ICM4_ARB_CFG		(MISC_BASE + 0x088)
+#define ICM5_ARB_CFG		(MISC_BASE + 0x08C)
+#define ICM6_ARB_CFG		(MISC_BASE + 0x090)
+#define ICM7_ARB_CFG		(MISC_BASE + 0x094)
+#define ICM8_ARB_CFG		(MISC_BASE + 0x098)
+#define ICM9_ARB_CFG		(MISC_BASE + 0x09C)
+#define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
+#define USB2_PHY_CFG		(MISC_BASE + 0x0A4)
+#define GMAC_CFG_CTR		(MISC_BASE + 0x0A8)
+#define EXPI_CFG_CTR		(MISC_BASE + 0x0AC)
+#define PRC1_LOCK_CTR		(MISC_BASE + 0x0C0)
+#define PRC2_LOCK_CTR		(MISC_BASE + 0x0C4)
+#define PRC3_LOCK_CTR		(MISC_BASE + 0x0C8)
+#define PRC4_LOCK_CTR		(MISC_BASE + 0x0CC)
+#define PRC1_IRQ_CTR		(MISC_BASE + 0x0D0)
+#define PRC2_IRQ_CTR		(MISC_BASE + 0x0D4)
+#define PRC3_IRQ_CTR		(MISC_BASE + 0x0D8)
+#define PRC4_IRQ_CTR		(MISC_BASE + 0x0DC)
+#define PWRDOWN_CFG_CTR		(MISC_BASE + 0x0E0)
+#define COMPSSTL_1V8_CFG	(MISC_BASE + 0x0E4)
+#define COMPSSTL_2V5_CFG	(MISC_BASE + 0x0E8)
+#define COMPCOR_3V3_CFG		(MISC_BASE + 0x0EC)
+#define SSTLPAD_CFG_CTR		(MISC_BASE + 0x0F0)
+#define BIST1_CFG_CTR		(MISC_BASE + 0x0F4)
+#define BIST2_CFG_CTR		(MISC_BASE + 0x0F8)
+#define BIST3_CFG_CTR		(MISC_BASE + 0x0FC)
+#define BIST4_CFG_CTR		(MISC_BASE + 0x100)
+#define BIST5_CFG_CTR		(MISC_BASE + 0x104)
+#define BIST1_STS_RES		(MISC_BASE + 0x108)
+#define BIST2_STS_RES		(MISC_BASE + 0x10C)
+#define BIST3_STS_RES		(MISC_BASE + 0x110)
+#define BIST4_STS_RES		(MISC_BASE + 0x114)
+#define BIST5_STS_RES		(MISC_BASE + 0x118)
+#define SYSERR_CFG_CTR		(MISC_BASE + 0x11C)
 
 #endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/hardware.h b/arch/arm/mach-spear6xx/include/mach/hardware.h
index 7545116..0291476 100644
--- a/arch/arm/mach-spear6xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear6xx/include/mach/hardware.h
@@ -14,8 +14,9 @@
 #ifndef __MACH_HARDWARE_H
 #define __MACH_HARDWARE_H
 
+#include <plat/hardware.h>
+
 /* Vitual to physical translation of statically mapped space */
 #define IO_ADDRESS(x)		(x | 0xF0000000)
 
 #endif /* __MACH_HARDWARE_H */
-
diff --git a/arch/arm/mach-spear6xx/include/mach/misc_regs.h b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
index 0390803..d153177 100644
--- a/arch/arm/mach-spear6xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
@@ -16,14 +16,14 @@
 
 #include <mach/spear.h>
 
-#define MISC_BASE		VA_SPEAR6XX_ICM3_MISC_REG_BASE
+#define MISC_BASE		IOMEM(VA_SPEAR6XX_ICM3_MISC_REG_BASE)
 
-#define SOC_CFG_CTR		((unsigned int *)(MISC_BASE + 0x000))
-#define DIAG_CFG_CTR		((unsigned int *)(MISC_BASE + 0x004))
-#define PLL1_CTR		((unsigned int *)(MISC_BASE + 0x008))
-#define PLL1_FRQ		((unsigned int *)(MISC_BASE + 0x00C))
-#define PLL1_MOD		((unsigned int *)(MISC_BASE + 0x010))
-#define PLL2_CTR		((unsigned int *)(MISC_BASE + 0x014))
+#define SOC_CFG_CTR		(MISC_BASE + 0x000)
+#define DIAG_CFG_CTR		(MISC_BASE + 0x004)
+#define PLL1_CTR		(MISC_BASE + 0x008)
+#define PLL1_FRQ		(MISC_BASE + 0x00C)
+#define PLL1_MOD		(MISC_BASE + 0x010)
+#define PLL2_CTR		(MISC_BASE + 0x014)
 /* PLL_CTR register masks */
 #define PLL_ENABLE		2
 #define PLL_MODE_SHIFT		4
@@ -33,7 +33,7 @@
 #define PLL_MODE_DITH_DSB	2
 #define PLL_MODE_DITH_SSB	3
 
-#define PLL2_FRQ		((unsigned int *)(MISC_BASE + 0x018))
+#define PLL2_FRQ		(MISC_BASE + 0x018)
 /* PLL FRQ register masks */
 #define PLL_DIV_N_SHIFT		0
 #define PLL_DIV_N_MASK		0xFF
@@ -44,16 +44,16 @@
 #define PLL_DITH_FDBK_M_SHIFT	16
 #define PLL_DITH_FDBK_M_MASK	0xFFFF
 
-#define PLL2_MOD		((unsigned int *)(MISC_BASE + 0x01C))
-#define PLL_CLK_CFG		((unsigned int *)(MISC_BASE + 0x020))
-#define CORE_CLK_CFG		((unsigned int *)(MISC_BASE + 0x024))
+#define PLL2_MOD		(MISC_BASE + 0x01C)
+#define PLL_CLK_CFG		(MISC_BASE + 0x020)
+#define CORE_CLK_CFG		(MISC_BASE + 0x024)
 /* CORE CLK CFG register masks */
 #define PLL_HCLK_RATIO_SHIFT	10
 #define PLL_HCLK_RATIO_MASK	0x3
 #define HCLK_PCLK_RATIO_SHIFT	8
 #define HCLK_PCLK_RATIO_MASK	0x3
 
-#define PERIP_CLK_CFG		((unsigned int *)(MISC_BASE + 0x028))
+#define PERIP_CLK_CFG		(MISC_BASE + 0x028)
 /* PERIP_CLK_CFG register masks */
 #define CLCD_CLK_SHIFT		2
 #define CLCD_CLK_MASK		0x3
@@ -69,7 +69,7 @@
 #define AUX_CLK_PLL3_MASK	0
 #define AUX_CLK_PLL1_MASK	1
 
-#define PERIP1_CLK_ENB		((unsigned int *)(MISC_BASE + 0x02C))
+#define PERIP1_CLK_ENB		(MISC_BASE + 0x02C)
 /* PERIP1_CLK_ENB register masks */
 #define UART0_CLK_ENB		3
 #define UART1_CLK_ENB		4
@@ -95,33 +95,33 @@
 #define USBH0_CLK_ENB		25
 #define USBH1_CLK_ENB		26
 
-#define SOC_CORE_ID		((unsigned int *)(MISC_BASE + 0x030))
-#define RAS_CLK_ENB		((unsigned int *)(MISC_BASE + 0x034))
-#define PERIP1_SOF_RST		((unsigned int *)(MISC_BASE + 0x038))
+#define SOC_CORE_ID		(MISC_BASE + 0x030)
+#define RAS_CLK_ENB		(MISC_BASE + 0x034)
+#define PERIP1_SOF_RST		(MISC_BASE + 0x038)
 /* PERIP1_SOF_RST register masks */
 #define JPEG_SOF_RST		8
 
-#define SOC_USER_ID		((unsigned int *)(MISC_BASE + 0x03C))
-#define RAS_SOF_RST		((unsigned int *)(MISC_BASE + 0x040))
-#define PRSC1_CLK_CFG		((unsigned int *)(MISC_BASE + 0x044))
-#define PRSC2_CLK_CFG		((unsigned int *)(MISC_BASE + 0x048))
-#define PRSC3_CLK_CFG		((unsigned int *)(MISC_BASE + 0x04C))
+#define SOC_USER_ID		(MISC_BASE + 0x03C)
+#define RAS_SOF_RST		(MISC_BASE + 0x040)
+#define PRSC1_CLK_CFG		(MISC_BASE + 0x044)
+#define PRSC2_CLK_CFG		(MISC_BASE + 0x048)
+#define PRSC3_CLK_CFG		(MISC_BASE + 0x04C)
 /* gpt synthesizer register masks */
 #define GPT_MSCALE_SHIFT	0
 #define GPT_MSCALE_MASK		0xFFF
 #define GPT_NSCALE_SHIFT	12
 #define GPT_NSCALE_MASK		0xF
 
-#define AMEM_CLK_CFG		((unsigned int *)(MISC_BASE + 0x050))
-#define EXPI_CLK_CFG		((unsigned int *)(MISC_BASE + 0x054))
-#define CLCD_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x05C))
-#define FIRDA_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x060))
-#define UART_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x064))
-#define GMAC_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x068))
-#define RAS1_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x06C))
-#define RAS2_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x070))
-#define RAS3_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x074))
-#define RAS4_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x078))
+#define AMEM_CLK_CFG		(MISC_BASE + 0x050)
+#define EXPI_CLK_CFG		(MISC_BASE + 0x054)
+#define CLCD_CLK_SYNT		(MISC_BASE + 0x05C)
+#define FIRDA_CLK_SYNT		(MISC_BASE + 0x060)
+#define UART_CLK_SYNT		(MISC_BASE + 0x064)
+#define GMAC_CLK_SYNT		(MISC_BASE + 0x068)
+#define RAS1_CLK_SYNT		(MISC_BASE + 0x06C)
+#define RAS2_CLK_SYNT		(MISC_BASE + 0x070)
+#define RAS3_CLK_SYNT		(MISC_BASE + 0x074)
+#define RAS4_CLK_SYNT		(MISC_BASE + 0x078)
 /* aux clk synthesiser register masks for irda to ras4 */
 #define AUX_EQ_SEL_SHIFT	30
 #define AUX_EQ_SEL_MASK		1
@@ -132,42 +132,42 @@
 #define AUX_YSCALE_SHIFT	0
 #define AUX_YSCALE_MASK		0xFFF
 
-#define ICM1_ARB_CFG		((unsigned int *)(MISC_BASE + 0x07C))
-#define ICM2_ARB_CFG		((unsigned int *)(MISC_BASE + 0x080))
-#define ICM3_ARB_CFG		((unsigned int *)(MISC_BASE + 0x084))
-#define ICM4_ARB_CFG		((unsigned int *)(MISC_BASE + 0x088))
-#define ICM5_ARB_CFG		((unsigned int *)(MISC_BASE + 0x08C))
-#define ICM6_ARB_CFG		((unsigned int *)(MISC_BASE + 0x090))
-#define ICM7_ARB_CFG		((unsigned int *)(MISC_BASE + 0x094))
-#define ICM8_ARB_CFG		((unsigned int *)(MISC_BASE + 0x098))
-#define ICM9_ARB_CFG		((unsigned int *)(MISC_BASE + 0x09C))
-#define DMA_CHN_CFG		((unsigned int *)(MISC_BASE + 0x0A0))
-#define USB2_PHY_CFG		((unsigned int *)(MISC_BASE + 0x0A4))
-#define GMAC_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0A8))
-#define EXPI_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0AC))
-#define PRC1_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0C0))
-#define PRC2_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0C4))
-#define PRC3_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0C8))
-#define PRC4_LOCK_CTR		((unsigned int *)(MISC_BASE + 0x0CC))
-#define PRC1_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0D0))
-#define PRC2_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0D4))
-#define PRC3_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0D8))
-#define PRC4_IRQ_CTR		((unsigned int *)(MISC_BASE + 0x0DC))
-#define PWRDOWN_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0E0))
-#define COMPSSTL_1V8_CFG	((unsigned int *)(MISC_BASE + 0x0E4))
-#define COMPSSTL_2V5_CFG	((unsigned int *)(MISC_BASE + 0x0E8))
-#define COMPCOR_3V3_CFG		((unsigned int *)(MISC_BASE + 0x0EC))
-#define SSTLPAD_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0F0))
-#define BIST1_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0F4))
-#define BIST2_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0F8))
-#define BIST3_CFG_CTR		((unsigned int *)(MISC_BASE + 0x0FC))
-#define BIST4_CFG_CTR		((unsigned int *)(MISC_BASE + 0x100))
-#define BIST5_CFG_CTR		((unsigned int *)(MISC_BASE + 0x104))
-#define BIST1_STS_RES		((unsigned int *)(MISC_BASE + 0x108))
-#define BIST2_STS_RES		((unsigned int *)(MISC_BASE + 0x10C))
-#define BIST3_STS_RES		((unsigned int *)(MISC_BASE + 0x110))
-#define BIST4_STS_RES		((unsigned int *)(MISC_BASE + 0x114))
-#define BIST5_STS_RES		((unsigned int *)(MISC_BASE + 0x118))
-#define SYSERR_CFG_CTR		((unsigned int *)(MISC_BASE + 0x11C))
+#define ICM1_ARB_CFG		(MISC_BASE + 0x07C)
+#define ICM2_ARB_CFG		(MISC_BASE + 0x080)
+#define ICM3_ARB_CFG		(MISC_BASE + 0x084)
+#define ICM4_ARB_CFG		(MISC_BASE + 0x088)
+#define ICM5_ARB_CFG		(MISC_BASE + 0x08C)
+#define ICM6_ARB_CFG		(MISC_BASE + 0x090)
+#define ICM7_ARB_CFG		(MISC_BASE + 0x094)
+#define ICM8_ARB_CFG		(MISC_BASE + 0x098)
+#define ICM9_ARB_CFG		(MISC_BASE + 0x09C)
+#define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
+#define USB2_PHY_CFG		(MISC_BASE + 0x0A4)
+#define GMAC_CFG_CTR		(MISC_BASE + 0x0A8)
+#define EXPI_CFG_CTR		(MISC_BASE + 0x0AC)
+#define PRC1_LOCK_CTR		(MISC_BASE + 0x0C0)
+#define PRC2_LOCK_CTR		(MISC_BASE + 0x0C4)
+#define PRC3_LOCK_CTR		(MISC_BASE + 0x0C8)
+#define PRC4_LOCK_CTR		(MISC_BASE + 0x0CC)
+#define PRC1_IRQ_CTR		(MISC_BASE + 0x0D0)
+#define PRC2_IRQ_CTR		(MISC_BASE + 0x0D4)
+#define PRC3_IRQ_CTR		(MISC_BASE + 0x0D8)
+#define PRC4_IRQ_CTR		(MISC_BASE + 0x0DC)
+#define PWRDOWN_CFG_CTR		(MISC_BASE + 0x0E0)
+#define COMPSSTL_1V8_CFG	(MISC_BASE + 0x0E4)
+#define COMPSSTL_2V5_CFG	(MISC_BASE + 0x0E8)
+#define COMPCOR_3V3_CFG		(MISC_BASE + 0x0EC)
+#define SSTLPAD_CFG_CTR		(MISC_BASE + 0x0F0)
+#define BIST1_CFG_CTR		(MISC_BASE + 0x0F4)
+#define BIST2_CFG_CTR		(MISC_BASE + 0x0F8)
+#define BIST3_CFG_CTR		(MISC_BASE + 0x0FC)
+#define BIST4_CFG_CTR		(MISC_BASE + 0x100)
+#define BIST5_CFG_CTR		(MISC_BASE + 0x104)
+#define BIST1_STS_RES		(MISC_BASE + 0x108)
+#define BIST2_STS_RES		(MISC_BASE + 0x10C)
+#define BIST3_STS_RES		(MISC_BASE + 0x110)
+#define BIST4_STS_RES		(MISC_BASE + 0x114)
+#define BIST5_STS_RES		(MISC_BASE + 0x118)
+#define SYSERR_CFG_CTR		(MISC_BASE + 0x11C)
 
 #endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/plat-spear/include/plat/hardware.h b/arch/arm/plat-spear/include/plat/hardware.h
new file mode 100644
index 0000000..66d6772
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/hardware.h
@@ -0,0 +1,23 @@
+/*
+ * arch/arm/plat-spear/include/plat/hardware.h
+ *
+ * Hardware definitions for SPEAr
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_HARDWARE_H
+#define __PLAT_HARDWARE_H
+
+#ifndef __ASSEMBLY__
+#define IOMEM(x)	((void __iomem __force *)(x))
+#else
+#define IOMEM(x)	(x)
+#endif
+
+#endif /* __PLAT_HARDWARE_H */
-- 
1.7.3.4
