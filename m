From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 16:54:21 +0100
Subject: [PATCH 6/9] lpc2k: multifunction pin configuration
In-Reply-To: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300377264-10843-7-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inspired by the mfp support in PXA. Includes definition of pins
for NXP LPC2468/78.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
 arch/arm/mach-lpc2k/Makefile                   |    2 +-
 arch/arm/mach-lpc2k/include/mach/hardware.h    |    1 +
 arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h |   98 +++++++++++
 arch/arm/mach-lpc2k/include/mach/mfp.h         |  209 ++++++++++++++++++++++++
 arch/arm/mach-lpc2k/mfp.c                      |   99 +++++++++++
 5 files changed, 408 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/mfp.h
 create mode 100644 arch/arm/mach-lpc2k/mfp.c

diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
index 89596a7..2c50bb9 100644
--- a/arch/arm/mach-lpc2k/Makefile
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -1 +1 @@
-obj-y	:= clock.o irq.o gpio.o time.o
+obj-y	:= clock.o irq.o gpio.o mfp.o time.o
diff --git a/arch/arm/mach-lpc2k/include/mach/hardware.h b/arch/arm/mach-lpc2k/include/mach/hardware.h
index 0d7c10c..29c561a 100644
--- a/arch/arm/mach-lpc2k/include/mach/hardware.h
+++ b/arch/arm/mach-lpc2k/include/mach/hardware.h
@@ -20,6 +20,7 @@
 #define APB_TIMER1_BASE		0xe0008000
 #define APB_UART0_BASE		0xe000c000
 #define APB_GPIO_BASE		0xe0028000
+#define APB_PINSEL_BASE		0xe002c000
 #define APB_SCB_BASE		0xe01fc000
 #define APH_VIC_BASE		0xfffff000
 
diff --git a/arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h b/arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h
new file mode 100644
index 0000000..9b6bec4
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_MFP_LPC24XX_H
+#define MACH_LPC2K_MFP_LPC24XX_H
+
+#include <mach/mfp.h>
+
+#define GPIO0_RD1		MFP_CFG(GPIO0, AF1)
+#define GPIO0_TXD3		MFP_CFG(GPIO0, AF2)
+#define GPIO0_SDA1		MFP_CFG(GPIO0, AF3)
+#define GPIO1_TD1		MFP_CFG(GPIO1, AF1)
+#define GPIO1_RXD3		MFP_CFG(GPIO1, AF2)
+#define GPIO1_SCL1		MFP_CFG(GPIO1, AF3)
+#define GPIO2_TXD0		MFP_CFG(GPIO2, AF1)
+#define GPIO3_RXD0		MFP_CFG(GPIO3, AF1)
+#define GPIO4_LCDVD0		MFP_CFG(GPIO4, AF1)
+#define GPIO5_LCDVD1		MFP_CFG(GPIO5, AF1)
+#define GPIO6_LCDVD8		MFP_CFG(GPIO6, AF1)
+#define GPIO7_LCDVD9		MFP_CFG(GPIO7, AF1)
+#define GPIO8_LCDVD16		MFP_CFG(GPIO8, AF1)
+#define GPIO9_LCDVD17		MFP_CFG(GPIO9, AF1)
+#define GPIO10_TXD2		MFP_CFG(GPIO10, AF1)
+#define GPIO11_RXD2		MFP_CFG(GPIO11, AF1)
+#define GPIO12_USB_PPWR2	MFP_CFG(GPIO12, AF1)
+#define GPIO13_USB_UP_LED2	MFP_CFG(GPIO13, AF1)
+#define GPIO15_SCK		MFP_CFG(GPIO15, AF3)
+#define GPIO17_MISO		MFP_CFG(GPIO17, AF3)
+#define GPIO18_MOSI		MFP_CFG(GPIO18, AF3)
+#define GPIO27_SDA0		MFP_CFG(GPIO27, AF1)
+#define GPIO28_SCL0		MFP_CFG(GPIO28, AF1)
+#define GPIO29_USB_Dp1		MFP_CFG(GPIO29, AF1)
+#define GPIO30_USB_Dn1		MFP_CFG(GPIO30, AF1)
+#define GPIO31_USB_Dp2		MFP_CFG(GPIO31, AF1)
+#define GPIO32_ENET_TXD0	MFP_CFG(GPIO32, AF1)
+#define GPIO33_ENET_TXD1	MFP_CFG(GPIO33, AF1)
+#define GPIO34_MCICLK		MFP_CFG(GPIO34, AF2)
+#define GPIO35_MCICMD		MFP_CFG(GPIO35, AF2)
+#define GPIO36_ENET_TX_EN	MFP_CFG(GPIO36, AF1)
+#define GPIO37_MCIPWR		MFP_CFG(GPIO37, AF2)
+#define GPIO38_ENET_TX_CLK	MFP_CFG(GPIO38, AF1)
+#define GPIO38_MCIDAT0		MFP_CFG(GPIO38, AF2)
+#define GPIO39_MCIDAT1		MFP_CFG(GPIO39, AF2)
+#define GPIO40_ENET_CRS		MFP_CFG(GPIO40, AF1)
+#define GPIO41_ENET_RXD0	MFP_CFG(GPIO41, AF1)
+#define GPIO42_ENET_RXD1	MFP_CFG(GPIO42, AF1)
+#define GPIO43_MCIDAT2		MFP_CFG(GPIO43, AF2)
+#define GPIO44_MCIDAT3		MFP_CFG(GPIO44, AF2)
+#define GPIO46_ENET_RX_ERR	MFP_CFG(GPIO46, AF1)
+#define GPIO47_ENET_REF_CLK	MFP_CFG(GPIO47, AF1)
+#define GPIO48_ENET_MDC		MFP_CFG(GPIO48, AF1)
+#define GPIO49_ENET_MDIO	MFP_CFG(GPIO49, AF1)
+#define GPIO50_PWM1		MFP_CFG(GPIO50, AF2)
+#define GPIO52_LCDVD10		MFP_CFG(GPIO52, AF1)
+#define GPIO53_LCDVD11		MFP_CFG(GPIO53, AF1)
+#define GPIO54_LCDVD12		MFP_CFG(GPIO54, AF1)
+#define GPIO55_LCDVD13		MFP_CFG(GPIO55, AF1)
+#define GPIO56_LCDVD14		MFP_CFG(GPIO56, AF1)
+#define GPIO57_LCDVD15		MFP_CFG(GPIO57, AF1)
+#define GPIO58_LCDVD20		MFP_CFG(GPIO58, AF1)
+#define GPIO59_LCDVD21		MFP_CFG(GPIO59, AF1)
+#define GPIO60_LCDVD22		MFP_CFG(GPIO60, AF1)
+#define GPIO61_LCDVD23		MFP_CFG(GPIO61, AF1)
+#define GPIO62_VBUS		MFP_CFG(GPIO62, AF2)
+#define GPIO63_USB_OVRCR2	MFP_CFG(GPIO63, AF1)
+#define GPIO64_LCDPWR		MFP_CFG(GPIO64, AF3)
+#define GPIO65_LCDLE		MFP_CFG(GPIO65, AF3)
+#define GPIO66_LCDDCLK		MFP_CFG(GPIO66, AF3)
+#define GPIO67_LCDFP		MFP_CFG(GPIO67, AF3)
+#define GPIO68_LCDM		MFP_CFG(GPIO68, AF3)
+#define GPIO69_LCDLP		MFP_CFG(GPIO69, AF3)
+#define GPIO70_LCDVP4		MFP_CFG(GPIO70, AF3)
+#define GPIO71_LCDVP5		MFP_CFG(GPIO71, AF3)
+#define GPIO72_LCDVP6		MFP_CFG(GPIO72, AF3)
+#define GPIO73_LCDVP7		MFP_CFG(GPIO73, AF3)
+#define GPIO75_LCDCLKIN		MFP_CFG(GPIO75, AF1)
+#define GPIO76_LCDVP18		MFP_CFG(GPIO76, AF1)
+#define GPIO77_LCDVP19		MFP_CFG(GPIO77, AF1)
+#define GPIO112_TXD1		MFP_CFG(GPIO112, AF3)
+#define GPIO113_RXD1		MFP_CFG(GPIO113, AF3)
+#define GPIO114_CTS1		MFP_CFG(GPIO114, AF3)
+#define GPIO115_DCD1		MFP_CFG(GPIO115, AF3)
+#define GPIO116_DSR1		MFP_CFG(GPIO116, AF3)
+#define GPIO117_DR1		MFP_CFG(GPIO117, AF3)
+#define GPIO118_RI1		MFP_CFG(GPIO118, AF3)
+#define GPIO126_RTS1		MFP_CFG(GPIO126, AF3)
+#define GPIO156_TXD3		MFP_CFG(GPIO156, AF3)
+#define GPIO156_LCDVP2		MFP_CFG(GPIO156, AF2)
+#define GPIO157_RXD3		MFP_CFG(GPIO157, AF3)
+#define GPIO157_LCDVP3		MFP_CFG(GPIO157, AF2)
+
+#endif /* MACH_LPC2K_MFP_LPC24XX_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/mfp.h b/arch/arm/mach-lpc2k/include/mach/mfp.h
new file mode 100644
index 0000000..3c919c8
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/mfp.h
@@ -0,0 +1,209 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_LPC2K_MFP_H
+#define ARCH_LPC2K_MFP_H
+
+#define mfp_to_gpio(m)	((m) % 160)
+
+/* list of all the configurable MFP pins */
+enum {
+	MFP_PIN_INVALID = -1,
+
+	MFP_PIN_GPIO0 = 0,
+	MFP_PIN_GPIO1,
+	MFP_PIN_GPIO2,
+	MFP_PIN_GPIO3,
+	MFP_PIN_GPIO4,
+	MFP_PIN_GPIO5,
+	MFP_PIN_GPIO6,
+	MFP_PIN_GPIO7,
+	MFP_PIN_GPIO8,
+	MFP_PIN_GPIO9,
+	MFP_PIN_GPIO10,
+	MFP_PIN_GPIO11,
+	MFP_PIN_GPIO12,
+	MFP_PIN_GPIO13,
+	MFP_PIN_GPIO14,
+	MFP_PIN_GPIO15,
+	MFP_PIN_GPIO16,
+	MFP_PIN_GPIO17,
+	MFP_PIN_GPIO18,
+	MFP_PIN_GPIO19,
+	MFP_PIN_GPIO20,
+	MFP_PIN_GPIO21,
+	MFP_PIN_GPIO22,
+	MFP_PIN_GPIO23,
+	MFP_PIN_GPIO24,
+	MFP_PIN_GPIO25,
+	MFP_PIN_GPIO26,
+	MFP_PIN_GPIO27,
+	MFP_PIN_GPIO28,
+	MFP_PIN_GPIO29,
+	MFP_PIN_GPIO30,
+	MFP_PIN_GPIO31,
+	MFP_PIN_GPIO32,
+	MFP_PIN_GPIO33,
+	MFP_PIN_GPIO34,
+	MFP_PIN_GPIO35,
+	MFP_PIN_GPIO36,
+	MFP_PIN_GPIO37,
+	MFP_PIN_GPIO38,
+	MFP_PIN_GPIO39,
+	MFP_PIN_GPIO40,
+	MFP_PIN_GPIO41,
+	MFP_PIN_GPIO42,
+	MFP_PIN_GPIO43,
+	MFP_PIN_GPIO44,
+	MFP_PIN_GPIO45,
+	MFP_PIN_GPIO46,
+	MFP_PIN_GPIO47,
+	MFP_PIN_GPIO48,
+	MFP_PIN_GPIO49,
+	MFP_PIN_GPIO50,
+	MFP_PIN_GPIO51,
+	MFP_PIN_GPIO52,
+	MFP_PIN_GPIO53,
+	MFP_PIN_GPIO54,
+	MFP_PIN_GPIO55,
+	MFP_PIN_GPIO56,
+	MFP_PIN_GPIO57,
+	MFP_PIN_GPIO58,
+	MFP_PIN_GPIO59,
+	MFP_PIN_GPIO60,
+	MFP_PIN_GPIO61,
+	MFP_PIN_GPIO62,
+	MFP_PIN_GPIO63,
+	MFP_PIN_GPIO64,
+	MFP_PIN_GPIO65,
+	MFP_PIN_GPIO66,
+	MFP_PIN_GPIO67,
+	MFP_PIN_GPIO68,
+	MFP_PIN_GPIO69,
+	MFP_PIN_GPIO70,
+	MFP_PIN_GPIO71,
+	MFP_PIN_GPIO72,
+	MFP_PIN_GPIO73,
+	MFP_PIN_GPIO74,
+	MFP_PIN_GPIO75,
+	MFP_PIN_GPIO76,
+	MFP_PIN_GPIO77,
+	MFP_PIN_GPIO78,
+	MFP_PIN_GPIO79,
+	MFP_PIN_GPIO80,
+	MFP_PIN_GPIO81,
+	MFP_PIN_GPIO82,
+	MFP_PIN_GPIO83,
+	MFP_PIN_GPIO84,
+	MFP_PIN_GPIO85,
+	MFP_PIN_GPIO86,
+	MFP_PIN_GPIO87,
+	MFP_PIN_GPIO88,
+	MFP_PIN_GPIO89,
+	MFP_PIN_GPIO90,
+	MFP_PIN_GPIO91,
+	MFP_PIN_GPIO92,
+	MFP_PIN_GPIO93,
+	MFP_PIN_GPIO94,
+	MFP_PIN_GPIO95,
+	MFP_PIN_GPIO96,
+	MFP_PIN_GPIO97,
+	MFP_PIN_GPIO98,
+	MFP_PIN_GPIO99,
+	MFP_PIN_GPIO100,
+	MFP_PIN_GPIO101,
+	MFP_PIN_GPIO102,
+	MFP_PIN_GPIO103,
+	MFP_PIN_GPIO104,
+	MFP_PIN_GPIO105,
+	MFP_PIN_GPIO106,
+	MFP_PIN_GPIO107,
+	MFP_PIN_GPIO108,
+	MFP_PIN_GPIO109,
+	MFP_PIN_GPIO110,
+	MFP_PIN_GPIO111,
+	MFP_PIN_GPIO112,
+	MFP_PIN_GPIO113,
+	MFP_PIN_GPIO114,
+	MFP_PIN_GPIO115,
+	MFP_PIN_GPIO116,
+	MFP_PIN_GPIO117,
+	MFP_PIN_GPIO118,
+	MFP_PIN_GPIO119,
+	MFP_PIN_GPIO120,
+	MFP_PIN_GPIO121,
+	MFP_PIN_GPIO122,
+	MFP_PIN_GPIO123,
+	MFP_PIN_GPIO124,
+	MFP_PIN_GPIO125,
+	MFP_PIN_GPIO126,
+	MFP_PIN_GPIO127,
+	MFP_PIN_GPIO128,
+	MFP_PIN_GPIO129,
+	MFP_PIN_GPIO130,
+	MFP_PIN_GPIO131,
+	MFP_PIN_GPIO132,
+	MFP_PIN_GPIO133,
+	MFP_PIN_GPIO134,
+	MFP_PIN_GPIO135,
+	MFP_PIN_GPIO136,
+	MFP_PIN_GPIO137,
+	MFP_PIN_GPIO138,
+	MFP_PIN_GPIO139,
+	MFP_PIN_GPIO140,
+	MFP_PIN_GPIO141,
+	MFP_PIN_GPIO142,
+	MFP_PIN_GPIO143,
+	MFP_PIN_GPIO144,
+	MFP_PIN_GPIO145,
+	MFP_PIN_GPIO146,
+	MFP_PIN_GPIO147,
+	MFP_PIN_GPIO148,
+	MFP_PIN_GPIO149,
+	MFP_PIN_GPIO150,
+	MFP_PIN_GPIO151,
+	MFP_PIN_GPIO152,
+	MFP_PIN_GPIO153,
+	MFP_PIN_GPIO154,
+	MFP_PIN_GPIO155,
+	MFP_PIN_GPIO156,
+	MFP_PIN_GPIO157,
+	MFP_PIN_GPIO158,
+	MFP_PIN_GPIO159,
+};
+
+/* pin number; currently only 0-159 are used */
+#define MFP_PIN(x)	((x) & 0x3ff)
+
+/* Alternate functions, currently only 0-3 are used */
+#define MFP_AF0		(0x0 << 10)
+#define MFP_AF1		(0x1 << 10)
+#define MFP_AF2		(0x2 << 10)
+#define MFP_AF3		(0x3 << 10)
+#define MFP_AF_MASK	(0x3 << 10)
+#define MFP_AF(x)	(((x) >> 10) & 0x3)
+
+/* Pullup/down configuration, currently only none/high/low are used */
+#define MFP_PULL_NONE	(0x2 << 21)
+#define MFP_PULL_LOW	(0x3 << 21)
+#define MFP_PULL_HIGH	(0x0 << 21)
+#define MFP_PULL_MASK	(0x3 << 21)
+#define MFP_PULL(x)	(((x) >> 21) & 0x3)
+
+#define MFP_CFG_DEFAULT	(MFP_PULL_HIGH | MFP_AF0)
+
+#define MFP_CFG(pin, af)		\
+	((MFP_CFG_DEFAULT & ~MFP_AF_MASK) |\
+	 (MFP_PIN(MFP_PIN_##pin) | MFP_##af))
+
+#define MFP_CFG_PULL(pin, af, pull)	\
+	((MFP_CFG_DEFAULT & ~(MFP_AF_MASK | MFP_PULL_MASK)) |\
+	 (MFP_PIN(MFP_PIN_##pin) | MFP_##af | MFP_##pull))
+
+#endif /* ARCH_LPC2K_MFP_H */
diff --git a/arch/arm/mach-lpc2k/mfp.c b/arch/arm/mach-lpc2k/mfp.c
new file mode 100644
index 0000000..6e4779d
--- /dev/null
+++ b/arch/arm/mach-lpc2k/mfp.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (C) 2011 Team Embeded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * Based on MFP code from mach-pxa.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/mfp.h>
+
+#define PINSEL(bank)	(0x00 + (bank)*4)
+#define PINMODE(bank)	(0x40 + (bank)*4)
+
+struct gpio_desc {
+	unsigned valid:1;
+	unsigned long config;
+};
+
+static struct gpio_desc gpio_desc[MFP_PIN_GPIO159 + 1];
+
+static int __mfp_config_gpio(unsigned gpio, unsigned long c)
+{
+	unsigned bank = gpio >> 4;
+	unsigned shift = (gpio & 0xf) * 2;
+	unsigned val;
+
+	/* Configure alternate function */
+	val = __raw_readl(APB_PINSEL_BASE + PINSEL(bank));
+	if ((val & (3 << shift)) &&
+	    (val & (3 << shift)) != (MFP_AF(c) << shift))
+		pr_warning
+		    ("GPIO%d is already configured (%x), not reconfigured!\n",
+		     gpio, (val & (3 << shift)) >> shift);
+	else {
+		val &= ~(0x3 << shift);
+		val |= MFP_AF(c) << shift;
+		__raw_writel(val, APB_PINSEL_BASE + PINSEL(bank));
+	}
+
+	/* Configuration pullup/dn */
+	val = __raw_readl(APB_PINSEL_BASE + PINMODE(bank));
+	val &= ~(0x3 << shift);
+	val |= MFP_PULL(c) << shift;
+	__raw_writel(val, APB_PINSEL_BASE + PINMODE(bank));
+
+	return 0;
+}
+
+static inline int __mfp_validate(int mfp)
+{
+	int gpio = mfp_to_gpio(mfp);
+
+	if (!gpio_desc[gpio].valid) {
+		pr_warning("%s: GPIO%d is invalid pin\n", __func__, gpio);
+		return -1;
+	}
+
+	return gpio;
+}
+
+void lpc2k_mfp_config(unsigned long *mfp_cfgs, int num)
+{
+	unsigned long flags;
+	unsigned long *c;
+	int i, gpio;
+
+	for (i = 0, c = mfp_cfgs; i < num; i++, c++) {
+
+		gpio = __mfp_validate(MFP_PIN(*c));
+		if (gpio < 0)
+			continue;
+
+		local_irq_save(flags);
+
+		gpio_desc[gpio].config = *c;
+		__mfp_config_gpio(gpio, *c);
+
+		local_irq_restore(flags);
+	}
+}
+
+static int __init lpc2k_mfp_init(void)
+{
+	int i;
+
+	for (i = MFP_PIN_GPIO0; i <= MFP_PIN_GPIO159; i++)
+		gpio_desc[i].valid = 1;
+
+	return 0;
+}
+
+postcore_initcall(lpc2k_mfp_init);
-- 
1.7.1
