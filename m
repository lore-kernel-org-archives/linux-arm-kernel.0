From: mike@compulab.co.il (Mike Rapoport)
Date: Tue,  8 Mar 2011 14:58:58 +0200
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <cover.1299588456.git.mike@compulab.co.il>
References: <cover.1299588456.git.mike@compulab.co.il>
Message-ID: <4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-tegra/Makefile              |    1 +
 arch/arm/mach-tegra/board-harmony-power.c |  161 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.c       |    1 +
 arch/arm/mach-tegra/board-harmony.h       |    1 +
 4 files changed, 164 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-power.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 9bf39fa..cdc4788 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
+obj-${CONFIG_MACH_HARMONY}              += board-harmony-power.o
 
 obj-${CONFIG_MACH_SEABOARD}             += board-seaboard.o
 obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
new file mode 100644
index 0000000..ca43d7a
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -0,0 +1,161 @@
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
+static struct regulator_consumer_supply tps658621_sm0_supply[] = {
+	REGULATOR_SUPPLY("vdd_core", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_sm1_supply[] = {
+	REGULATOR_SUPPLY("vdd_cpu", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_sm2_supply[] = {
+	REGULATOR_SUPPLY("vdd_sm2", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo0_supply[] = {
+	REGULATOR_SUPPLY("pex_clk", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo1_supply[] = {
+	REGULATOR_SUPPLY("avdd_pll", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo2_supply[] = {
+	REGULATOR_SUPPLY("vdd_rtc", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo3_supply[] = {
+	REGULATOR_SUPPLY("avdd_usb", NULL),
+	REGULATOR_SUPPLY("avdd_usb_pll", NULL),
+	REGULATOR_SUPPLY("avdd_lvds", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo4_supply[] = {
+	REGULATOR_SUPPLY("avdd_osc", NULL),
+	REGULATOR_SUPPLY("vddio_sys", "panjit_touch"),
+};
+
+static struct regulator_consumer_supply tps658621_ldo5_supply[] = {
+	REGULATOR_SUPPLY("vcore_mmc", "sdhci-tegra.1"),
+	REGULATOR_SUPPLY("vcore_mmc", "sdhci-tegra.3"),
+};
+
+static struct regulator_consumer_supply tps658621_ldo6_supply[] = {
+	REGULATOR_SUPPLY("avdd_vdac", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo7_supply[] = {
+	REGULATOR_SUPPLY("avdd_hdmi", NULL),
+	REGULATOR_SUPPLY("vdd_fuse", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo8_supply[] = {
+	REGULATOR_SUPPLY("avdd_hdmi_pll", NULL),
+};
+
+static struct regulator_consumer_supply tps658621_ldo9_supply[] = {
+	REGULATOR_SUPPLY("avdd_2v85", NULL),
+	REGULATOR_SUPPLY("vdd_ddr_rx", NULL),
+	REGULATOR_SUPPLY("avdd_amp", NULL),
+};
+
+#define REGULATOR_INIT(_id, _minmv, _maxmv)				\
+	{								\
+		.constraints = {					\
+			.min_uV = (_minmv)*1000,			\
+			.max_uV = (_maxmv)*1000,			\
+			.valid_modes_mask = (REGULATOR_MODE_NORMAL |	\
+					     REGULATOR_MODE_STANDBY),	\
+			.valid_ops_mask = (REGULATOR_CHANGE_MODE |	\
+					   REGULATOR_CHANGE_STATUS |	\
+					   REGULATOR_CHANGE_VOLTAGE),	\
+		},							\
+		.num_consumer_supplies = ARRAY_SIZE(tps658621_##_id##_supply),\
+		.consumer_supplies = tps658621_##_id##_supply,		\
+	}
+
+static struct regulator_init_data sm0_data = REGULATOR_INIT(sm0, 725, 1500);
+static struct regulator_init_data sm1_data = REGULATOR_INIT(sm1, 725, 1500);
+static struct regulator_init_data sm2_data = REGULATOR_INIT(sm2, 3000, 4550);
+static struct regulator_init_data ldo0_data = REGULATOR_INIT(ldo0, 1250, 3300);
+static struct regulator_init_data ldo1_data = REGULATOR_INIT(ldo1, 725, 1500);
+static struct regulator_init_data ldo2_data = REGULATOR_INIT(ldo2, 725, 1500);
+static struct regulator_init_data ldo3_data = REGULATOR_INIT(ldo3, 1250, 3300);
+static struct regulator_init_data ldo4_data = REGULATOR_INIT(ldo4, 1700, 2475);
+static struct regulator_init_data ldo5_data = REGULATOR_INIT(ldo5, 1250, 3300);
+static struct regulator_init_data ldo6_data = REGULATOR_INIT(ldo6, 1250, 3300);
+static struct regulator_init_data ldo7_data = REGULATOR_INIT(ldo7, 1250, 3300);
+static struct regulator_init_data ldo8_data = REGULATOR_INIT(ldo8, 1250, 3300);
+static struct regulator_init_data ldo9_data = REGULATOR_INIT(ldo9, 1250, 3300);
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
index 2d7d9d9..7de4a7e 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -147,6 +147,7 @@ static void __init tegra_harmony_init(void)
 
 	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
 	harmony_i2c_init();
+	harmony_regulator_init();
 }
 
 MACHINE_START(HARMONY, "harmony")
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 09ca775..0a69661 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -18,5 +18,6 @@
 #define _MACH_TEGRA_BOARD_HARMONY_H
 
 void harmony_pinmux_init(void);
+int harmony_regulator_init(void);
 
 #endif
-- 
1.7.3.1
