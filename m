From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  9 Feb 2013 16:54:27 +0100
Subject: [PATCH 1/2] ARM: at91: create ebi read/write interface for RM9200
In-Reply-To: <1360425268-29060-1-git-send-email-manabian@gmail.com>
References: <1360425268-29060-1-git-send-email-manabian@gmail.com>
Message-ID: <1360425268-29060-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce ebi read/write functions on AT91RM9200 to make
it possible to have a common SDRAMC header and driver.

SDRAMC register layout is more or less the same on RM9200
and SAM926x. The only difference is the header file for
RM9200 uses a different offset on SDRAMC registers. The
offset used is actually for RM9200 MC.

By using the real base for SDRAMC on RM9200 header files
can be shared. With this change there are also no users
of ramc outside mach-at91.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi                  |  4 +-
 arch/arm/mach-at91/at91rm9200.c                    |  3 +-
 arch/arm/mach-at91/at91rm9200_devices.c            | 14 ++---
 arch/arm/mach-at91/board-eco920.c                  |  6 +--
 arch/arm/mach-at91/board-yl-9200.c                 |  4 +-
 arch/arm/mach-at91/generic.h                       |  3 ++
 arch/arm/mach-at91/include/mach/at91_ebi.h         | 20 +++++++
 arch/arm/mach-at91/include/mach/at91_ramc.h        |  1 -
 arch/arm/mach-at91/include/mach/at91rm9200.h       |  1 +
 .../arm/mach-at91/include/mach/at91rm9200_sdramc.h | 63 ----------------------
 arch/arm/mach-at91/include/mach/at91sam9_sdramc.h  |  2 +
 arch/arm/mach-at91/pm.c                            |  2 +-
 arch/arm/mach-at91/pm.h                            |  7 ++-
 arch/arm/mach-at91/setup.c                         | 10 ++++
 drivers/pcmcia/at91_cf.c                           |  6 +--
 15 files changed, 59 insertions(+), 87 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91_ebi.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 5d3ed5a..48dd97f 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -64,9 +64,9 @@
 				atmel,external-irqs = <25 26 27 28 29 30 31>;
 			};
 
-			ramc0: ramc at ffffff00 {
+			ramc0: ramc at ffffff90 {
 				compatible = "atmel,at91rm9200-sdramc";
-				reg = <0xffffff00 0x100>;
+				reg = <0xffffff90 0x30>;
 			};
 
 			pmc: pmc at fffffc00 {
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 36b05fc..c4c22d1 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -325,7 +325,8 @@ static void __init at91rm9200_map_io(void)
 static void __init at91rm9200_ioremap_registers(void)
 {
 	at91rm9200_ioremap_st(AT91RM9200_BASE_ST);
-	at91_ioremap_ramc(0, AT91RM9200_BASE_MC, 256);
+	at91_ioremap_ebi(AT91RM9200_BASE_MC, 144);
+	at91_ioremap_ramc(0, AT91RM9200_BASE_SDRAMC, 48);
 }
 
 static void __init at91rm9200_initialize(void)
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 3ebc979..a298707 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -20,7 +20,7 @@
 
 #include <mach/at91rm9200.h>
 #include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
+#include <mach/at91_ebi.h>
 
 #include "board.h"
 #include "generic.h"
@@ -242,15 +242,15 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 	data->chipselect = 4;		/* can only use EBI ChipSelect 4 */
 
 	/* CF takes over CS4, CS5, CS6 */
-	csa = at91_ramc_read(0, AT91_EBI_CSA);
-	at91_ramc_write(0, AT91_EBI_CSA, csa | AT91_EBI_CS4A_SMC_COMPACTFLASH);
+	csa = at91_ebi_read(AT91_EBI_CSA);
+	at91_ebi_write(AT91_EBI_CSA, csa | AT91_EBI_CS4A_SMC_COMPACTFLASH);
 
 	/*
 	 * Static memory controller timing adjustments.
 	 * REVISIT:  these timings are in terms of MCK cycles, so
 	 * when MCK changes (cpufreq etc) so must these values...
 	 */
-	at91_ramc_write(0, AT91_SMC_CSR(4),
+	at91_ebi_write(AT91_SMC_CSR(4),
 				  AT91_SMC_ACSS_STD
 				| AT91_SMC_DBW_16
 				| AT91_SMC_BAT
@@ -424,11 +424,11 @@ void __init at91_add_device_nand(struct atmel_nand_data *data)
 		return;
 
 	/* enable the address range of CS3 */
-	csa = at91_ramc_read(0, AT91_EBI_CSA);
-	at91_ramc_write(0, AT91_EBI_CSA, csa | AT91_EBI_CS3A_SMC_SMARTMEDIA);
+	csa = at91_ebi_read(AT91_EBI_CSA);
+	at91_ebi_write(AT91_EBI_CSA, csa | AT91_EBI_CS3A_SMC_SMARTMEDIA);
 
 	/* set the bus interface characteristics */
-	at91_ramc_write(0, AT91_SMC_CSR(3), AT91_SMC_ACSS_STD | AT91_SMC_DBW_8 | AT91_SMC_WSEN
+	at91_ebi_write(AT91_SMC_CSR(3), AT91_SMC_ACSS_STD | AT91_SMC_DBW_8 | AT91_SMC_WSEN
 		| AT91_SMC_NWS_(5)
 		| AT91_SMC_TDF_(1)
 		| AT91_SMC_RWSETUP_(0)	/* tDS Data Set up Time 30 - ns */
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 77de410..fbe9f7b 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -25,7 +25,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
+#include <mach/at91_ebi.h>
 #include <mach/cpu.h>
 
 #include "at91_aic.h"
@@ -123,7 +123,7 @@ static void __init eco920_board_init(void)
 	at91_add_device_mci(0, &eco920_mci0_data);
 	platform_device_register(&eco920_flash);
 
-	at91_ramc_write(0, AT91_SMC_CSR(7),	AT91_SMC_RWHOLD_(1)
+	at91_ebi_write(AT91_SMC_CSR(7),	AT91_SMC_RWHOLD_(1)
 				| AT91_SMC_RWSETUP_(1)
 				| AT91_SMC_DBW_8
 				| AT91_SMC_WSEN
@@ -135,7 +135,7 @@ static void __init eco920_board_init(void)
 	at91_set_deglitch(AT91_PIN_PA23, 1);
 
 /* Initialization of the Static Memory Controller for Chip Select 3 */
-	at91_ramc_write(0, AT91_SMC_CSR(3),
+	at91_ebi_write(AT91_SMC_CSR(3),
 		AT91_SMC_DBW_16  |	/* 16 bit */
 		AT91_SMC_WSEN    |
 		AT91_SMC_NWS_(5) |	/* wait states */
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index be08377..541ce1d 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -44,7 +44,7 @@
 
 #include <mach/hardware.h>
 #include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
+#include <mach/at91_ebi.h>
 #include <mach/cpu.h>
 
 #include "at91_aic.h"
@@ -377,7 +377,7 @@ static void yl9200_init_video(void)
 	at91_set_A_periph(AT91_PIN_PC6, 0);
 
 	/* Initialization of the Static Memory Controller for Chip Select 2 */
-	at91_ramc_write(0, AT91_SMC_CSR(2), AT91_SMC_DBW_16		/* 16 bit */
+	at91_ebi_write(AT91_SMC_CSR(2), AT91_SMC_DBW_16		/* 16 bit */
 			| AT91_SMC_WSEN | AT91_SMC_NWS_(0x4)	/* wait states */
 			| AT91_SMC_TDF_(0x100)			/* float time */
 	);
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 78ab065..3cced6b 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -69,6 +69,9 @@ extern void at91_ioremap_shdwc(u32 base_addr);
 /* Matrix */
 extern void at91_ioremap_matrix(u32 base_addr);
 
+/* EBI */
+extern void at91_ioremap_ebi(u32 addr, u32 size);
+
 /* Ram Controler */
 extern void at91_ioremap_ramc(int id, u32 addr, u32 size);
 
diff --git a/arch/arm/mach-at91/include/mach/at91_ebi.h b/arch/arm/mach-at91/include/mach/at91_ebi.h
new file mode 100644
index 0000000..4d400c0
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/at91_ebi.h
@@ -0,0 +1,20 @@
+/*
+ * Header file for the Atmel EBI Controller
+ *
+ * Copyright (C) 2012 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Under GPLv2 only
+ */
+
+#ifndef __AT91_EBI_H__
+#define __AT91_EBI_H__
+
+extern void __iomem *at91_ebi_base;
+
+#define at91_ebi_read(field) \
+	__raw_readl(at91_ebi_base + field)
+
+#define at91_ebi_write(field, value) \
+	__raw_writel(value, at91_ebi_base + field)
+
+#endif /* __AT91_EBI_H__ */
diff --git a/arch/arm/mach-at91/include/mach/at91_ramc.h b/arch/arm/mach-at91/include/mach/at91_ramc.h
index d8aeb27..038041d 100644
--- a/arch/arm/mach-at91/include/mach/at91_ramc.h
+++ b/arch/arm/mach-at91/include/mach/at91_ramc.h
@@ -25,7 +25,6 @@ extern void __iomem *at91_ramc_base[];
 #define AT91_MEMCTRL_SDRAMC	1
 #define AT91_MEMCTRL_DDRSDR	2
 
-#include <mach/at91rm9200_sdramc.h>
 #include <mach/at91sam9_ddrsdr.h>
 #include <mach/at91sam9_sdramc.h>
 
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index e67317c..cca1b96 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -87,6 +87,7 @@
 #define AT91RM9200_BASE_ST	0xfffffd00	/* System Timer */
 #define AT91RM9200_BASE_RTC	0xfffffe00	/* Real-Time Clock */
 #define AT91RM9200_BASE_MC	0xffffff00	/* Memory Controllers */
+#define AT91RM9200_BASE_SDRAMC	0xffffff90	/* SDRAM Controller */
 
 /*
  * Internal Memory.
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h b/arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h
deleted file mode 100644
index aa047f45..0000000
--- a/arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h
- *
- * Copyright (C) 2005 Ivan Kokshaysky
- * Copyright (C) SAN People
- *
- * Memory Controllers (SDRAMC only) - System peripherals registers.
- * Based on AT91RM9200 datasheet revision E.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef AT91RM9200_SDRAMC_H
-#define AT91RM9200_SDRAMC_H
-
-/* SDRAM Controller registers */
-#define AT91RM9200_SDRAMC_MR		0x90			/* Mode Register */
-#define		AT91RM9200_SDRAMC_MODE	(0xf << 0)		/* Command Mode */
-#define			AT91RM9200_SDRAMC_MODE_NORMAL		(0 << 0)
-#define			AT91RM9200_SDRAMC_MODE_NOP		(1 << 0)
-#define			AT91RM9200_SDRAMC_MODE_PRECHARGE	(2 << 0)
-#define			AT91RM9200_SDRAMC_MODE_LMR		(3 << 0)
-#define			AT91RM9200_SDRAMC_MODE_REFRESH	(4 << 0)
-#define		AT91RM9200_SDRAMC_DBW		(1   << 4)		/* Data Bus Width */
-#define			AT91RM9200_SDRAMC_DBW_32	(0 << 4)
-#define			AT91RM9200_SDRAMC_DBW_16	(1 << 4)
-
-#define AT91RM9200_SDRAMC_TR		0x94			/* Refresh Timer Register */
-#define		AT91RM9200_SDRAMC_COUNT	(0xfff << 0)		/* Refresh Timer Count */
-
-#define AT91RM9200_SDRAMC_CR		0x98			/* Configuration Register */
-#define		AT91RM9200_SDRAMC_NC		(3   <<  0)		/* Number of Column Bits */
-#define			AT91RM9200_SDRAMC_NC_8	(0 << 0)
-#define			AT91RM9200_SDRAMC_NC_9	(1 << 0)
-#define			AT91RM9200_SDRAMC_NC_10	(2 << 0)
-#define			AT91RM9200_SDRAMC_NC_11	(3 << 0)
-#define		AT91RM9200_SDRAMC_NR		(3   <<  2)		/* Number of Row Bits */
-#define			AT91RM9200_SDRAMC_NR_11	(0 << 2)
-#define			AT91RM9200_SDRAMC_NR_12	(1 << 2)
-#define			AT91RM9200_SDRAMC_NR_13	(2 << 2)
-#define		AT91RM9200_SDRAMC_NB		(1   <<  4)		/* Number of Banks */
-#define			AT91RM9200_SDRAMC_NB_2	(0 << 4)
-#define			AT91RM9200_SDRAMC_NB_4	(1 << 4)
-#define		AT91RM9200_SDRAMC_CAS		(3   <<  5)		/* CAS Latency */
-#define			AT91RM9200_SDRAMC_CAS_2	(2 << 5)
-#define		AT91RM9200_SDRAMC_TWR		(0xf <<  7)		/* Write Recovery Delay */
-#define		AT91RM9200_SDRAMC_TRC		(0xf << 11)		/* Row Cycle Delay */
-#define		AT91RM9200_SDRAMC_TRP		(0xf << 15)		/* Row Precharge Delay */
-#define		AT91RM9200_SDRAMC_TRCD	(0xf << 19)		/* Row to Column Delay */
-#define		AT91RM9200_SDRAMC_TRAS	(0xf << 23)		/* Active to Precharge Delay */
-#define		AT91RM9200_SDRAMC_TXSR	(0xf << 27)		/* Exit Self Refresh to Active Delay */
-
-#define AT91RM9200_SDRAMC_SRR		0x9c			/* Self Refresh Register */
-#define AT91RM9200_SDRAMC_LPR		0xa0			/* Low Power Register */
-#define AT91RM9200_SDRAMC_IER		0xa4			/* Interrupt Enable Register */
-#define AT91RM9200_SDRAMC_IDR		0xa8			/* Interrupt Disable Register */
-#define AT91RM9200_SDRAMC_IMR		0xac			/* Interrupt Mask Register */
-#define AT91RM9200_SDRAMC_ISR		0xb0			/* Interrupt Status Register */
-
-#endif
diff --git a/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h b/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h
index 3d085a9..e45aff7 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_sdramc.h
@@ -57,6 +57,8 @@
 #define		AT91_SDRAMC_TRAS	(0xf << 24)		/* Active to Precharge Delay */
 #define		AT91_SDRAMC_TXSR	(0xf << 28)		/* Exit Self Refresh to Active Delay */
 
+#define AT91_SDRAMC_SRR		0x0c	/* SDRAM Controller Self Refresh Register AT91RM9200 only */
+
 #define AT91_SDRAMC_LPR		0x10	/* SDRAM Controller Low Power Register */
 #define		AT91_SDRAMC_LPCB		(3 << 0)	/* Low-power Configurations */
 #define			AT91_SDRAMC_LPCB_DISABLE		0
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index adb6db8..5ba38e5 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -316,7 +316,7 @@ static int __init at91_pm_init(void)
 
 	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refresh. */
 	if (cpu_is_at91rm9200())
-		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
+		at91_ramc_write(0, AT91_SDRAMC_LPR, 0);
 
 	suspend_set_ops(&at91_pm_ops);
 
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 38f467c..c5dd8dc 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -12,7 +12,6 @@
 #define __ARCH_ARM_MACH_AT91_PM
 
 #include <mach/at91_ramc.h>
-#include <mach/at91rm9200_sdramc.h>
 
 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
@@ -26,7 +25,7 @@
 
 static inline void at91rm9200_standby(void)
 {
-	u32 lpr = at91_ramc_read(0, AT91RM9200_SDRAMC_LPR);
+	u32 lpr = at91_ramc_read(0, AT91_SDRAMC_LPR);
 
 	asm volatile(
 		"b    1f\n\t"
@@ -37,8 +36,8 @@ static inline void at91rm9200_standby(void)
 		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
 		"    str    %5, [%1, %2]"
 		:
-		: "r" (0), "r" (AT91_BASE_SYS), "r" (AT91RM9200_SDRAMC_LPR),
-		  "r" (1), "r" (AT91RM9200_SDRAMC_SRR),
+		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91_SDRAMC_LPR),
+		  "r" (1), "r" (AT91_SDRAMC_SRR),
 		  "r" (lpr));
 }
 
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 4b67847..10d5b2f 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -54,6 +54,16 @@ void __init at91_init_interrupts(unsigned int *priority)
 	at91_gpio_irq_setup();
 }
 
+void __iomem *at91_ebi_base;
+EXPORT_SYMBOL_GPL(at91_ebi_base);
+
+void __init at91_ioremap_ebi(u32 addr, u32 size)
+{
+	at91_ebi_base = ioremap(addr, size);
+	if (!at91_ebi_base)
+		panic("Impossible to ioremap ebi. 0x%x\n", addr);
+}
+
 void __iomem *at91_ramc_base[2];
 EXPORT_SYMBOL_GPL(at91_ramc_base);
 
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 01463c7..d9d696f 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -26,7 +26,7 @@
 #include <asm/sizes.h>
 
 #include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
+#include <mach/at91_ebi.h>
 
 
 /*
@@ -157,7 +157,7 @@ static int at91_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
 	/*
 	 * Use 16 bit accesses unless/until we need 8-bit i/o space.
 	 */
-	csr = at91_ramc_read(0, AT91_SMC_CSR(cf->board->chipselect)) & ~AT91_SMC_DBW;
+	csr = at91_ebi_read(AT91_SMC_CSR(cf->board->chipselect)) & ~AT91_SMC_DBW;
 
 	/*
 	 * NOTE: this CF controller ignores IOIS16, so we can't really do
@@ -176,7 +176,7 @@ static int at91_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
 		csr |= AT91_SMC_DBW_16;
 		pr_debug("%s: 16bit i/o bus\n", driver_name);
 	}
-	at91_ramc_write(0, AT91_SMC_CSR(cf->board->chipselect), csr);
+	at91_ebi_write(AT91_SMC_CSR(cf->board->chipselect), csr);
 
 	io->start = cf->socket.io_offset;
 	io->stop = io->start + SZ_2K - 1;
-- 
1.8.0
