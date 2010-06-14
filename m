From: konkers@android.com (Erik Gilling)
Date: Mon, 14 Jun 2010 14:10:22 -0700
Subject: [PATCH v3 06/11] [ARM] tegra: add GPIO support
In-Reply-To: <1276549827-2688-6-git-send-email-konkers@android.com>
References: <1271198563-10424-1-git-send-email-konkers@android.com>
	<1276549827-2688-1-git-send-email-konkers@android.com>
	<1276549827-2688-2-git-send-email-konkers@android.com>
	<1276549827-2688-3-git-send-email-konkers@android.com>
	<1276549827-2688-4-git-send-email-konkers@android.com>
	<1276549827-2688-5-git-send-email-konkers@android.com>
	<1276549827-2688-6-git-send-email-konkers@android.com>
Message-ID: <1276549827-2688-7-git-send-email-konkers@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: fixes from Mike Rapoport:
	- move gpio-names.h to arch/arm/mach-tegra
    fixes from Russell King
	- include linux/io.h and linux/gpio.h instead of asm/io.h
	  and asm/gpio.h
    additional changes:
    	- add macros to convert between irq and gpio numbers for platform data
	- change for_each_bit to for_each_set_bit in gpio.c
v3:
	- minor bugfixes

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Erik Gilling <konkers@android.com>
---
 arch/arm/mach-tegra/Kconfig             |    1 +
 arch/arm/mach-tegra/Makefile            |    1 +
 arch/arm/mach-tegra/gpio-names.h        |  247 ++++++++++++++++++++++
 arch/arm/mach-tegra/gpio.c              |  348 +++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/include/mach/gpio.h |   53 +++++
 5 files changed, 650 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/gpio-names.h
 create mode 100644 arch/arm/mach-tegra/gpio.c
 create mode 100644 arch/arm/mach-tegra/include/mach/gpio.h

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index bcbda96..a57713c 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -9,6 +9,7 @@ config ARCH_TEGRA_2x_SOC
 	bool "Tegra 2 family"
 	select CPU_V7
 	select ARM_GIC
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 01f47fd..122f7dc 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -3,6 +3,7 @@ obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y                                   += clock.o
 obj-y                                   += timer.o
+obj-y                                   += gpio.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-tegra/gpio-names.h b/arch/arm/mach-tegra/gpio-names.h
new file mode 100644
index 0000000..f28220a
--- /dev/null
+++ b/arch/arm/mach-tegra/gpio-names.h
@@ -0,0 +1,247 @@
+/*
+ * arch/arm/mach-tegra/include/mach/gpio-names.h
+ *
+ * Copyright (c) 2010 Google, Inc
+ *
+ * Author:
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MACH_TEGRA_GPIO_NAMES_H
+#define __MACH_TEGRA_GPIO_NAMES_H
+
+#define TEGRA_GPIO_PA0		0
+#define TEGRA_GPIO_PA1		1
+#define TEGRA_GPIO_PA2		2
+#define TEGRA_GPIO_PA3		3
+#define TEGRA_GPIO_PA4		4
+#define TEGRA_GPIO_PA5		5
+#define TEGRA_GPIO_PA6		6
+#define TEGRA_GPIO_PA7		7
+#define TEGRA_GPIO_PB0		8
+#define TEGRA_GPIO_PB1		9
+#define TEGRA_GPIO_PB2		10
+#define TEGRA_GPIO_PB3		11
+#define TEGRA_GPIO_PB4		12
+#define TEGRA_GPIO_PB5		13
+#define TEGRA_GPIO_PB6		14
+#define TEGRA_GPIO_PB7		15
+#define TEGRA_GPIO_PC0		16
+#define TEGRA_GPIO_PC1		17
+#define TEGRA_GPIO_PC2		18
+#define TEGRA_GPIO_PC3		19
+#define TEGRA_GPIO_PC4		20
+#define TEGRA_GPIO_PC5		21
+#define TEGRA_GPIO_PC6		22
+#define TEGRA_GPIO_PC7		23
+#define TEGRA_GPIO_PD0		24
+#define TEGRA_GPIO_PD1		25
+#define TEGRA_GPIO_PD2		26
+#define TEGRA_GPIO_PD3		27
+#define TEGRA_GPIO_PD4		28
+#define TEGRA_GPIO_PD5		29
+#define TEGRA_GPIO_PD6		30
+#define TEGRA_GPIO_PD7		31
+#define TEGRA_GPIO_PE0		32
+#define TEGRA_GPIO_PE1		33
+#define TEGRA_GPIO_PE2		34
+#define TEGRA_GPIO_PE3		35
+#define TEGRA_GPIO_PE4		36
+#define TEGRA_GPIO_PE5		37
+#define TEGRA_GPIO_PE6		38
+#define TEGRA_GPIO_PE7		39
+#define TEGRA_GPIO_PF0		40
+#define TEGRA_GPIO_PF1		41
+#define TEGRA_GPIO_PF2		42
+#define TEGRA_GPIO_PF3		43
+#define TEGRA_GPIO_PF4		44
+#define TEGRA_GPIO_PF5		45
+#define TEGRA_GPIO_PF6		46
+#define TEGRA_GPIO_PF7		47
+#define TEGRA_GPIO_PG0		48
+#define TEGRA_GPIO_PG1		49
+#define TEGRA_GPIO_PG2		50
+#define TEGRA_GPIO_PG3		51
+#define TEGRA_GPIO_PG4		52
+#define TEGRA_GPIO_PG5		53
+#define TEGRA_GPIO_PG6		54
+#define TEGRA_GPIO_PG7		55
+#define TEGRA_GPIO_PH0		56
+#define TEGRA_GPIO_PH1		57
+#define TEGRA_GPIO_PH2		58
+#define TEGRA_GPIO_PH3		59
+#define TEGRA_GPIO_PH4		60
+#define TEGRA_GPIO_PH5		61
+#define TEGRA_GPIO_PH6		62
+#define TEGRA_GPIO_PH7		63
+#define TEGRA_GPIO_PI0		64
+#define TEGRA_GPIO_PI1		65
+#define TEGRA_GPIO_PI2		66
+#define TEGRA_GPIO_PI3		67
+#define TEGRA_GPIO_PI4		68
+#define TEGRA_GPIO_PI5		69
+#define TEGRA_GPIO_PI6		70
+#define TEGRA_GPIO_PI7		71
+#define TEGRA_GPIO_PJ0		72
+#define TEGRA_GPIO_PJ1		73
+#define TEGRA_GPIO_PJ2		74
+#define TEGRA_GPIO_PJ3		75
+#define TEGRA_GPIO_PJ4		76
+#define TEGRA_GPIO_PJ5		77
+#define TEGRA_GPIO_PJ6		78
+#define TEGRA_GPIO_PJ7		79
+#define TEGRA_GPIO_PK0		80
+#define TEGRA_GPIO_PK1		81
+#define TEGRA_GPIO_PK2		82
+#define TEGRA_GPIO_PK3		83
+#define TEGRA_GPIO_PK4		84
+#define TEGRA_GPIO_PK5		85
+#define TEGRA_GPIO_PK6		86
+#define TEGRA_GPIO_PK7		87
+#define TEGRA_GPIO_PL0		88
+#define TEGRA_GPIO_PL1		89
+#define TEGRA_GPIO_PL2		90
+#define TEGRA_GPIO_PL3		91
+#define TEGRA_GPIO_PL4		92
+#define TEGRA_GPIO_PL5		93
+#define TEGRA_GPIO_PL6		94
+#define TEGRA_GPIO_PL7		95
+#define TEGRA_GPIO_PM0		96
+#define TEGRA_GPIO_PM1		97
+#define TEGRA_GPIO_PM2		98
+#define TEGRA_GPIO_PM3		99
+#define TEGRA_GPIO_PM4		100
+#define TEGRA_GPIO_PM5		101
+#define TEGRA_GPIO_PM6		102
+#define TEGRA_GPIO_PM7		103
+#define TEGRA_GPIO_PN0		104
+#define TEGRA_GPIO_PN1		105
+#define TEGRA_GPIO_PN2		106
+#define TEGRA_GPIO_PN3		107
+#define TEGRA_GPIO_PN4		108
+#define TEGRA_GPIO_PN5		109
+#define TEGRA_GPIO_PN6		110
+#define TEGRA_GPIO_PN7		111
+#define TEGRA_GPIO_PO0		112
+#define TEGRA_GPIO_PO1		113
+#define TEGRA_GPIO_PO2		114
+#define TEGRA_GPIO_PO3		115
+#define TEGRA_GPIO_PO4		116
+#define TEGRA_GPIO_PO5		117
+#define TEGRA_GPIO_PO6		118
+#define TEGRA_GPIO_PO7		119
+#define TEGRA_GPIO_PP0		120
+#define TEGRA_GPIO_PP1		121
+#define TEGRA_GPIO_PP2		122
+#define TEGRA_GPIO_PP3		123
+#define TEGRA_GPIO_PP4		124
+#define TEGRA_GPIO_PP5		125
+#define TEGRA_GPIO_PP6		126
+#define TEGRA_GPIO_PP7		127
+#define TEGRA_GPIO_PQ0		128
+#define TEGRA_GPIO_PQ1		129
+#define TEGRA_GPIO_PQ2		130
+#define TEGRA_GPIO_PQ3		131
+#define TEGRA_GPIO_PQ4		132
+#define TEGRA_GPIO_PQ5		133
+#define TEGRA_GPIO_PQ6		134
+#define TEGRA_GPIO_PQ7		135
+#define TEGRA_GPIO_PR0		136
+#define TEGRA_GPIO_PR1		137
+#define TEGRA_GPIO_PR2		138
+#define TEGRA_GPIO_PR3		139
+#define TEGRA_GPIO_PR4		140
+#define TEGRA_GPIO_PR5		141
+#define TEGRA_GPIO_PR6		142
+#define TEGRA_GPIO_PR7		143
+#define TEGRA_GPIO_PS0		144
+#define TEGRA_GPIO_PS1		145
+#define TEGRA_GPIO_PS2		146
+#define TEGRA_GPIO_PS3		147
+#define TEGRA_GPIO_PS4		148
+#define TEGRA_GPIO_PS5		149
+#define TEGRA_GPIO_PS6		150
+#define TEGRA_GPIO_PS7		151
+#define TEGRA_GPIO_PT0		152
+#define TEGRA_GPIO_PT1		153
+#define TEGRA_GPIO_PT2		154
+#define TEGRA_GPIO_PT3		155
+#define TEGRA_GPIO_PT4		156
+#define TEGRA_GPIO_PT5		157
+#define TEGRA_GPIO_PT6		158
+#define TEGRA_GPIO_PT7		159
+#define TEGRA_GPIO_PU0		160
+#define TEGRA_GPIO_PU1		161
+#define TEGRA_GPIO_PU2		162
+#define TEGRA_GPIO_PU3		163
+#define TEGRA_GPIO_PU4		164
+#define TEGRA_GPIO_PU5		165
+#define TEGRA_GPIO_PU6		166
+#define TEGRA_GPIO_PU7		167
+#define TEGRA_GPIO_PV0		168
+#define TEGRA_GPIO_PV1		169
+#define TEGRA_GPIO_PV2		170
+#define TEGRA_GPIO_PV3		171
+#define TEGRA_GPIO_PV4		172
+#define TEGRA_GPIO_PV5		173
+#define TEGRA_GPIO_PV6		174
+#define TEGRA_GPIO_PV7		175
+#define TEGRA_GPIO_PW0		176
+#define TEGRA_GPIO_PW1		177
+#define TEGRA_GPIO_PW2		178
+#define TEGRA_GPIO_PW3		179
+#define TEGRA_GPIO_PW4		180
+#define TEGRA_GPIO_PW5		181
+#define TEGRA_GPIO_PW6		182
+#define TEGRA_GPIO_PW7		183
+#define TEGRA_GPIO_PX0		184
+#define TEGRA_GPIO_PX1		185
+#define TEGRA_GPIO_PX2		186
+#define TEGRA_GPIO_PX3		187
+#define TEGRA_GPIO_PX4		188
+#define TEGRA_GPIO_PX5		189
+#define TEGRA_GPIO_PX6		190
+#define TEGRA_GPIO_PX7		191
+#define TEGRA_GPIO_PY0		192
+#define TEGRA_GPIO_PY1		193
+#define TEGRA_GPIO_PY2		194
+#define TEGRA_GPIO_PY3		195
+#define TEGRA_GPIO_PY4		196
+#define TEGRA_GPIO_PY5		197
+#define TEGRA_GPIO_PY6		198
+#define TEGRA_GPIO_PY7		199
+#define TEGRA_GPIO_PZ0		200
+#define TEGRA_GPIO_PZ1		201
+#define TEGRA_GPIO_PZ2		202
+#define TEGRA_GPIO_PZ3		203
+#define TEGRA_GPIO_PZ4		204
+#define TEGRA_GPIO_PZ5		205
+#define TEGRA_GPIO_PZ6		206
+#define TEGRA_GPIO_PZ7		207
+#define TEGRA_GPIO_PAA0		208
+#define TEGRA_GPIO_PAA1		209
+#define TEGRA_GPIO_PAA2		210
+#define TEGRA_GPIO_PAA3		211
+#define TEGRA_GPIO_PAA4		212
+#define TEGRA_GPIO_PAA5		213
+#define TEGRA_GPIO_PAA6		214
+#define TEGRA_GPIO_PAA7		215
+#define TEGRA_GPIO_PBB0		216
+#define TEGRA_GPIO_PBB1		217
+#define TEGRA_GPIO_PBB2		218
+#define TEGRA_GPIO_PBB3		219
+#define TEGRA_GPIO_PBB4		220
+#define TEGRA_GPIO_PBB5		221
+#define TEGRA_GPIO_PBB6		222
+#define TEGRA_GPIO_PBB7		223
+
+#endif
diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
new file mode 100644
index 0000000..fe78fba
--- /dev/null
+++ b/arch/arm/mach-tegra/gpio.c
@@ -0,0 +1,348 @@
+/*
+ * arch/arm/mach-tegra/gpio.c
+ *
+ * Copyright (c) 2010 Google, Inc
+ *
+ * Author:
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <mach/iomap.h>
+
+#define GPIO_BANK(x)		((x) >> 5)
+#define GPIO_PORT(x)		(((x) >> 3) & 0x3)
+#define GPIO_BIT(x)		((x) & 0x7)
+
+#define GPIO_REG(x)		(IO_TO_VIRT(TEGRA_GPIO_BASE) +	\
+				 GPIO_BANK(x) * 0x80 +		\
+				 GPIO_PORT(x) * 4)
+
+#define GPIO_CNF(x)		(GPIO_REG(x) + 0x00)
+#define GPIO_OE(x)		(GPIO_REG(x) + 0x10)
+#define GPIO_OUT(x)		(GPIO_REG(x) + 0X20)
+#define GPIO_IN(x)		(GPIO_REG(x) + 0x30)
+#define GPIO_INT_STA(x)		(GPIO_REG(x) + 0x40)
+#define GPIO_INT_ENB(x)		(GPIO_REG(x) + 0x50)
+#define GPIO_INT_LVL(x)		(GPIO_REG(x) + 0x60)
+#define GPIO_INT_CLR(x)		(GPIO_REG(x) + 0x70)
+
+#define GPIO_MSK_CNF(x)		(GPIO_REG(x) + 0x800)
+#define GPIO_MSK_OE(x)		(GPIO_REG(x) + 0x810)
+#define GPIO_MSK_OUT(x)		(GPIO_REG(x) + 0X820)
+#define GPIO_MSK_INT_STA(x)	(GPIO_REG(x) + 0x840)
+#define GPIO_MSK_INT_ENB(x)	(GPIO_REG(x) + 0x850)
+#define GPIO_MSK_INT_LVL(x)	(GPIO_REG(x) + 0x860)
+
+#define GPIO_INT_LVL_MASK		0x010101
+#define GPIO_INT_LVL_EDGE_RISING	0x000101
+#define GPIO_INT_LVL_EDGE_FALLING	0x000100
+#define GPIO_INT_LVL_EDGE_BOTH		0x010100
+#define GPIO_INT_LVL_LEVEL_HIGH		0x000001
+#define GPIO_INT_LVL_LEVEL_LOW		0x000000
+
+struct tegra_gpio_bank {
+	int bank;
+	int irq;
+	spinlock_t lvl_lock[4];
+};
+
+
+static struct tegra_gpio_bank tegra_gpio_banks[] = {
+	{.bank = 0, .irq = INT_GPIO1},
+	{.bank = 1, .irq = INT_GPIO2},
+	{.bank = 2, .irq = INT_GPIO3},
+	{.bank = 3, .irq = INT_GPIO4},
+	{.bank = 4, .irq = INT_GPIO5},
+	{.bank = 5, .irq = INT_GPIO6},
+	{.bank = 6, .irq = INT_GPIO7},
+};
+
+static int tegra_gpio_compose(int bank, int port, int bit)
+{
+	return (bank << 5) | ((port & 0x3) << 3) | (bit & 0x7);
+}
+
+static void tegra_gpio_mask_write(u32 reg, int gpio, int value)
+{
+	u32 val;
+
+	val = 0x100 << GPIO_BIT(gpio);
+	if (value)
+		val |= 1 << GPIO_BIT(gpio);
+	__raw_writel(val, reg);
+}
+
+void tegra_gpio_enable(int gpio)
+{
+	tegra_gpio_mask_write(GPIO_MSK_CNF(gpio), gpio, 1);
+}
+
+void tegra_gpio_disable(int gpio)
+{
+	tegra_gpio_mask_write(GPIO_MSK_CNF(gpio), gpio, 0);
+}
+
+static void tegra_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	tegra_gpio_mask_write(GPIO_MSK_OUT(offset), offset, value);
+}
+
+static int tegra_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	return (__raw_readl(GPIO_IN(offset)) >> GPIO_BIT(offset)) & 0x1;
+}
+
+static int tegra_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	tegra_gpio_mask_write(GPIO_MSK_OE(offset), offset, 0);
+	return 0;
+}
+
+static int tegra_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+					int value)
+{
+	tegra_gpio_set(chip, offset, value);
+	tegra_gpio_mask_write(GPIO_MSK_OE(offset), offset, 1);
+	return 0;
+}
+
+
+
+static struct gpio_chip tegra_gpio_chip = {
+	.label			= "tegra-gpio",
+	.direction_input	= tegra_gpio_direction_input,
+	.get			= tegra_gpio_get,
+	.direction_output	= tegra_gpio_direction_output,
+	.set			= tegra_gpio_set,
+	.base			= 0,
+	.ngpio			= ARCH_NR_GPIOS,
+};
+
+static void tegra_gpio_irq_ack(unsigned int irq)
+{
+	int gpio = irq - INT_GPIO_BASE;
+
+	__raw_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
+}
+
+static void tegra_gpio_irq_mask(unsigned int irq)
+{
+	int gpio = irq - INT_GPIO_BASE;
+
+	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 0);
+}
+
+static void tegra_gpio_irq_unmask(unsigned int irq)
+{
+	int gpio = irq - INT_GPIO_BASE;
+
+	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 1);
+}
+
+static int tegra_gpio_irq_set_type(unsigned int irq, unsigned int type)
+{
+	int gpio = irq - INT_GPIO_BASE;
+	struct tegra_gpio_bank *bank = get_irq_chip_data(irq);
+	int port = GPIO_PORT(gpio);
+	int lvl_type;
+	int val;
+	unsigned long flags;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+		lvl_type = GPIO_INT_LVL_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		lvl_type = GPIO_INT_LVL_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		lvl_type = GPIO_INT_LVL_EDGE_BOTH;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		lvl_type = GPIO_INT_LVL_LEVEL_HIGH;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		lvl_type = GPIO_INT_LVL_LEVEL_LOW;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&bank->lvl_lock[port], flags);
+
+	val = __raw_readl(GPIO_INT_LVL(gpio));
+	val &= ~(GPIO_INT_LVL_MASK << GPIO_BIT(gpio));
+	val |= lvl_type << GPIO_BIT(gpio);
+	__raw_writel(val, GPIO_INT_LVL(gpio));
+
+	spin_unlock_irqrestore(&bank->lvl_lock[port], flags);
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
+		__set_irq_handler_unlocked(irq, handle_level_irq);
+	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
+		__set_irq_handler_unlocked(irq, handle_edge_irq);
+
+	return 0;
+}
+
+static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct tegra_gpio_bank *bank;
+	int port;
+	int pin;
+	int unmasked = 0;
+
+	desc->chip->ack(irq);
+
+	bank = get_irq_data(irq);
+
+	for (port = 0; port < 4; port++) {
+		int gpio = tegra_gpio_compose(bank->bank, port, 0);
+		unsigned long sta = __raw_readl(GPIO_INT_STA(gpio)) &
+			__raw_readl(GPIO_INT_ENB(gpio));
+		u32 lvl = __raw_readl(GPIO_INT_LVL(gpio));
+
+		for_each_set_bit(pin, &sta, 8) {
+			__raw_writel(1 << pin, GPIO_INT_CLR(gpio));
+
+			/* if gpio is edge triggered, clear condition
+			 * before executing the hander so that we don't
+			 * miss edges
+			 */
+			if (lvl & (0x100 << pin)) {
+				unmasked = 1;
+				desc->chip->unmask(irq);
+			}
+
+			generic_handle_irq(gpio_to_irq(gpio + pin));
+		}
+	}
+
+	if (!unmasked)
+		desc->chip->unmask(irq);
+
+}
+
+
+static struct irq_chip tegra_gpio_irq_chip = {
+	.name		= "GPIO",
+	.ack		= tegra_gpio_irq_ack,
+	.mask		= tegra_gpio_irq_mask,
+	.unmask		= tegra_gpio_irq_unmask,
+	.set_type	= tegra_gpio_irq_set_type,
+};
+
+
+/* This lock class tells lockdep that GPIO irqs are in a different
+ * category than their parents, so it won't report false recursion.
+ */
+static struct lock_class_key gpio_lock_class;
+
+static int __init tegra_gpio_init(void)
+{
+	struct tegra_gpio_bank *bank;
+	int i;
+	int j;
+
+	for (i = 0; i < 7; i++) {
+		for (j = 0; j < 4; j++) {
+			int gpio = tegra_gpio_compose(i, j, 0);
+			__raw_writel(0x00, GPIO_INT_ENB(gpio));
+		}
+	}
+
+	gpiochip_add(&tegra_gpio_chip);
+
+	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + ARCH_NR_GPIOS); i++) {
+		bank = &tegra_gpio_banks[GPIO_BANK(irq_to_gpio(i))];
+
+		lockdep_set_class(&irq_desc[i].lock, &gpio_lock_class);
+		set_irq_chip_data(i, bank);
+		set_irq_chip(i, &tegra_gpio_irq_chip);
+		set_irq_handler(i, handle_simple_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
+		bank = &tegra_gpio_banks[i];
+
+		set_irq_chained_handler(bank->irq, tegra_gpio_irq_handler);
+		set_irq_data(bank->irq, bank);
+
+		for (j = 0; j < 4; j++)
+			spin_lock_init(&bank->lvl_lock[j]);
+	}
+
+	return 0;
+}
+
+postcore_initcall(tegra_gpio_init);
+
+#ifdef	CONFIG_DEBUG_FS
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static int dbg_gpio_show(struct seq_file *s, void *unused)
+{
+	int i;
+	int j;
+
+	for (i = 0; i < 7; i++) {
+		for (j = 0; j < 4; j++) {
+			int gpio = tegra_gpio_compose(i, j, 0);
+			seq_printf(s, "%d:%d %02x %02x %02x %02x %02x %02x %06x\n",
+			       i, j,
+			       __raw_readl(GPIO_CNF(gpio)),
+			       __raw_readl(GPIO_OE(gpio)),
+			       __raw_readl(GPIO_OUT(gpio)),
+			       __raw_readl(GPIO_IN(gpio)),
+			       __raw_readl(GPIO_INT_STA(gpio)),
+			       __raw_readl(GPIO_INT_ENB(gpio)),
+			       __raw_readl(GPIO_INT_LVL(gpio)));
+		}
+	}
+	return 0;
+}
+
+static int dbg_gpio_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dbg_gpio_show, &inode->i_private);
+}
+
+static const struct file_operations debug_fops = {
+	.open		= dbg_gpio_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init tegra_gpio_debuginit(void)
+{
+	(void) debugfs_create_file("tegra_gpio", S_IRUGO,
+					NULL, NULL, &debug_fops);
+	return 0;
+}
+late_initcall(tegra_gpio_debuginit);
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
new file mode 100644
index 0000000..540e822
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -0,0 +1,53 @@
+/*
+ * arch/arm/mach-tegra/include/mach/gpio.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_GPIO_H
+#define __MACH_TEGRA_GPIO_H
+
+#include <mach/irqs.h>
+
+#define ARCH_NR_GPIOS		INT_GPIO_NR
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value		__gpio_get_value
+#define gpio_set_value		__gpio_set_value
+#define gpio_cansleep		__gpio_cansleep
+
+#define TEGRA_GPIO_TO_IRQ(gpio) (INT_GPIO_BASE + (gpio))
+#define TEGRA_IRQ_TO_GPIO(irq) ((gpio) - INT_GPIO_BASE)
+
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	if (gpio < ARCH_NR_GPIOS)
+		return INT_GPIO_BASE + gpio;
+	return -EINVAL;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	if ((irq >= INT_GPIO_BASE) && (irq < INT_GPIO_BASE + INT_GPIO_NR))
+		return irq - INT_GPIO_BASE;
+	return -EINVAL;
+}
+
+void tegra_gpio_enable(int gpio);
+void tegra_gpio_disable(int gpio);
+
+#endif
-- 
1.6.5.6
