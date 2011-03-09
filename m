From: mike@compulab.co.il (Mike Rapoport)
Date: Wed,  9 Mar 2011 16:31:18 +0200
Subject: [PATCH v2 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <cover.1299681036.git.mike@compulab.co.il>
References: <cover.1299681036.git.mike@compulab.co.il>
Message-ID: <f7a5f9247f32e85f5b008412a973f9ad7ef4010f.1299681036.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the PMIC voltage regulators and provide the supply map for
PCI-e clock supply. The rest of the supplies should be added together
with the drivers that use them.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-tegra/Makefile              |    1 +
 arch/arm/mach-tegra/board-harmony-power.c |  117 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.c       |    1 +
 arch/arm/mach-tegra/board-harmony.h       |    1 +
 4 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-power.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 673651f..bbe1dbe 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
+obj-${CONFIG_MACH_HARMONY}              += board-harmony-power.o
 
 obj-${CONFIG_MACH_PAZ00}		+= board-paz00.o
 obj-${CONFIG_MACH_PAZ00}		+= board-paz00-pinmux.o
diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
new file mode 100644
index 0000000..c84442c
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2010 NVIDIA, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307, USA
+ */
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <linux/regulator/machine.h>
+#include <linux/mfd/tps6586x.h>
+
+#include <mach/irqs.h>
+
+#define PMC_CTRL		0x0
+#define PMC_CTRL_INTR_LOW	(1 << 17)
+
+static struct regulator_consumer_supply tps658621_ldo0_supply[] = {
+	REGULATOR_SUPPLY("pex_clk", NULL),
+};
+
+static struct regulator_init_data ldo0_data = {
+	.constraints = {
+		.min_uV = 1250 * 1000,
+		.max_uV = 3300 * 1000,
+		.valid_modes_mask = (REGULATOR_MODE_NORMAL |
+				     REGULATOR_MODE_STANDBY),
+		.valid_ops_mask = (REGULATOR_CHANGE_MODE |
+				   REGULATOR_CHANGE_STATUS |
+				   REGULATOR_CHANGE_VOLTAGE),
+	},
+	.num_consumer_supplies = ARRAY_SIZE(tps658621_ldo0_supply),
+	.consumer_supplies = tps658621_ldo0_supply,
+};
+
+#define HARMONY_REGULATOR_INIT(_id, _minmv, _maxmv)			\
+	static struct regulator_init_data _id##_data = {		\
+		.constraints = {					\
+			.min_uV = (_minmv)*1000,			\
+			.max_uV = (_maxmv)*1000,			\
+			.valid_modes_mask = (REGULATOR_MODE_NORMAL |	\
+					     REGULATOR_MODE_STANDBY),	\
+			.valid_ops_mask = (REGULATOR_CHANGE_MODE |	\
+					   REGULATOR_CHANGE_STATUS |	\
+					   REGULATOR_CHANGE_VOLTAGE),	\
+		},							\
+	}
+
+HARMONY_REGULATOR_INIT(sm0, 725, 1500);
+HARMONY_REGULATOR_INIT(sm1, 725, 1500);
+HARMONY_REGULATOR_INIT(sm2, 3000, 4550);
+HARMONY_REGULATOR_INIT(ldo1, 725, 1500);
+HARMONY_REGULATOR_INIT(ldo2, 725, 1500);
+HARMONY_REGULATOR_INIT(ldo3, 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo4, 1700, 2475);
+HARMONY_REGULATOR_INIT(ldo5, 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo6, 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo7, 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo8, 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo9, 1250, 3300);
+
+#define TPS_REG(_id, _data)			\
+	{					\
+		.id = TPS6586X_ID_##_id,	\
+		.name = "tps6586x-regulator",	\
+		.platform_data = _data,		\
+	}
+
+static struct tps6586x_subdev_info tps_devs[] = {
+	TPS_REG(SM_0, &sm0_data),
+	TPS_REG(SM_1, &sm1_data),
+	TPS_REG(SM_2, &sm2_data),
+	TPS_REG(LDO_0, &ldo0_data),
+	TPS_REG(LDO_1, &ldo1_data),
+	TPS_REG(LDO_2, &ldo2_data),
+	TPS_REG(LDO_3, &ldo3_data),
+	TPS_REG(LDO_4, &ldo4_data),
+	TPS_REG(LDO_5, &ldo5_data),
+	TPS_REG(LDO_6, &ldo6_data),
+	TPS_REG(LDO_7, &ldo7_data),
+	TPS_REG(LDO_8, &ldo8_data),
+	TPS_REG(LDO_9, &ldo9_data),
+};
+
+static struct tps6586x_platform_data tps_platform = {
+	.irq_base	= TEGRA_NR_IRQS,
+	.num_subdevs	= ARRAY_SIZE(tps_devs),
+	.subdevs	= tps_devs,
+	.gpio_base	= TEGRA_NR_GPIOS,
+};
+
+static struct i2c_board_info __initdata harmony_regulators[] = {
+	{
+		I2C_BOARD_INFO("tps6586x", 0x34),
+		.irq		= INT_EXTERNAL_PMU,
+		.platform_data	= &tps_platform,
+	},
+};
+
+int __init harmony_regulator_init(void)
+{
+	i2c_register_board_info(3, harmony_regulators, 1);
+
+	return 0;
+}
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index e7c2fea..75c918a 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -196,6 +196,7 @@ static void __init tegra_harmony_init(void)
 
 	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
 	harmony_i2c_init();
+	harmony_regulator_init();
 }
 
 MACHINE_START(HARMONY, "harmony")
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 9243521..1e57b07 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -32,5 +32,6 @@
 #define TEGRA_GPIO_EXT_MIC_EN		TEGRA_GPIO_PX1
 
 void harmony_pinmux_init(void);
+int harmony_regulator_init(void);
 
 #endif
-- 
1.7.3.1
