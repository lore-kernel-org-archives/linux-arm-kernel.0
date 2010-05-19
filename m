From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 May 2010 17:25:32 +0900
Subject: [PATCH v4] ARM: S5PV210: Add GPIOlib support
Message-ID: <1274257532-18468-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pannaga Bhushan <p.bhushan@samsung.com>

This patch adds GPIOlib support for S5PV210.

Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---

Changes since v3:
Fixed on the GPH base address.


 arch/arm/mach-s5pv210/Makefile            |    2 +-
 arch/arm/mach-s5pv210/gpiolib.c           |  261 +++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/gpio.h |   18 ++-
 3 files changed, 277 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/gpiolib.c

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 8ebf51c..0acbdb3 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5PV210 system
 
-obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
+obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpiolib.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
new file mode 100644
index 0000000..ae8686b
--- /dev/null
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -0,0 +1,261 @@
+/* linux/arch/arm/mach-s5pv210/gpiolib.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - GPIOlib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <plat/gpio-core.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
+#include <mach/map.h>
+
+static struct s3c_gpio_cfg gpio_cfg = {
+	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+	.set_pull	= s3c_gpio_setpull_updown,
+	.get_pull	= s3c_gpio_getpull_updown,
+};
+
+static struct s3c_gpio_cfg gpio_cfg_noint = {
+	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+	.set_pull	= s3c_gpio_setpull_updown,
+	.get_pull	= s3c_gpio_getpull_updown,
+};
+
+/* GPIO bank's base address given the index of the bank in the
+ * list of all gpio banks.
+ */
+#define S5PV210_BANK_BASE(bank_nr)	(S5P_VA_GPIO + ((bank_nr) * 0x20))
+
+/*
+ * Following are the gpio banks in v210.
+ *
+ * The 'config' member when left to NULL, is initialized to the default
+ * structure gpio_cfg in the init function below.
+ *
+ * The 'base' member is also initialized in the init function below.
+ * Note: The initialization of 'base' member of s3c_gpio_chip structure
+ * uses the above macro and depends on the banks being listed in order here.
+ */
+static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
+	{
+		.chip	= {
+			.base	= S5PV210_GPA0(0),
+			.ngpio	= S5PV210_GPIO_A0_NR,
+			.label	= "GPA0",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPA1(0),
+			.ngpio	= S5PV210_GPIO_A1_NR,
+			.label	= "GPA1",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPB(0),
+			.ngpio	= S5PV210_GPIO_B_NR,
+			.label	= "GPB",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPC0(0),
+			.ngpio	= S5PV210_GPIO_C0_NR,
+			.label	= "GPC0",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPC1(0),
+			.ngpio	= S5PV210_GPIO_C1_NR,
+			.label	= "GPC1",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPD0(0),
+			.ngpio	= S5PV210_GPIO_D0_NR,
+			.label	= "GPD0",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPD1(0),
+			.ngpio	= S5PV210_GPIO_D1_NR,
+			.label	= "GPD1",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPE0(0),
+			.ngpio	= S5PV210_GPIO_E0_NR,
+			.label	= "GPE0",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPE1(0),
+			.ngpio	= S5PV210_GPIO_E1_NR,
+			.label	= "GPE1",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPF0(0),
+			.ngpio	= S5PV210_GPIO_F0_NR,
+			.label	= "GPF0",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPF1(0),
+			.ngpio	= S5PV210_GPIO_F1_NR,
+			.label	= "GPF1",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPF2(0),
+			.ngpio	= S5PV210_GPIO_F2_NR,
+			.label	= "GPF2",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPF3(0),
+			.ngpio	= S5PV210_GPIO_F3_NR,
+			.label	= "GPF3",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPG0(0),
+			.ngpio	= S5PV210_GPIO_G0_NR,
+			.label	= "GPG0",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPG1(0),
+			.ngpio	= S5PV210_GPIO_G1_NR,
+			.label	= "GPG1",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPG2(0),
+			.ngpio	= S5PV210_GPIO_G2_NR,
+			.label	= "GPG2",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPG3(0),
+			.ngpio	= S5PV210_GPIO_G3_NR,
+			.label	= "GPG3",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPI(0),
+			.ngpio	= S5PV210_GPIO_I_NR,
+			.label	= "GPI",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPJ0(0),
+			.ngpio	= S5PV210_GPIO_J0_NR,
+			.label	= "GPJ0",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPJ1(0),
+			.ngpio	= S5PV210_GPIO_J1_NR,
+			.label	= "GPJ1",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPJ2(0),
+			.ngpio	= S5PV210_GPIO_J2_NR,
+			.label	= "GPJ2",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPJ3(0),
+			.ngpio	= S5PV210_GPIO_J3_NR,
+			.label	= "GPJ3",
+		},
+	}, {
+		.chip	= {
+			.base	= S5PV210_GPJ4(0),
+			.ngpio	= S5PV210_GPIO_J4_NR,
+			.label	= "GPJ4",
+		},
+	}, {
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_MP01(0),
+			.ngpio	= S5PV210_GPIO_MP01_NR,
+			.label	= "MP01",
+		},
+	}, {
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_MP02(0),
+			.ngpio	= S5PV210_GPIO_MP02_NR,
+			.label	= "MP02",
+		},
+	}, {
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_MP03(0),
+			.ngpio	= S5PV210_GPIO_MP03_NR,
+			.label	= "MP03",
+		},
+	}, {
+		.base	= (S5P_VA_GPIO + 0xC00),
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_GPH0(0),
+			.ngpio	= S5PV210_GPIO_H0_NR,
+			.label	= "GPH0",
+		},
+	}, {
+		.base	= (S5P_VA_GPIO + 0xC20),
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_GPH1(0),
+			.ngpio	= S5PV210_GPIO_H1_NR,
+			.label	= "GPH1",
+		},
+	}, {
+		.base	= (S5P_VA_GPIO + 0xC40),
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_GPH2(0),
+			.ngpio	= S5PV210_GPIO_H2_NR,
+			.label	= "GPH2",
+		},
+	}, {
+		.base	= (S5P_VA_GPIO + 0xC60),
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PV210_GPH3(0),
+			.ngpio	= S5PV210_GPIO_H3_NR,
+			.label	= "GPH3",
+		},
+	},
+};
+
+static __init int s5pv210_gpiolib_init(void)
+{
+	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
+	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
+	int i = 0;
+
+	for (i = 0; i < nr_chips; i++, chip++) {
+		if (chip->config == NULL)
+			chip->config = &gpio_cfg;
+		if (chip->base == NULL)
+			chip->base = S5PV210_BANK_BASE(i);
+	}
+
+	samsung_gpiolib_add_4bit_chips(s5pv210_gpio_4bit, nr_chips);
+
+	return 0;
+}
+core_initcall(s5pv210_gpiolib_init);
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index 533b020..4dd417c 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -18,6 +18,8 @@
 #define gpio_cansleep	__gpio_cansleep
 #define gpio_to_irq	__gpio_to_irq
 
+/* Practically, GPIO banks upto MP03 are the configurable gpio banks */
+
 /* GPIO bank sizes */
 #define S5PV210_GPIO_A0_NR	(8)
 #define S5PV210_GPIO_A1_NR	(4)
@@ -47,6 +49,10 @@
 #define S5PV210_GPIO_J3_NR	(8)
 #define S5PV210_GPIO_J4_NR	(5)
 
+#define S5PV210_GPIO_MP01_NR	(8)
+#define S5PV210_GPIO_MP02_NR	(4)
+#define S5PV210_GPIO_MP03_NR	(8)
+
 /* GPIO bank numbers */
 
 /* CONFIG_S3C_GPIO_SPACE allows the user to select extra
@@ -85,6 +91,9 @@ enum s5p_gpio_number {
 	S5PV210_GPIO_J2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J1),
 	S5PV210_GPIO_J3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J2),
 	S5PV210_GPIO_J4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J3),
+	S5PV210_GPIO_MP01_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J4),
+	S5PV210_GPIO_MP02_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP01),
+	S5PV210_GPIO_MP03_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP02),
 };
 
 /* S5PV210 GPIO number definitions */
@@ -115,13 +124,16 @@ enum s5p_gpio_number {
 #define S5PV210_GPJ2(_nr)	(S5PV210_GPIO_J2_START + (_nr))
 #define S5PV210_GPJ3(_nr)	(S5PV210_GPIO_J3_START + (_nr))
 #define S5PV210_GPJ4(_nr)	(S5PV210_GPIO_J4_START + (_nr))
+#define S5PV210_MP01(_nr)	(S5PV210_GPIO_MP01_START + (_nr))
+#define S5PV210_MP02(_nr)	(S5PV210_GPIO_MP02_START + (_nr))
+#define S5PV210_MP03(_nr)	(S5PV210_GPIO_MP03_START + (_nr))
 
 /* the end of the S5PV210 specific gpios */
-#define S5PV210_GPIO_END	(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) + 1)
+#define S5PV210_GPIO_END	(S5PV210_MP03(S5PV210_GPIO_MP03_NR) + 1)
 #define S3C_GPIO_END		S5PV210_GPIO_END
 
-/* define the number of gpios we need to the one after the GPJ4() range */
-#define ARCH_NR_GPIOS		(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) +	\
+/* define the number of gpios we need to the one after the MP03() range */
+#define ARCH_NR_GPIOS		(S5PV210_MP03(S5PV210_GPIO_MP03_NR) +	\
 				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
 
 #include <asm-generic/gpio.h>
-- 
1.6.3.3
