From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 16:11:54 +0100
Subject: [PATCH v2 7/9] lpc2k: Add EmbeddedArtists LPC2478 Developer's Kit
	board
In-Reply-To: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300461116-6028-8-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for EmbeddedArtists LPC2478 Developer's Kit, consisting
of the LPC2478OEM board, with QVGA base board. For details, see:

http://www.embeddedartists.com/products/kits/lpc2478_kit.php

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
changes since v1:
	* Fixed RTC clock rate
	* Marked mfp_cfgs as __initdata.
	* renamed LPC2478OEM to more appropriate EA2478DEVKIT.

since the machine ID was not used anywhere yet, this rename is
harmless.
---
 arch/arm/mach-lpc2k/Kconfig             |    7 ++
 arch/arm/mach-lpc2k/Makefile            |    2 +
 arch/arm/mach-lpc2k/common.h            |   21 ++++++
 arch/arm/mach-lpc2k/mach-ea2478devkit.c |  121 +++++++++++++++++++++++++++++++
 arch/arm/tools/mach-types               |    2 +-
 5 files changed, 152 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/common.h
 create mode 100644 arch/arm/mach-lpc2k/mach-ea2478devkit.c

diff --git a/arch/arm/mach-lpc2k/Kconfig b/arch/arm/mach-lpc2k/Kconfig
index fad47b8..210b641 100644
--- a/arch/arm/mach-lpc2k/Kconfig
+++ b/arch/arm/mach-lpc2k/Kconfig
@@ -2,4 +2,11 @@ if ARCH_LPC2K
 
 comment "LPC2K machines"
 
+config MACH_EA2478DEVKIT
+	bool "Embedded Artists LPC2478 Developer's Kit"
+	help
+	  Say Y if you want the kernel to support the EmbeddedArtists
+	  LPC2478 Developer's Kit. For more hardware details, see:
+	  http://www.embeddedartists.com/products/kits/lpc2478_kit.php
+
 endif
diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
index 2c50bb9..93e27fb 100644
--- a/arch/arm/mach-lpc2k/Makefile
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -1 +1,3 @@
 obj-y	:= clock.o irq.o gpio.o mfp.o time.o
+
+obj-$(CONFIG_MACH_EA2478DEVKIT) += mach-ea2478devkit.o
diff --git a/arch/arm/mach-lpc2k/common.h b/arch/arm/mach-lpc2k/common.h
new file mode 100644
index 0000000..6b775d9
--- /dev/null
+++ b/arch/arm/mach-lpc2k/common.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef LPC2K_COMMON_H
+#define LPC2K_COMMON_H
+
+struct sys_timer;
+
+extern void lpc2k_init_clocks(unsigned long xtal, unsigned long rtc);
+extern void lpc2k_mfp_config(unsigned long *mfp_cfgs, int num);
+extern void lpc2k_init_irq(void);
+
+extern struct sys_timer lpc2k_timer;
+
+#endif /* LPC2K_COMMON_H */
diff --git a/arch/arm/mach-lpc2k/mach-ea2478devkit.c b/arch/arm/mach-lpc2k/mach-ea2478devkit.c
new file mode 100644
index 0000000..bc9c980
--- /dev/null
+++ b/arch/arm/mach-lpc2k/mach-ea2478devkit.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (C) 2011 Team Embeded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <mach/mfp-lpc24xx.h>
+#include <mach/hardware.h>
+
+#include "common.h"
+
+#define EXTPOLAR	0x14c
+
+static unsigned long mfp_cfgs[] __initdata = {
+	/* UART0 */
+	GPIO2_TXD0,
+	GPIO3_RXD0,
+	/* USB Host */
+	GPIO12_USB_PPWR2,
+	GPIO13_USB_UP_LED2,
+	GPIO31_USB_Dp2,
+	GPIO62_VBUS,
+	GPIO63_USB_OVRCR2,
+	/* USB Gadget */
+	GPIO29_USB_Dp1,
+	GPIO30_USB_Dn1,
+	/* Ethernet */
+	GPIO32_ENET_TXD0,
+	GPIO33_ENET_TXD1,
+	GPIO36_ENET_TX_EN,
+	GPIO40_ENET_CRS,
+	GPIO41_ENET_RXD0,
+	GPIO42_ENET_RXD1,
+	GPIO46_ENET_RX_ERR,
+	GPIO47_ENET_REF_CLK,
+	GPIO48_ENET_MDC,
+	GPIO49_ENET_MDIO,
+	/* I2C0 */
+	GPIO27_SDA0,
+	GPIO28_SCL0,
+	/* SPI */
+	GPIO15_SCK,
+	GPIO17_MISO,
+	GPIO18_MOSI,
+	/* LCD */
+	GPIO4_LCDVD0,
+	GPIO5_LCDVD1,
+	GPIO6_LCDVD8,
+	GPIO7_LCDVD9,
+	GPIO8_LCDVD16,
+	GPIO9_LCDVD17,
+	GPIO52_LCDVD10,
+	GPIO53_LCDVD11,
+	GPIO54_LCDVD12,
+	GPIO55_LCDVD13,
+	GPIO56_LCDVD14,
+	GPIO57_LCDVD15,
+	GPIO58_LCDVD20,
+	GPIO59_LCDVD21,
+	GPIO60_LCDVD22,
+	GPIO61_LCDVD23,
+	GPIO64_LCDPWR,
+	GPIO65_LCDLE,
+	GPIO66_LCDDCLK,
+	GPIO67_LCDFP,
+	GPIO68_LCDM,
+	GPIO69_LCDLP,
+	GPIO70_LCDVP4,
+	GPIO71_LCDVP5,
+	GPIO72_LCDVP6,
+	GPIO73_LCDVP7,
+	GPIO75_LCDCLKIN,
+	GPIO76_LCDVP18,
+	GPIO77_LCDVP19,
+	GPIO156_LCDVP2,
+	GPIO157_LCDVP3,
+	/* Backlight */
+	GPIO50_PWM1,
+	/* MMC/SD */
+	GPIO34_MCICLK,
+	GPIO35_MCICMD,
+	GPIO37_MCIPWR,
+	GPIO38_MCIDAT0,
+	GPIO39_MCIDAT1,
+	GPIO43_MCIDAT2,
+	GPIO44_MCIDAT3,
+};
+
+void __init ea2478devkit_init_machine(void)
+{
+	lpc2k_mfp_config(mfp_cfgs, ARRAY_SIZE(mfp_cfgs));
+}
+
+static void __init ea2478devkit_init_irq(void)
+{
+	/* XXX workaround for the fact that EINT3 is connected to high-active
+	 * signal, but can't be disabled. As the EINT3 interrupt is also used
+	 * for GPIO interrupts, this will cause an interrupt storm without
+	 * this setting.
+	 */
+	iowrite32(ioread32(APB_SCB_BASE + EXTPOLAR) | (1 << 3),
+		APB_SCB_BASE + EXTPOLAR);
+
+	lpc2k_init_irq();
+	lpc2k_init_clocks(12000000UL, 32768UL);
+}
+
+MACHINE_START(EA2478DEVKIT, "Embedded Artists LPC2478 Developer's Kit")
+	.init_irq	= ea2478devkit_init_irq,
+	.timer		= &lpc2k_timer,
+	.init_machine	= ea2478devkit_init_machine,
+MACHINE_END
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 9d6feaa..570a990 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -2667,7 +2667,7 @@ msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
 micro2440		MACH_MICRO2440		MICRO2440		2680
 am2440			MACH_AM2440		AM2440			2681
 tq2440			MACH_TQ2440		TQ2440			2682
-lpc2478oem		MACH_LPC2478OEM		LPC2478OEM		2683
+ea2478devkit		MACH_EA2478DEVKIT	EA2478DEVKIT		2683
 ak880x			MACH_AK880X		AK880X			2684
 cobra3530		MACH_COBRA3530		COBRA3530		2685
 pmppb			MACH_PMPPB		PMPPB			2686
-- 
1.7.1
