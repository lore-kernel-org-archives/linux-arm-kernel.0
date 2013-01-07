From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:57:07 +0100
Subject: [PATCH 11/11] ARM: nomadik: get rid of <mach/hardware.h>
Message-ID: <1357599427-7691-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was only used from the core machine, source it into the machine
file and delete, also convert all direct references using the
physical-to-virtual macros in this file to ioremap() and only
default-remap the 4K used by the debug UART.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/cpu-8815.c                | 67 ++++++++++++++----
 arch/arm/mach-nomadik/include/mach/hardware.h   | 90 -------------------------
 arch/arm/mach-nomadik/include/mach/irqs.h       |  2 -
 arch/arm/mach-nomadik/include/mach/uncompress.h |  1 -
 4 files changed, 55 insertions(+), 105 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/include/mach/hardware.h

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index b661b90..30a4cf2 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -37,7 +37,6 @@
 #include <linux/gpio.h>
 #include <linux/amba/mmci.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -48,6 +47,51 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 
+/*
+ * These are the only hard-coded address offsets we still have to use.
+ */
+#define NOMADIK_FSMC_BASE	0x10100000	/* FSMC registers */
+#define NOMADIK_SDRAMC_BASE	0x10110000	/* SDRAM Controller */
+#define NOMADIK_CLCDC_BASE	0x10120000	/* CLCD Controller */
+#define NOMADIK_MDIF_BASE	0x10120000	/* MDIF */
+#define NOMADIK_DMA0_BASE	0x10130000	/* DMA0 Controller */
+#define NOMADIK_IC_BASE		0x10140000	/* Vectored Irq Controller */
+#define NOMADIK_DMA1_BASE	0x10150000	/* DMA1 Controller */
+#define NOMADIK_USB_BASE	0x10170000	/* USB-OTG conf reg base */
+#define NOMADIK_CRYP_BASE	0x10180000	/* Crypto processor */
+#define NOMADIK_SHA1_BASE	0x10190000	/* SHA-1 Processor */
+#define NOMADIK_XTI_BASE	0x101A0000	/* XTI */
+#define NOMADIK_RNG_BASE	0x101B0000	/* Random number generator */
+#define NOMADIK_SRC_BASE	0x101E0000	/* SRC base */
+#define NOMADIK_WDOG_BASE	0x101E1000	/* Watchdog */
+#define NOMADIK_MTU0_BASE	0x101E2000	/* Multiple Timer 0 */
+#define NOMADIK_MTU1_BASE	0x101E3000	/* Multiple Timer 1 */
+#define NOMADIK_GPIO0_BASE	0x101E4000	/* GPIO0 */
+#define NOMADIK_GPIO1_BASE	0x101E5000	/* GPIO1 */
+#define NOMADIK_GPIO2_BASE	0x101E6000	/* GPIO2 */
+#define NOMADIK_GPIO3_BASE	0x101E7000	/* GPIO3 */
+#define NOMADIK_RTC_BASE	0x101E8000	/* Real Time Clock base */
+#define NOMADIK_PMU_BASE	0x101E9000	/* Power Management Unit */
+#define NOMADIK_OWM_BASE	0x101EA000	/* One wire master */
+#define NOMADIK_SCR_BASE	0x101EF000	/* Secure Control registers */
+#define NOMADIK_MSP2_BASE	0x101F0000	/* MSP 2 interface */
+#define NOMADIK_MSP1_BASE	0x101F1000	/* MSP 1 interface */
+#define NOMADIK_UART2_BASE	0x101F2000	/* UART 2 interface */
+#define NOMADIK_SSIRx_BASE	0x101F3000	/* SSI 8-ch rx interface */
+#define NOMADIK_SSITx_BASE	0x101F4000	/* SSI 8-ch tx interface */
+#define NOMADIK_MSHC_BASE	0x101F5000	/* Memory Stick(Pro) Host */
+#define NOMADIK_SDI_BASE	0x101F6000	/* SD-card/MM-Card */
+#define NOMADIK_I2C1_BASE	0x101F7000	/* I2C1 interface */
+#define NOMADIK_I2C0_BASE	0x101F8000	/* I2C0 interface */
+#define NOMADIK_MSP0_BASE	0x101F9000	/* MSP 0 interface */
+#define NOMADIK_FIRDA_BASE	0x101FA000	/* FIrDA interface */
+#define NOMADIK_UART1_BASE	0x101FB000	/* UART 1 interface */
+#define NOMADIK_SSP_BASE	0x101FC000	/* SSP interface */
+#define NOMADIK_UART0_BASE	0x101FD000	/* UART 0 interface */
+#define NOMADIK_SGA_BASE	0x101FE000	/* SGA interface */
+#define NOMADIK_L2CC_BASE	0x10210000	/* L2 Cache controller */
+#define NOMADIK_UART1_VBASE	0xF01FB000
+
 static unsigned long out_low[] = { PIN_OUTPUT_LOW };
 static unsigned long out_high[] = { PIN_OUTPUT_HIGH };
 static unsigned long in_nopull[] = { PIN_INPUT_NOPULL };
@@ -90,30 +134,29 @@ static struct pinctrl_map __initdata nhk8815_pinmap[] = {
 	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO74_C20", in_pullup),
 };
 
-/* All SoC devices live in the same area (see hardware.h) */
-static struct map_desc nomadik_io_desc[] __initdata = {
+/* This is needed for LL-debug/earlyprintk/debug-macro.S */
+static struct map_desc cpu8815_io_desc[] __initdata = {
 	{
-		.virtual =	NOMADIK_IO_VIRTUAL,
-		.pfn =		__phys_to_pfn(NOMADIK_IO_PHYSICAL),
-		.length =	NOMADIK_IO_SIZE,
-		.type = 	MT_DEVICE,
-	}
-	/* static ram and secured ram may be added later */
+		.virtual =	NOMADIK_UART1_VBASE,
+		.pfn =		__phys_to_pfn(NOMADIK_UART1_BASE),
+		.length =	SZ_4K,
+		.type =		MT_DEVICE,
+	},
 };
 
 static void __init cpu8815_map_io(void)
 {
-	iotable_init(nomadik_io_desc, ARRAY_SIZE(nomadik_io_desc));
+	iotable_init(cpu8815_io_desc, ARRAY_SIZE(cpu8815_io_desc));
 }
 
 static void cpu8815_restart(char mode, const char *cmd)
 {
-	void __iomem *src_rstsr = io_p2v(NOMADIK_SRC_BASE + 0x18);
+	void __iomem *srcbase = ioremap(NOMADIK_SRC_BASE, SZ_4K);
 
 	/* FIXME: use egpio when implemented */
 
 	/* Write anything to Reset status register */
-	writel(1, src_rstsr);
+	writel(1, srcbase + 0x18);
 }
 
 /* Lookup table for finding a DT node that represents the vic instance */
diff --git a/arch/arm/mach-nomadik/include/mach/hardware.h b/arch/arm/mach-nomadik/include/mach/hardware.h
deleted file mode 100644
index 02035e4..0000000
--- a/arch/arm/mach-nomadik/include/mach/hardware.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * This file contains the hardware definitions of the Nomadik.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * YOU should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-/* Nomadik registers live from 0x1000.0000 to 0x1023.0000 -- currently */
-#define NOMADIK_IO_VIRTUAL	0xF0000000	/* VA of IO  */
-#define NOMADIK_IO_PHYSICAL	0x10000000	/* PA of IO */
-#define NOMADIK_IO_SIZE		0x00300000	/* 3MB for all regs */
-
-/* used in C code, so cast to proper type */
-#define io_p2v(x) ((void __iomem *)(x) \
-			- NOMADIK_IO_PHYSICAL + NOMADIK_IO_VIRTUAL)
-#define io_v2p(x) ((unsigned long)(x) \
-			- NOMADIK_IO_VIRTUAL + NOMADIK_IO_PHYSICAL)
-
-/* used in asm code, so no casts */
-#define IO_ADDRESS(x) IOMEM((x) - NOMADIK_IO_PHYSICAL + NOMADIK_IO_VIRTUAL)
-
-/*
- *   Base address defination for Nomadik Onchip Logic Block
- */
-#define NOMADIK_FSMC_BASE	0x10100000	/* FSMC registers */
-#define NOMADIK_SDRAMC_BASE	0x10110000	/* SDRAM Controller */
-#define NOMADIK_CLCDC_BASE	0x10120000	/* CLCD Controller */
-#define NOMADIK_MDIF_BASE	0x10120000	/* MDIF */
-#define NOMADIK_DMA0_BASE	0x10130000	/* DMA0 Controller */
-#define NOMADIK_IC_BASE		0x10140000	/* Vectored Irq Controller */
-#define NOMADIK_DMA1_BASE	0x10150000	/* DMA1 Controller */
-#define NOMADIK_USB_BASE	0x10170000	/* USB-OTG conf reg base */
-#define NOMADIK_CRYP_BASE	0x10180000	/* Crypto processor */
-#define NOMADIK_SHA1_BASE	0x10190000	/* SHA-1 Processor */
-#define NOMADIK_XTI_BASE	0x101A0000	/* XTI */
-#define NOMADIK_RNG_BASE	0x101B0000	/* Random number generator */
-#define NOMADIK_SRC_BASE	0x101E0000	/* SRC base */
-#define NOMADIK_WDOG_BASE	0x101E1000	/* Watchdog */
-#define NOMADIK_MTU0_BASE	0x101E2000	/* Multiple Timer 0 */
-#define NOMADIK_MTU1_BASE	0x101E3000	/* Multiple Timer 1 */
-#define NOMADIK_GPIO0_BASE	0x101E4000	/* GPIO0 */
-#define NOMADIK_GPIO1_BASE	0x101E5000	/* GPIO1 */
-#define NOMADIK_GPIO2_BASE	0x101E6000	/* GPIO2 */
-#define NOMADIK_GPIO3_BASE	0x101E7000	/* GPIO3 */
-#define NOMADIK_RTC_BASE	0x101E8000	/* Real Time Clock base */
-#define NOMADIK_PMU_BASE	0x101E9000	/* Power Management Unit */
-#define NOMADIK_OWM_BASE	0x101EA000	/* One wire master */
-#define NOMADIK_SCR_BASE	0x101EF000	/* Secure Control registers */
-#define NOMADIK_MSP2_BASE	0x101F0000	/* MSP 2 interface */
-#define NOMADIK_MSP1_BASE	0x101F1000	/* MSP 1 interface */
-#define NOMADIK_UART2_BASE	0x101F2000	/* UART 2 interface */
-#define NOMADIK_SSIRx_BASE	0x101F3000	/* SSI 8-ch rx interface */
-#define NOMADIK_SSITx_BASE	0x101F4000	/* SSI 8-ch tx interface */
-#define NOMADIK_MSHC_BASE	0x101F5000	/* Memory Stick(Pro) Host */
-#define NOMADIK_SDI_BASE	0x101F6000	/* SD-card/MM-Card */
-#define NOMADIK_I2C1_BASE	0x101F7000	/* I2C1 interface */
-#define NOMADIK_I2C0_BASE	0x101F8000	/* I2C0 interface */
-#define NOMADIK_MSP0_BASE	0x101F9000	/* MSP 0 interface  */
-#define NOMADIK_FIRDA_BASE	0x101FA000	/* FIrDA interface  */
-#define NOMADIK_UART1_BASE	0x101FB000	/* UART 1 interface */
-#define NOMADIK_SSP_BASE	0x101FC000	/* SSP interface  */
-#define NOMADIK_UART0_BASE	0x101FD000	/* UART 0 interface */
-#define NOMADIK_SGA_BASE	0x101FE000	/* SGA interface */
-#define NOMADIK_L2CC_BASE	0x10210000	/* L2 Cache controller */
-
-/* Other ranges, not for p2v/v2p */
-#define NOMADIK_BACKUP_RAM	0x80010000
-#define NOMADIK_EBROM		0x80000000	/* Embedded boot ROM */
-#define NOMADIK_HAMACV_DMEM_BASE 0xA0100000	/* HAMACV Data Memory Start */
-#define NOMADIK_HAMACV_DMEM_END	0xA01FFFFF	/* HAMACV Data Memory End */
-#define NOMADIK_HAMACA_DMEM	0xA0200000	/* HAMACA Data Memory Space */
-
-#define NOMADIK_FSMC_VA		IO_ADDRESS(NOMADIK_FSMC_BASE)
-#define NOMADIK_MTU0_VA		IO_ADDRESS(NOMADIK_MTU0_BASE)
-#define NOMADIK_MTU1_VA		IO_ADDRESS(NOMADIK_MTU1_BASE)
-
-#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-nomadik/include/mach/irqs.h b/arch/arm/mach-nomadik/include/mach/irqs.h
index 215f8cd..90ac965 100644
--- a/arch/arm/mach-nomadik/include/mach/irqs.h
+++ b/arch/arm/mach-nomadik/include/mach/irqs.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
 
-#include <mach/hardware.h>
-
 #define IRQ_VIC_START		32	/* first VIC interrupt is 1 */
 
 /*
diff --git a/arch/arm/mach-nomadik/include/mach/uncompress.h b/arch/arm/mach-nomadik/include/mach/uncompress.h
index 7d4687e..f793ace 100644
--- a/arch/arm/mach-nomadik/include/mach/uncompress.h
+++ b/arch/arm/mach-nomadik/include/mach/uncompress.h
@@ -21,7 +21,6 @@
 
 #include <asm/setup.h>
 #include <asm/io.h>
-#include <mach/hardware.h>
 
 /* we need the constants in amba/serial.h, but it refers to amba_device */
 struct amba_device;
-- 
1.7.11.7
