From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Apr 2012 17:30:11 +0000
Subject: [GIT PULL] ARM: spear-soc DT support for 3.5
In-Reply-To: <4F793C56.2030605@st.com>
References: <4F793C56.2030605@st.com>
Message-ID: <201204111730.12267.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Viresh Kumar wrote:
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> 
>   Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> 
> are available in the git repository at:
> 
>   git://git.stlinux.com/spear/linux-2.6.git spear-dt
> 
> for you to fetch changes up to 8f21ec99c7b78c3f0baf6bbf2e438da68da3dc08:
> 
>   SPEAr: Update defconfigs (2012-04-02 09:03:59 +0530)
> 
> ----------------------------------------------------------------

Hi Viresh,

I've played around with spear myself, based on your patches. Please
consider adding this patch, or a variation of it.

8<---
ARM: spear: remove most mach/*.h header contents

The register and irq definitions in mach/*.h for spear3xx and
spear6xx are now mostly obsolete, after the platforms have been
converted to device tree based probing and the data is now
part of the device tree files.

The misc_regs.h contents are moved into clock.c because that is
the only user, aside from the DMA_CHN_CFG that should eventually
get handled differently. Some of the contents of mach/spear.h
still remain, because they are used to set up the static map table,
timer, uart and auxdata tables, but almost everything got removed.
We might remove everything but the map table as the DT conversion
completes, but that is not a priority. I've also made sure to
make both copies of spear.h more or less identical so we can
eventually combine them.

The spear3?0.h files were only used by the spear3?0.c files, so I
merged the contents in there and removed the bits that were unused.
This is something that should still be looked at.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 arch/arm/mach-spear3xx/clock.c                  |  145 +++++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h   |   11 +--
 arch/arm/mach-spear3xx/include/mach/hardware.h  |   21 +---
 arch/arm/mach-spear3xx/include/mach/irqs.h      |  130 +-------------------
 arch/arm/mach-spear3xx/include/mach/misc_regs.h |  144 ---------------------
 arch/arm/mach-spear3xx/include/mach/spear.h     |   38 +------
 arch/arm/mach-spear3xx/include/mach/spear300.h  |   54 --------
 arch/arm/mach-spear3xx/include/mach/spear310.h  |   58 ---------
 arch/arm/mach-spear3xx/include/mach/spear320.h  |   67 ----------
 arch/arm/mach-spear3xx/spear300.c               |   41 ++++++-
 arch/arm/mach-spear3xx/spear310.c               |   62 +++++++++-
 arch/arm/mach-spear3xx/spear320.c               |   62 +++++++++-
 arch/arm/mach-spear3xx/spear3xx.c               |    4 +-
 arch/arm/mach-spear6xx/clock.c                  |  154 +++++++++++++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h   |   29 +----
 arch/arm/mach-spear6xx/include/mach/hardware.h  |   24 +----
 arch/arm/mach-spear6xx/include/mach/irqs.h      |   75 +-----------
 arch/arm/mach-spear6xx/include/mach/misc_regs.h |  154 -----------------------
 arch/arm/mach-spear6xx/include/mach/spear.h     |   55 +-------
 arch/arm/mach-spear6xx/include/mach/spear600.h  |   21 ---
 arch/arm/mach-spear6xx/spear6xx.c               |   49 ++++----
 arch/arm/plat-spear/include/plat/debug-macro.S  |    2 +-
 arch/arm/plat-spear/include/plat/hardware.h     |   17 ---
 arch/arm/plat-spear/include/plat/uncompress.h   |    2 +-
 arch/arm/plat-spear/pl080.c                     |    1 +
 arch/arm/plat-spear/restart.c                   |    2 +-
 arch/arm/plat-spear/time.c                      |   17 ++--
 27 files changed, 518 insertions(+), 921 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index eeafe38..00c508a 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -19,6 +19,151 @@
 #include <asm/mach-types.h>
 #include <plat/clock.h>
 #include <mach/misc_regs.h>
+#include <mach/spear.h>
+
+#define MISC_BASE		IOMEM(VA_SPEAR3XX_ICM3_MISC_REG_BASE)
+
+#define SOC_CFG_CTR		(MISC_BASE + 0x000)
+#define DIAG_CFG_CTR		(MISC_BASE + 0x004)
+#define PLL1_CTR		(MISC_BASE + 0x008)
+#define PLL1_FRQ		(MISC_BASE + 0x00C)
+#define PLL1_MOD		(MISC_BASE + 0x010)
+#define PLL2_CTR		(MISC_BASE + 0x014)
+/* PLL_CTR register masks */
+#define PLL_ENABLE		2
+#define PLL_MODE_SHIFT		4
+#define PLL_MODE_MASK		0x3
+#define PLL_MODE_NORMAL		0
+#define PLL_MODE_FRACTION	1
+#define PLL_MODE_DITH_DSB	2
+#define PLL_MODE_DITH_SSB	3
+
+#define PLL2_FRQ		(MISC_BASE + 0x018)
+/* PLL FRQ register masks */
+#define PLL_DIV_N_SHIFT		0
+#define PLL_DIV_N_MASK		0xFF
+#define PLL_DIV_P_SHIFT		8
+#define PLL_DIV_P_MASK		0x7
+#define PLL_NORM_FDBK_M_SHIFT	24
+#define PLL_NORM_FDBK_M_MASK	0xFF
+#define PLL_DITH_FDBK_M_SHIFT	16
+#define PLL_DITH_FDBK_M_MASK	0xFFFF
+
+#define PLL2_MOD		(MISC_BASE + 0x01C)
+#define PLL_CLK_CFG		(MISC_BASE + 0x020)
+#define CORE_CLK_CFG		(MISC_BASE + 0x024)
+/* CORE CLK CFG register masks */
+#define PLL_HCLK_RATIO_SHIFT	10
+#define PLL_HCLK_RATIO_MASK	0x3
+#define HCLK_PCLK_RATIO_SHIFT	8
+#define HCLK_PCLK_RATIO_MASK	0x3
+
+#define PERIP_CLK_CFG		(MISC_BASE + 0x028)
+/* PERIP_CLK_CFG register masks */
+#define UART_CLK_SHIFT		4
+#define UART_CLK_MASK		0x1
+#define FIRDA_CLK_SHIFT		5
+#define FIRDA_CLK_MASK		0x3
+#define GPT0_CLK_SHIFT		8
+#define GPT1_CLK_SHIFT		11
+#define GPT2_CLK_SHIFT		12
+#define GPT_CLK_MASK		0x1
+#define AUX_CLK_PLL3_VAL	0
+#define AUX_CLK_PLL1_VAL	1
+
+#define PERIP1_CLK_ENB		(MISC_BASE + 0x02C)
+/* PERIP1_CLK_ENB register masks */
+#define UART_CLK_ENB		3
+#define SSP_CLK_ENB		5
+#define I2C_CLK_ENB		7
+#define JPEG_CLK_ENB		8
+#define FIRDA_CLK_ENB		10
+#define GPT1_CLK_ENB		11
+#define GPT2_CLK_ENB		12
+#define ADC_CLK_ENB		15
+#define RTC_CLK_ENB		17
+#define GPIO_CLK_ENB		18
+#define DMA_CLK_ENB		19
+#define SMI_CLK_ENB		21
+#define GMAC_CLK_ENB		23
+#define USBD_CLK_ENB		24
+#define USBH_CLK_ENB		25
+#define C3_CLK_ENB		31
+
+#define SOC_CORE_ID		(MISC_BASE + 0x030)
+#define RAS_CLK_ENB		(MISC_BASE + 0x034)
+#define PERIP1_SOF_RST		(MISC_BASE + 0x038)
+/* PERIP1_SOF_RST register masks */
+#define JPEG_SOF_RST		8
+
+#define SOC_USER_ID		(MISC_BASE + 0x03C)
+#define RAS_SOF_RST		(MISC_BASE + 0x040)
+#define PRSC1_CLK_CFG		(MISC_BASE + 0x044)
+#define PRSC2_CLK_CFG		(MISC_BASE + 0x048)
+#define PRSC3_CLK_CFG		(MISC_BASE + 0x04C)
+/* gpt synthesizer register masks */
+#define GPT_MSCALE_SHIFT	0
+#define GPT_MSCALE_MASK		0xFFF
+#define GPT_NSCALE_SHIFT	12
+#define GPT_NSCALE_MASK		0xF
+
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
+/* aux clk synthesiser register masks for irda to ras4 */
+#define AUX_SYNT_ENB		31
+#define AUX_EQ_SEL_SHIFT	30
+#define AUX_EQ_SEL_MASK		1
+#define AUX_EQ1_SEL		0
+#define AUX_EQ2_SEL		1
+#define AUX_XSCALE_SHIFT	16
+#define AUX_XSCALE_MASK		0xFFF
+#define AUX_YSCALE_SHIFT	0
+#define AUX_YSCALE_MASK		0xFFF
+
+#define ICM1_ARB_CFG		(MISC_BASE + 0x07C)
+#define ICM2_ARB_CFG		(MISC_BASE + 0x080)
+#define ICM3_ARB_CFG		(MISC_BASE + 0x084)
+#define ICM4_ARB_CFG		(MISC_BASE + 0x088)
+#define ICM5_ARB_CFG		(MISC_BASE + 0x08C)
+#define ICM6_ARB_CFG		(MISC_BASE + 0x090)
+#define ICM7_ARB_CFG		(MISC_BASE + 0x094)
+#define ICM8_ARB_CFG		(MISC_BASE + 0x098)
+#define ICM9_ARB_CFG		(MISC_BASE + 0x09C)
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
 
 /* root clks */
 /* 32 KHz oscillator clock */
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index a756958..e4f4d72 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -22,22 +22,13 @@
 #include <asm/mach/map.h>
 #include <plat/padmux.h>
 
-/* spear3xx declarations */
-/*
- * Each GPT has 2 timer channels
- * Following GPT channels will be used as clock source and clockevent
- */
-#define SPEAR_GPT0_BASE		SPEAR3XX_ML1_TMR_BASE
-#define SPEAR_GPT0_CHAN0_IRQ	SPEAR3XX_IRQ_CPU_GPT1_1
-#define SPEAR_GPT0_CHAN1_IRQ	SPEAR3XX_IRQ_CPU_GPT1_2
-
 /* Add spear3xx family device structure declarations here */
 extern struct sys_timer spear3xx_timer;
 extern struct pl022_ssp_controller pl022_plat_data;
 extern struct pl08x_platform_data pl080_plat_data;
 
 /* Add spear3xx family function declarations here */
-void __init spear_setup_timer(void);
+void __init spear_setup_timer(resource_size_t base, int irq);
 void __init spear3xx_map_io(void);
 void __init spear3xx_dt_init_irq(void);
 
diff --git a/arch/arm/mach-spear3xx/include/mach/hardware.h b/arch/arm/mach-spear3xx/include/mach/hardware.h
index defa374..40a8c17 100644
--- a/arch/arm/mach-spear3xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear3xx/include/mach/hardware.h
@@ -1,20 +1 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/hardware.h
- *
- * Hardware definitions for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_HARDWARE_H
-#define __MACH_HARDWARE_H
-
-#include <plat/hardware.h>
-#include <mach/spear.h>
-
-#endif /* __MACH_HARDWARE_H */
+/* empty */
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index 6e26544..319620a 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -14,141 +14,15 @@
 #ifndef __MACH_IRQS_H
 #define __MACH_IRQS_H
 
-/* SPEAr3xx IRQ definitions */
-#define SPEAR3XX_IRQ_HW_ACCEL_MOD_0		0
+/* FIXME: probe all these from DT */
 #define SPEAR3XX_IRQ_INTRCOMM_RAS_ARM		1
 #define SPEAR3XX_IRQ_CPU_GPT1_1			2
-#define SPEAR3XX_IRQ_CPU_GPT1_2			3
-#define SPEAR3XX_IRQ_BASIC_GPT1_1		4
-#define SPEAR3XX_IRQ_BASIC_GPT1_2		5
-#define SPEAR3XX_IRQ_BASIC_GPT2_1		6
-#define SPEAR3XX_IRQ_BASIC_GPT2_2		7
-#define SPEAR3XX_IRQ_BASIC_DMA			8
-#define SPEAR3XX_IRQ_BASIC_SMI			9
-#define SPEAR3XX_IRQ_BASIC_RTC			10
-#define SPEAR3XX_IRQ_BASIC_GPIO			11
-#define SPEAR3XX_IRQ_BASIC_WDT			12
-#define SPEAR3XX_IRQ_DDR_CONTROLLER		13
-#define SPEAR3XX_IRQ_SYS_ERROR			14
-#define SPEAR3XX_IRQ_WAKEUP_RCV			15
-#define SPEAR3XX_IRQ_JPEG			16
-#define SPEAR3XX_IRQ_IRDA			17
-#define SPEAR3XX_IRQ_ADC			18
-#define SPEAR3XX_IRQ_UART			19
-#define SPEAR3XX_IRQ_SSP			20
-#define SPEAR3XX_IRQ_I2C			21
-#define SPEAR3XX_IRQ_MAC_1			22
-#define SPEAR3XX_IRQ_MAC_2			23
-#define SPEAR3XX_IRQ_USB_DEV			24
-#define SPEAR3XX_IRQ_USB_H_OHCI_0		25
-#define SPEAR3XX_IRQ_USB_H_EHCI_0		26
-#define SPEAR3XX_IRQ_USB_H_EHCI_1		SPEAR3XX_IRQ_USB_H_EHCI_0
-#define SPEAR3XX_IRQ_USB_H_OHCI_1		27
 #define SPEAR3XX_IRQ_GEN_RAS_1			28
 #define SPEAR3XX_IRQ_GEN_RAS_2			29
 #define SPEAR3XX_IRQ_GEN_RAS_3			30
-#define SPEAR3XX_IRQ_HW_ACCEL_MOD_1		31
 #define SPEAR3XX_IRQ_VIC_END			32
-
 #define SPEAR3XX_VIRQ_START			SPEAR3XX_IRQ_VIC_END
 
-/* SPEAr300 Virtual irq definitions */
-/* IRQs sharing IRQ_GEN_RAS_1 */
-#define SPEAR300_VIRQ_IT_PERS_S			(SPEAR3XX_VIRQ_START + 0)
-#define SPEAR300_VIRQ_IT_CHANGE_S		(SPEAR3XX_VIRQ_START + 1)
-#define SPEAR300_VIRQ_I2S			(SPEAR3XX_VIRQ_START + 2)
-#define SPEAR300_VIRQ_TDM			(SPEAR3XX_VIRQ_START + 3)
-#define SPEAR300_VIRQ_CAMERA_L			(SPEAR3XX_VIRQ_START + 4)
-#define SPEAR300_VIRQ_CAMERA_F			(SPEAR3XX_VIRQ_START + 5)
-#define SPEAR300_VIRQ_CAMERA_V			(SPEAR3XX_VIRQ_START + 6)
-#define SPEAR300_VIRQ_KEYBOARD			(SPEAR3XX_VIRQ_START + 7)
-#define SPEAR300_VIRQ_GPIO1			(SPEAR3XX_VIRQ_START + 8)
-
-/* IRQs sharing IRQ_GEN_RAS_3 */
-#define SPEAR300_IRQ_CLCD			SPEAR3XX_IRQ_GEN_RAS_3
-
-/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
-#define SPEAR300_IRQ_SDHCI			SPEAR3XX_IRQ_INTRCOMM_RAS_ARM
-
-/* SPEAr310 Virtual irq definitions */
-/* IRQs sharing IRQ_GEN_RAS_1 */
-#define SPEAR310_VIRQ_SMII0			(SPEAR3XX_VIRQ_START + 0)
-#define SPEAR310_VIRQ_SMII1			(SPEAR3XX_VIRQ_START + 1)
-#define SPEAR310_VIRQ_SMII2			(SPEAR3XX_VIRQ_START + 2)
-#define SPEAR310_VIRQ_SMII3			(SPEAR3XX_VIRQ_START + 3)
-#define SPEAR310_VIRQ_WAKEUP_SMII0		(SPEAR3XX_VIRQ_START + 4)
-#define SPEAR310_VIRQ_WAKEUP_SMII1		(SPEAR3XX_VIRQ_START + 5)
-#define SPEAR310_VIRQ_WAKEUP_SMII2		(SPEAR3XX_VIRQ_START + 6)
-#define SPEAR310_VIRQ_WAKEUP_SMII3		(SPEAR3XX_VIRQ_START + 7)
-
-/* IRQs sharing IRQ_GEN_RAS_2 */
-#define SPEAR310_VIRQ_UART1			(SPEAR3XX_VIRQ_START + 8)
-#define SPEAR310_VIRQ_UART2			(SPEAR3XX_VIRQ_START + 9)
-#define SPEAR310_VIRQ_UART3			(SPEAR3XX_VIRQ_START + 10)
-#define SPEAR310_VIRQ_UART4			(SPEAR3XX_VIRQ_START + 11)
-#define SPEAR310_VIRQ_UART5			(SPEAR3XX_VIRQ_START + 12)
-
-/* IRQs sharing IRQ_GEN_RAS_3 */
-#define SPEAR310_VIRQ_EMI			(SPEAR3XX_VIRQ_START + 13)
-#define SPEAR310_VIRQ_PLGPIO			(SPEAR3XX_VIRQ_START + 14)
-
-/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
-#define SPEAR310_VIRQ_TDM_HDLC			(SPEAR3XX_VIRQ_START + 15)
-#define SPEAR310_VIRQ_RS485_0			(SPEAR3XX_VIRQ_START + 16)
-#define SPEAR310_VIRQ_RS485_1			(SPEAR3XX_VIRQ_START + 17)
-
-/* SPEAr320 Virtual irq definitions */
-/* IRQs sharing IRQ_GEN_RAS_1 */
-#define SPEAR320_VIRQ_EMI			(SPEAR3XX_VIRQ_START + 0)
-#define SPEAR320_VIRQ_CLCD			(SPEAR3XX_VIRQ_START + 1)
-#define SPEAR320_VIRQ_SPP			(SPEAR3XX_VIRQ_START + 2)
-
-/* IRQs sharing IRQ_GEN_RAS_2 */
-#define SPEAR320_IRQ_SDHCI			SPEAR3XX_IRQ_GEN_RAS_2
-
-/* IRQs sharing IRQ_GEN_RAS_3 */
-#define SPEAR320_VIRQ_PLGPIO			(SPEAR3XX_VIRQ_START + 3)
-#define SPEAR320_VIRQ_I2S_PLAY			(SPEAR3XX_VIRQ_START + 4)
-#define SPEAR320_VIRQ_I2S_REC			(SPEAR3XX_VIRQ_START + 5)
-
-/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
-#define SPEAR320_VIRQ_CANU			(SPEAR3XX_VIRQ_START + 6)
-#define SPEAR320_VIRQ_CANL			(SPEAR3XX_VIRQ_START + 7)
-#define SPEAR320_VIRQ_UART1			(SPEAR3XX_VIRQ_START + 8)
-#define SPEAR320_VIRQ_UART2			(SPEAR3XX_VIRQ_START + 9)
-#define SPEAR320_VIRQ_SSP1			(SPEAR3XX_VIRQ_START + 10)
-#define SPEAR320_VIRQ_SSP2			(SPEAR3XX_VIRQ_START + 11)
-#define SPEAR320_VIRQ_SMII0			(SPEAR3XX_VIRQ_START + 12)
-#define SPEAR320_VIRQ_MII1_SMII1		(SPEAR3XX_VIRQ_START + 13)
-#define SPEAR320_VIRQ_WAKEUP_SMII0		(SPEAR3XX_VIRQ_START + 14)
-#define SPEAR320_VIRQ_WAKEUP_MII1_SMII1		(SPEAR3XX_VIRQ_START + 15)
-#define SPEAR320_VIRQ_I2C1			(SPEAR3XX_VIRQ_START + 16)
-
-/*
- * GPIO pins virtual irqs
- * Use the lowest number for the GPIO virtual IRQs base on which subarchs
- * we have compiled in
- */
-#if defined(CONFIG_MACH_SPEAR310)
-#define SPEAR3XX_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 18)
-#elif defined(CONFIG_MACH_SPEAR320)
-#define SPEAR3XX_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 17)
-#else
-#define SPEAR3XX_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 9)
-#endif
-
-#define SPEAR300_GPIO1_INT_BASE			(SPEAR3XX_GPIO_INT_BASE + 8)
-#define SPEAR3XX_PLGPIO_COUNT	102
-
-#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
-#define SPEAR3XX_PLGPIO_INT_BASE		(SPEAR3XX_GPIO_INT_BASE + 8)
-#define SPEAR3XX_GPIO_INT_END			(SPEAR3XX_PLGPIO_INT_BASE + \
-							SPEAR3XX_PLGPIO_COUNT)
-#else
-#define SPEAR3XX_GPIO_INT_END	(SPEAR300_GPIO1_INT_BASE + 8)
-#endif
-
-#define SPEAR3XX_VIRQ_END	SPEAR3XX_GPIO_INT_END
-#define NR_IRQS			SPEAR3XX_VIRQ_END
+#define NR_IRQS			160
 
 #endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/misc_regs.h b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
index 5bd8cd8..e0ab72e 100644
--- a/arch/arm/mach-spear3xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
@@ -14,151 +14,7 @@
 #ifndef __MACH_MISC_REGS_H
 #define __MACH_MISC_REGS_H
 
-#include <mach/hardware.h>
-
 #define MISC_BASE		IOMEM(VA_SPEAR3XX_ICM3_MISC_REG_BASE)
-
-#define SOC_CFG_CTR		(MISC_BASE + 0x000)
-#define DIAG_CFG_CTR		(MISC_BASE + 0x004)
-#define PLL1_CTR		(MISC_BASE + 0x008)
-#define PLL1_FRQ		(MISC_BASE + 0x00C)
-#define PLL1_MOD		(MISC_BASE + 0x010)
-#define PLL2_CTR		(MISC_BASE + 0x014)
-/* PLL_CTR register masks */
-#define PLL_ENABLE		2
-#define PLL_MODE_SHIFT		4
-#define PLL_MODE_MASK		0x3
-#define PLL_MODE_NORMAL		0
-#define PLL_MODE_FRACTION	1
-#define PLL_MODE_DITH_DSB	2
-#define PLL_MODE_DITH_SSB	3
-
-#define PLL2_FRQ		(MISC_BASE + 0x018)
-/* PLL FRQ register masks */
-#define PLL_DIV_N_SHIFT		0
-#define PLL_DIV_N_MASK		0xFF
-#define PLL_DIV_P_SHIFT		8
-#define PLL_DIV_P_MASK		0x7
-#define PLL_NORM_FDBK_M_SHIFT	24
-#define PLL_NORM_FDBK_M_MASK	0xFF
-#define PLL_DITH_FDBK_M_SHIFT	16
-#define PLL_DITH_FDBK_M_MASK	0xFFFF
-
-#define PLL2_MOD		(MISC_BASE + 0x01C)
-#define PLL_CLK_CFG		(MISC_BASE + 0x020)
-#define CORE_CLK_CFG		(MISC_BASE + 0x024)
-/* CORE CLK CFG register masks */
-#define PLL_HCLK_RATIO_SHIFT	10
-#define PLL_HCLK_RATIO_MASK	0x3
-#define HCLK_PCLK_RATIO_SHIFT	8
-#define HCLK_PCLK_RATIO_MASK	0x3
-
-#define PERIP_CLK_CFG		(MISC_BASE + 0x028)
-/* PERIP_CLK_CFG register masks */
-#define UART_CLK_SHIFT		4
-#define UART_CLK_MASK		0x1
-#define FIRDA_CLK_SHIFT		5
-#define FIRDA_CLK_MASK		0x3
-#define GPT0_CLK_SHIFT		8
-#define GPT1_CLK_SHIFT		11
-#define GPT2_CLK_SHIFT		12
-#define GPT_CLK_MASK		0x1
-#define AUX_CLK_PLL3_VAL	0
-#define AUX_CLK_PLL1_VAL	1
-
-#define PERIP1_CLK_ENB		(MISC_BASE + 0x02C)
-/* PERIP1_CLK_ENB register masks */
-#define UART_CLK_ENB		3
-#define SSP_CLK_ENB		5
-#define I2C_CLK_ENB		7
-#define JPEG_CLK_ENB		8
-#define FIRDA_CLK_ENB		10
-#define GPT1_CLK_ENB		11
-#define GPT2_CLK_ENB		12
-#define ADC_CLK_ENB		15
-#define RTC_CLK_ENB		17
-#define GPIO_CLK_ENB		18
-#define DMA_CLK_ENB		19
-#define SMI_CLK_ENB		21
-#define GMAC_CLK_ENB		23
-#define USBD_CLK_ENB		24
-#define USBH_CLK_ENB		25
-#define C3_CLK_ENB		31
-
-#define SOC_CORE_ID		(MISC_BASE + 0x030)
-#define RAS_CLK_ENB		(MISC_BASE + 0x034)
-#define PERIP1_SOF_RST		(MISC_BASE + 0x038)
-/* PERIP1_SOF_RST register masks */
-#define JPEG_SOF_RST		8
-
-#define SOC_USER_ID		(MISC_BASE + 0x03C)
-#define RAS_SOF_RST		(MISC_BASE + 0x040)
-#define PRSC1_CLK_CFG		(MISC_BASE + 0x044)
-#define PRSC2_CLK_CFG		(MISC_BASE + 0x048)
-#define PRSC3_CLK_CFG		(MISC_BASE + 0x04C)
-/* gpt synthesizer register masks */
-#define GPT_MSCALE_SHIFT	0
-#define GPT_MSCALE_MASK		0xFFF
-#define GPT_NSCALE_SHIFT	12
-#define GPT_NSCALE_MASK		0xF
-
-#define AMEM_CLK_CFG		(MISC_BASE + 0x050)
-#define EXPI_CLK_CFG		(MISC_BASE + 0x054)
-#define CLCD_CLK_SYNT		(MISC_BASE + 0x05C)
-#define FIRDA_CLK_SYNT		(MISC_BASE + 0x060)
-#define UART_CLK_SYNT		(MISC_BASE + 0x064)
-#define GMAC_CLK_SYNT		(MISC_BASE + 0x068)
-#define RAS1_CLK_SYNT		(MISC_BASE + 0x06C)
-#define RAS2_CLK_SYNT		(MISC_BASE + 0x070)
-#define RAS3_CLK_SYNT		(MISC_BASE + 0x074)
-#define RAS4_CLK_SYNT		(MISC_BASE + 0x078)
-/* aux clk synthesiser register masks for irda to ras4 */
-#define AUX_SYNT_ENB		31
-#define AUX_EQ_SEL_SHIFT	30
-#define AUX_EQ_SEL_MASK		1
-#define AUX_EQ1_SEL		0
-#define AUX_EQ2_SEL		1
-#define AUX_XSCALE_SHIFT	16
-#define AUX_XSCALE_MASK		0xFFF
-#define AUX_YSCALE_SHIFT	0
-#define AUX_YSCALE_MASK		0xFFF
-
-#define ICM1_ARB_CFG		(MISC_BASE + 0x07C)
-#define ICM2_ARB_CFG		(MISC_BASE + 0x080)
-#define ICM3_ARB_CFG		(MISC_BASE + 0x084)
-#define ICM4_ARB_CFG		(MISC_BASE + 0x088)
-#define ICM5_ARB_CFG		(MISC_BASE + 0x08C)
-#define ICM6_ARB_CFG		(MISC_BASE + 0x090)
-#define ICM7_ARB_CFG		(MISC_BASE + 0x094)
-#define ICM8_ARB_CFG		(MISC_BASE + 0x098)
-#define ICM9_ARB_CFG		(MISC_BASE + 0x09C)
 #define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
-#define USB2_PHY_CFG		(MISC_BASE + 0x0A4)
-#define GMAC_CFG_CTR		(MISC_BASE + 0x0A8)
-#define EXPI_CFG_CTR		(MISC_BASE + 0x0AC)
-#define PRC1_LOCK_CTR		(MISC_BASE + 0x0C0)
-#define PRC2_LOCK_CTR		(MISC_BASE + 0x0C4)
-#define PRC3_LOCK_CTR		(MISC_BASE + 0x0C8)
-#define PRC4_LOCK_CTR		(MISC_BASE + 0x0CC)
-#define PRC1_IRQ_CTR		(MISC_BASE + 0x0D0)
-#define PRC2_IRQ_CTR		(MISC_BASE + 0x0D4)
-#define PRC3_IRQ_CTR		(MISC_BASE + 0x0D8)
-#define PRC4_IRQ_CTR		(MISC_BASE + 0x0DC)
-#define PWRDOWN_CFG_CTR		(MISC_BASE + 0x0E0)
-#define COMPSSTL_1V8_CFG	(MISC_BASE + 0x0E4)
-#define COMPSSTL_2V5_CFG	(MISC_BASE + 0x0E8)
-#define COMPCOR_3V3_CFG		(MISC_BASE + 0x0EC)
-#define SSTLPAD_CFG_CTR		(MISC_BASE + 0x0F0)
-#define BIST1_CFG_CTR		(MISC_BASE + 0x0F4)
-#define BIST2_CFG_CTR		(MISC_BASE + 0x0F8)
-#define BIST3_CFG_CTR		(MISC_BASE + 0x0FC)
-#define BIST4_CFG_CTR		(MISC_BASE + 0x100)
-#define BIST5_CFG_CTR		(MISC_BASE + 0x104)
-#define BIST1_STS_RES		(MISC_BASE + 0x108)
-#define BIST2_STS_RES		(MISC_BASE + 0x10C)
-#define BIST3_STS_RES		(MISC_BASE + 0x110)
-#define BIST4_STS_RES		(MISC_BASE + 0x114)
-#define BIST5_STS_RES		(MISC_BASE + 0x118)
-#define SYSERR_CFG_CTR		(MISC_BASE + 0x11C)
 
 #endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear.h b/arch/arm/mach-spear3xx/include/mach/spear.h
index 8e3900a..6d4dadc 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear.h
@@ -15,61 +15,27 @@
 #define __MACH_SPEAR3XX_H
 
 #include <asm/memory.h>
-#include <mach/spear300.h>
-#include <mach/spear310.h>
-#include <mach/spear320.h>
-
-#define SPEAR3XX_ML_SDRAM_BASE		UL(0x00000000)
-
-#define SPEAR3XX_ICM9_BASE		UL(0xC0000000)
 
 /* ICM1 - Low speed connection */
 #define SPEAR3XX_ICM1_2_BASE		UL(0xD0000000)
 #define VA_SPEAR3XX_ICM1_2_BASE		UL(0xFD000000)
 #define SPEAR3XX_ICM1_UART_BASE		UL(0xD0000000)
 #define VA_SPEAR3XX_ICM1_UART_BASE	(VA_SPEAR3XX_ICM1_2_BASE | SPEAR3XX_ICM1_UART_BASE)
-#define SPEAR3XX_ICM1_ADC_BASE		UL(0xD0080000)
 #define SPEAR3XX_ICM1_SSP_BASE		UL(0xD0100000)
-#define SPEAR3XX_ICM1_I2C_BASE		UL(0xD0180000)
-#define SPEAR3XX_ICM1_JPEG_BASE		UL(0xD0800000)
-#define SPEAR3XX_ICM1_IRDA_BASE		UL(0xD1000000)
-#define SPEAR3XX_ICM1_SRAM_BASE		UL(0xD2800000)
-
-/* ICM2 - Application Subsystem */
-#define SPEAR3XX_ICM2_HWACCEL0_BASE	UL(0xD8800000)
-#define SPEAR3XX_ICM2_HWACCEL1_BASE	UL(0xD9000000)
-
-/* ICM4 - High Speed Connection */
-#define SPEAR3XX_ICM4_BASE		UL(0xE0000000)
-#define SPEAR3XX_ICM4_MII_BASE		UL(0xE0800000)
-#define SPEAR3XX_ICM4_USBD_FIFO_BASE	UL(0xE1000000)
-#define SPEAR3XX_ICM4_USBD_CSR_BASE	UL(0xE1100000)
-#define SPEAR3XX_ICM4_USBD_PLDT_BASE	UL(0xE1200000)
-#define SPEAR3XX_ICM4_USB_EHCI0_1_BASE	UL(0xE1800000)
-#define SPEAR3XX_ICM4_USB_OHCI0_BASE	UL(0xE1900000)
-#define SPEAR3XX_ICM4_USB_OHCI1_BASE	UL(0xE2100000)
-#define SPEAR3XX_ICM4_USB_ARB_BASE	UL(0xE2800000)
 
 /* ML1 - Multi Layer CPU Subsystem */
 #define SPEAR3XX_ICM3_ML1_2_BASE	UL(0xF0000000)
-#define SPEAR3XX_ML1_TMR_BASE		UL(0xF0000000)
-#define SPEAR3XX_ML1_VIC_BASE		UL(0xF1100000)
+#define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
+#define SPEAR3XX_CPU_TMR_BASE		UL(0xF0000000)
 
 /* ICM3 - Basic Subsystem */
-#define SPEAR3XX_ICM3_SMEM_BASE		UL(0xF8000000)
 #define SPEAR3XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
 #define VA_SPEAR3XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
 #define SPEAR3XX_ICM3_DMA_BASE		UL(0xFC400000)
-#define SPEAR3XX_ICM3_SDRAM_CTRL_BASE	UL(0xFC600000)
-#define SPEAR3XX_ICM3_TMR0_BASE		UL(0xFC800000)
-#define SPEAR3XX_ICM3_WDT_BASE		UL(0xFC880000)
-#define SPEAR3XX_ICM3_RTC_BASE		UL(0xFC900000)
-#define SPEAR3XX_ICM3_GPIO_BASE		UL(0xFC980000)
 #define SPEAR3XX_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
 #define VA_SPEAR3XX_ICM3_SYS_CTRL_BASE	(VA_SPEAR3XX_ICM3_SMI_CTRL_BASE | SPEAR3XX_ICM3_SYS_CTRL_BASE)
 #define SPEAR3XX_ICM3_MISC_REG_BASE	UL(0xFCA80000)
 #define VA_SPEAR3XX_ICM3_MISC_REG_BASE	(VA_SPEAR3XX_ICM3_SMI_CTRL_BASE | SPEAR3XX_ICM3_MISC_REG_BASE)
-#define SPEAR3XX_ICM3_TMR1_BASE		UL(0xFCB00000)
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
 #define SPEAR_DBG_UART_BASE		SPEAR3XX_ICM1_UART_BASE
diff --git a/arch/arm/mach-spear3xx/include/mach/spear300.h b/arch/arm/mach-spear3xx/include/mach/spear300.h
deleted file mode 100644
index 3b6ea07..0000000
--- a/arch/arm/mach-spear3xx/include/mach/spear300.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/spear300.h
- *
- * SPEAr300 Machine specific definition
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifdef	CONFIG_MACH_SPEAR300
-
-#ifndef __MACH_SPEAR300_H
-#define __MACH_SPEAR300_H
-
-/* Base address of various IPs */
-#define SPEAR300_TELECOM_BASE		UL(0x50000000)
-
-/* Interrupt registers offsets and masks */
-#define SPEAR300_INT_ENB_MASK_REG	0x54
-#define SPEAR300_INT_STS_MASK_REG	0x58
-#define SPEAR300_IT_PERS_S_IRQ_MASK	(1 << 0)
-#define SPEAR300_IT_CHANGE_S_IRQ_MASK	(1 << 1)
-#define SPEAR300_I2S_IRQ_MASK		(1 << 2)
-#define SPEAR300_TDM_IRQ_MASK		(1 << 3)
-#define SPEAR300_CAMERA_L_IRQ_MASK	(1 << 4)
-#define SPEAR300_CAMERA_F_IRQ_MASK	(1 << 5)
-#define SPEAR300_CAMERA_V_IRQ_MASK	(1 << 6)
-#define SPEAR300_KEYBOARD_IRQ_MASK	(1 << 7)
-#define SPEAR300_GPIO1_IRQ_MASK		(1 << 8)
-
-#define SPEAR300_SHIRQ_RAS1_MASK	0x1FF
-
-#define SPEAR300_CLCD_BASE		UL(0x60000000)
-#define SPEAR300_SDHCI_BASE		UL(0x70000000)
-#define SPEAR300_NAND_0_BASE		UL(0x80000000)
-#define SPEAR300_NAND_1_BASE		UL(0x84000000)
-#define SPEAR300_NAND_2_BASE		UL(0x88000000)
-#define SPEAR300_NAND_3_BASE		UL(0x8c000000)
-#define SPEAR300_NOR_0_BASE		UL(0x90000000)
-#define SPEAR300_NOR_1_BASE		UL(0x91000000)
-#define SPEAR300_NOR_2_BASE		UL(0x92000000)
-#define SPEAR300_NOR_3_BASE		UL(0x93000000)
-#define SPEAR300_FSMC_BASE		UL(0x94000000)
-#define SPEAR300_SOC_CONFIG_BASE	UL(0x99000000)
-#define SPEAR300_KEYBOARD_BASE		UL(0xA0000000)
-#define SPEAR300_GPIO_BASE		UL(0xA9000000)
-
-#endif /* __MACH_SPEAR300_H */
-
-#endif /* CONFIG_MACH_SPEAR300 */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear310.h b/arch/arm/mach-spear3xx/include/mach/spear310.h
deleted file mode 100644
index 1567d0da..0000000
--- a/arch/arm/mach-spear3xx/include/mach/spear310.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/spear310.h
- *
- * SPEAr310 Machine specific definition
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifdef	CONFIG_MACH_SPEAR310
-
-#ifndef __MACH_SPEAR310_H
-#define __MACH_SPEAR310_H
-
-#define SPEAR310_NAND_BASE		UL(0x40000000)
-#define SPEAR310_FSMC_BASE		UL(0x44000000)
-#define SPEAR310_UART1_BASE		UL(0xB2000000)
-#define SPEAR310_UART2_BASE		UL(0xB2080000)
-#define SPEAR310_UART3_BASE		UL(0xB2100000)
-#define SPEAR310_UART4_BASE		UL(0xB2180000)
-#define SPEAR310_UART5_BASE		UL(0xB2200000)
-#define SPEAR310_HDLC_BASE		UL(0xB2800000)
-#define SPEAR310_RS485_0_BASE		UL(0xB3000000)
-#define SPEAR310_RS485_1_BASE		UL(0xB3800000)
-#define SPEAR310_SOC_CONFIG_BASE	UL(0xB4000000)
-
-/* Interrupt registers offsets and masks */
-#define SPEAR310_INT_STS_MASK_REG	0x04
-#define SPEAR310_SMII0_IRQ_MASK		(1 << 0)
-#define SPEAR310_SMII1_IRQ_MASK		(1 << 1)
-#define SPEAR310_SMII2_IRQ_MASK		(1 << 2)
-#define SPEAR310_SMII3_IRQ_MASK		(1 << 3)
-#define SPEAR310_WAKEUP_SMII0_IRQ_MASK	(1 << 4)
-#define SPEAR310_WAKEUP_SMII1_IRQ_MASK	(1 << 5)
-#define SPEAR310_WAKEUP_SMII2_IRQ_MASK	(1 << 6)
-#define SPEAR310_WAKEUP_SMII3_IRQ_MASK	(1 << 7)
-#define SPEAR310_UART1_IRQ_MASK		(1 << 8)
-#define SPEAR310_UART2_IRQ_MASK		(1 << 9)
-#define SPEAR310_UART3_IRQ_MASK		(1 << 10)
-#define SPEAR310_UART4_IRQ_MASK		(1 << 11)
-#define SPEAR310_UART5_IRQ_MASK		(1 << 12)
-#define SPEAR310_EMI_IRQ_MASK		(1 << 13)
-#define SPEAR310_TDM_HDLC_IRQ_MASK	(1 << 14)
-#define SPEAR310_RS485_0_IRQ_MASK	(1 << 15)
-#define SPEAR310_RS485_1_IRQ_MASK	(1 << 16)
-
-#define SPEAR310_SHIRQ_RAS1_MASK	0x000FF
-#define SPEAR310_SHIRQ_RAS2_MASK	0x01F00
-#define SPEAR310_SHIRQ_RAS3_MASK	0x02000
-#define SPEAR310_SHIRQ_INTRCOMM_RAS_MASK	0x1C000
-
-#endif /* __MACH_SPEAR310_H */
-
-#endif /* CONFIG_MACH_SPEAR310 */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
deleted file mode 100644
index 8cfa83f..0000000
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/spear320.h
- *
- * SPEAr320 Machine specific definition
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifdef	CONFIG_MACH_SPEAR320
-
-#ifndef __MACH_SPEAR320_H
-#define __MACH_SPEAR320_H
-
-#define SPEAR320_EMI_CTRL_BASE		UL(0x40000000)
-#define SPEAR320_FSMC_BASE		UL(0x4C000000)
-#define SPEAR320_NAND_BASE		UL(0x50000000)
-#define SPEAR320_I2S_BASE		UL(0x60000000)
-#define SPEAR320_SDHCI_BASE		UL(0x70000000)
-#define SPEAR320_CLCD_BASE		UL(0x90000000)
-#define SPEAR320_PAR_PORT_BASE		UL(0xA0000000)
-#define SPEAR320_CAN0_BASE		UL(0xA1000000)
-#define SPEAR320_CAN1_BASE		UL(0xA2000000)
-#define SPEAR320_UART1_BASE		UL(0xA3000000)
-#define SPEAR320_UART2_BASE		UL(0xA4000000)
-#define SPEAR320_SSP0_BASE		UL(0xA5000000)
-#define SPEAR320_SSP1_BASE		UL(0xA6000000)
-#define SPEAR320_I2C_BASE		UL(0xA7000000)
-#define SPEAR320_PWM_BASE		UL(0xA8000000)
-#define SPEAR320_SMII0_BASE		UL(0xAA000000)
-#define SPEAR320_SMII1_BASE		UL(0xAB000000)
-#define SPEAR320_SOC_CONFIG_BASE	UL(0xB3000000)
-
-/* Interrupt registers offsets and masks */
-#define SPEAR320_INT_STS_MASK_REG		0x04
-#define SPEAR320_INT_CLR_MASK_REG		0x04
-#define SPEAR320_INT_ENB_MASK_REG		0x08
-#define SPEAR320_GPIO_IRQ_MASK			(1 << 0)
-#define SPEAR320_I2S_PLAY_IRQ_MASK		(1 << 1)
-#define SPEAR320_I2S_REC_IRQ_MASK		(1 << 2)
-#define SPEAR320_EMI_IRQ_MASK			(1 << 7)
-#define SPEAR320_CLCD_IRQ_MASK			(1 << 8)
-#define SPEAR320_SPP_IRQ_MASK			(1 << 9)
-#define SPEAR320_SDHCI_IRQ_MASK			(1 << 10)
-#define SPEAR320_CAN_U_IRQ_MASK			(1 << 11)
-#define SPEAR320_CAN_L_IRQ_MASK			(1 << 12)
-#define SPEAR320_UART1_IRQ_MASK			(1 << 13)
-#define SPEAR320_UART2_IRQ_MASK			(1 << 14)
-#define SPEAR320_SSP1_IRQ_MASK			(1 << 15)
-#define SPEAR320_SSP2_IRQ_MASK			(1 << 16)
-#define SPEAR320_SMII0_IRQ_MASK			(1 << 17)
-#define SPEAR320_MII1_SMII1_IRQ_MASK		(1 << 18)
-#define SPEAR320_WAKEUP_SMII0_IRQ_MASK		(1 << 19)
-#define SPEAR320_WAKEUP_MII1_SMII1_IRQ_MASK	(1 << 20)
-#define SPEAR320_I2C1_IRQ_MASK			(1 << 21)
-
-#define SPEAR320_SHIRQ_RAS1_MASK		0x000380
-#define SPEAR320_SHIRQ_RAS3_MASK		0x000007
-#define SPEAR320_SHIRQ_INTRCOMM_RAS_MASK	0x3FF800
-
-#endif /* __MACH_SPEAR320_H */
-
-#endif /* CONFIG_MACH_SPEAR320 */
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index f46fc26..4d75f8f 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -19,7 +19,28 @@
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
-#include <mach/hardware.h>
+#include <mach/spear.h>
+
+/* Base address of various IPs */
+#define SPEAR300_TELECOM_BASE		UL(0x50000000)
+
+/* Interrupt registers offsets and masks */
+#define SPEAR300_INT_ENB_MASK_REG	0x54
+#define SPEAR300_INT_STS_MASK_REG	0x58
+#define SPEAR300_IT_PERS_S_IRQ_MASK	(1 << 0)
+#define SPEAR300_IT_CHANGE_S_IRQ_MASK	(1 << 1)
+#define SPEAR300_I2S_IRQ_MASK		(1 << 2)
+#define SPEAR300_TDM_IRQ_MASK		(1 << 3)
+#define SPEAR300_CAMERA_L_IRQ_MASK	(1 << 4)
+#define SPEAR300_CAMERA_F_IRQ_MASK	(1 << 5)
+#define SPEAR300_CAMERA_V_IRQ_MASK	(1 << 6)
+#define SPEAR300_KEYBOARD_IRQ_MASK	(1 << 7)
+#define SPEAR300_GPIO1_IRQ_MASK		(1 << 8)
+
+#define SPEAR300_SHIRQ_RAS1_MASK	0x1FF
+
+#define SPEAR300_SOC_CONFIG_BASE	UL(0x99000000)
+
 
 /* pad multiplexing support */
 /* muxing registers */
@@ -42,6 +63,24 @@
 #define CAML_LCD_MODE			(1 << 12)
 #define ALL_MODES			0x1FFF
 
+/* SPEAr300 Virtual irq definitions */
+/* IRQs sharing IRQ_GEN_RAS_1 */
+#define SPEAR300_VIRQ_IT_PERS_S			(SPEAR3XX_VIRQ_START + 0)
+#define SPEAR300_VIRQ_IT_CHANGE_S		(SPEAR3XX_VIRQ_START + 1)
+#define SPEAR300_VIRQ_I2S			(SPEAR3XX_VIRQ_START + 2)
+#define SPEAR300_VIRQ_TDM			(SPEAR3XX_VIRQ_START + 3)
+#define SPEAR300_VIRQ_CAMERA_L			(SPEAR3XX_VIRQ_START + 4)
+#define SPEAR300_VIRQ_CAMERA_F			(SPEAR3XX_VIRQ_START + 5)
+#define SPEAR300_VIRQ_CAMERA_V			(SPEAR3XX_VIRQ_START + 6)
+#define SPEAR300_VIRQ_KEYBOARD			(SPEAR3XX_VIRQ_START + 7)
+#define SPEAR300_VIRQ_GPIO1			(SPEAR3XX_VIRQ_START + 8)
+
+/* IRQs sharing IRQ_GEN_RAS_3 */
+#define SPEAR300_IRQ_CLCD			SPEAR3XX_IRQ_GEN_RAS_3
+
+/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
+#define SPEAR300_IRQ_SDHCI			SPEAR3XX_IRQ_INTRCOMM_RAS_ARM
+
 struct pmx_mode spear300_nand_mode = {
 	.id = NAND_MODE,
 	.name = "nand mode",
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 063e7da..b26e415 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -20,7 +20,67 @@
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
-#include <mach/hardware.h>
+#include <mach/spear.h>
+
+#define SPEAR310_UART1_BASE		UL(0xB2000000)
+#define SPEAR310_UART2_BASE		UL(0xB2080000)
+#define SPEAR310_UART3_BASE		UL(0xB2100000)
+#define SPEAR310_UART4_BASE		UL(0xB2180000)
+#define SPEAR310_UART5_BASE		UL(0xB2200000)
+#define SPEAR310_SOC_CONFIG_BASE	UL(0xB4000000)
+
+/* Interrupt registers offsets and masks */
+#define SPEAR310_INT_STS_MASK_REG	0x04
+#define SPEAR310_SMII0_IRQ_MASK		(1 << 0)
+#define SPEAR310_SMII1_IRQ_MASK		(1 << 1)
+#define SPEAR310_SMII2_IRQ_MASK		(1 << 2)
+#define SPEAR310_SMII3_IRQ_MASK		(1 << 3)
+#define SPEAR310_WAKEUP_SMII0_IRQ_MASK	(1 << 4)
+#define SPEAR310_WAKEUP_SMII1_IRQ_MASK	(1 << 5)
+#define SPEAR310_WAKEUP_SMII2_IRQ_MASK	(1 << 6)
+#define SPEAR310_WAKEUP_SMII3_IRQ_MASK	(1 << 7)
+#define SPEAR310_UART1_IRQ_MASK		(1 << 8)
+#define SPEAR310_UART2_IRQ_MASK		(1 << 9)
+#define SPEAR310_UART3_IRQ_MASK		(1 << 10)
+#define SPEAR310_UART4_IRQ_MASK		(1 << 11)
+#define SPEAR310_UART5_IRQ_MASK		(1 << 12)
+#define SPEAR310_EMI_IRQ_MASK		(1 << 13)
+#define SPEAR310_TDM_HDLC_IRQ_MASK	(1 << 14)
+#define SPEAR310_RS485_0_IRQ_MASK	(1 << 15)
+#define SPEAR310_RS485_1_IRQ_MASK	(1 << 16)
+
+#define SPEAR310_SHIRQ_RAS1_MASK	0x000FF
+#define SPEAR310_SHIRQ_RAS2_MASK	0x01F00
+#define SPEAR310_SHIRQ_RAS3_MASK	0x02000
+#define SPEAR310_SHIRQ_INTRCOMM_RAS_MASK	0x1C000
+
+/* SPEAr310 Virtual irq definitions */
+/* IRQs sharing IRQ_GEN_RAS_1 */
+#define SPEAR310_VIRQ_SMII0			(SPEAR3XX_VIRQ_START + 0)
+#define SPEAR310_VIRQ_SMII1			(SPEAR3XX_VIRQ_START + 1)
+#define SPEAR310_VIRQ_SMII2			(SPEAR3XX_VIRQ_START + 2)
+#define SPEAR310_VIRQ_SMII3			(SPEAR3XX_VIRQ_START + 3)
+#define SPEAR310_VIRQ_WAKEUP_SMII0		(SPEAR3XX_VIRQ_START + 4)
+#define SPEAR310_VIRQ_WAKEUP_SMII1		(SPEAR3XX_VIRQ_START + 5)
+#define SPEAR310_VIRQ_WAKEUP_SMII2		(SPEAR3XX_VIRQ_START + 6)
+#define SPEAR310_VIRQ_WAKEUP_SMII3		(SPEAR3XX_VIRQ_START + 7)
+
+/* IRQs sharing IRQ_GEN_RAS_2 */
+#define SPEAR310_VIRQ_UART1			(SPEAR3XX_VIRQ_START + 8)
+#define SPEAR310_VIRQ_UART2			(SPEAR3XX_VIRQ_START + 9)
+#define SPEAR310_VIRQ_UART3			(SPEAR3XX_VIRQ_START + 10)
+#define SPEAR310_VIRQ_UART4			(SPEAR3XX_VIRQ_START + 11)
+#define SPEAR310_VIRQ_UART5			(SPEAR3XX_VIRQ_START + 12)
+
+/* IRQs sharing IRQ_GEN_RAS_3 */
+#define SPEAR310_VIRQ_EMI			(SPEAR3XX_VIRQ_START + 13)
+#define SPEAR310_VIRQ_PLGPIO			(SPEAR3XX_VIRQ_START + 14)
+
+/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
+#define SPEAR310_VIRQ_TDM_HDLC			(SPEAR3XX_VIRQ_START + 15)
+#define SPEAR310_VIRQ_RS485_0			(SPEAR3XX_VIRQ_START + 16)
+#define SPEAR310_VIRQ_RS485_1			(SPEAR3XX_VIRQ_START + 17)
+
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 1e74031..2f5979b 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -21,7 +21,67 @@
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
-#include <mach/hardware.h>
+#include <mach/spear.h>
+
+#define SPEAR320_UART1_BASE		UL(0xA3000000)
+#define SPEAR320_UART2_BASE		UL(0xA4000000)
+#define SPEAR320_SSP0_BASE		UL(0xA5000000)
+#define SPEAR320_SSP1_BASE		UL(0xA6000000)
+#define SPEAR320_SOC_CONFIG_BASE	UL(0xB3000000)
+
+/* Interrupt registers offsets and masks */
+#define SPEAR320_INT_STS_MASK_REG		0x04
+#define SPEAR320_INT_CLR_MASK_REG		0x04
+#define SPEAR320_INT_ENB_MASK_REG		0x08
+#define SPEAR320_GPIO_IRQ_MASK			(1 << 0)
+#define SPEAR320_I2S_PLAY_IRQ_MASK		(1 << 1)
+#define SPEAR320_I2S_REC_IRQ_MASK		(1 << 2)
+#define SPEAR320_EMI_IRQ_MASK			(1 << 7)
+#define SPEAR320_CLCD_IRQ_MASK			(1 << 8)
+#define SPEAR320_SPP_IRQ_MASK			(1 << 9)
+#define SPEAR320_SDHCI_IRQ_MASK			(1 << 10)
+#define SPEAR320_CAN_U_IRQ_MASK			(1 << 11)
+#define SPEAR320_CAN_L_IRQ_MASK			(1 << 12)
+#define SPEAR320_UART1_IRQ_MASK			(1 << 13)
+#define SPEAR320_UART2_IRQ_MASK			(1 << 14)
+#define SPEAR320_SSP1_IRQ_MASK			(1 << 15)
+#define SPEAR320_SSP2_IRQ_MASK			(1 << 16)
+#define SPEAR320_SMII0_IRQ_MASK			(1 << 17)
+#define SPEAR320_MII1_SMII1_IRQ_MASK		(1 << 18)
+#define SPEAR320_WAKEUP_SMII0_IRQ_MASK		(1 << 19)
+#define SPEAR320_WAKEUP_MII1_SMII1_IRQ_MASK	(1 << 20)
+#define SPEAR320_I2C1_IRQ_MASK			(1 << 21)
+
+#define SPEAR320_SHIRQ_RAS1_MASK		0x000380
+#define SPEAR320_SHIRQ_RAS3_MASK		0x000007
+#define SPEAR320_SHIRQ_INTRCOMM_RAS_MASK	0x3FF800
+
+/* SPEAr320 Virtual irq definitions */
+/* IRQs sharing IRQ_GEN_RAS_1 */
+#define SPEAR320_VIRQ_EMI			(SPEAR3XX_VIRQ_START + 0)
+#define SPEAR320_VIRQ_CLCD			(SPEAR3XX_VIRQ_START + 1)
+#define SPEAR320_VIRQ_SPP			(SPEAR3XX_VIRQ_START + 2)
+
+/* IRQs sharing IRQ_GEN_RAS_2 */
+#define SPEAR320_IRQ_SDHCI			SPEAR3XX_IRQ_GEN_RAS_2
+
+/* IRQs sharing IRQ_GEN_RAS_3 */
+#define SPEAR320_VIRQ_PLGPIO			(SPEAR3XX_VIRQ_START + 3)
+#define SPEAR320_VIRQ_I2S_PLAY			(SPEAR3XX_VIRQ_START + 4)
+#define SPEAR320_VIRQ_I2S_REC			(SPEAR3XX_VIRQ_START + 5)
+
+/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
+#define SPEAR320_VIRQ_CANU			(SPEAR3XX_VIRQ_START + 6)
+#define SPEAR320_VIRQ_CANL			(SPEAR3XX_VIRQ_START + 7)
+#define SPEAR320_VIRQ_UART1			(SPEAR3XX_VIRQ_START + 8)
+#define SPEAR320_VIRQ_UART2			(SPEAR3XX_VIRQ_START + 9)
+#define SPEAR320_VIRQ_SSP1			(SPEAR3XX_VIRQ_START + 10)
+#define SPEAR320_VIRQ_SSP2			(SPEAR3XX_VIRQ_START + 11)
+#define SPEAR320_VIRQ_SMII0			(SPEAR3XX_VIRQ_START + 12)
+#define SPEAR320_VIRQ_MII1_SMII1		(SPEAR3XX_VIRQ_START + 13)
+#define SPEAR320_VIRQ_WAKEUP_SMII0		(SPEAR3XX_VIRQ_START + 14)
+#define SPEAR320_VIRQ_WAKEUP_MII1_SMII1		(SPEAR3XX_VIRQ_START + 15)
+#define SPEAR320_VIRQ_I2C1			(SPEAR3XX_VIRQ_START + 16)
 
 /* pad multiplexing support */
 /* muxing registers */
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 17d4ac9..434ae47 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -20,8 +20,8 @@
 #include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
 #include <plat/pl080.h>
+#include <mach/spear.h>
 #include <mach/generic.h>
-#include <mach/hardware.h>
 
 /* pad multiplexing support */
 /* devices */
@@ -534,7 +534,7 @@ static void __init spear3xx_timer_init(void)
 	clk_put(gpt_clk);
 	clk_put(pclk);
 
-	spear_setup_timer();
+	spear_setup_timer(SPEAR3XX_CPU_TMR_BASE, SPEAR3XX_IRQ_CPU_GPT1_1);
 }
 
 struct sys_timer spear3xx_timer = {
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index adadef2..68fe11d 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -16,6 +16,160 @@
 #include <linux/kernel.h>
 #include <plat/clock.h>
 #include <mach/misc_regs.h>
+#include <mach/spear.h>
+
+#define SOC_CFG_CTR		(MISC_BASE + 0x000)
+#define DIAG_CFG_CTR		(MISC_BASE + 0x004)
+#define PLL1_CTR		(MISC_BASE + 0x008)
+#define PLL1_FRQ		(MISC_BASE + 0x00C)
+#define PLL1_MOD		(MISC_BASE + 0x010)
+#define PLL2_CTR		(MISC_BASE + 0x014)
+/* PLL_CTR register masks */
+#define PLL_ENABLE		2
+#define PLL_MODE_SHIFT		4
+#define PLL_MODE_MASK		0x3
+#define PLL_MODE_NORMAL		0
+#define PLL_MODE_FRACTION	1
+#define PLL_MODE_DITH_DSB	2
+#define PLL_MODE_DITH_SSB	3
+
+#define PLL2_FRQ		(MISC_BASE + 0x018)
+/* PLL FRQ register masks */
+#define PLL_DIV_N_SHIFT		0
+#define PLL_DIV_N_MASK		0xFF
+#define PLL_DIV_P_SHIFT		8
+#define PLL_DIV_P_MASK		0x7
+#define PLL_NORM_FDBK_M_SHIFT	24
+#define PLL_NORM_FDBK_M_MASK	0xFF
+#define PLL_DITH_FDBK_M_SHIFT	16
+#define PLL_DITH_FDBK_M_MASK	0xFFFF
+
+#define PLL2_MOD		(MISC_BASE + 0x01C)
+#define PLL_CLK_CFG		(MISC_BASE + 0x020)
+#define CORE_CLK_CFG		(MISC_BASE + 0x024)
+/* CORE CLK CFG register masks */
+#define PLL_HCLK_RATIO_SHIFT	10
+#define PLL_HCLK_RATIO_MASK	0x3
+#define HCLK_PCLK_RATIO_SHIFT	8
+#define HCLK_PCLK_RATIO_MASK	0x3
+
+#define PERIP_CLK_CFG		(MISC_BASE + 0x028)
+/* PERIP_CLK_CFG register masks */
+#define CLCD_CLK_SHIFT		2
+#define CLCD_CLK_MASK		0x3
+#define UART_CLK_SHIFT		4
+#define UART_CLK_MASK		0x1
+#define FIRDA_CLK_SHIFT		5
+#define FIRDA_CLK_MASK		0x3
+#define GPT0_CLK_SHIFT		8
+#define GPT1_CLK_SHIFT		10
+#define GPT2_CLK_SHIFT		11
+#define GPT3_CLK_SHIFT		12
+#define GPT_CLK_MASK		0x1
+#define AUX_CLK_PLL3_VAL	0
+#define AUX_CLK_PLL1_VAL	1
+
+#define PERIP1_CLK_ENB		(MISC_BASE + 0x02C)
+/* PERIP1_CLK_ENB register masks */
+#define UART0_CLK_ENB		3
+#define UART1_CLK_ENB		4
+#define SSP0_CLK_ENB		5
+#define SSP1_CLK_ENB		6
+#define I2C_CLK_ENB		7
+#define JPEG_CLK_ENB		8
+#define FSMC_CLK_ENB		9
+#define FIRDA_CLK_ENB		10
+#define GPT2_CLK_ENB		11
+#define GPT3_CLK_ENB		12
+#define GPIO2_CLK_ENB		13
+#define SSP2_CLK_ENB		14
+#define ADC_CLK_ENB		15
+#define GPT1_CLK_ENB		11
+#define RTC_CLK_ENB		17
+#define GPIO1_CLK_ENB		18
+#define DMA_CLK_ENB		19
+#define SMI_CLK_ENB		21
+#define CLCD_CLK_ENB		22
+#define GMAC_CLK_ENB		23
+#define USBD_CLK_ENB		24
+#define USBH0_CLK_ENB		25
+#define USBH1_CLK_ENB		26
+
+#define SOC_CORE_ID		(MISC_BASE + 0x030)
+#define RAS_CLK_ENB		(MISC_BASE + 0x034)
+#define PERIP1_SOF_RST		(MISC_BASE + 0x038)
+/* PERIP1_SOF_RST register masks */
+#define JPEG_SOF_RST		8
+
+#define SOC_USER_ID		(MISC_BASE + 0x03C)
+#define RAS_SOF_RST		(MISC_BASE + 0x040)
+#define PRSC1_CLK_CFG		(MISC_BASE + 0x044)
+#define PRSC2_CLK_CFG		(MISC_BASE + 0x048)
+#define PRSC3_CLK_CFG		(MISC_BASE + 0x04C)
+/* gpt synthesizer register masks */
+#define GPT_MSCALE_SHIFT	0
+#define GPT_MSCALE_MASK		0xFFF
+#define GPT_NSCALE_SHIFT	12
+#define GPT_NSCALE_MASK		0xF
+
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
+/* aux clk synthesiser register masks for irda to ras4 */
+#define AUX_SYNT_ENB		31
+#define AUX_EQ_SEL_SHIFT	30
+#define AUX_EQ_SEL_MASK		1
+#define AUX_EQ1_SEL		0
+#define AUX_EQ2_SEL		1
+#define AUX_XSCALE_SHIFT	16
+#define AUX_XSCALE_MASK		0xFFF
+#define AUX_YSCALE_SHIFT	0
+#define AUX_YSCALE_MASK		0xFFF
+
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
 
 /* root clks */
 /* 32 KHz oscillator clock */
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 116b993..7167fd3 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -15,34 +15,9 @@
 #define __MACH_GENERIC_H
 
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/amba/bus.h>
-#include <asm/mach/time.h>
-#include <asm/mach/map.h>
-
-/*
- * Each GPT has 2 timer channels
- * Following GPT channels will be used as clock source and clockevent
- */
-#define SPEAR_GPT0_BASE		SPEAR6XX_CPU_TMR_BASE
-#define SPEAR_GPT0_CHAN0_IRQ	IRQ_CPU_GPT1_1
-#define SPEAR_GPT0_CHAN1_IRQ	IRQ_CPU_GPT1_2
-
-/* Add spear6xx family device structure declarations here */
-extern struct amba_device gpio_device[];
-extern struct amba_device uart_device[];
-extern struct sys_timer spear6xx_timer;
-
-/* Add spear6xx family function declarations here */
-void __init spear_setup_timer(void);
-void __init spear6xx_map_io(void);
-void __init spear6xx_init_irq(void);
-void __init spear6xx_init(void);
-void __init spear600_init(void);
-void __init spear6xx_clk_init(void);
 
+void __init spear_setup_timer(resource_size_t base, int irq);
 void spear_restart(char, const char *);
-
-/* Add spear600 machine device structure declarations here */
+void __init spear6xx_clk_init(void);
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/hardware.h b/arch/arm/mach-spear6xx/include/mach/hardware.h
index 0b3f96a..40a8c17 100644
--- a/arch/arm/mach-spear6xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear6xx/include/mach/hardware.h
@@ -1,23 +1 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/hardware.h
- *
- * Hardware definitions for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_HARDWARE_H
-#define __MACH_HARDWARE_H
-
-#include <plat/hardware.h>
-#include <mach/spear.h>
-
-/* Vitual to physical translation of statically mapped space */
-#define IO_ADDRESS(x)		(x | 0xF0000000)
-
-#endif /* __MACH_HARDWARE_H */
+/* empty */
diff --git a/arch/arm/mach-spear6xx/include/mach/irqs.h b/arch/arm/mach-spear6xx/include/mach/irqs.h
index 8f214b0..2b73538 100644
--- a/arch/arm/mach-spear6xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear6xx/include/mach/irqs.h
@@ -16,82 +16,13 @@
 
 /* IRQ definitions */
 /* VIC 1 */
-#define IRQ_INTRCOMM_SW_IRQ			0
-#define IRQ_INTRCOMM_CPU_1			1
-#define IRQ_INTRCOMM_CPU_2			2
-#define IRQ_INTRCOMM_RAS2A11_1			3
-#define IRQ_INTRCOMM_RAS2A11_2			4
-#define IRQ_INTRCOMM_RAS2A12_1			5
-#define IRQ_INTRCOMM_RAS2A12_2			6
-#define IRQ_GEN_RAS_0				7
-#define IRQ_GEN_RAS_1				8
-#define IRQ_GEN_RAS_2				9
-#define IRQ_GEN_RAS_3				10
-#define IRQ_GEN_RAS_4				11
-#define IRQ_GEN_RAS_5				12
-#define IRQ_GEN_RAS_6				13
-#define IRQ_GEN_RAS_7				14
-#define IRQ_GEN_RAS_8				15
+/* FIXME: probe this from DT */
 #define IRQ_CPU_GPT1_1				16
-#define IRQ_CPU_GPT1_2				17
-#define IRQ_LOCAL_GPIO				18
-#define IRQ_PLL_UNLOCK				19
-#define IRQ_JPEG				20
-#define IRQ_FSMC				21
-#define IRQ_IRDA				22
-#define IRQ_RESERVED				23
-#define IRQ_UART_0				24
-#define IRQ_UART_1				25
-#define IRQ_SSP_1				26
-#define IRQ_SSP_2				27
-#define IRQ_I2C					28
-#define IRQ_GEN_RAS_9				29
-#define IRQ_GEN_RAS_10				30
-#define IRQ_GEN_RAS_11				31
-
-/* VIC 2 */
-#define IRQ_APPL_GPT1_1				32
-#define IRQ_APPL_GPT1_2				33
-#define IRQ_APPL_GPT2_1				34
-#define IRQ_APPL_GPT2_2				35
-#define IRQ_APPL_GPIO				36
-#define IRQ_APPL_SSP				37
-#define IRQ_APPL_ADC				38
-#define IRQ_APPL_RESERVED			39
-#define IRQ_AHB_EXP_MASTER			40
-#define IRQ_DDR_CONTROLLER			41
-#define IRQ_BASIC_DMA				42
-#define IRQ_BASIC_RESERVED1			43
-#define IRQ_BASIC_SMI				44
-#define IRQ_BASIC_CLCD				45
-#define IRQ_EXP_AHB_1				46
-#define IRQ_EXP_AHB_2				47
-#define IRQ_BASIC_GPT1_1			48
-#define IRQ_BASIC_GPT1_2			49
-#define IRQ_BASIC_RTC				50
-#define IRQ_BASIC_GPIO				51
-#define IRQ_BASIC_WDT				52
-#define IRQ_BASIC_RESERVED			53
-#define IRQ_AHB_EXP_SLAVE			54
-#define IRQ_GMAC_1				55
-#define IRQ_GMAC_2				56
-#define IRQ_USB_DEV				57
-#define IRQ_USB_H_OHCI_0			58
-#define IRQ_USB_H_EHCI_0			59
-#define IRQ_USB_H_OHCI_1			60
-#define IRQ_USB_H_EHCI_1			61
-#define IRQ_EXP_AHB_3				62
-#define IRQ_EXP_AHB_4				63
 
 #define IRQ_VIC_END				64
 
 /* GPIO pins virtual irqs */
-#define SPEAR_GPIO_INT_BASE	IRQ_VIC_END
-#define SPEAR_GPIO0_INT_BASE	SPEAR_GPIO_INT_BASE
-#define SPEAR_GPIO1_INT_BASE	(SPEAR_GPIO0_INT_BASE + 8)
-#define SPEAR_GPIO2_INT_BASE	(SPEAR_GPIO1_INT_BASE + 8)
-#define SPEAR_GPIO_INT_END	(SPEAR_GPIO2_INT_BASE + 8)
-#define VIRTUAL_IRQS		(SPEAR_GPIO_INT_END - IRQ_VIC_END)
-#define NR_IRQS			(IRQ_VIC_END + VIRTUAL_IRQS)
+#define VIRTUAL_IRQS				24
+#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
 
 #endif	/* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/misc_regs.h b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
index 68c20a0..2b9aaa6 100644
--- a/arch/arm/mach-spear6xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
@@ -14,161 +14,7 @@
 #ifndef __MACH_MISC_REGS_H
 #define __MACH_MISC_REGS_H
 
-#include <mach/hardware.h>
-
 #define MISC_BASE		IOMEM(VA_SPEAR6XX_ICM3_MISC_REG_BASE)
-
-#define SOC_CFG_CTR		(MISC_BASE + 0x000)
-#define DIAG_CFG_CTR		(MISC_BASE + 0x004)
-#define PLL1_CTR		(MISC_BASE + 0x008)
-#define PLL1_FRQ		(MISC_BASE + 0x00C)
-#define PLL1_MOD		(MISC_BASE + 0x010)
-#define PLL2_CTR		(MISC_BASE + 0x014)
-/* PLL_CTR register masks */
-#define PLL_ENABLE		2
-#define PLL_MODE_SHIFT		4
-#define PLL_MODE_MASK		0x3
-#define PLL_MODE_NORMAL		0
-#define PLL_MODE_FRACTION	1
-#define PLL_MODE_DITH_DSB	2
-#define PLL_MODE_DITH_SSB	3
-
-#define PLL2_FRQ		(MISC_BASE + 0x018)
-/* PLL FRQ register masks */
-#define PLL_DIV_N_SHIFT		0
-#define PLL_DIV_N_MASK		0xFF
-#define PLL_DIV_P_SHIFT		8
-#define PLL_DIV_P_MASK		0x7
-#define PLL_NORM_FDBK_M_SHIFT	24
-#define PLL_NORM_FDBK_M_MASK	0xFF
-#define PLL_DITH_FDBK_M_SHIFT	16
-#define PLL_DITH_FDBK_M_MASK	0xFFFF
-
-#define PLL2_MOD		(MISC_BASE + 0x01C)
-#define PLL_CLK_CFG		(MISC_BASE + 0x020)
-#define CORE_CLK_CFG		(MISC_BASE + 0x024)
-/* CORE CLK CFG register masks */
-#define PLL_HCLK_RATIO_SHIFT	10
-#define PLL_HCLK_RATIO_MASK	0x3
-#define HCLK_PCLK_RATIO_SHIFT	8
-#define HCLK_PCLK_RATIO_MASK	0x3
-
-#define PERIP_CLK_CFG		(MISC_BASE + 0x028)
-/* PERIP_CLK_CFG register masks */
-#define CLCD_CLK_SHIFT		2
-#define CLCD_CLK_MASK		0x3
-#define UART_CLK_SHIFT		4
-#define UART_CLK_MASK		0x1
-#define FIRDA_CLK_SHIFT		5
-#define FIRDA_CLK_MASK		0x3
-#define GPT0_CLK_SHIFT		8
-#define GPT1_CLK_SHIFT		10
-#define GPT2_CLK_SHIFT		11
-#define GPT3_CLK_SHIFT		12
-#define GPT_CLK_MASK		0x1
-#define AUX_CLK_PLL3_VAL	0
-#define AUX_CLK_PLL1_VAL	1
-
-#define PERIP1_CLK_ENB		(MISC_BASE + 0x02C)
-/* PERIP1_CLK_ENB register masks */
-#define UART0_CLK_ENB		3
-#define UART1_CLK_ENB		4
-#define SSP0_CLK_ENB		5
-#define SSP1_CLK_ENB		6
-#define I2C_CLK_ENB		7
-#define JPEG_CLK_ENB		8
-#define FSMC_CLK_ENB		9
-#define FIRDA_CLK_ENB		10
-#define GPT2_CLK_ENB		11
-#define GPT3_CLK_ENB		12
-#define GPIO2_CLK_ENB		13
-#define SSP2_CLK_ENB		14
-#define ADC_CLK_ENB		15
-#define GPT1_CLK_ENB		11
-#define RTC_CLK_ENB		17
-#define GPIO1_CLK_ENB		18
-#define DMA_CLK_ENB		19
-#define SMI_CLK_ENB		21
-#define CLCD_CLK_ENB		22
-#define GMAC_CLK_ENB		23
-#define USBD_CLK_ENB		24
-#define USBH0_CLK_ENB		25
-#define USBH1_CLK_ENB		26
-
-#define SOC_CORE_ID		(MISC_BASE + 0x030)
-#define RAS_CLK_ENB		(MISC_BASE + 0x034)
-#define PERIP1_SOF_RST		(MISC_BASE + 0x038)
-/* PERIP1_SOF_RST register masks */
-#define JPEG_SOF_RST		8
-
-#define SOC_USER_ID		(MISC_BASE + 0x03C)
-#define RAS_SOF_RST		(MISC_BASE + 0x040)
-#define PRSC1_CLK_CFG		(MISC_BASE + 0x044)
-#define PRSC2_CLK_CFG		(MISC_BASE + 0x048)
-#define PRSC3_CLK_CFG		(MISC_BASE + 0x04C)
-/* gpt synthesizer register masks */
-#define GPT_MSCALE_SHIFT	0
-#define GPT_MSCALE_MASK		0xFFF
-#define GPT_NSCALE_SHIFT	12
-#define GPT_NSCALE_MASK		0xF
-
-#define AMEM_CLK_CFG		(MISC_BASE + 0x050)
-#define EXPI_CLK_CFG		(MISC_BASE + 0x054)
-#define CLCD_CLK_SYNT		(MISC_BASE + 0x05C)
-#define FIRDA_CLK_SYNT		(MISC_BASE + 0x060)
-#define UART_CLK_SYNT		(MISC_BASE + 0x064)
-#define GMAC_CLK_SYNT		(MISC_BASE + 0x068)
-#define RAS1_CLK_SYNT		(MISC_BASE + 0x06C)
-#define RAS2_CLK_SYNT		(MISC_BASE + 0x070)
-#define RAS3_CLK_SYNT		(MISC_BASE + 0x074)
-#define RAS4_CLK_SYNT		(MISC_BASE + 0x078)
-/* aux clk synthesiser register masks for irda to ras4 */
-#define AUX_SYNT_ENB		31
-#define AUX_EQ_SEL_SHIFT	30
-#define AUX_EQ_SEL_MASK		1
-#define AUX_EQ1_SEL		0
-#define AUX_EQ2_SEL		1
-#define AUX_XSCALE_SHIFT	16
-#define AUX_XSCALE_MASK		0xFFF
-#define AUX_YSCALE_SHIFT	0
-#define AUX_YSCALE_MASK		0xFFF
-
-#define ICM1_ARB_CFG		(MISC_BASE + 0x07C)
-#define ICM2_ARB_CFG		(MISC_BASE + 0x080)
-#define ICM3_ARB_CFG		(MISC_BASE + 0x084)
-#define ICM4_ARB_CFG		(MISC_BASE + 0x088)
-#define ICM5_ARB_CFG		(MISC_BASE + 0x08C)
-#define ICM6_ARB_CFG		(MISC_BASE + 0x090)
-#define ICM7_ARB_CFG		(MISC_BASE + 0x094)
-#define ICM8_ARB_CFG		(MISC_BASE + 0x098)
-#define ICM9_ARB_CFG		(MISC_BASE + 0x09C)
 #define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
-#define USB2_PHY_CFG		(MISC_BASE + 0x0A4)
-#define GMAC_CFG_CTR		(MISC_BASE + 0x0A8)
-#define EXPI_CFG_CTR		(MISC_BASE + 0x0AC)
-#define PRC1_LOCK_CTR		(MISC_BASE + 0x0C0)
-#define PRC2_LOCK_CTR		(MISC_BASE + 0x0C4)
-#define PRC3_LOCK_CTR		(MISC_BASE + 0x0C8)
-#define PRC4_LOCK_CTR		(MISC_BASE + 0x0CC)
-#define PRC1_IRQ_CTR		(MISC_BASE + 0x0D0)
-#define PRC2_IRQ_CTR		(MISC_BASE + 0x0D4)
-#define PRC3_IRQ_CTR		(MISC_BASE + 0x0D8)
-#define PRC4_IRQ_CTR		(MISC_BASE + 0x0DC)
-#define PWRDOWN_CFG_CTR		(MISC_BASE + 0x0E0)
-#define COMPSSTL_1V8_CFG	(MISC_BASE + 0x0E4)
-#define COMPSSTL_2V5_CFG	(MISC_BASE + 0x0E8)
-#define COMPCOR_3V3_CFG		(MISC_BASE + 0x0EC)
-#define SSTLPAD_CFG_CTR		(MISC_BASE + 0x0F0)
-#define BIST1_CFG_CTR		(MISC_BASE + 0x0F4)
-#define BIST2_CFG_CTR		(MISC_BASE + 0x0F8)
-#define BIST3_CFG_CTR		(MISC_BASE + 0x0FC)
-#define BIST4_CFG_CTR		(MISC_BASE + 0x100)
-#define BIST5_CFG_CTR		(MISC_BASE + 0x104)
-#define BIST1_STS_RES		(MISC_BASE + 0x108)
-#define BIST2_STS_RES		(MISC_BASE + 0x10C)
-#define BIST3_STS_RES		(MISC_BASE + 0x110)
-#define BIST4_STS_RES		(MISC_BASE + 0x114)
-#define BIST5_STS_RES		(MISC_BASE + 0x118)
-#define SYSERR_CFG_CTR		(MISC_BASE + 0x11C)
 
 #endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/spear.h b/arch/arm/mach-spear6xx/include/mach/spear.h
index 7fd6215..d278ed0 100644
--- a/arch/arm/mach-spear6xx/include/mach/spear.h
+++ b/arch/arm/mach-spear6xx/include/mach/spear.h
@@ -15,69 +15,26 @@
 #define __MACH_SPEAR6XX_H
 
 #include <asm/memory.h>
-#include <mach/spear600.h>
 
-#define SPEAR6XX_ML_SDRAM_BASE		UL(0x00000000)
 /* ICM1 - Low speed connection */
 #define SPEAR6XX_ICM1_BASE		UL(0xD0000000)
-
+#define VA_SPEAR6XX_ICM1_BASE		UL(0xFD000000)
 #define SPEAR6XX_ICM1_UART0_BASE	UL(0xD0000000)
-#define VA_SPEAR6XX_ICM1_UART0_BASE	IO_ADDRESS(SPEAR6XX_ICM1_UART0_BASE)
-
-#define SPEAR6XX_ICM1_UART1_BASE	UL(0xD0080000)
-#define SPEAR6XX_ICM1_SSP0_BASE		UL(0xD0100000)
-#define SPEAR6XX_ICM1_SSP1_BASE		UL(0xD0180000)
-#define SPEAR6XX_ICM1_I2C_BASE		UL(0xD0200000)
-#define SPEAR6XX_ICM1_JPEG_BASE		UL(0xD0800000)
-#define SPEAR6XX_ICM1_IRDA_BASE		UL(0xD1000000)
-#define SPEAR6XX_ICM1_FSMC_BASE		UL(0xD1800000)
-#define SPEAR6XX_ICM1_NAND_BASE		UL(0xD2000000)
-#define SPEAR6XX_ICM1_SRAM_BASE		UL(0xD2800000)
-
-/* ICM2 - Application Subsystem */
-#define SPEAR6XX_ICM2_BASE		UL(0xD8000000)
-#define SPEAR6XX_ICM2_TMR0_BASE		UL(0xD8000000)
-#define SPEAR6XX_ICM2_TMR1_BASE		UL(0xD8080000)
-#define SPEAR6XX_ICM2_GPIO_BASE		UL(0xD8100000)
-#define SPEAR6XX_ICM2_SSP2_BASE		UL(0xD8180000)
-#define SPEAR6XX_ICM2_ADC_BASE		UL(0xD8200000)
+#define VA_SPEAR6XX_ICM1_UART0_BASE	(VA_SPEAR6XX_ICM1_2_BASE | SPEAR6XX_ICM1_UART0_BASE)
 
 /* ML-1, 2 - Multi Layer CPU Subsystem */
 #define SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
+#define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
 #define SPEAR6XX_CPU_TMR_BASE		UL(0xF0000000)
-#define SPEAR6XX_CPU_GPIO_BASE		UL(0xF0100000)
-#define SPEAR6XX_CPU_VIC_SEC_BASE	UL(0xF1000000)
-#define VA_SPEAR6XX_CPU_VIC_SEC_BASE	IO_ADDRESS(SPEAR6XX_CPU_VIC_SEC_BASE)
-#define SPEAR6XX_CPU_VIC_PRI_BASE	UL(0xF1100000)
-#define VA_SPEAR6XX_CPU_VIC_PRI_BASE	IO_ADDRESS(SPEAR6XX_CPU_VIC_PRI_BASE)
 
 /* ICM3 - Basic Subsystem */
-#define SPEAR6XX_ICM3_BASE		UL(0xF8000000)
-#define SPEAR6XX_ICM3_SMEM_BASE		UL(0xF8000000)
 #define SPEAR6XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define SPEAR6XX_ICM3_CLCD_BASE		UL(0xFC200000)
+#define VA_SPEAR6XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
 #define SPEAR6XX_ICM3_DMA_BASE		UL(0xFC400000)
-#define SPEAR6XX_ICM3_SDRAM_CTRL_BASE	UL(0xFC600000)
-#define SPEAR6XX_ICM3_TMR_BASE		UL(0xFC800000)
-#define SPEAR6XX_ICM3_WDT_BASE		UL(0xFC880000)
-#define SPEAR6XX_ICM3_RTC_BASE		UL(0xFC900000)
-#define SPEAR6XX_ICM3_GPIO_BASE		UL(0xFC980000)
 #define SPEAR6XX_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
-#define VA_SPEAR6XX_ICM3_SYS_CTRL_BASE	IO_ADDRESS(SPEAR6XX_ICM3_SYS_CTRL_BASE)
+#define VA_SPEAR6XX_ICM3_SYS_CTRL_BASE	(VA_SPEAR6XX_ICM3_SMI_CTRL_BASE | SPEAR6XX_ICM3_SYS_CTRL_BASE)
 #define SPEAR6XX_ICM3_MISC_REG_BASE	UL(0xFCA80000)
-#define VA_SPEAR6XX_ICM3_MISC_REG_BASE	IO_ADDRESS(SPEAR6XX_ICM3_MISC_REG_BASE)
-
-/* ICM4 - High Speed Connection */
-#define SPEAR6XX_ICM4_BASE		UL(0xE0000000)
-#define SPEAR6XX_ICM4_GMAC_BASE		UL(0xE0800000)
-#define SPEAR6XX_ICM4_USBD_FIFO_BASE	UL(0xE1000000)
-#define SPEAR6XX_ICM4_USBD_CSR_BASE	UL(0xE1100000)
-#define SPEAR6XX_ICM4_USBD_PLDT_BASE	UL(0xE1200000)
-#define SPEAR6XX_ICM4_USB_EHCI0_BASE	UL(0xE1800000)
-#define SPEAR6XX_ICM4_USB_OHCI0_BASE	UL(0xE1900000)
-#define SPEAR6XX_ICM4_USB_EHCI1_BASE	UL(0xE2000000)
-#define SPEAR6XX_ICM4_USB_OHCI1_BASE	UL(0xE2100000)
-#define SPEAR6XX_ICM4_USB_ARB_BASE	UL(0xE2800000)
+#define VA_SPEAR6XX_ICM3_MISC_REG_BASE	(VA_SPEAR6XX_ICM3_SMI_CTRL_BASE | SPEAR6XX_ICM3_MISC_REG_BASE)
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
 #define SPEAR_DBG_UART_BASE		SPEAR6XX_ICM1_UART0_BASE
diff --git a/arch/arm/mach-spear6xx/include/mach/spear600.h b/arch/arm/mach-spear6xx/include/mach/spear600.h
deleted file mode 100644
index c068cc5..0000000
--- a/arch/arm/mach-spear6xx/include/mach/spear600.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-spear66xx/include/mach/spear600.h
- *
- * SPEAr600 Machine specific definition
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifdef	CONFIG_MACH_SPEAR600
-
-#ifndef __MACH_SPEAR600_H
-#define __MACH_SPEAR600_H
-
-#endif /* __MACH_SPEAR600_H */
-
-#endif /* CONFIG_MACH_SPEAR600 */
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 5b9e30f..de194db 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -14,6 +14,8 @@
  */
 
 #include <linux/amba/pl08x.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -21,9 +23,11 @@
 #include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
 #include <plat/pl080.h>
 #include <mach/generic.h>
-#include <mach/hardware.h>
+#include <mach/spear.h>
 
 /* dmac device registration */
 static struct pl08x_channel_data spear600_dma_info[] = {
@@ -384,32 +388,29 @@ struct pl08x_platform_data pl080_plat_data = {
 	.num_slave_channels = ARRAY_SIZE(spear600_dma_info),
 };
 
-/* Following will create static virtual/physical mappings */
-static struct map_desc spear6xx_io_desc[] __initdata = {
+/*
+ * Following will create 16MB static virtual/physical mappings
+ * PHYSICAL		VIRTUAL
+ * 0xF0000000		0xF0000000
+ * 0xF1000000		0xF1000000
+ * 0xD0000000		0xFD000000
+ * 0xFC000000		0xFC000000
+ */
+struct map_desc spear6xx_io_desc[] __initdata = {
 	{
-		.virtual	= VA_SPEAR6XX_ICM1_UART0_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_ICM1_UART0_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= VA_SPEAR6XX_CPU_VIC_PRI_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_PRI_BASE),
-		.length		= SZ_4K,
+		.virtual	= VA_SPEAR6XX_ML_CPU_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_ML_CPU_BASE),
+		.length		= 2 * SZ_16M,
 		.type		= MT_DEVICE
-	}, {
-		.virtual	= VA_SPEAR6XX_CPU_VIC_SEC_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_SEC_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= VA_SPEAR6XX_ICM3_SYS_CTRL_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_SYS_CTRL_BASE),
-		.length		= SZ_4K,
+	},	{
+		.virtual	= VA_SPEAR6XX_ICM1_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_ICM1_BASE),
+		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= VA_SPEAR6XX_ICM3_MISC_REG_BASE,
-		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_MISC_REG_BASE),
-		.length		= SZ_4K,
+		.virtual	= VA_SPEAR6XX_ICM3_SMI_CTRL_BASE,
+		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_SMI_CTRL_BASE),
+		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	},
 };
@@ -447,7 +448,7 @@ static void __init spear6xx_timer_init(void)
 	clk_put(gpt_clk);
 	clk_put(pclk);
 
-	spear_setup_timer();
+	spear_setup_timer(SPEAR6XX_CPU_TMR_BASE, IRQ_CPU_GPT1_1);
 }
 
 struct sys_timer spear6xx_timer = {
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index 02b160a..ab3de72 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -12,7 +12,7 @@
  */
 
 #include <linux/amba/serial.h>
-#include <mach/hardware.h>
+#include <mach/spear.h>
 
 		.macro	addruart, rp, rv, tmp
 		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
diff --git a/arch/arm/plat-spear/include/plat/hardware.h b/arch/arm/plat-spear/include/plat/hardware.h
deleted file mode 100644
index 70187d7..0000000
--- a/arch/arm/plat-spear/include/plat/hardware.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/hardware.h
- *
- * Hardware definitions for SPEAr
- *
- * Copyright (C) 2010 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_HARDWARE_H
-#define __PLAT_HARDWARE_H
-
-#endif /* __PLAT_HARDWARE_H */
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 1bf8452..6dd455b 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -13,7 +13,7 @@
 
 #include <linux/io.h>
 #include <linux/amba/serial.h>
-#include <mach/hardware.h>
+#include <mach/spear.h>
 
 #ifndef __PLAT_UNCOMPRESS_H
 #define __PLAT_UNCOMPRESS_H
diff --git a/arch/arm/plat-spear/pl080.c b/arch/arm/plat-spear/pl080.c
index d53d75e..a56a067 100644
--- a/arch/arm/plat-spear/pl080.c
+++ b/arch/arm/plat-spear/pl080.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/spinlock_types.h>
+#include <mach/spear.h>
 #include <mach/misc_regs.h>
 
 static spinlock_t lock = __SPIN_LOCK_UNLOCKED(x);
diff --git a/arch/arm/plat-spear/restart.c b/arch/arm/plat-spear/restart.c
index 16f203e..4471a23 100644
--- a/arch/arm/plat-spear/restart.c
+++ b/arch/arm/plat-spear/restart.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <asm/system_misc.h>
 #include <asm/hardware/sp810.h>
-#include <mach/hardware.h>
+#include <mach/spear.h>
 #include <mach/generic.h>
 
 void spear_restart(char mode, const char *cmd)
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index abb5bde..a3164d1 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -15,14 +15,13 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/irq.h>
 #include <asm/mach/time.h>
 #include <mach/generic.h>
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 
 /*
  * We would use TIMER0 and TIMER1 as clockevent and clocksource.
@@ -175,7 +174,7 @@ static struct irqaction spear_timer_irq = {
 	.handler = spear_timer_interrupt
 };
 
-static void __init spear_clockevent_init(void)
+static void __init spear_clockevent_init(int irq)
 {
 	u32 tick_rate;
 
@@ -195,19 +194,19 @@ static void __init spear_clockevent_init(void)
 
 	clockevents_register_device(&clkevt);
 
-	setup_irq(SPEAR_GPT0_CHAN0_IRQ, &spear_timer_irq);
+	setup_irq(irq, &spear_timer_irq);
 }
 
-void __init spear_setup_timer(void)
+void __init spear_setup_timer(resource_size_t base, int irq)
 {
 	int ret;
 
-	if (!request_mem_region(SPEAR_GPT0_BASE, SZ_1K, "gpt0")) {
+	if (!request_mem_region(base, SZ_1K, "gpt0")) {
 		pr_err("%s:cannot get IO addr\n", __func__);
 		return;
 	}
 
-	gpt_base = (void __iomem *)ioremap(SPEAR_GPT0_BASE, SZ_1K);
+	gpt_base = ioremap(base, SZ_1K);
 	if (!gpt_base) {
 		pr_err("%s:ioremap failed for gpt\n", __func__);
 		goto err_mem;
@@ -225,7 +224,7 @@ void __init spear_setup_timer(void)
 		goto err_clk;
 	}
 
-	spear_clockevent_init();
+	spear_clockevent_init(irq);
 	spear_clocksource_init();
 
 	return;
@@ -235,5 +234,5 @@ err_clk:
 err_iomap:
 	iounmap(gpt_base);
 err_mem:
-	release_mem_region(SPEAR_GPT0_BASE, SZ_1K);
+	release_mem_region(base, SZ_1K);
 }
