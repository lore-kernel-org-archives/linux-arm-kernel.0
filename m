From: joel@jms.id.au (Joel Stanley)
Date: Thu, 14 Apr 2016 19:17:48 +0930
Subject: [PATCH 8/9] arm: Add Aspeed AST2400 machine
In-Reply-To: <1460627269-21721-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
Message-ID: <1460627269-21721-9-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Apseed AST2400 is a common Baseboard Management Controller (BMC)
system on chip containing an ARM9 core, off-chip DDR RAM and support
for a large number of peripherals.

This patch dds basic support for the ast2400, capable of booting to a
prompt in QEMU (-M palmetto-bmc) or on an Palmetto OpenPower development
machine.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                    |   8 +++
 arch/arm/Kconfig               |   2 +
 arch/arm/Makefile              |   1 +
 arch/arm/mach-aspeed/Kconfig   |  19 +++++++
 arch/arm/mach-aspeed/Makefile  |   3 ++
 arch/arm/mach-aspeed/aspeed.c  |  80 ++++++++++++++++++++++++++++
 arch/arm/mach-aspeed/ast2400.h | 117 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 230 insertions(+)
 create mode 100644 arch/arm/mach-aspeed/Kconfig
 create mode 100644 arch/arm/mach-aspeed/Makefile
 create mode 100644 arch/arm/mach-aspeed/aspeed.c
 create mode 100644 arch/arm/mach-aspeed/ast2400.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 61a323a6b2cf..d0a1962f7753 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -975,6 +975,14 @@ F:	arch/arm/mach-artpec
 F:	arch/arm/boot/dts/artpec6*
 F:	drivers/clk/clk-artpec6.c
 
+ARM/ASPEED MACHINE SUPPORT
+M:	Joel Stanley <joel@jms.id.au>
+S:	Maintained
+F:	arch/arm/mach-aspeed/
+F:	arch/arm/boot/dts/aspeed-*
+F:	arch/arm/boot/dts/ast2400.dtsi
+F:	drivers/*/*aspeed*
+
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2b7626..c4512f6b77f6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -775,6 +775,8 @@ source "arch/arm/mach-meson/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
 
+source "arch/arm/mach-aspeed/Kconfig"
+
 source "arch/arm/mach-mv78xx0/Kconfig"
 
 source "arch/arm/mach-imx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8c3ce2ac44c4..8ab09fb78e1c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -184,6 +184,7 @@ machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
 machine-$(CONFIG_ARCH_MOXART)		+= moxart
+machine-$(CONFIG_ARCH_ASPEED)		+= aspeed
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
new file mode 100644
index 000000000000..9437015222b1
--- /dev/null
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -0,0 +1,19 @@
+menuconfig ARCH_ASPEED
+	bool "ASpeed BMC SoCs" if ARCH_MULTI_V5
+	select CPU_ARM926T
+	select OF
+	select SRAM
+	help
+	  Say Y here if you want to run your kernel on hardware with an
+	  ASpeed BMC SoC.
+
+if ARCH_ASPEED
+
+config MACH_OPP_PALMETTO_BMC
+	bool "OpenPower Palmetto"
+	depends on ARCH_ASPEED
+	help
+	  Say Y here if you intend to run this kernel on the BMC
+	  of an OpenPower "Palmetto" eval board
+
+endif
diff --git a/arch/arm/mach-aspeed/Makefile b/arch/arm/mach-aspeed/Makefile
new file mode 100644
index 000000000000..3a4f025dd520
--- /dev/null
+++ b/arch/arm/mach-aspeed/Makefile
@@ -0,0 +1,3 @@
+# Object file lists.
+
+obj-$(CONFIG_ARCH_ASPEED)	+= aspeed.o
diff --git a/arch/arm/mach-aspeed/aspeed.c b/arch/arm/mach-aspeed/aspeed.c
new file mode 100644
index 000000000000..25424cfd0b89
--- /dev/null
+++ b/arch/arm/mach-aspeed/aspeed.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright IBM Corporation 2016
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include "ast2400.h"
+
+static void __init aspeed_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+#define AST_IO_VA	0xf0000000
+#define AST_IO_PA	0x1e600000
+#define AST_IO_SZ	0x00200000
+
+#define AST_IO(__pa)	((void __iomem *)(((__pa) & 0x001fffff) | AST_IO_VA))
+
+static struct map_desc aspeed_io_desc[] __initdata __maybe_unused = {
+	{
+		.virtual	=  AST_IO_VA,
+		.pfn		= __phys_to_pfn(AST_IO_PA),
+		.length		= AST_IO_SZ,
+		.type		= MT_DEVICE
+	},
+};
+
+#define SCU_PASSWORD	0x1688A8A8
+
+static void __init aspeed_init_early(void)
+{
+	u32 reg;
+
+	/*
+	 * Unlock SCU
+	 */
+	writel(SCU_PASSWORD, AST_IO(AST_BASE_SCU));
+
+	/* We enable the UART clock divisor in the SCU's misc control
+	 * register, as the baud rates in aspeed.dtb all assume that the
+	 * divisor is active
+	 */
+	reg = readl(AST_IO(AST_BASE_SCU | 0x2c));
+	writel(reg | 0x00001000, AST_IO(AST_BASE_SCU | 0x2c));
+
+	/*
+	 * Disable the watchdogs
+	 */
+	writel(0, AST_IO(AST_BASE_WDT | 0x0c));
+	writel(0, AST_IO(AST_BASE_WDT | 0x2c));
+}
+
+static void __init aspeed_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(aspeed_io_desc, ARRAY_SIZE(aspeed_io_desc));
+}
+
+static const char *const aspeed_dt_match[] __initconst = {
+	"aspeed,ast2400",
+	NULL,
+};
+
+DT_MACHINE_START(aspeed_dt, "ASpeed SoC")
+	.map_io		= aspeed_map_io,
+	.init_early	= aspeed_init_early,
+	.init_machine	= aspeed_dt_init,
+	.dt_compat	= aspeed_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-aspeed/ast2400.h b/arch/arm/mach-aspeed/ast2400.h
new file mode 100644
index 000000000000..2f222163ee54
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2400.h
@@ -0,0 +1,117 @@
+/*
+ * Copyright 2016 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#ifndef AST2400_H
+#define AST2400_H
+
+/* Periperhal base addresses */
+#define AST_BASE_LEGACY_SRAM	0x10000000 /* Legacy BMC Static Memory */
+#define AST_BASE_LEGACY_SMC	0x16000000 /* Legacy BMC Static Memory Controller (SMC) */
+#define AST_BASE_APBC		0x1E600000 /* AHB Bus Controller (AHBC) */
+#define AST_BASE_FMC		0x1E620000 /* New BMC Static Memory Controller (FMC) */
+#define AST_BASE_SPI		0x1E630000 /* SPI Memory Controller */
+#define AST_BASE_MIC		0x1E640000 /* Memory Integrity Check Controller (MIC) */
+#define AST_BASE_MAC1		0x1E660000 /* Fast Ethernet MAC Controller #1 (MAC1) */
+#define AST_BASE_MAC2		0x1E680000 /* Fast Ethernet MAC Controller #2 (MAC2) */
+#define AST_BASE_USB2HUB	0x1E6A0000 /* USB2.0 Hub Controller */
+#define AST_BASE_USB2HC		0x1E6A1000 /* USB2.0 Host Controller */
+#define AST_BASE_USB1HC		0x1E6B0000 /* USB1.1 Host Controller */
+#define AST_BASE_VIC		0x1E6C0000 /* Interrupt Controller (VIC) */
+#define AST_BASE_MMC		0x1E6E0000 /* SDRAM Controller (MMC) */
+#define AST_BASE_USB1		0x1E6E1000 /* USB1.1 Controller */
+#define AST_BASE_SCU		0x1E6E2000 /* System Control Unit (SCU) */
+#define AST_BASE_HACE		0x1E6E3000 /* Hash & Crypto Engine (HACE) */
+#define AST_BASE_JTAG		0x1E6E4000 /* JTAG Master */
+#define AST_BASE_CRT		0x1E6E6000 /* Graphics Display Controller (CRT) */
+#define AST_BASE_DMA		0x1E6E7000 /* X-DMA Controller */
+#define AST_BASE_MCTP		0x1E6E8000 /* MCTP Controller */
+#define AST_BASE_ADC		0x1E6E9000 /* ADC Voltage Monitor */
+#define AST_BASE_LPCPLUS	0x1E6EC000 /* LPC+ Controller */
+#define AST_BASE_VIDEO		0x1E700000 /* Video Engine */
+#define AST_BASE_SRAM		0x1E720000 /* 32KB SRAM */
+#define AST_BASE_SDIO		0x1E740000 /* SD/SDIO Controller */
+#define AST_BASE_2D		0x1E760000 /* 2D Engine */
+#define AST_BASE_GPIO		0x1E780000 /* GPIO Controller */
+#define AST_BASE_RTC		0x1E781000 /* Real-Time Clock (RTC) */
+#define AST_BASE_TIMER		0x1E782000 /* Timer #1 ? #8 Controller */
+#define AST_BASE_UART1		0x1E783000 /* UART - #1 (LPC UART1) */
+#define AST_BASE_UART5		0x1E784000 /* UART - #5 (BMC Debug) */
+#define AST_BASE_WDT		0x1E785000 /* Watchdog Timer (WDT) */
+#define AST_BASE_PWM		0x1E786000 /* PWM & Fan Tacho Controller */
+#define AST_BASE_VUART		0x1E787000 /* Virtual UART (VUART) */
+#define AST_BASE_PUART		0x1E788000 /* Pass Through UART (PUART) */
+#define AST_BASE_LPC		0x1E789000 /* LPC Controller */
+#define AST_BASE_I2C		0x1E78A000 /* I2C/SMBus Controller */
+#define AST_BASE_PECI		0x1E78B000 /* PECI Controller */
+#define AST_BASE_UART2		0x1E78D000 /* UART - #2 (LPC UART2) */
+#define AST_BASE_UART3		0x1E78E000 /* UART - #3 */
+#define AST_BASE_UART4		0x1E78F000 /* UART - #4 */
+
+/* Memory */
+#define AST_BASE_BMCSRAM	0x20000000 /* BMC Static Memory */
+#define AST_BASE_SPIMEM		0x30000000 /* SPI Flash Memory */
+#define AST_BASE_SDRAM		0x40000000 /* SDRAM */
+#define AST_BASE_LPCBRIDGE	0x60000000 /* AHB Bus to LPC Bus Bridge */
+#define AST_BASE_LPCPBRIDGE	0x70000000 /* AHB Bus to LPC+ Bus Bridge */
+
+/* BMC interrupt sources */
+#define AST_ID_SDRAM		0	/* SDRAM interrupt */
+#define AST_ID_MIC		1	/* MIC interrupt */
+#define AST_ID_MAC1		2	/* MAC1 interrupt */
+#define AST_ID_MAC2		3	/* MAC2 interrupt */
+#define AST_ID_CRYPTO		4	/* Crypto interrupt */
+#define AST_ID_USB2		5	/* USB 2.0 Hub/Host interrupt */
+#define AST_ID_XDMA		6	/* X-DMA interrupt */
+#define AST_ID_VIDEO		7	/* Video Engine interrupt */
+#define AST_ID_LPC		8	/* LPC interrupt */
+#define AST_ID_UART1		9	/* UART1 interrupt */
+#define AST_ID_UART5		10	/* UART5 interrupt */
+#define AST_ID_11		11	/* Reserved */
+#define AST_ID_I2C		12	/* I2C/SMBus interrupt */
+#define AST_ID_USB1HID		13	/* USB 1.1 HID interrupt */
+#define AST_ID_USB1HOST		14	/* USB 1.1 Host interrupt */
+#define AST_ID_PECI		15	/* PECI interrupt */
+#define AST_ID_TIMER1		16	/* Timer 1 interrupt */
+#define AST_ID_TIMER2		17	/* Timer 2 interrupt */
+#define AST_ID_TIMER3		18	/* Timer 3 interrupt */
+#define AST_ID_SMC		19	/* SMC interrupt */
+#define AST_ID_GPIO		20	/* GPIO interrupt */
+#define AST_ID_SCU		21	/* SCU interrupt */
+#define AST_ID_RTC		22	/* RTC alarm interrupt */
+#define AST_ID_23		23	/* Reserved */
+#define AST_ID_24		24	/* Reserved */
+#define AST_ID_GRAPHICS		25	/* Graphics CRT interrupt */
+#define AST_ID_SDIO		26	/* SD/SDIO interrupt */
+#define AST_ID_WDT		27	/* WDT alarm interrupt */
+#define AST_ID_PWM		28	/* PWM/Tachometer interrupt */
+#define AST_ID_2D		29	/* Graphics 2D interrupt */
+#define AST_ID_WAKEUP		30	/* System Wakeup Control */
+#define AST_ID_ADC		31	/* ADC interrupt */
+#define AST_ID_UART2		32	/* UART2 interrupt */
+#define AST_ID_UART3		33	/* UART3 interrupt */
+#define AST_ID_UART4		34	/* UART4 interrupt */
+#define AST_ID_TIMER4		35	/* Timer 4 interrupt */
+#define AST_ID_TIMER5		36	/* Timer 5 interrupt */
+#define AST_ID_TIMER6		37	/* Timer 6 interrupt */
+#define AST_ID_TIMER38		38	/* Timer 7 interrupt */
+#define AST_ID_TIMER39		39	/* Timer 8 interrupt */
+#define AST_ID_SGPIOMASTER	40	/* SGPIO Master interrupt */
+#define AST_ID_SGPIOSLAVE	41	/* SGPIO Slave interrupt */
+#define AST_ID_MCTP		42	/* MCTP interrupt */
+#define AST_ID_JTAG		43	/* JTAG Master interrupt */
+#define AST_ID_44		44	/* Reserved */
+#define AST_ID_COPRO		45	/* Coprocessor interrupt */
+#define AST_ID_MAILBOX		46	/* MailBox interrupt */
+#define AST_ID_GPIOL1		47	/* GPIOL1 direct input */
+#define AST_ID_GPIOL3		48	/* GPIOL3 direct input */
+#define AST_ID_GPIOM1		49	/* GPIOM1 direct input */
+#define AST_ID_GPIOM3		50	/* GPIOM3 direct input */
+
+#endif /*AST2400_H*/
-- 
2.7.4
