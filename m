From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:35 +0530
Subject: [PATCH V2 15/69] ST SPEAr: Adding PLGPIO driver for spear platform
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <11e011e9f14a3a763aff8403989ee12dfd06a379.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Plgpio pads on few spear machines can be configured as gpios. This patch add
support for configuring these PLGPIOs.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear3xx/include/mach/gpio.h    |  141 ++++++++
 arch/arm/mach-spear3xx/include/mach/irqs.h    |    9 +-
 arch/arm/mach-spear3xx/spear310.c             |   69 ++++
 arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320.c             |   30 ++-
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear6xx/include/mach/gpio.h    |   27 ++
 arch/arm/plat-spear/Makefile                  |    2 +
 arch/arm/plat-spear/include/plat/gpio.h       |   35 ++
 arch/arm/plat-spear/plgpio.c                  |  452 +++++++++++++++++++++++++
 11 files changed, 764 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/plat-spear/plgpio.c

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 1c8f9f1..d76ee98 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -144,6 +144,7 @@ extern struct clcd_board clcd_plat_data;
 /* spear310 declarations */
 #ifdef CONFIG_MACH_SPEAR310
 /* Add spear310 machine device structure declarations here */
+extern struct platform_device plgpio_device;
 
 /* pad mux devices */
 extern struct pmx_dev pmx_emi_cs_0_1_4_5;
@@ -164,6 +165,7 @@ void __init spear310_init(void);
 #ifdef CONFIG_MACH_SPEAR320
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
+extern struct platform_device plgpio_device;
 
 /* pad mux modes */
 extern struct pmx_mode auto_net_smii_mode;
diff --git a/arch/arm/mach-spear3xx/include/mach/gpio.h b/arch/arm/mach-spear3xx/include/mach/gpio.h
index 451b208..e531f6d 100644
--- a/arch/arm/mach-spear3xx/include/mach/gpio.h
+++ b/arch/arm/mach-spear3xx/include/mach/gpio.h
@@ -16,4 +16,145 @@
 
 #include <plat/gpio.h>
 
+#ifdef CONFIG_MACH_SPEAR310
+#define PLGPIO_ENB		0x0010
+#define PLGPIO_WDATA		0x0020
+#define PLGPIO_DIR		0x0030
+#define PLGPIO_IE		0x0040
+#define PLGPIO_RDATA		0x0050
+#define PLGPIO_MIS		0x0060
+
+#elif defined(CONFIG_MACH_SPEAR320)
+#define PLGPIO_ENB		0x0024
+#define PLGPIO_WDATA		0x0034
+#define PLGPIO_DIR		0x0044
+#define PLGPIO_RDATA		0x0054
+#define PLGPIO_IE		0x0064
+#define PLGPIO_MIS		0x0074
+#endif
+
+#define BASIC_GPIO_0		0
+#define BASIC_GPIO_1		1
+#define BASIC_GPIO_2		2
+#define BASIC_GPIO_3		3
+#define BASIC_GPIO_4		4
+#define BASIC_GPIO_5		5
+#define BASIC_GPIO_6		6
+#define BASIC_GPIO_7		7
+
+#ifdef CONFIG_MACH_SPEAR300
+#define RAS_GPIO_0		8
+#define RAS_GPIO_1		9
+#define RAS_GPIO_2		10
+#define RAS_GPIO_3		11
+#define RAS_GPIO_4		12
+#define RAS_GPIO_5		13
+#define RAS_GPIO_6		14
+#define RAS_GPIO_7		15
+
+#elif defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+#define PLGPIO_0		8
+#define PLGPIO_1		9
+#define PLGPIO_2		10
+#define PLGPIO_3		11
+#define PLGPIO_4		12
+#define PLGPIO_5		13
+#define PLGPIO_6		14
+#define PLGPIO_7		15
+#define PLGPIO_8		16
+#define PLGPIO_9		17
+#define PLGPIO_10		18
+#define PLGPIO_11		19
+#define PLGPIO_12		20
+#define PLGPIO_13		21
+#define PLGPIO_14		22
+#define PLGPIO_15		23
+#define PLGPIO_16		24
+#define PLGPIO_17		25
+#define PLGPIO_18		26
+#define PLGPIO_19		27
+#define PLGPIO_20		28
+#define PLGPIO_21		29
+#define PLGPIO_22		30
+#define PLGPIO_23		31
+#define PLGPIO_24		32
+#define PLGPIO_25		33
+#define PLGPIO_26		34
+#define PLGPIO_27		35
+#define PLGPIO_28		36
+#define PLGPIO_29		37
+#define PLGPIO_30		38
+#define PLGPIO_31		39
+#define PLGPIO_32		40
+#define PLGPIO_33		41
+#define PLGPIO_34		42
+#define PLGPIO_35		43
+#define PLGPIO_36		44
+#define PLGPIO_37		45
+#define PLGPIO_38		46
+#define PLGPIO_39		47
+#define PLGPIO_40		48
+#define PLGPIO_41		49
+#define PLGPIO_42		50
+#define PLGPIO_43		51
+#define PLGPIO_44		52
+#define PLGPIO_45		53
+#define PLGPIO_46		54
+#define PLGPIO_47		55
+#define PLGPIO_48		56
+#define PLGPIO_49		57
+#define PLGPIO_50		58
+#define PLGPIO_51		59
+#define PLGPIO_52		60
+#define PLGPIO_53		61
+#define PLGPIO_54		62
+#define PLGPIO_55		63
+#define PLGPIO_56		64
+#define PLGPIO_57		65
+#define PLGPIO_58		66
+#define PLGPIO_59		67
+#define PLGPIO_60		68
+#define PLGPIO_61		69
+#define PLGPIO_62		70
+#define PLGPIO_63		71
+#define PLGPIO_64		72
+#define PLGPIO_65		73
+#define PLGPIO_66		74
+#define PLGPIO_67		75
+#define PLGPIO_68		76
+#define PLGPIO_69		77
+#define PLGPIO_70		78
+#define PLGPIO_71		79
+#define PLGPIO_72		80
+#define PLGPIO_73		81
+#define PLGPIO_74		82
+#define PLGPIO_75		83
+#define PLGPIO_76		84
+#define PLGPIO_77		85
+#define PLGPIO_78		86
+#define PLGPIO_79		87
+#define PLGPIO_80		88
+#define PLGPIO_81		89
+#define PLGPIO_82		90
+#define PLGPIO_83		91
+#define PLGPIO_84		92
+#define PLGPIO_85		93
+#define PLGPIO_86		94
+#define PLGPIO_87		95
+#define PLGPIO_88		96
+#define PLGPIO_89		97
+#define PLGPIO_90		98
+#define PLGPIO_91		99
+#define PLGPIO_92		100
+#define PLGPIO_93		101
+#define PLGPIO_94		102
+#define PLGPIO_95		103
+#define PLGPIO_96		104
+#define PLGPIO_97		105
+#define PLGPIO_98		106
+#define PLGPIO_99		107
+#define PLGPIO_100		108
+#define PLGPIO_101		109
+#endif /* CONFIG_MACH_SPEAR310 || CONFIG_MACH_SPEAR320 */
+
 #endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index 7f940b8..f1175b9 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -141,12 +141,13 @@
 #endif
 
 /* PLGPIO Virtual IRQs */
+#define SPEAR_PLGPIO_COUNT	102
 #if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
-#define SPEAR_PLGPIO_INT_BASE			(SPEAR_GPIO_INT_BASE + 8)
-#define SPEAR_GPIO_INT_END			(SPEAR_PLGPIO_INT_BASE + 102)
+#define SPEAR_PLGPIO_INT_BASE	(SPEAR_GPIO_INT_BASE + 8)
+#define SPEAR_GPIO_INT_END	(SPEAR_PLGPIO_INT_BASE + SPEAR_PLGPIO_COUNT)
 #endif
 
-#define VIRQ_END				SPEAR_GPIO_INT_END
-#define NR_IRQS					VIRQ_END
+#define VIRQ_END		SPEAR_GPIO_INT_END
+#define NR_IRQS			VIRQ_END
 
 #endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 576bc57..88b55b5 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/gpio.h>
 #include <plat/shirq.h>
 
 /* pad multiplexing support */
@@ -140,6 +141,74 @@ struct pmx_driver pmx_driver = {
 };
 
 /* Add spear310 specific devices here */
+/* plgpio device registeration */
+/*
+ * pin to offset and offset to pin converter functions
+ *
+ * In spear310 there is inconsistency among bit positions in plgpio regiseters,
+ * for different plgpio pins. For example: for pin 27, bit offset is 23, pin
+ * 28-33 are not supported, pin 95 has offset bit 95, bit 100 has offset bit 1
+ */
+static int spear300_p2o(int pin)
+{
+	int offset = pin;
+
+	if (pin <= 27)
+		offset += 4;
+	else if (pin <= 33)
+		offset = -1;
+	else if (pin <= 97)
+		offset -= 2;
+	else if (pin <= 101)
+		offset = 101 - pin;
+	else
+		offset = -1;
+
+	return offset;
+}
+
+int spear300_o2p(int offset)
+{
+	if (offset <= 3)
+		return 101 - offset;
+	else if (offset <= 31)
+		return offset - 4;
+	else
+		return offset + 2;
+}
+
+static struct plgpio_platform_data plgpio_plat_data = {
+	.gpio_base = 8,
+	.irq_base = SPEAR_PLGPIO_INT_BASE,
+	.gpio_count = SPEAR_PLGPIO_COUNT,
+	.p2o = spear300_p2o,
+	.o2p = spear300_o2p,
+	/* list of registers with inconsistency */
+	.p2o_regs = PTO_RDATA_REG | PTO_WDATA_REG | PTO_DIR_REG |
+		PTO_IE_REG | PTO_RDATA_REG | PTO_MIS_REG,
+};
+
+static struct resource plgpio_resources[] = {
+	{
+		.start = SPEAR310_SOC_CONFIG_BASE,
+		.end = SPEAR310_SOC_CONFIG_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_PLGPIO,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device plgpio_device = {
+	.name = "plgpio",
+	.id = -1,
+	.dev = {
+		.platform_data = &plgpio_plat_data,
+	},
+	.num_resources = ARRAY_SIZE(plgpio_resources),
+	.resource = plgpio_resources,
+};
+
 
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 3855431..7dd93bd 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -52,6 +52,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 
 	/* spear310 specific devices */
+	&plgpio_device,
 };
 
 static void __init spear310_evb_init(void)
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index e5baa00..2e388dd 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/gpio.h>
 #include <plat/shirq.h>
 
 /* pad multiplexing support */
@@ -385,7 +386,6 @@ struct pmx_driver pmx_driver = {
 };
 
 /* Add spear320 specific devices here */
-
 /* CLCD device registration */
 struct amba_device clcd_device = {
 	.dev = {
@@ -402,6 +402,34 @@ struct amba_device clcd_device = {
 	.irq = {VIRQ_CLCD, NO_IRQ},
 };
 
+/* plgpio device registeration */
+static struct plgpio_platform_data plgpio_plat_data = {
+	.gpio_base = 8,
+	.irq_base = SPEAR_PLGPIO_INT_BASE,
+	.gpio_count = SPEAR_PLGPIO_COUNT,
+};
+
+static struct resource plgpio_resources[] = {
+	{
+		.start = SPEAR320_SOC_CONFIG_BASE,
+		.end = SPEAR320_SOC_CONFIG_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_PLGPIO,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device plgpio_device = {
+	.name = "plgpio",
+	.id = -1,
+	.dev = {
+		.platform_data = &plgpio_plat_data,
+	},
+	.num_resources = ARRAY_SIZE(plgpio_resources),
+	.resource = plgpio_resources,
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 821e806..82f4e76 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -50,6 +50,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 
 	/* spear320 specific devices */
+	&plgpio_device,
 };
 
 static void __init spear320_evb_init(void)
diff --git a/arch/arm/mach-spear6xx/include/mach/gpio.h b/arch/arm/mach-spear6xx/include/mach/gpio.h
index 3a789db..465b2e7 100644
--- a/arch/arm/mach-spear6xx/include/mach/gpio.h
+++ b/arch/arm/mach-spear6xx/include/mach/gpio.h
@@ -16,4 +16,31 @@
 
 #include <plat/gpio.h>
 
+#define CPU_GPIO_0		0
+#define CPU_GPIO_1		1
+#define CPU_GPIO_2		2
+#define CPU_GPIO_3		3
+#define CPU_GPIO_4		4
+#define CPU_GPIO_5		5
+#define CPU_GPIO_6		6
+#define CPU_GPIO_7		7
+
+#define BASIC_GPIO_0		8
+#define BASIC_GPIO_1		9
+#define BASIC_GPIO_2		10
+#define BASIC_GPIO_3		11
+#define BASIC_GPIO_4		12
+#define BASIC_GPIO_5		13
+#define BASIC_GPIO_6		14
+#define BASIC_GPIO_7		15
+
+#define APPL_GPIO_0		16
+#define APPL_GPIO_1		17
+#define APPL_GPIO_2		18
+#define APPL_GPIO_3		19
+#define APPL_GPIO_4		20
+#define APPL_GPIO_5		21
+#define APPL_GPIO_6		22
+#define APPL_GPIO_7		23
+
 #endif /* __MACH_GPIO_H */
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 01a4a91..e66bc5f 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -6,3 +6,5 @@
 obj-y	:= clcd.o clock.o time.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
+obj-$(CONFIG_MACH_SPEAR310)	+= plgpio.o
+obj-$(CONFIG_MACH_SPEAR320)	+= plgpio.o
diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
index b857c91..450671e 100644
--- a/arch/arm/plat-spear/include/plat/gpio.h
+++ b/arch/arm/plat-spear/include/plat/gpio.h
@@ -21,4 +21,39 @@
 #define gpio_cansleep	__gpio_cansleep
 #define gpio_to_irq	__gpio_to_irq
 
+/* plgpio driver declarations */
+/*
+ * plgpio pins in all machines are not one to one mapped, bitwise with
+ * registers bits. These set of macros define register masks for which below
+ * functions (pin_to_offset and offset_to_pin) are required to be called.
+ */
+#define PTO_ENB_REG		0x001
+#define PTO_WDATA_REG		0x002
+#define PTO_DIR_REG		0x004
+#define PTO_IE_REG		0x008
+#define PTO_RDATA_REG		0x010
+#define PTO_MIS_REG		0x020
+
+/* functions for converting pin to correct offset in register and vice versa */
+/**
+ * struct plgpio_platform_data: plgpio driver platform data
+ *
+ * gpio_base: gpio start number of plgpios
+ * irq_base: irq number of plgpio0
+ * gpio_count: total count of plgpios
+ * p2o: function ptr for pin to offset conversion. This is required only for
+ * machines where mapping b/w pin and offset is not 1-to-1.
+ * o2p: function ptr for offset to pin conversion. This is required only for
+ * machines where mapping b/w pin and offset is not 1-to-1.
+ * p2o_regs: mask of registers for which p2o and o2p are applicable
+ */
+struct plgpio_platform_data {
+	u32 gpio_base;
+	u32 irq_base;
+	u32 gpio_count;
+	int (*p2o)(int pin);		/* pin_to_offset */
+	int (*o2p)(int offset);		/* offset_to_pin */
+	u32 p2o_regs;
+};
+
 #endif /* __PLAT_GPIO_H */
diff --git a/arch/arm/plat-spear/plgpio.c b/arch/arm/plat-spear/plgpio.c
new file mode 100644
index 0000000..3080178
--- /dev/null
+++ b/arch/arm/plat-spear/plgpio.c
@@ -0,0 +1,452 @@
+/*
+ * arch/arm/plat-spear/plgpio.c
+ *
+ * SPEAr platform PLGPIO driver source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#define MAX_GPIO_PER_REG		32
+#define PIN_OFFSET(pin)			(pin % MAX_GPIO_PER_REG)
+#define REG_OFFSET(base, reg, pin)	(base + reg + (pin / MAX_GPIO_PER_REG)\
+		* sizeof(int *))
+
+/*
+ * struct plgpio: plgpio driver specific structure
+ *
+ * lock: lock for guarding gpio registers
+ * base: base address of plgpio block
+ * irq_base: irq number of plgpio0
+ * chip: gpio framework specific chip information structure
+ * p2o: function ptr for pin to offset conversion. This is required only for
+ * machines where mapping b/w pin and offset is not 1-to-1.
+ * o2p: function ptr for offset to pin conversion. This is required only for
+ * machines where mapping b/w pin and offset is not 1-to-1.
+ * p2o_regs: mask of registers for which p2o and o2p are applicable
+ */
+struct plgpio {
+	spinlock_t		lock;
+	void __iomem		*base;
+	unsigned		irq_base;
+	struct gpio_chip	chip;
+	int (*p2o)(int pin);		/* pin_to_offset */
+	int (*o2p)(int offset);		/* offset_to_pin */
+	u32			p2o_regs;
+};
+
+/* register manipulation inline functions */
+static inline u32 is_plgpio_set(void __iomem *base, u32 pin, u32 reg)
+{
+	u32 offset = PIN_OFFSET(pin);
+	void __iomem *reg_off = REG_OFFSET(base, reg, pin);
+	u32 val = readl(reg_off);
+
+	return val & (1 << offset);
+}
+
+static inline void plgpio_reg_set(void __iomem *base, u32 pin, u32 reg)
+{
+	u32 offset = PIN_OFFSET(pin);
+	void __iomem *reg_off = REG_OFFSET(base, reg, pin);
+	u32 val = readl(reg_off);
+
+	writel(val | (1 << offset), reg_off);
+}
+
+static inline void plgpio_reg_reset(void __iomem *base, u32 pin, u32 reg)
+{
+	u32 offset = PIN_OFFSET(pin);
+	void __iomem *reg_off = REG_OFFSET(base, reg, pin);
+	u32 val = readl(reg_off);
+
+	writel(val & ~(1 << offset), reg_off);
+}
+
+/* gpio framework specific routines */
+static int plgpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct plgpio *plgpio = container_of(chip, struct plgpio, chip);
+	unsigned long flags;
+
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & PTO_DIR_REG)) {
+		offset = plgpio->p2o(offset);
+		if (offset == -1)
+			return -EINVAL;
+	}
+
+	spin_lock_irqsave(&plgpio->lock, flags);
+	plgpio_reg_set(plgpio->base, offset, PLGPIO_DIR);
+	spin_unlock_irqrestore(&plgpio->lock, flags);
+
+	return 0;
+}
+
+static int plgpio_direction_output(struct gpio_chip *chip, unsigned offset,
+		int value)
+{
+	struct plgpio *plgpio = container_of(chip, struct plgpio, chip);
+	unsigned long flags;
+	unsigned dir_offset = offset, wdata_offset = offset, tmp;
+
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & (PTO_DIR_REG | PTO_WDATA_REG))) {
+		tmp = plgpio->p2o(offset);
+		if (tmp == -1)
+			return -EINVAL;
+
+		if (plgpio->p2o_regs & PTO_DIR_REG)
+			dir_offset = tmp;
+		if (plgpio->p2o_regs & PTO_WDATA_REG)
+			wdata_offset = tmp;
+	}
+
+	spin_lock_irqsave(&plgpio->lock, flags);
+	plgpio_reg_reset(plgpio->base, dir_offset, PLGPIO_DIR);
+	if (value)
+		plgpio_reg_set(plgpio->base, wdata_offset, PLGPIO_WDATA);
+	else
+		plgpio_reg_reset(plgpio->base, wdata_offset, PLGPIO_WDATA);
+	spin_unlock_irqrestore(&plgpio->lock, flags);
+
+	return 0;
+}
+
+static int plgpio_get_value(struct gpio_chip *chip, unsigned offset)
+{
+	struct plgpio *plgpio = container_of(chip, struct plgpio, chip);
+
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & PTO_RDATA_REG)) {
+		offset = plgpio->p2o(offset);
+		if (offset == -1)
+			return -EINVAL;
+	}
+
+	return is_plgpio_set(plgpio->base, offset, PLGPIO_RDATA);
+}
+
+static void plgpio_set_value(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct plgpio *plgpio = container_of(chip, struct plgpio, chip);
+
+	if (offset >= chip->ngpio)
+		return;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & PTO_WDATA_REG)) {
+		offset = plgpio->p2o(offset);
+		if (offset == -1)
+			return;
+	}
+
+	if (value)
+		plgpio_reg_set(plgpio->base, offset, PLGPIO_WDATA);
+	else
+		plgpio_reg_reset(plgpio->base, offset, PLGPIO_WDATA);
+}
+
+static int plgpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct plgpio *plgpio = container_of(chip, struct plgpio, chip);
+	unsigned long flags;
+	int ret = 0;
+
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	/*
+	 * put gpio in IN mode before enabling it. This make enabling gpio safe
+	 */
+	ret = plgpio_direction_input(chip, offset);
+	if (ret)
+		return ret;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & PTO_ENB_REG)) {
+		offset = plgpio->p2o(offset);
+		if (offset == -1)
+			return -EINVAL;
+	}
+
+	spin_lock_irqsave(&plgpio->lock, flags);
+	plgpio_reg_set(plgpio->base, offset, PLGPIO_ENB);
+	spin_unlock_irqrestore(&plgpio->lock, flags);
+
+	return 0;
+}
+
+static void plgpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct plgpio *plgpio = container_of(chip, struct plgpio, chip);
+	unsigned long flags;
+
+	if (offset >= chip->ngpio)
+		return;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & PTO_ENB_REG)) {
+		offset = plgpio->p2o(offset);
+		if (offset == -1)
+			return;
+	}
+
+	spin_lock_irqsave(&plgpio->lock, flags);
+	plgpio_reg_reset(plgpio->base, offset, PLGPIO_ENB);
+	spin_unlock_irqrestore(&plgpio->lock, flags);
+}
+
+static int plgpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct plgpio *plgpio = container_of(chip, struct plgpio, chip);
+
+	if (plgpio->irq_base == (unsigned) -1)
+		return -EINVAL;
+
+	return plgpio->irq_base + offset;
+}
+
+/* PLGPIO IRQ */
+static void plgpio_irq_mask(unsigned irq)
+{
+	struct plgpio *plgpio = get_irq_chip_data(irq);
+	int offset = irq - plgpio->irq_base;
+	unsigned long flags;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & PTO_IE_REG)) {
+		offset = plgpio->p2o(offset);
+		if (offset == -1)
+			return;
+	}
+
+	spin_lock_irqsave(&plgpio->lock, flags);
+	plgpio_reg_set(plgpio->base, offset, PLGPIO_IE);
+	spin_unlock_irqrestore(&plgpio->lock, flags);
+}
+
+static void plgpio_irq_unmask(unsigned irq)
+{
+	struct plgpio *plgpio = get_irq_chip_data(irq);
+	int offset = irq - plgpio->irq_base;
+	unsigned long flags;
+
+	/* get correct offset for "offset" pin */
+	if (plgpio->p2o && (plgpio->p2o_regs & PTO_IE_REG)) {
+		offset = plgpio->p2o(offset);
+		if (offset == -1)
+			return;
+	}
+
+	spin_lock_irqsave(&plgpio->lock, flags);
+	plgpio_reg_reset(plgpio->base, offset, PLGPIO_IE);
+	spin_unlock_irqrestore(&plgpio->lock, flags);
+}
+
+static int plgpio_irq_type(unsigned irq, unsigned trigger)
+{
+	struct plgpio *plgpio = get_irq_chip_data(irq);
+	int offset = irq - plgpio->irq_base;
+
+	if (offset >= plgpio->chip.ngpio)
+		return -EINVAL;
+
+	if (trigger != IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+	return 0;
+}
+
+static struct irq_chip plgpio_irqchip = {
+	.name		= "PLGPIO",
+	.mask		= plgpio_irq_mask,
+	.unmask		= plgpio_irq_unmask,
+	.set_type	= plgpio_irq_type,
+};
+
+static void plgpio_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	struct plgpio *plgpio = get_irq_data(irq);
+	unsigned long pending;
+	int regs_count = DIV_ROUND_UP(plgpio->chip.ngpio, MAX_GPIO_PER_REG),
+	    count, pin, offset, i = 0;
+
+	/* check all plgpio MIS registers for a possible interrupt */
+	for (; i < regs_count; i++) {
+		pending = readl(plgpio->base + PLGPIO_MIS + i * sizeof(int *));
+		if (!pending)
+			continue;
+
+		/*
+		 * clear extra bits in last register having gpios < MAX/REG
+		 * ex: Suppose there are max 102 plgpios. then last register
+		 * must have only (102 - MAX_GPIO_PER_REG * 3) = 6 relevant bits
+		 * so, we must not take other 28 bits into consideration for
+		 * checking interrupt. so clear those bits.
+		 */
+		count = plgpio->chip.ngpio - i * MAX_GPIO_PER_REG;
+		if (count < MAX_GPIO_PER_REG)
+			pending &= (1 << count) - 1;
+
+		for_each_set_bit(offset, &pending, MAX_GPIO_PER_REG) {
+			/* get correct pin for "offset" */
+			if (plgpio->o2p && (plgpio->p2o_regs & PTO_MIS_REG)) {
+				pin = plgpio->o2p(offset);
+				if (pin == -1)
+					continue;
+			} else
+				pin = offset;
+
+			generic_handle_irq(plgpio_to_irq(&plgpio->chip,
+						i * MAX_GPIO_PER_REG + pin));
+		}
+	}
+}
+
+static int __devinit plgpio_probe(struct platform_device *pdev)
+{
+	struct plgpio_platform_data *pdata;
+	struct plgpio *plgpio;
+	int ret, irq, i;
+	struct resource *res;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		ret = -ENODEV;
+		dev_dbg(&pdev->dev, "invalid platform data\n");
+		goto fail;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EBUSY;
+		dev_dbg(&pdev->dev, "invalid IORESOURCE_MEM\n");
+		goto fail;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), "plgpio")) {
+		ret = -EBUSY;
+		dev_dbg(&pdev->dev, "request mem region fail\n");
+		goto fail;
+	}
+
+	plgpio = kzalloc(sizeof(*plgpio), GFP_KERNEL);
+	if (!plgpio) {
+		ret = -ENOMEM;
+		dev_dbg(&pdev->dev, "memory allocation fail\n");
+		goto release_region;
+	}
+
+	plgpio->base = ioremap(res->start, resource_size(res));
+	if (!plgpio->base) {
+		ret = -ENOMEM;
+		dev_dbg(&pdev->dev, "ioremap fail\n");
+		goto kfree;
+	}
+
+	spin_lock_init(&plgpio->lock);
+
+	plgpio->chip.request = plgpio_request;
+	plgpio->chip.free = plgpio_free;
+	plgpio->chip.direction_input = plgpio_direction_input;
+	plgpio->chip.direction_output = plgpio_direction_output;
+	plgpio->chip.get = plgpio_get_value;
+	plgpio->chip.set = plgpio_set_value;
+	plgpio->chip.to_irq = plgpio_to_irq;
+	plgpio->chip.base = pdata->gpio_base;
+	plgpio->chip.ngpio = pdata->gpio_count;
+	plgpio->chip.label = dev_name(&pdev->dev);
+	plgpio->chip.dev = &pdev->dev;
+	plgpio->chip.owner = THIS_MODULE;
+	plgpio->irq_base = pdata->irq_base;
+	plgpio->p2o = pdata->p2o;
+	plgpio->o2p = pdata->o2p;
+	plgpio->p2o_regs = pdata->p2o_regs;
+
+	ret = gpiochip_add(&plgpio->chip);
+	if (ret) {
+		dev_dbg(&pdev->dev, "unable to add gpio chip\n");
+		goto iounmap;
+	}
+
+	/* irq_chip support */
+	if (pdata->irq_base == (unsigned) -1) {
+		dev_info(&pdev->dev, "Initialization successful\n");
+		return 0;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = -ENODEV;
+		dev_dbg(&pdev->dev, "invalid irq number\n");
+		goto remove_gpiochip;
+	}
+
+	set_irq_chained_handler(irq, plgpio_irq_handler);
+	for (i = 0; i < pdata->gpio_count; i++) {
+		set_irq_chip(i+plgpio->irq_base, &plgpio_irqchip);
+		set_irq_handler(i+plgpio->irq_base, handle_simple_irq);
+		set_irq_flags(i+plgpio->irq_base, IRQF_VALID);
+		set_irq_chip_data(i+plgpio->irq_base, plgpio);
+	}
+	set_irq_data(irq, plgpio);
+	dev_info(&pdev->dev, "Initialization successful\n");
+
+	return 0;
+
+remove_gpiochip:
+	if (gpiochip_remove(&plgpio->chip))
+		dev_dbg(&pdev->dev, "unable to remove gpiochip\n");
+iounmap:
+	iounmap(plgpio->base);
+kfree:
+	kfree(plgpio);
+release_region:
+	release_mem_region(res->start, resource_size(res));
+fail:
+	dev_err(&pdev->dev, "probe fail: %d\n", ret);
+	return ret;
+}
+
+static struct platform_driver plgpio_driver = {
+	.probe		= plgpio_probe,
+	.driver		= {
+		.name	= "plgpio",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init plgpio_init(void)
+{
+	return platform_driver_register(&plgpio_driver);
+}
+subsys_initcall(plgpio_init);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@st.com>");
+MODULE_DESCRIPTION("SPEAr PLGPIO driver");
+MODULE_LICENSE("GPL");
-- 
1.7.2.2
