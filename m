From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Sun, 20 Mar 2011 21:30:06 +0100
Subject: [PATCH v3 6/9] lpc2k: multifunction pin configuration
In-Reply-To: <1300653009-11675-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300653009-11675-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300653009-11675-7-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inspired by the mfp support in PXA. Includes definition of pins
for NXP LPC2468/78.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
changes since v2:
	* Removed MFP_PIN_* enum.
	* Renamed GPIOx_signal defines to Px_y_signal.

no changes since v1.
---
 arch/arm/mach-lpc2k/Makefile                   |    2 +-
 arch/arm/mach-lpc2k/include/mach/hardware.h    |    1 +
 arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h |   98 +++++++++++++++++++++++
 arch/arm/mach-lpc2k/include/mach/mfp.h         |   43 ++++++++++
 arch/arm/mach-lpc2k/mfp.c                      |  100 ++++++++++++++++++++++++
 5 files changed, 243 insertions(+), 1 deletions(-)
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
index b8c471b..1a20126 100644
--- a/arch/arm/mach-lpc2k/include/mach/hardware.h
+++ b/arch/arm/mach-lpc2k/include/mach/hardware.h
@@ -21,6 +21,7 @@
 #define APB_TIMER1_BASE		0xe0008000
 #define APB_UART0_BASE		0xe000c000
 #define APB_GPIO_BASE		0xe0028000
+#define APB_PINSEL_BASE		0xe002c000
 #define APB_SCB_BASE		0xe01fc000
 #define APH_VIC_BASE		0xfffff000
 
diff --git a/arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h b/arch/arm/mach-lpc2k/include/mach/mfp-lpc24xx.h
new file mode 100644
index 0000000..dafb8f1
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
+#define P0_0_RD1		MFP_CFG(LPC2K_GPIO(0,0), AF1)
+#define P0_0_TXD3		MFP_CFG(LPC2K_GPIO(0,0), AF2)
+#define P0_0_SDA1		MFP_CFG(LPC2K_GPIO(0,0), AF3)
+#define P0_1_TD1		MFP_CFG(LPC2K_GPIO(0,1), AF1)
+#define P0_1_RXD3		MFP_CFG(LPC2K_GPIO(0,1), AF2)
+#define P0_1_SCL1		MFP_CFG(LPC2K_GPIO(0,1), AF3)
+#define P0_2_TXD0		MFP_CFG(LPC2K_GPIO(0,2), AF1)
+#define P0_3_RXD0		MFP_CFG(LPC2K_GPIO(0,3), AF1)
+#define P0_4_LCDVD0		MFP_CFG(LPC2K_GPIO(0,4), AF1)
+#define P0_5_LCDVD1		MFP_CFG(LPC2K_GPIO(0,5), AF1)
+#define P0_6_LCDVD8		MFP_CFG(LPC2K_GPIO(0,6), AF1)
+#define P0_7_LCDVD9		MFP_CFG(LPC2K_GPIO(0,7), AF1)
+#define P0_8_LCDVD16		MFP_CFG(LPC2K_GPIO(0,8), AF1)
+#define P0_9_LCDVD17		MFP_CFG(LPC2K_GPIO(0,9), AF1)
+#define P0_10_TXD2		MFP_CFG(LPC2K_GPIO(0,10), AF1)
+#define P0_11_RXD2		MFP_CFG(LPC2K_GPIO(0,11), AF1)
+#define P0_12_USB_PPWR2		MFP_CFG(LPC2K_GPIO(0,12), AF1)
+#define P0_13_USB_UP_LED2	MFP_CFG(LPC2K_GPIO(0,13), AF1)
+#define P0_15_SCK		MFP_CFG(LPC2K_GPIO(0,15), AF3)
+#define P0_17_MISO		MFP_CFG(LPC2K_GPIO(0,17), AF3)
+#define P0_18_MOSI		MFP_CFG(LPC2K_GPIO(0,18), AF3)
+#define P0_27_SDA0		MFP_CFG(LPC2K_GPIO(0,27), AF1)
+#define P0_28_SCL0		MFP_CFG(LPC2K_GPIO(0,28), AF1)
+#define P0_29_USB_Dp1		MFP_CFG(LPC2K_GPIO(0,29), AF1)
+#define P0_30_USB_Dn1		MFP_CFG(LPC2K_GPIO(0,30), AF1)
+#define P0_31_USB_Dp2		MFP_CFG(LPC2K_GPIO(0,31), AF1)
+#define P1_0_ENET_TXD0		MFP_CFG(LPC2K_GPIO(1,0), AF1)
+#define P1_1_ENET_TXD1		MFP_CFG(LPC2K_GPIO(1,1), AF1)
+#define P1_2_MCICLK		MFP_CFG(LPC2K_GPIO(1,2), AF2)
+#define P1_3_MCICMD		MFP_CFG(LPC2K_GPIO(1,3), AF2)
+#define P1_4_ENET_TX_EN		MFP_CFG(LPC2K_GPIO(1,4), AF1)
+#define P1_5_MCIPWR		MFP_CFG(LPC2K_GPIO(1,5), AF2)
+#define P1_6_ENET_TX_CLK	MFP_CFG(LPC2K_GPIO(1,6), AF1)
+#define P1_6_MCIDAT0		MFP_CFG(LPC2K_GPIO(1,6), AF2)
+#define P1_7_MCIDAT1		MFP_CFG(LPC2K_GPIO(1,7), AF2)
+#define P1_8_ENET_CRS		MFP_CFG(LPC2K_GPIO(1,8), AF1)
+#define P1_9_ENET_RXD0		MFP_CFG(LPC2K_GPIO(1,9), AF1)
+#define P1_10_ENET_RXD1		MFP_CFG(LPC2K_GPIO(1,10), AF1)
+#define P1_11_MCIDAT2		MFP_CFG(LPC2K_GPIO(1,11), AF2)
+#define P1_12_MCIDAT3		MFP_CFG(LPC2K_GPIO(1,12), AF2)
+#define P1_14_ENET_RX_ERR	MFP_CFG(LPC2K_GPIO(1,14), AF1)
+#define P1_15_ENET_REF_CLK	MFP_CFG(LPC2K_GPIO(1,15), AF1)
+#define P1_16_ENET_MDC		MFP_CFG(LPC2K_GPIO(1,16), AF1)
+#define P1_17_ENET_MDIO		MFP_CFG(LPC2K_GPIO(1,17), AF1)
+#define P1_18_PWM1		MFP_CFG(LPC2K_GPIO(1,18), AF2)
+#define P1_20_LCDVD10		MFP_CFG(LPC2K_GPIO(1,20), AF1)
+#define P1_21_LCDVD11		MFP_CFG(LPC2K_GPIO(1,21), AF1)
+#define P1_22_LCDVD12		MFP_CFG(LPC2K_GPIO(1,22), AF1)
+#define P1_23_LCDVD13		MFP_CFG(LPC2K_GPIO(1,23), AF1)
+#define P1_24_LCDVD14		MFP_CFG(LPC2K_GPIO(1,24), AF1)
+#define P1_25_LCDVD15		MFP_CFG(LPC2K_GPIO(1,25), AF1)
+#define P1_26_LCDVD20		MFP_CFG(LPC2K_GPIO(1,26), AF1)
+#define P1_27_LCDVD21		MFP_CFG(LPC2K_GPIO(1,27), AF1)
+#define P1_28_LCDVD22		MFP_CFG(LPC2K_GPIO(1,28), AF1)
+#define P1_29_LCDVD23		MFP_CFG(LPC2K_GPIO(1,29), AF1)
+#define P1_30_VBUS		MFP_CFG(LPC2K_GPIO(1,30), AF2)
+#define P1_31_USB_OVRCR2	MFP_CFG(LPC2K_GPIO(1,31), AF1)
+#define P2_0_LCDPWR		MFP_CFG(LPC2K_GPIO(2,0), AF3)
+#define P2_1_LCDLE		MFP_CFG(LPC2K_GPIO(2,1), AF3)
+#define P2_2_LCDDCLK		MFP_CFG(LPC2K_GPIO(2,2), AF3)
+#define P2_3_LCDFP		MFP_CFG(LPC2K_GPIO(2,3), AF3)
+#define P2_4_LCDM		MFP_CFG(LPC2K_GPIO(2,4), AF3)
+#define P2_5_LCDLP		MFP_CFG(LPC2K_GPIO(2,5), AF3)
+#define P2_6_LCDVP4		MFP_CFG(LPC2K_GPIO(2,6), AF3)
+#define P2_7_LCDVP5		MFP_CFG(LPC2K_GPIO(2,7), AF3)
+#define P2_8_LCDVP6		MFP_CFG(LPC2K_GPIO(2,8), AF3)
+#define P2_9_LCDVP7		MFP_CFG(LPC2K_GPIO(2,9), AF3)
+#define P2_11_LCDCLKIN		MFP_CFG(LPC2K_GPIO(2,11), AF1)
+#define P2_12_LCDVP18		MFP_CFG(LPC2K_GPIO(2,12), AF1)
+#define P2_13_LCDVP19		MFP_CFG(LPC2K_GPIO(2,13), AF1)
+#define P3_16_TXD1		MFP_CFG(LPC2K_GPIO(3,16), AF3)
+#define P3_17_RXD1		MFP_CFG(LPC2K_GPIO(3,17), AF3)
+#define P3_18_CTS1		MFP_CFG(LPC2K_GPIO(3,18), AF3)
+#define P3_19_DCD1		MFP_CFG(LPC2K_GPIO(3,19), AF3)
+#define P3_20_DSR1		MFP_CFG(LPC2K_GPIO(3,20), AF3)
+#define P3_21_DR1		MFP_CFG(LPC2K_GPIO(3,21), AF3)
+#define P3_22_RI1		MFP_CFG(LPC2K_GPIO(3,22), AF3)
+#define P3_30_RTS1		MFP_CFG(LPC2K_GPIO(3,30), AF3)
+#define P4_28_TXD3		MFP_CFG(LPC2K_GPIO(4,28), AF3)
+#define P4_28_LCDVP2		MFP_CFG(LPC2K_GPIO(4,28), AF2)
+#define P4_29_RXD3		MFP_CFG(LPC2K_GPIO(4,29), AF3)
+#define P4_29_LCDVP3		MFP_CFG(LPC2K_GPIO(4,29), AF2)
+
+#endif /* MACH_LPC2K_MFP_LPC24XX_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/mfp.h b/arch/arm/mach-lpc2k/include/mach/mfp.h
new file mode 100644
index 0000000..c3d0378
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/mfp.h
@@ -0,0 +1,43 @@
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
+	 (MFP_PIN(pin) | MFP_##af))
+
+#define MFP_CFG_PULL(pin, af, pull)	\
+	((MFP_CFG_DEFAULT & ~(MFP_AF_MASK | MFP_PULL_MASK)) |\
+	 (MFP_PIN(pin) | MFP_##af | MFP_##pull))
+
+#endif /* ARCH_LPC2K_MFP_H */
diff --git a/arch/arm/mach-lpc2k/mfp.c b/arch/arm/mach-lpc2k/mfp.c
new file mode 100644
index 0000000..c0d356b
--- /dev/null
+++ b/arch/arm/mach-lpc2k/mfp.c
@@ -0,0 +1,100 @@
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
+#include <linux/gpio.h>
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
+static struct gpio_desc gpio_desc[LPC2K_GPIO(4,31) + 1];
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
+	for (i = 0; i < ARRAY_SIZE(gpio_desc); i++)
+		gpio_desc[i].valid = 1;
+
+	return 0;
+}
+
+postcore_initcall(lpc2k_mfp_init);
-- 
1.7.1
