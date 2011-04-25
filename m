From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:40:48 +0200
Subject: [PATCH 11/14] at91: move pit timer to drivers/clocksource
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756851-29442-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 MAINTAINERS                                        |    1 +
 arch/arm/mach-at91/Kconfig                         |    4 ++++
 arch/arm/mach-at91/Makefile                        |   18 +++++++++---------
 arch/arm/mach-at91/include/mach/at91_st.h          |   20 ++++++++++----------
 drivers/clocksource/Makefile                       |    1 +
 .../clocksource/at91_pit.c                         |    0
 6 files changed, 25 insertions(+), 19 deletions(-)
 rename arch/arm/mach-at91/at91sam926x_time.c => drivers/clocksource/at91_pit.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30ba179..c026709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -655,6 +655,7 @@ W:	http://www.linux4sam.org
 S:	Supported
 F:	arch/arm/mach-at91/
 F:	drivers/gpio/at91_gpio.c
+F:	drivers/clocksource/at91_*
 
 ARM/BCMRING ARM ARCHITECTURE
 M:	Jiandong Zheng <jdzheng@broadcom.com>
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 8cbc3aa..2663dea 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -97,6 +97,10 @@ config AT91_PMC_UNIT
 	bool
 	default !ARCH_AT91X40
 
+config AT91_PIT
+	bool
+	default !ARCH_AT91X40 && !ARCH_AT91RM9200
+
 # ----------------------------------------------------------
 
 if ARCH_AT91RM9200
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 6aa38f9..39f44d1 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -11,15 +11,15 @@ obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o
 
 # CPU-specific support
 obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o at91rm9200_devices.o
-obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9G10)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91sam9263.o at91sam926x_time.o at91sam9263_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
-obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
-obj-$(CONFIG_ARCH_AT572D940HF)  += at572d940hf.o at91sam926x_time.o at572d940hf_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9G10)	+= at91sam9261.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91sam9263.o at91sam9263_devices.o sam9_smc.o at91sam9_alt_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam9rl_devices.o sam9_smc.o at91sam9_alt_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam9g45_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91cap9_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT572D940HF)  += at572d940hf.o at572d940hf_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 
 # AT91RM9200 board-specific support
diff --git a/arch/arm/mach-at91/include/mach/at91_st.h b/arch/arm/mach-at91/include/mach/at91_st.h
index 8847173..958023f 100644
--- a/arch/arm/mach-at91/include/mach/at91_st.h
+++ b/arch/arm/mach-at91/include/mach/at91_st.h
@@ -16,34 +16,34 @@
 #ifndef AT91_ST_H
 #define AT91_ST_H
 
-#define	AT91_ST_CR		(AT91_ST + 0x00)	/* Control Register */
+#define	AT91_ST_CR		(0x00)			/* Control Register */
 #define 	AT91_ST_WDRST		(1 << 0)		/* Watchdog Timer Restart */
 
-#define	AT91_ST_PIMR		(AT91_ST + 0x04)	/* Period Interval Mode Register */
+#define	AT91_ST_PIMR		(0x04)			/* Period Interval Mode Register */
 #define		AT91_ST_PIV		(0xffff <<  0)		/* Period Interval Value */
 
-#define	AT91_ST_WDMR		(AT91_ST + 0x08)	/* Watchdog Mode Register */
+#define	AT91_ST_WDMR		(0x08)			/* Watchdog Mode Register */
 #define		AT91_ST_WDV		(0xffff <<  0)		/* Watchdog Counter Value */
 #define		AT91_ST_RSTEN		(1	<< 16)		/* Reset Enable */
 #define		AT91_ST_EXTEN		(1	<< 17)		/* External Signal Assertion Enable */
 
-#define	AT91_ST_RTMR		(AT91_ST + 0x0c)	/* Real-time Mode Register */
+#define	AT91_ST_RTMR		(0x0c)			/* Real-time Mode Register */
 #define		AT91_ST_RTPRES		(0xffff <<  0)		/* Real-time Prescalar Value */
 
-#define	AT91_ST_SR		(AT91_ST + 0x10)	/* Status Register */
+#define	AT91_ST_SR		(0x10)			/* Status Register */
 #define		AT91_ST_PITS		(1 << 0)		/* Period Interval Timer Status */
 #define		AT91_ST_WDOVF		(1 << 1) 		/* Watchdog Overflow */
 #define		AT91_ST_RTTINC		(1 << 2) 		/* Real-time Timer Increment */
 #define		AT91_ST_ALMS		(1 << 3) 		/* Alarm Status */
 
-#define	AT91_ST_IER		(AT91_ST + 0x14)	/* Interrupt Enable Register */
-#define	AT91_ST_IDR		(AT91_ST + 0x18)	/* Interrupt Disable Register */
-#define	AT91_ST_IMR		(AT91_ST + 0x1c)	/* Interrupt Mask Register */
+#define	AT91_ST_IER		(0x14)			/* Interrupt Enable Register */
+#define	AT91_ST_IDR		(0x18)			/* Interrupt Disable Register */
+#define	AT91_ST_IMR		(0x1c)			/* Interrupt Mask Register */
 
-#define	AT91_ST_RTAR		(AT91_ST + 0x20)	/* Real-time Alarm Register */
+#define	AT91_ST_RTAR		(0x20)			/* Real-time Alarm Register */
 #define		AT91_ST_ALMV		(0xfffff << 0)		/* Alarm Value */
 
-#define	AT91_ST_CRTR		(AT91_ST + 0x24)	/* Current Real-time Register */
+#define	AT91_ST_CRTR		(0x24)			/* Current Real-time Register */
 #define		AT91_ST_CRTV		(0xfffff << 0)		/* Current Real-Time Value */
 
 #endif
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be61ece..93556cd 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_AT91_PIT)		+= at91_pit.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclone.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/drivers/clocksource/at91_pit.c
similarity index 100%
rename from arch/arm/mach-at91/at91sam926x_time.c
rename to drivers/clocksource/at91_pit.c
-- 
1.7.4.1
