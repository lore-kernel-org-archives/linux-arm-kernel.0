From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 4 Dec 2009 09:41:28 -0500
Subject: [PATCH] [ARM] mmp: support marvell ARMADA610
Message-ID: <mailman.72.1260166779.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell ARMADA610 is a SoC based on PJ4 core. It's ARMv6 compatible.
Support basic interrupt handler and timer.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig                             |    4 +-
 arch/arm/mach-mmp/Kconfig                    |   20 +++-
 arch/arm/mach-mmp/common.h                   |    2 +
 arch/arm/mach-mmp/include/mach/cputype.h     |   17 ++-
 arch/arm/mach-mmp/include/mach/entry-macro.S |   34 ++++-
 arch/arm/mach-mmp/include/mach/irqs.h        |  107 ++++++++++++-
 arch/arm/mach-mmp/include/mach/regs-apbc.h   |   41 +++++
 arch/arm/mach-mmp/include/mach/regs-icu.h    |   32 ++++-
 arch/arm/mach-mmp/include/mach/timex.h       |    4 +
 arch/arm/mach-mmp/irq.c                      |  225 ++++++++++++++++++++++++++
 arch/arm/mach-mmp/time.c                     |   29 ++++-
 11 files changed, 499 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..e4495ce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -484,7 +484,7 @@ config ARCH_ORION5X
 	  Orion-2 (5281), Orion-1-90 (6183).

 config ARCH_MMP
-	bool "Marvell PXA168/910"
+	bool "Marvell PXA168/910 & ARMADA610"
 	depends on MMU
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
@@ -495,7 +495,7 @@ config ARCH_MMP
 	select TICK_ONESHOT
 	select PLAT_PXA
 	help
-	  Support for Marvell's PXA168/910 processor line.
+	  Support for Marvell's PXA168/910 & ARMADA610 processor line.

 config ARCH_KS8695
 	bool "Micrel/Kendin KS8695"
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index c6a564f..2ed130d 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,6 +1,6 @@
 if ARCH_MMP

-menu "Marvell PXA168/910 Implmentations"
+menu "Marvell PXA168/910 & ARMADA610 Implmentations"

 config MACH_ASPENITE
 	bool "Marvell's PXA168 Aspenite Development Board"
@@ -30,6 +30,16 @@ config MACH_TTC_DKB
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TTC_DKB Development Board.

+config MACH_FLINT
+	bool "Marvell's Flint Development Platform"
+	select CPU_ARMADA610
+	help
+	  Say 'Y' here if you want to support the Marvell ARMADA610-based
+	  Flint Development Platform.
+	  ARMADA610-based board can't be co-existed with PXA168-based &
+	  PXA910-based development board. Since ARMADA610 is compatible to
+	  ARMv6 architecture.
+
 endmenu

 config CPU_PXA168
@@ -44,4 +54,12 @@ config CPU_PXA910
 	help
 	  Select code specific to PXA910

+config CPU_ARMADA610
+	bool
+	select CPU_V6
+	select CPU_32v6K
+	select PLAT_PXA
+	help
+	  Select code specific to ARMADA610
+	  ARMADA610 is ARMv6 compatible.
 endif
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index c33fbbc..f929d61 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -6,8 +6,10 @@ extern void timer_init(int irq);

 extern struct sys_timer pxa168_timer;
 extern struct sys_timer pxa910_timer;
+extern struct sys_timer armada610_timer;
 extern void __init pxa168_init_irq(void);
 extern void __init pxa910_init_irq(void);
+extern void __init armada610_init_irq(void);

 extern void __init icu_init_irq(void);
 extern void __init pxa_map_io(void);
diff --git a/arch/arm/mach-mmp/include/mach/cputype.h
b/arch/arm/mach-mmp/include/mach/cputype.h
index 25e797b..3071ba9 100644
--- a/arch/arm/mach-mmp/include/mach/cputype.h
+++ b/arch/arm/mach-mmp/include/mach/cputype.h
@@ -8,23 +8,32 @@
  *
  * PXA168    A0    0x41159263   0x56158400   0x00A0A333
  * PXA910    Y0    0x41159262   0x56158000   0x00F0C910
+ * ARMADA610 Z0			0x560f5811
  */

 #ifdef CONFIG_CPU_PXA168
-#  define __cpu_is_pxa168(id)	\
+#define __cpu_is_pxa168(id)	\
 	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x84; })
 #else
-#  define __cpu_is_pxa168(id)	(0)
+#define __cpu_is_pxa168(id)	(0)
 #endif

 #ifdef CONFIG_CPU_PXA910
-#  define __cpu_is_pxa910(id)	\
+#define __cpu_is_pxa910(id)	\
 	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x80; })
 #else
-#  define __cpu_is_pxa910(id)	(0)
+#define __cpu_is_pxa910(id)	(0)
+#endif
+
+#ifdef CONFIG_CPU_ARMADA610
+#define __cpu_is_armada610(id)	\
+	({ unsigned int _id = ((id) >> 4) & 0xfff; _id == 0x581; })
+#else
+#define __cpu_is_armada610(id)	(0)
 #endif

 #define cpu_is_pxa168()		({ __cpu_is_pxa168(read_cpuid_id()); })
 #define cpu_is_pxa910()		({ __cpu_is_pxa910(read_cpuid_id()); })
+#define cpu_is_armada610()	({ __cpu_is_armada610(read_cpuid_id()); })

 #endif /* __ASM_MACH_CPUTYPE_H */
diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S
b/arch/arm/mach-mmp/include/mach/entry-macro.S
index 6d3cd35..cfaa4b2 100644
--- a/arch/arm/mach-mmp/include/mach/entry-macro.S
+++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
@@ -11,15 +11,39 @@
 	.macro	disable_fiq
 	.endm

-	.macro	arch_ret_to_user, tmp1, tmp2
+	.macro	get_irqnr_preamble, base, tmp
 	.endm

-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =ICU_AP_IRQ_SEL_INT_NUM
+	.macro	arch_ret_to_user, tmp1, tmp2
 	.endm

 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\tmp, [\base, #0]
+	ldr	\base, =ICU_VIRT_BASE		@ ICU register base
+	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
+	mov	\tmp, \tmp, lsr #4
+	ldr	\irqstat, =0xfff
+	and	\irqstat, \tmp, \irqstat	@ Core G
+
+	@ Core Sheeva PJ1 (PXA168/910)
+	ldr	\tmp, =0x800			@ PXA910
+	cmp	\irqstat, \tmp
+	beq	1001f
+	ldr	\tmp, =0x840			@ PXA168
+	cmp	\irqstat, \tmp
+	bne	1002f
+1001:
+	ldr	\tmp, [\base, #0x10c]		@ AP INT SEL register
+	tst	\tmp, #0x40
+	and	\irqnr, \tmp, #0x3f
+	b	1003f
+
+1002:
+	@ Core Sheeva PJ4 (PXA688)
+	ldr	\tmp, =0x581
+	cmp	\irqstat, \tmp
+	bne	1003f
+	ldr	\tmp, [\base, #0x104]		@ PJ4 IRQ SEL register
+	tst	\tmp, #0x40
 	and	\irqnr, \tmp, #0x3f
-	tst	\tmp, #(1 << 6)
+1003:
 	.endm
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h
b/arch/arm/mach-mmp/include/mach/irqs.h
index d68871b..3c246c6 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -113,8 +113,111 @@
 #define IRQ_PXA910_AP_PMU		60
 #define IRQ_PXA910_SM_INT		63	/* from PinMux */

-#define IRQ_GPIO_START			64
-#define IRQ_GPIO_NUM			128
+/*
+ * Interrupt numbers for ARMADA610
+ */
+#define IRQ_ARMADA610_NONE		(-1)
+#define IRQ_ARMADA610_SSP1		0
+#define IRQ_ARMADA610_SSP2		1
+#define IRQ_ARMADA610_SSPA1		2
+#define IRQ_ARMADA610_SSPA2		3
+#define IRQ_ARMADA610_PMIC_BASE		4	/* PMIC & Charger */
+#define IRQ_ARMADA610_RTC_BASE		5
+#define IRQ_ARMADA610_TWSI1		7
+#define IRQ_ARMADA610_GPU		8
+#define IRQ_ARMADA610_KEYPAD		9
+#define IRQ_ARMADA610_ROTARY		10
+#define IRQ_ARMADA610_TRACKBALL		11
+#define IRQ_ARMADA610_ONEWIRE		12
+#define IRQ_ARMADA610_TIMER1		13
+#define IRQ_ARMADA610_TIMER2		14
+#define IRQ_ARMADA610_TIMER3		15
+#define IRQ_ARMADA610_RIPC		16
+#define IRQ_ARMADA610_TWSI_BASE		17	/* TWSI2 ~ TWSI6 */
+#define IRQ_ARMADA610_HDMI		19
+#define IRQ_ARMADA610_SSP3		20
+#define IRQ_ARMADA610_SSP4		21
+#define IRQ_ARMADA610_USB_HS1		22
+#define IRQ_ARMADA610_USB_HS2		23
+#define IRQ_ARMADA610_UART3		24
+#define IRQ_ARMADA610_UART1		27
+#define IRQ_ARMADA610_UART2		28
+#define IRQ_ARMADA610_MIPI_DSI		29
+#define IRQ_ARMADA610_CI2		30
+#define IRQ_ARMADA610_PMU_TIMER1	31
+#define IRQ_ARMADA610_PMU_TIMER2	32
+#define IRQ_ARMADA610_PMU_TIMER3	33
+#define IRQ_ARMADA610_USB_FS		34
+#define IRQ_ARMADA610_MISC_BASE		35
+#define IRQ_ARMADA610_WDT1		36
+#define IRQ_ARMADA610_NAND_DMA		37
+#define IRQ_ARMADA610_USIM		38
+#define IRQ_ARMADA610_MMC		39
+#define IRQ_ARMADA610_WTM		40
+#define IRQ_ARMADA610_LCD		41
+#define IRQ_ARMADA610_CI		42
+#define IRQ_ARMADA610_IRE		43
+#define IRQ_ARMADA610_USB_OTG		44
+#define IRQ_ARMADA610_NAND		45
+#define IRQ_ARMADA610_UART4		46
+#define IRQ_ARMADA610_DMA_FIQ		47
+#define IRQ_ARMADA610_DMA_RIQ		48
+#define IRQ_ARMADA610_GPIO		49
+#define IRQ_ARMADA610_SSP_BASE		51
+#define IRQ_ARMADA610_MMC2		52
+#define IRQ_ARMADA610_MMC3		53
+#define IRQ_ARMADA610_MMC4		54
+#define IRQ_ARMADA610_MIPI_HSI		55
+#define IRQ_ARMADA610_MSP		58
+#define IRQ_ARMADA610_MIPI_SLIM_DMA	59
+#define IRQ_ARMADA610_PJ4_FREQ_CHG	60
+#define IRQ_ARMADA610_MIPI_SLIM		62
+#define IRQ_ARMADA610_SM		63
+
+/* secondary interrupt of INT #4 */
+#define ARMADA610_BASE_INT4		64
+#define IRQ_ARMADA610_CHARGER		(ARMADA610_BASE_INT4)
+#define IRQ_ARMADA610_PMIC		(ARMADA610_BASE_INT4 + 1)
+
+/* secondary interrupt of INT #5 */
+#define ARMADA610_BASE_INT5		66
+#define IRQ_ARMADA610_RTC_ALARM		(ARMADA610_BASE_INT5)
+#define IRQ_ARMADA610_RTC		(ARMADA610_BASE_INT5 + 1)
+
+/* secondary interrupt of INT #17 */
+#define ARMADA610_BASE_INT17		68
+#define IRQ_ARMADA610_TWSI2		(ARMADA610_BASE_INT17)
+#define IRQ_ARMADA610_TWSI3		(ARMADA610_BASE_INT17 + 1)
+#define IRQ_ARMADA610_TWSI4		(ARMADA610_BASE_INT17 + 2)
+#define IRQ_ARMADA610_TWSI5		(ARMADA610_BASE_INT17 + 3)
+#define IRQ_ARMADA610_TWSI6		(ARMADA610_BASE_INT17 + 4)
+
+/* secondary interrupt of INT #35 */
+#define ARMADA610_BASE_INT35		73
+#define IRQ_ARMADA610_PERF		(ARMADA610_BASE_INT35)
+#define IRQ_ARMADA610_L2_PA_ECC		(ARMADA610_BASE_INT35 + 1)
+#define IRQ_ARMADA610_L2_ECC		(ARMADA610_BASE_INT35 + 2)
+#define IRQ_ARMADA610_L2_UECC		(ARMADA610_BASE_INT35 + 3)
+#define IRQ_ARMADA610_DDR		(ARMADA610_BASE_INT35 + 4)
+#define IRQ_ARMADA610_FAB0_TIMEOUT	(ARMADA610_BASE_INT35 + 5)
+#define IRQ_ARMADA610_FAB1_TIMEOUT	(ARMADA610_BASE_INT35 + 6)
+#define IRQ_ARMADA610_FAB2_TIMEOUT	(ARMADA610_BASE_INT35 + 7)
+#define IRQ_ARMADA610_THERMAL		(ARMADA610_BASE_INT35 + 9)
+#define IRQ_ARMADA610_MAIN_PMU		(ARMADA610_BASE_INT35 + 10)
+#define IRQ_ARMADA610_WDT2		(ARMADA610_BASE_INT35 + 11)
+#define IRQ_ARMADA610_CORESIGHT		(ARMADA610_BASE_INT35 + 12)
+#define IRQ_ARMADA610_COMMTX		(ARMADA610_BASE_INT35 + 13)
+#define IRQ_ARMADA610_COMMRX		(ARMADA610_BASE_INT35 + 14)
+
+/* secondary interrupt of INT #51 */
+#define ARMADA610_BASE_INT51		88
+#define IRQ_ARMADA610_SSP1_SRDY		(ARMADA610_BASE_INT51)
+#define IRQ_ARMADA610_SSP3_SRDY		(ARMADA610_BASE_INT51 + 1)
+
+#define ARMADA610_BASE_INT_END		90
+
+#define IRQ_GPIO_START			128
+#define IRQ_GPIO_NUM			192
 #define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))

 #define NR_IRQS		(IRQ_GPIO_START + IRQ_GPIO_NUM)
diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h
b/arch/arm/mach-mmp/include/mach/regs-apbc.h
index 98ccbee..6ed1b9b 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apbc.h
@@ -69,6 +69,47 @@
 #define APBC_PXA910_ASFAR	APBC_REG(0x050)
 #define APBC_PXA910_ASSAR	APBC_REG(0x054)

+/*
+ * APB Clock register offsets for ARMADA610
+ */
+#define APBC_ARMADA610_RTC		APBC_REG(0x000)
+#define APBC_ARMADA610_TWSI1		APBC_REG(0x004)
+#define APBC_ARMADA610_TWSI2		APBC_REG(0x008)
+#define APBC_ARMADA610_TWSI3		APBC_REG(0x00c)
+#define APBC_ARMADA610_TWSI4		APBC_REG(0x010)
+#define APBC_ARMADA610_ONEWIRE		APBC_REG(0x014)
+#define APBC_ARMADA610_KPC		APBC_REG(0x018)
+#define APBC_ARMADA610_TB_ROTARY	APBC_REG(0x01c)
+#define APBC_ARMADA610_SW_JTAG		APBC_REG(0x020)
+#define APBC_ARMADA610_TIMERS		APBC_REG(0x024)
+#define APBC_ARMADA610_UART1		APBC_REG(0x02c)
+#define APBC_ARMADA610_UART2		APBC_REG(0x030)
+#define APBC_ARMADA610_UART3		APBC_REG(0x034)
+#define APBC_ARMADA610_GPIO		APBC_REG(0x038)
+#define APBC_ARMADA610_PWM0		APBC_REG(0x03c)
+#define APBC_ARMADA610_PWM1		APBC_REG(0x040)
+#define APBC_ARMADA610_PWM2		APBC_REG(0x044)
+#define APBC_ARMADA610_PWM3		APBC_REG(0x048)
+#define APBC_ARMADA610_SSP0		APBC_REG(0x04c)
+#define APBC_ARMADA610_SSP1		APBC_REG(0x050)
+#define APBC_ARMADA610_SSP2		APBC_REG(0x054)
+#define APBC_ARMADA610_SSP3		APBC_REG(0x058)
+#define APBC_ARMADA610_SSP4		APBC_REG(0x05c)
+#define APBC_ARMADA610_SSP5		APBC_REG(0x060)
+#define APBC_ARMADA610_AIB		APBC_REG(0x064)
+#define APBC_ARMADA610_ASFAR		APBC_REG(0x068)
+#define APBC_ARMADA610_ASSAR		APBC_REG(0x06c)
+#define APBC_ARMADA610_USIM		APBC_REG(0x070)
+#define APBC_ARMADA610_MPMU		APBC_REG(0x074)
+#define APBC_ARMADA610_IPC		APBC_REG(0x078)
+#define APBC_ARMADA610_TWSI5		APBC_REG(0x07c)
+#define APBC_ARMADA610_TWSI6		APBC_REG(0x080)
+#define APBC_ARMADA610_TWSI_INTSTS	APBC_REG(0x084)
+#define APBC_ARMADA610_UART4		APBC_REG(0x088)
+#define APBC_ARMADA610_RIPC		APBC_REG(0x08c)
+#define APBC_ARMADA610_THSENS1		APBC_REG(0x090)	/* Thermal Sensor */
+#define APBC_ARMADA610_THSENS_INTSTS	APBC_REG(0x0a4)
+
 /* Common APB clock register bit definitions */
 #define APBC_APBCLK	(1 << 0)  /* APB Bus Clock Enable */
 #define APBC_FNCLK	(1 << 1)  /* Functional Clock Enable */
diff --git a/arch/arm/mach-mmp/include/mach/regs-icu.h
b/arch/arm/mach-mmp/include/mach/regs-icu.h
index e5f0872..ae7f97f 100644
--- a/arch/arm/mach-mmp/include/mach/regs-icu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-icu.h
@@ -17,15 +17,45 @@
 #define ICU_REG(x)	(ICU_VIRT_BASE + (x))

 #define ICU_INT_CONF(n)		ICU_REG((n) << 2)
+#define ICU_INT_CONF_MASK	(0xf)
+
+#if defined(CONFIG_CPU_PXA168) || defined(CONFIG_CPU_PXA910)
 #define ICU_INT_CONF_AP_INT	(1 << 6)
 #define ICU_INT_CONF_CP_INT	(1 << 5)
 #define ICU_INT_CONF_IRQ	(1 << 4)
-#define ICU_INT_CONF_MASK	(0xf)

 #define ICU_AP_FIQ_SEL_INT_NUM	ICU_REG(0x108)	/* AP FIQ Selected Interrupt */
 #define ICU_AP_IRQ_SEL_INT_NUM	ICU_REG(0x10C)	/* AP IRQ Selected Interrupt */
 #define ICU_AP_GBL_IRQ_MSK	ICU_REG(0x114)	/* AP Global Interrupt Mask */
 #define ICU_INT_STATUS_0	ICU_REG(0x128)	/* Interrupt Stuats 0 */
 #define ICU_INT_STATUS_1	ICU_REG(0x12C)	/* Interrupt Status 1 */
+#endif	/* CONFIG_CPU_PXA168 || CONFIG_CPU_PXA910 */
+
+#ifdef CONFIG_CPU_ARMADA610
+/*
+ * IRQ0/FIQ0 is routed to SP IRQ/FIQ.
+ * IRQ1 is routed to PJ4 IRQ, and IRQ2 is routes to PJ4 FIQ.
+ */
+#define ICU_INT_ROUTE_SP_IRQ		(1 << 4)
+#define ICU_INT_ROUTE_PJ4_IRQ		(1 << 5)
+#define ICU_INT_ROUTE_PJ4_FIQ		(1 << 6)
+
+#define ARMADA610_ICU_INT4_STATUS	ICU_REG(0x150)
+#define ARMADA610_ICU_INT5_STATUS	ICU_REG(0x154)
+#define ARMADA610_ICU_INT17_STATUS	ICU_REG(0x158)
+#define ARMADA610_ICU_INT35_STATUS	ICU_REG(0x15c)
+#define ARMADA610_ICU_INT51_STATUS	ICU_REG(0x160)
+
+#define ARMADA610_ICU_INT4_MASK		ICU_REG(0x168)
+#define ARMADA610_ICU_INT5_MASK		ICU_REG(0x16C)
+#define ARMADA610_ICU_INT17_MASK	ICU_REG(0x170)
+#define ARMADA610_ICU_INT35_MASK	ICU_REG(0x174)
+#define ARMADA610_ICU_INT51_MASK	ICU_REG(0x178)
+
+#define ARMADA610_ICU_SP_IRQ_SEL	ICU_REG(0x100)
+#define ARMADA610_ICU_PJ4_IRQ_SEL	ICU_REG(0x104)
+#define ARMADA610_ICU_PJ4_FIQ_SEL	ICU_REG(0x108)
+
+#endif	/* CONFIG_CPU_ARMADA610 */

 #endif /* __ASM_MACH_ICU_H */
diff --git a/arch/arm/mach-mmp/include/mach/timex.h
b/arch/arm/mach-mmp/include/mach/timex.h
index 6cebbd0..9255e48 100644
--- a/arch/arm/mach-mmp/include/mach/timex.h
+++ b/arch/arm/mach-mmp/include/mach/timex.h
@@ -6,4 +6,8 @@
  * published by the Free Software Foundation.
  */

+#ifdef CONFIG_CPU_PXA688
+#define CLOCK_TICK_RATE		6500000
+#else
 #define CLOCK_TICK_RATE		3250000
+#endif
diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
index 52ff2f0..11b62c5 100644
--- a/arch/arm/mach-mmp/irq.c
+++ b/arch/arm/mach-mmp/irq.c
@@ -20,6 +20,8 @@

 #include "common.h"

+#if defined(CONFIG_CPU_PXA168) || defined(CONFIG_CPU_PXA910)
+
 #define IRQ_ROUTE_TO_AP		(ICU_INT_CONF_AP_INT | ICU_INT_CONF_IRQ)

 #define PRIORITY_DEFAULT	0x1
@@ -53,3 +55,226 @@ void __init icu_init_irq(void)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 }
+#endif	/* CONFIG_CPU_PXA168 || CONFIG_CPU_PXA910 */
+
+#if defined(CONFIG_CPU_ARMADA610)
+
+/* mask first-level interrupt */
+#define MASK_FIRST_INT(irq, data)		\
+do {						\
+	data = __raw_readl(ICU_INT_CONF(irq));	\
+	data &= ~ICU_INT_ROUTE_PJ4_IRQ;		\
+	__raw_writel(data, ICU_INT_CONF(irq));	\
+} while (0)
+
+/* unmask first-level interrupt */
+#define UNMASK_FIRST_INT(irq, data)		\
+do {						\
+	data = __raw_readl(ICU_INT_CONF(irq));	\
+	data |= ICU_INT_ROUTE_PJ4_IRQ;		\
+	__raw_writel(data, ICU_INT_CONF(irq));	\
+} while (0)
+
+/* mask second-level interrupt */
+#define MASK_SECOND_INT(irq, data, _base)			\
+do {								\
+	data = __raw_readl(ARMADA610_ICU_INT##_base##_MASK);	\
+	data |= (1 << (irq - ARMADA610_BASE_INT##_base));		\
+	__raw_writel(data, ARMADA610_ICU_INT##_base##_MASK);	\
+} while (0)
+
+/* unmask second-level interrupt */
+#define UNMASK_SECOND_INT(irq, data, _base)			\
+do {								\
+	data = __raw_readl(ARMADA610_ICU_INT##_base##_MASK);	\
+	data &= ~(1 << (irq - ARMADA610_BASE_INT##_base));		\
+	__raw_writel(data, ARMADA610_ICU_INT##_base##_MASK);	\
+} while (0)
+
+/* disable Sheeva PJ4 IRQ */
+static void armada610_ack_irq(unsigned int irq)
+{
+	unsigned int data;
+
+	if (irq < ARMADA610_BASE_INT4) {
+
+		MASK_FIRST_INT(irq, data);
+	} else if (irq < ARMADA610_BASE_INT5) {
+
+		MASK_FIRST_INT(4, data);
+		MASK_SECOND_INT(irq, data, 4);
+	} else if (irq < ARMADA610_BASE_INT17) {
+
+		MASK_FIRST_INT(5, data);
+		MASK_SECOND_INT(irq, data, 5);
+	} else if (irq < ARMADA610_BASE_INT35) {
+
+		MASK_FIRST_INT(17, data);
+		MASK_SECOND_INT(irq, data, 17);
+	} else if (irq < ARMADA610_BASE_INT51) {
+
+		MASK_FIRST_INT(35, data);
+		MASK_SECOND_INT(irq, data, 35);
+	} else if (irq < ARMADA610_BASE_INT_END) {
+
+		MASK_FIRST_INT(51, data);
+		MASK_SECOND_INT(irq, data, 51);
+	}
+}
+
+/* disable Sheeva PJ4 IRQ */
+static void armada610_mask_irq(unsigned int irq)
+{
+	unsigned int data;
+
+	if (irq < ARMADA610_BASE_INT4) {
+
+		MASK_FIRST_INT(irq, data);
+	} else if (irq < ARMADA610_BASE_INT5) {
+
+		MASK_SECOND_INT(irq, data, 4);
+	} else if (irq < ARMADA610_BASE_INT17) {
+
+		MASK_SECOND_INT(irq, data, 5);
+	} else if (irq < ARMADA610_BASE_INT35) {
+
+		MASK_SECOND_INT(irq, data, 17);
+	} else if (irq < ARMADA610_BASE_INT51) {
+
+		MASK_SECOND_INT(irq, data, 35);
+	} else if (irq < ARMADA610_BASE_INT_END) {
+
+		MASK_SECOND_INT(irq, data, 51);
+	}
+}
+
+/* enable Sheeva PJ4 IRQ */
+static void armada610_unmask_irq(unsigned int irq)
+{
+	unsigned int data;
+
+	if (irq < ARMADA610_BASE_INT4) {
+
+		UNMASK_FIRST_INT(irq, data);
+	} else if (irq < ARMADA610_BASE_INT5) {
+
+		UNMASK_SECOND_INT(irq, data, 4);
+		UNMASK_FIRST_INT(4, data);
+	} else if (irq < ARMADA610_BASE_INT17) {
+
+		UNMASK_SECOND_INT(irq, data, 5);
+		UNMASK_FIRST_INT(5, data);
+	} else if (irq < ARMADA610_BASE_INT35) {
+
+		UNMASK_SECOND_INT(irq, data, 17);
+		UNMASK_FIRST_INT(17, data);
+	} else if (irq < ARMADA610_BASE_INT51) {
+
+		UNMASK_SECOND_INT(irq, data, 35);
+		UNMASK_FIRST_INT(35, data);
+	} else if (irq < ARMADA610_BASE_INT_END) {
+
+		UNMASK_SECOND_INT(irq, data, 51);
+		UNMASK_FIRST_INT(51, data);
+	}
+}
+
+static void armada610_irq_demux_handler(unsigned int irq, struct
irq_desc *desc)
+{
+	DECLARE_BITMAP(irq_status, 32);
+	unsigned int status, mask, irq_nr;
+
+	switch (irq) {
+	case IRQ_ARMADA610_PMIC_BASE:
+		status = __raw_readl(ARMADA610_ICU_INT4_STATUS);
+		mask = __raw_readl(ARMADA610_ICU_INT4_MASK);
+		status &= (~mask & 0x3);
+		break;
+	case IRQ_ARMADA610_RTC_BASE:
+		status = __raw_readl(ARMADA610_ICU_INT5_STATUS);
+		mask = __raw_readl(ARMADA610_ICU_INT5_MASK);
+		status &= (~mask & 0x3);
+		break;
+	case IRQ_ARMADA610_TWSI_BASE:
+		status = __raw_readl(ARMADA610_ICU_INT17_STATUS);
+		mask = __raw_readl(ARMADA610_ICU_INT17_MASK);
+		status &= (~mask & 0x1f);
+		break;
+	case IRQ_ARMADA610_MISC_BASE:
+		status = __raw_readl(ARMADA610_ICU_INT35_STATUS);
+		mask = __raw_readl(ARMADA610_ICU_INT35_MASK);
+		status &= (~mask & 0x7fff);
+		break;
+	case IRQ_ARMADA610_SSP_BASE:
+		status = __raw_readl(ARMADA610_ICU_INT51_STATUS);
+		mask = __raw_readl(ARMADA610_ICU_INT51_MASK);
+		status &= (~mask & 0x3);
+		break;
+	default:
+		return;
+	}
+
+	irq_status[0] = status;
+	while (!bitmap_empty(irq_status, 32)) {
+		irq_nr = find_first_bit(irq_status, 32);
+		clear_bit(irq_nr, irq_status);
+		switch (irq) {
+		case IRQ_ARMADA610_PMIC_BASE:
+			irq_nr += ARMADA610_BASE_INT4;
+			break;
+		case IRQ_ARMADA610_RTC_BASE:
+			irq_nr += ARMADA610_BASE_INT5;
+			break;
+		case IRQ_ARMADA610_TWSI_BASE:
+			irq_nr += ARMADA610_BASE_INT17;
+			break;
+		case IRQ_ARMADA610_MISC_BASE:
+			irq_nr += ARMADA610_BASE_INT35;
+			break;
+		case IRQ_ARMADA610_SSP_BASE:
+			irq_nr += ARMADA610_BASE_INT51;
+			break;
+		}
+		generic_handle_irq(irq_nr);
+	}
+}
+
+static struct irq_chip armada610_irq_chip = {
+	.name	= "icu_irq",
+	.ack	= armada610_ack_irq,
+	.mask	= armada610_mask_irq,
+	.unmask	= armada610_unmask_irq,
+};
+
+void __init armada610_init_irq(void)
+{
+	int irq;
+
+	for (irq = 0; irq < ARMADA610_BASE_INT4; irq++) {
+		armada610_mask_irq(irq);
+		set_irq_chip(irq, &armada610_irq_chip);
+		set_irq_flags(irq, IRQF_VALID);
+
+		switch (irq) {
+		case IRQ_ARMADA610_PMIC_BASE:
+		case IRQ_ARMADA610_RTC_BASE:
+		case IRQ_ARMADA610_TWSI_BASE:
+		case IRQ_ARMADA610_MISC_BASE:
+		case IRQ_ARMADA610_SSP_BASE:
+			set_irq_chained_handler(irq, armada610_irq_demux_handler);
+			break;
+		default:
+			set_irq_handler(irq, handle_level_irq);
+			break;
+		}
+	}
+
+	/* add secondary interrupt handler */
+	for (irq = ARMADA610_BASE_INT4; irq < ARMADA610_BASE_INT_END; irq++) {
+		armada610_mask_irq(irq);
+		set_irq_chip(irq, &armada610_irq_chip);
+		set_irq_flags(irq, IRQF_VALID);
+		set_irq_handler(irq, handle_level_irq);
+	}
+}
+#endif	/* CONFIG_CPU_ARMADA610 */
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index a8400bb..d5f4874 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -30,7 +30,10 @@

 #include <mach/addr-map.h>
 #include <mach/regs-timers.h>
+#include <mach/regs-apbc.h>
 #include <mach/irqs.h>
+#include <mach/cputype.h>
+#include <asm/mach/time.h>

 #include "clock.h"

@@ -158,7 +161,10 @@ static void __init timer_config(void)

 	__raw_writel(cer & ~0x1, TIMERS_VIRT_BASE + TMR_CER); /* disable */

-	ccr &= TMR_CCR_CS_0(0x3);
+	if (cpu_is_armada610())
+		ccr &= TMR_CCR_CS_0(0);
+	else
+		ccr &= TMR_CCR_CS_0(0x3);
 	__raw_writel(ccr, TIMERS_VIRT_BASE + TMR_CCR);

 	/* free-running mode */
@@ -197,3 +203,24 @@ void __init timer_init(int irq)
 	clocksource_register(&cksrc);
 	clockevents_register_device(&ckevt);
 }
+
+static void __init armada610_timer_init(void)
+{
+	unsigned long clk_rst;
+
+	__raw_writel(APBC_APBCLK | APBC_RST, APBC_ARMADA610_TIMERS);
+
+	/*
+	 * enable bus/functional clock, enable 6.5MHz (divider 4),
+	 * release reset
+	 */
+	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
+	__raw_writel(clk_rst, APBC_ARMADA610_TIMERS);
+
+	timer_init(IRQ_ARMADA610_TIMER1);
+}
+
+struct sys_timer armada610_timer = {
+	.init	= armada610_timer_init,
+};
+
-- 
1.5.6.5
