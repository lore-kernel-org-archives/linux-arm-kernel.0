From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 15 Jun 2010 11:27:24 -0700
Subject: [PATCH 1/2] Add GPIO support for HTC Dream.
In-Reply-To: <1276626445-20316-1-git-send-email-dwalker@codeaurora.org>
References: <1276626445-20316-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1276626445-20316-2-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Machek <pavel@ucw.cz>

Signed-off-by: Pavel Machek <pavel@ucw.cz>
[dwalker at codeaurora.org: renamed to trout]
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-msm/Makefile            |    2 +-
 arch/arm/mach-msm/board-trout-gpio.c  |  112 +++++++++++++++++++++++
 arch/arm/mach-msm/board-trout.h       |  157 +++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/gpio.h |    7 ++
 5 files changed, 278 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-trout-gpio.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..c171f35 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -586,6 +586,7 @@ config ARCH_MSM
 	bool "Qualcomm MSM"
 	select HAVE_CLK
 	select GENERIC_CLOCKEVENTS
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for Qualcomm MSM/QSD based systems.  This runs on the
 	  apps processor of the MSM/QSD and depends on a shared memory
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 66677f0..7ff8020 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 
-obj-$(CONFIG_MACH_TROUT) += board-trout.o devices-msm7x00.o
+obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o devices-msm7x00.o
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
 obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
 obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
new file mode 100644
index 0000000..6e6bc76
--- /dev/null
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -0,0 +1,112 @@
+/*
+ * linux/arch/arm/mach-msm/gpio.c
+ *
+ * Copyright (C) 2005 HP Labs
+ * Copyright (C) 2008 Google, Inc.
+ * Copyright (C) 2009 Pavel Machek <pavel@ucw.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+
+#include "board-trout.h"
+
+struct msm_gpio_chip {
+	struct gpio_chip	chip;
+	void __iomem		*reg;	/* Base of register bank */
+	u8			shadow;
+};
+
+#define to_msm_gpio_chip(c) container_of(c, struct msm_gpio_chip, chip)
+
+static int msm_gpiolib_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct msm_gpio_chip *msm_gpio = to_msm_gpio_chip(chip);
+	unsigned mask = 1 << offset;
+
+	return !! (readb(msm_gpio->reg) & mask);
+}
+
+static void msm_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val)
+{
+	struct msm_gpio_chip *msm_gpio = to_msm_gpio_chip(chip);
+	unsigned mask = 1 << offset;
+
+	if (val)
+		msm_gpio->shadow |= mask;
+	else
+		msm_gpio->shadow &= ~mask;
+
+	writeb(msm_gpio->shadow, msm_gpio->reg);
+}
+
+static int msm_gpiolib_direction_input(struct gpio_chip *chip,
+					unsigned offset)
+{
+	msm_gpiolib_set(chip, offset, 0);
+	return 0;
+}
+
+static int msm_gpiolib_direction_output(struct gpio_chip *chip,
+					 unsigned offset, int val)
+{
+	msm_gpiolib_set(chip, offset, val);
+	return 0;
+}
+
+#define TROUT_GPIO_BANK(name, reg_num, base_gpio, shadow_val)		\
+	{								\
+		.chip = {						\
+			.label		  = name,			\
+			.direction_input  = msm_gpiolib_direction_input,\
+			.direction_output = msm_gpiolib_direction_output, \
+			.get		  = msm_gpiolib_get,		\
+			.set		  = msm_gpiolib_set,		\
+			.base		  = base_gpio,			\
+			.ngpio		  = 8,				\
+		},							\
+		.reg = (void *) reg_num + TROUT_CPLD_BASE,		\
+		.shadow = shadow_val,					\
+	}
+
+static struct msm_gpio_chip msm_gpio_banks[] = {
+#if defined(CONFIG_MSM_DEBUG_UART1)
+        /* H2W pins <-> UART1 */
+        TROUT_GPIO_BANK("MISC2", 0x00,   TROUT_GPIO_MISC2_BASE, 0x40),
+#else
+	/* H2W pins <-> UART3, Bluetooth <-> UART1 */
+        TROUT_GPIO_BANK("MISC2", 0x00,   TROUT_GPIO_MISC2_BASE, 0x80),
+#endif
+	/* I2C pull */
+        TROUT_GPIO_BANK("MISC3", 0x02,   TROUT_GPIO_MISC3_BASE, 0x04),
+        TROUT_GPIO_BANK("MISC4", 0x04,   TROUT_GPIO_MISC4_BASE, 0),
+	/* mmdi 32k en */
+        TROUT_GPIO_BANK("MISC5", 0x06,   TROUT_GPIO_MISC5_BASE, 0x04),
+        TROUT_GPIO_BANK("INT2", 0x08,    TROUT_GPIO_INT2_BASE,  0),
+        TROUT_GPIO_BANK("MISC1", 0x0a,   TROUT_GPIO_MISC1_BASE, 0),
+        TROUT_GPIO_BANK("VIRTUAL", 0x12, TROUT_GPIO_VIRTUAL_BASE, 0),
+};
+
+/*
+ * Called from the processor-specific init to enable GPIO pin support.
+ */
+int __init trout_init_gpio(void)
+{
+        int i;
+
+        for (i = 0; i < ARRAY_SIZE(msm_gpio_banks); i++)
+                gpiochip_add(&msm_gpio_banks[i].chip);
+
+	return 0;
+}
+
+postcore_initcall(trout_init_gpio);
+
diff --git a/arch/arm/mach-msm/board-trout.h b/arch/arm/mach-msm/board-trout.h
index 4f345a5..308c4df 100644
--- a/arch/arm/mach-msm/board-trout.h
+++ b/arch/arm/mach-msm/board-trout.h
@@ -1,5 +1,162 @@
+/* linux/arch/arm/mach-msm/board-trout.h
+** Author: Brian Swetland <swetland@google.com>
+*/
+#ifndef __ARCH_ARM_MACH_MSM_BOARD_TROUT_H
+#define __ARCH_ARM_MACH_MSM_BOARD_TROUT_H
+
+#include <mach/board.h>
+
+#define MSM_SMI_BASE		0x00000000
+#define MSM_SMI_SIZE		0x00800000
+
+#define MSM_EBI_BASE		0x10000000
+#define MSM_EBI_SIZE		0x06e00000
+
+#define MSM_PMEM_GPU0_BASE	0x00000000
+#define MSM_PMEM_GPU0_SIZE	0x00700000
+
+#define MSM_PMEM_MDP_BASE	0x02000000
+#define MSM_PMEM_MDP_SIZE	0x00800000
+
+#define MSM_PMEM_ADSP_BASE      0x02800000
+#define MSM_PMEM_ADSP_SIZE	0x00800000
+
+#define MSM_PMEM_CAMERA_BASE	0x03000000
+#define MSM_PMEM_CAMERA_SIZE	0x00800000
+
+#define MSM_FB_BASE		0x03800000
+#define MSM_FB_SIZE		0x00100000
+
+#define MSM_LINUX_BASE		MSM_EBI_BASE
+#define MSM_LINUX_SIZE		0x06500000
+
+#define MSM_PMEM_GPU1_SIZE	0x800000
+#define MSM_PMEM_GPU1_BASE	MSM_RAM_CONSOLE_BASE - MSM_PMEM_GPU1_SIZE
+
+#define MSM_RAM_CONSOLE_BASE	MSM_EBI_BASE + 0x6d00000
+#define MSM_RAM_CONSOLE_SIZE	128 * SZ_1K
+
+#if (MSM_FB_BASE + MSM_FB_SIZE) >= (MSM_PMEM_GPU1_BASE)
+#error invalid memory map
+#endif
+
+#define DECLARE_MSM_IOMAP
+#include <mach/msm_iomap.h>
+
+#define TROUT_4_BALL_UP_0     1
+#define TROUT_4_BALL_LEFT_0   18
+#define TROUT_4_BALL_DOWN_0   57
+#define TROUT_4_BALL_RIGHT_0  91
+
+#define TROUT_5_BALL_UP_0     94
+#define TROUT_5_BALL_LEFT_0   18
+#define TROUT_5_BALL_DOWN_0   90
+#define TROUT_5_BALL_RIGHT_0  19
+
+#define TROUT_POWER_KEY     20
+
+#define TROUT_4_TP_LS_EN    19
+#define TROUT_5_TP_LS_EN    1
 
 #define TROUT_CPLD_BASE   0xE8100000
 #define TROUT_CPLD_START  0x98000000
 #define TROUT_CPLD_SIZE   SZ_4K
 
+#define TROUT_GPIO_CABLE_IN1		(83)
+#define TROUT_GPIO_CABLE_IN2		(49)
+
+#define TROUT_GPIO_START (128)
+
+#define TROUT_GPIO_INT_MASK0_REG            (0x0c)
+#define TROUT_GPIO_INT_STAT0_REG            (0x0e)
+#define TROUT_GPIO_INT_MASK1_REG            (0x14)
+#define TROUT_GPIO_INT_STAT1_REG            (0x10)
+
+#define TROUT_GPIO_HAPTIC_PWM               (28)
+#define TROUT_GPIO_PS_HOLD                  (25)
+
+#define TROUT_GPIO_MISC2_BASE               (TROUT_GPIO_START + 0x00)
+#define TROUT_GPIO_MISC3_BASE               (TROUT_GPIO_START + 0x08)
+#define TROUT_GPIO_MISC4_BASE               (TROUT_GPIO_START + 0x10)
+#define TROUT_GPIO_MISC5_BASE               (TROUT_GPIO_START + 0x18)
+#define TROUT_GPIO_INT2_BASE                (TROUT_GPIO_START + 0x20)
+#define TROUT_GPIO_MISC1_BASE               (TROUT_GPIO_START + 0x28)
+#define TROUT_GPIO_VIRTUAL_BASE             (TROUT_GPIO_START + 0x30)
+#define TROUT_GPIO_INT5_BASE                (TROUT_GPIO_START + 0x48)
+
+#define TROUT_GPIO_CHARGER_EN               (TROUT_GPIO_MISC2_BASE + 0)
+#define TROUT_GPIO_ISET                     (TROUT_GPIO_MISC2_BASE + 1)
+#define TROUT_GPIO_H2W_DAT_DIR              (TROUT_GPIO_MISC2_BASE + 2)
+#define TROUT_GPIO_H2W_CLK_DIR              (TROUT_GPIO_MISC2_BASE + 3)
+#define TROUT_GPIO_H2W_DAT_GPO              (TROUT_GPIO_MISC2_BASE + 4)
+#define TROUT_GPIO_H2W_CLK_GPO              (TROUT_GPIO_MISC2_BASE + 5)
+#define TROUT_GPIO_H2W_SEL0                 (TROUT_GPIO_MISC2_BASE + 6)
+#define TROUT_GPIO_H2W_SEL1                 (TROUT_GPIO_MISC2_BASE + 7)
+
+#define TROUT_GPIO_SPOTLIGHT_EN             (TROUT_GPIO_MISC3_BASE + 0)
+#define TROUT_GPIO_FLASH_EN                 (TROUT_GPIO_MISC3_BASE + 1)
+#define TROUT_GPIO_I2C_PULL                 (TROUT_GPIO_MISC3_BASE + 2)
+#define TROUT_GPIO_TP_I2C_PULL              (TROUT_GPIO_MISC3_BASE + 3)
+#define TROUT_GPIO_TP_EN                    (TROUT_GPIO_MISC3_BASE + 4)
+#define TROUT_GPIO_JOG_EN                   (TROUT_GPIO_MISC3_BASE + 5)
+#define TROUT_GPIO_UI_LED_EN                (TROUT_GPIO_MISC3_BASE + 6)
+#define TROUT_GPIO_QTKEY_LED_EN             (TROUT_GPIO_MISC3_BASE + 7)
+
+#define TROUT_GPIO_VCM_PWDN                 (TROUT_GPIO_MISC4_BASE + 0)
+#define TROUT_GPIO_USB_H2W_SW               (TROUT_GPIO_MISC4_BASE + 1)
+#define TROUT_GPIO_COMPASS_RST_N            (TROUT_GPIO_MISC4_BASE + 2)
+#define TROUT_GPIO_HAPTIC_EN_UP             (TROUT_GPIO_MISC4_BASE + 3)
+#define TROUT_GPIO_HAPTIC_EN_MAIN           (TROUT_GPIO_MISC4_BASE + 4)
+#define TROUT_GPIO_USB_PHY_RST_N            (TROUT_GPIO_MISC4_BASE + 5)
+#define TROUT_GPIO_WIFI_PA_RESETX           (TROUT_GPIO_MISC4_BASE + 6)
+#define TROUT_GPIO_WIFI_EN                  (TROUT_GPIO_MISC4_BASE + 7)
+
+#define TROUT_GPIO_BT_32K_EN                (TROUT_GPIO_MISC5_BASE + 0)
+#define TROUT_GPIO_MAC_32K_EN               (TROUT_GPIO_MISC5_BASE + 1)
+#define TROUT_GPIO_MDDI_32K_EN              (TROUT_GPIO_MISC5_BASE + 2)
+#define TROUT_GPIO_COMPASS_32K_EN           (TROUT_GPIO_MISC5_BASE + 3)
+
+#define TROUT_GPIO_NAVI_ACT_N               (TROUT_GPIO_INT2_BASE + 0)
+#define TROUT_GPIO_COMPASS_IRQ              (TROUT_GPIO_INT2_BASE + 1)
+#define TROUT_GPIO_SLIDING_DET              (TROUT_GPIO_INT2_BASE + 2)
+#define TROUT_GPIO_AUD_HSMIC_DET_N          (TROUT_GPIO_INT2_BASE + 3)
+#define TROUT_GPIO_SD_DOOR_N                (TROUT_GPIO_INT2_BASE + 4)
+#define TROUT_GPIO_CAM_BTN_STEP1_N          (TROUT_GPIO_INT2_BASE + 5)
+#define TROUT_GPIO_CAM_BTN_STEP2_N          (TROUT_GPIO_INT2_BASE + 6)
+#define TROUT_GPIO_TP_ATT_N                 (TROUT_GPIO_INT2_BASE + 7)
+#define TROUT_GPIO_BANK0_FIRST_INT_SOURCE   (TROUT_GPIO_NAVI_ACT_N)
+#define TROUT_GPIO_BANK0_LAST_INT_SOURCE    (TROUT_GPIO_TP_ATT_N)
+
+#define TROUT_GPIO_H2W_DAT_GPI              (TROUT_GPIO_MISC1_BASE + 0)
+#define TROUT_GPIO_H2W_CLK_GPI              (TROUT_GPIO_MISC1_BASE + 1)
+#define TROUT_GPIO_CPLD128_VER_0            (TROUT_GPIO_MISC1_BASE + 4)
+#define TROUT_GPIO_CPLD128_VER_1            (TROUT_GPIO_MISC1_BASE + 5)
+#define TROUT_GPIO_CPLD128_VER_2            (TROUT_GPIO_MISC1_BASE + 6)
+#define TROUT_GPIO_CPLD128_VER_3            (TROUT_GPIO_MISC1_BASE + 7)
+
+#define TROUT_GPIO_SDMC_CD_N                (TROUT_GPIO_VIRTUAL_BASE + 0)
+#define TROUT_GPIO_END                      (TROUT_GPIO_SDMC_CD_N)
+#define TROUT_GPIO_BANK1_FIRST_INT_SOURCE   (TROUT_GPIO_SDMC_CD_N)
+#define TROUT_GPIO_BANK1_LAST_INT_SOURCE    (TROUT_GPIO_SDMC_CD_N)
+
+#define TROUT_GPIO_VIRTUAL_TO_REAL_OFFSET \
+	(TROUT_GPIO_INT5_BASE - TROUT_GPIO_VIRTUAL_BASE)
+
+#define TROUT_INT_START (NR_MSM_IRQS + NR_GPIO_IRQS)
+#define TROUT_INT_BANK0_COUNT (8)
+#define TROUT_INT_BANK1_START (TROUT_INT_START + TROUT_INT_BANK0_COUNT)
+#define TROUT_INT_BANK1_COUNT (1)
+#define TROUT_INT_END (TROUT_INT_START + TROUT_INT_BANK0_COUNT + \
+			TROUT_INT_BANK1_COUNT - 1)
+#define TROUT_GPIO_TO_INT(n) (((n) <= TROUT_GPIO_BANK0_LAST_INT_SOURCE) ? \
+	(TROUT_INT_START - TROUT_GPIO_BANK0_FIRST_INT_SOURCE + (n)) : \
+	(TROUT_INT_BANK1_START - TROUT_GPIO_BANK1_FIRST_INT_SOURCE + (n)))
+
+#define TROUT_INT_TO_BANK(n) ((n - TROUT_INT_START) / TROUT_INT_BANK0_COUNT)
+#define TROUT_INT_TO_MASK(n) (1U << ((n - TROUT_INT_START) & 7))
+#define TROUT_BANK_TO_MASK_REG(bank) \
+	(bank ? TROUT_GPIO_INT_MASK1_REG : TROUT_GPIO_INT_MASK0_REG)
+#define TROUT_BANK_TO_STAT_REG(bank) \
+	(bank ? TROUT_GPIO_INT_STAT1_REG : TROUT_GPIO_INT_STAT0_REG)
+
+#endif /* GUARD */
diff --git a/arch/arm/mach-msm/include/mach/gpio.h b/arch/arm/mach-msm/include/mach/gpio.h
index 262b441..83e47c0 100644
--- a/arch/arm/mach-msm/include/mach/gpio.h
+++ b/arch/arm/mach-msm/include/mach/gpio.h
@@ -16,6 +16,13 @@
 #ifndef __ASM_ARCH_MSM_GPIO_H
 #define __ASM_ARCH_MSM_GPIO_H
 
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value  __gpio_get_value
+#define gpio_set_value  __gpio_set_value
+#define gpio_cansleep   __gpio_cansleep
+#define gpio_to_irq     __gpio_to_irq
+
 /**
  * struct msm_gpio - GPIO pin description
  * @gpio_cfg - configuration bitmap, as per gpio_tlmm_config()
-- 
1.7.1
