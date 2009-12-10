From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 10 Dec 2009 19:50:13 +0100
Subject: [PATCH 3/4] MXC: mc13783: Developing, trying to full support
	regulators.
In-Reply-To: <1260470743.2141.45.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
	<1260470743.2141.45.camel@climbing-alby>
Message-ID: <1260471013.2141.49.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the ability to change voltages settings
for all possible mc13783 regulators.
Pay attention that it is a development patch with many 
debug messages enabled.

Signed-off-by: Alberto Panizzo <alberto.panizzo@gmail.com>
---
 drivers/mfd/mc13783-core.c          |   20 ++
 drivers/regulator/mc13783.c         |  489 ++++++++++++++++++++++++++++++++--
 drivers/spi/spi_imx.c               |    2 +
 include/linux/mfd/mc13783-private.h |   53 ++++-
 4 files changed, 534 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/mc13783-core.c b/drivers/mfd/mc13783-core.c
index e354d29..50fd9d8 100644
--- a/drivers/mfd/mc13783-core.c
+++ b/drivers/mfd/mc13783-core.c
@@ -20,6 +20,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
+#define DEBUG	1
 
 #include <linux/mfd/mc13783-private.h>
 #include <linux/platform_device.h>
@@ -35,6 +36,10 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 
+#include <mach/hardware.h>
+#include <mach/board-mx31pdk.h>
+#include <linux/io.h>
+
 #define MC13783_MAX_REG_NUM	0x3f
 #define MC13783_FRAME_MASK	0x00ffffff
 #define MC13783_MAX_REG_NUM	0x3f
@@ -87,6 +92,8 @@ static int mc13783_write(struct mc13783 *mc13783, int reg_num, u32 reg_val)
 	frame |= reg_num << MC13783_REG_NUM_SHIFT;
 	frame |= reg_val & MC13783_FRAME_MASK;
 
+	printk(KERN_DEBUG "%s frame: 0x%x\n", __func__, frame);
+
 	return spi_rw(mc13783->spi_device, (u8 *)&frame, 4);
 }
 
@@ -127,15 +134,28 @@ int mc13783_set_bits(struct mc13783 *mc13783, int reg, u32 mask, u32 val)
 	u32 tmp;
 	int ret;
 
+	printk(KERN_DEBUG "%s reg: %d, mask: 0x%x, val: 0x%x\n", __func__, reg, mask, val);
+
 	mutex_lock(&mc13783->io_lock);
 
+	__raw_writew(__raw_readw(CPLD_LED_REG) | 0x10, CPLD_LED_REG);
+
 	ret = mc13783_read(mc13783, reg, &tmp);
+
+	printk(KERN_DEBUG "%s read ret: %d, tmp: 0x%x\n", __func__,ret,tmp);
+
 	tmp = (tmp & ~mask) | val;
 	if (ret == 0)
 		ret = mc13783_write(mc13783, reg, tmp);
 
+	printk(KERN_DEBUG "%s write ret: %d, tmp: 0x%x\n", __func__,ret,tmp);
+
 	mutex_unlock(&mc13783->io_lock);
 
+	printk(KERN_DEBUG "%s done\n", __func__);
+
+	__raw_writew(__raw_readw(CPLD_LED_REG) & 0xef, CPLD_LED_REG);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mc13783_set_bits);
diff --git a/drivers/regulator/mc13783.c b/drivers/regulator/mc13783.c
index 710211f..f265f07 100644
--- a/drivers/regulator/mc13783.c
+++ b/drivers/regulator/mc13783.c
@@ -2,12 +2,15 @@
  * Regulator Driver for Freescale MC13783 PMIC
  *
  * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
+#define DEBUG	1
+
 #include <linux/mfd/mc13783-private.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/driver.h>
@@ -19,23 +22,220 @@
 
 struct mc13783_regulator {
 	struct regulator_desc desc;
-	int reg;
+	int control_reg;
 	int enable_bit;
+	int vsel_reg;
+	int vsel_shift;
+	int vsel_mask;
+	int const *voltages;
+};
+
+/*
+ * Voltage Values
+ */
+static const int const mc13783_sw_voltages[] = {
+	 900000, 925000, 950000, 975000,
+	1000000,1025000,1050000,1075000,
+	1100000,1125000,1150000,1175000,
+	1200000,1225000,1250000,1275000,
+	1300000,1325000,1350000,1375000,
+	1400000,1425000,1450000,1475000,
+	1500000,1525000,1550000,1575000,
+	1600000,1625000,1650000,1675000,
+	1700000,1700000,1700000,1700000,
+	1800000,1800000,1800000,1800000,
+	1850000,1850000,1850000,1850000,
+	2000000,2000000,2000000,2000000,
+	2100000,2100000,2100000,2100000,
+	2200000,2200000,2200000,2200000,
+	2200000,2200000,2200000,2200000,
+	2200000,2200000,2200000,2200000,
+};
+
+static const int const mc13783_sw3_voltages[] = {
+	5000000,
+	5000000,
+	5000000,
+	5500000,
+};
+
+static const int const mc13783_vaudio_voltages[] = {
+	2775000,
+};
+
+static const int const mc13783_viohi_voltages[] = {
+	2775000,
+};
+
+static const int const mc13783_violo_voltage[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+};
+
+static const int const mc13783_vdig_voltage[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+};
+
+static const int const mc13783_vgen_voltage[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+	1100000,
+	2000000,
+	2775000,
+	2400000,
+};
+
+static const int const mc13783_vrfdig_voltage[] = {
+	1200000,
+	1500000,
+	1800000,
+	1875000,
+};
+
+static const int const mc13783_vrfref_voltage[] = {
+	2475000,
+	2600000,
+	2700000,
+	2775000,
+};
+
+static const int const mc13783_vrfcp_voltage[] = {
+	2700000,
+	2775000,
+};
+
+static const int const mc13783_vsim_voltage[] = {
+	1800000,
+	2900000,
+	3000000,
+};
+
+static const int const mc13783_vesim_voltage[] = {
+	1800000,
+	2900000,
+};
+
+static const int const mc13783_vcam_voltage[] = {
+	1500000,
+	1800000,
+	2500000,
+	2550000,
+	2600000,
+	2750000,
+	2800000,
+	3000000,
+};
+
+static const int const mc13783_vrfbg_voltages[] = {
+	1250000,
+};
+
+static const int const mc13783_vvib_voltage[] = {
+	1300000,
+	1800000,
+	2000000,
+	3000000,
+};
+
+static const int const mc13783_vmmc_voltage[] = {
+	1600000,
+	1800000,
+	2000000,
+	2600000,
+	2700000,
+	2800000,
+	2900000,
+	3000000,
+};
+
+static const int const mc13783_vrf_voltage[] = {
+	1500000,
+	1875000,
+	2700000,
+	2775000,
 };
 
 static struct regulator_ops mc13783_regulator_ops;
 
 static struct mc13783_regulator mc13783_regulators[] = {
+	[MC13783_SW_SW1A] = {
+		.desc = {
+			.name	= "SW_SW1A",
+			.n_voltages = ARRAY_SIZE(mc13783_sw_voltages),
+			.ops	= &mc13783_regulator_ops,
+			.type	= REGULATOR_VOLTAGE,
+			.id	= MC13783_SW_SW1A,
+			.owner	= THIS_MODULE,
+		},
+		.vsel_reg = MC13783_REG_SWITCHERS_0,
+		.vsel_shift = MC13783_REGSET_SW_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_SW_VSEL_MASK,
+		.voltages = mc13783_sw_voltages,
+	},
+	[MC13783_SW_SW1B] = {
+		.desc = {
+			.name	= "SW_SW1B",
+			.n_voltages = ARRAY_SIZE(mc13783_sw_voltages),
+			.ops	= &mc13783_regulator_ops,
+			.type	= REGULATOR_VOLTAGE,
+			.id	= MC13783_SW_SW1B,
+			.owner	= THIS_MODULE,
+		},
+		.vsel_reg = MC13783_REG_SWITCHERS_1,
+		.vsel_shift = MC13783_REGSET_SW_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_SW_VSEL_MASK,
+		.voltages = mc13783_sw_voltages,
+	},
+	[MC13783_SW_SW2A] = {
+		.desc = {
+			.name	= "SW_SW2A",
+			.n_voltages = ARRAY_SIZE(mc13783_sw_voltages),
+			.ops	= &mc13783_regulator_ops,
+			.type	= REGULATOR_VOLTAGE,
+			.id	= MC13783_SW_SW2A,
+			.owner	= THIS_MODULE,
+		},
+		.vsel_reg = MC13783_REG_SWITCHERS_2,
+		.vsel_shift = MC13783_REGSET_SW_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_SW_VSEL_MASK,
+		.voltages = mc13783_sw_voltages,
+	},
+	[MC13783_SW_SW2B] = {
+		.desc = {
+			.name	= "SW_SW2B",
+			.n_voltages = ARRAY_SIZE(mc13783_sw_voltages),
+			.ops	= &mc13783_regulator_ops,
+			.type	= REGULATOR_VOLTAGE,
+			.id	= MC13783_SW_SW2B,
+			.owner	= THIS_MODULE,
+		},
+		.vsel_reg = MC13783_REG_SWITCHERS_3,
+		.vsel_shift = MC13783_REGSET_SW_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_SW_VSEL_MASK,
+		.voltages = mc13783_sw_voltages,
+	},
 	[MC13783_SW_SW3] = {
 		.desc = {
 			.name	= "SW_SW3",
+			.n_voltages = ARRAY_SIZE(mc13783_sw3_voltages),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_SW_SW3,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_SWITCHERS_5,
+		.control_reg = MC13783_REG_SWITCHERS_5,
 		.enable_bit = MC13783_SWCTRL_SW3_EN,
+		.vsel_reg = MC13783_REG_SWITCHERS_5,
+		.vsel_shift = MC13783_REGSET_SW3_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_SW3_VSEL_MASK,
+		.voltages = mc13783_sw3_voltages,
 	},
 	[MC13783_SW_PLL] = {
 		.desc = {
@@ -45,195 +245,271 @@ static struct mc13783_regulator mc13783_regulators[] = {
 			.id	= MC13783_SW_PLL,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_SWITCHERS_4,
+		.control_reg = MC13783_REG_SWITCHERS_4,
 		.enable_bit = MC13783_SWCTRL_PLL_EN,
 	},
 	[MC13783_REGU_VAUDIO] = {
 		.desc = {
 			.name	= "REGU_VAUDIO",
+			.n_voltages = ARRAY_SIZE(mc13783_vaudio_voltages),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VAUDIO,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VAUDIO_EN,
+		.voltages = mc13783_vaudio_voltages,
 	},
 	[MC13783_REGU_VIOHI] = {
 		.desc = {
 			.name	= "REGU_VIOHI",
+			.n_voltages = ARRAY_SIZE(mc13783_viohi_voltages),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VIOHI,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VIOHI_EN,
+		.voltages = mc13783_viohi_voltages,
 	},
 	[MC13783_REGU_VIOLO] = {
 		.desc = {
 			.name	= "REGU_VIOLO",
+			.n_voltages = ARRAY_SIZE(mc13783_violo_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VIOLO,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VIOLO_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VIOLO_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VIOLO_VSEL_MASK,
+		.voltages = mc13783_violo_voltage,
 	},
 	[MC13783_REGU_VDIG] = {
 		.desc = {
 			.name	= "REGU_VDIG",
+			.n_voltages = ARRAY_SIZE(mc13783_vdig_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VDIG,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VDIG_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VDIG_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VDIG_VSEL_MASK,
+		.voltages = mc13783_vdig_voltage,
 	},
 	[MC13783_REGU_VGEN] = {
 		.desc = {
 			.name	= "REGU_VGEN",
+			.n_voltages = ARRAY_SIZE(mc13783_vgen_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VGEN,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VGEN_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VGEN_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VGEN_VSEL_MASK,
+		.voltages = mc13783_vgen_voltage,
 	},
 	[MC13783_REGU_VRFDIG] = {
 		.desc = {
 			.name	= "REGU_VRFDIG",
+			.n_voltages = ARRAY_SIZE(mc13783_vrfdig_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VRFDIG,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VRFDIG_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VRFDIG_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VRFDIG_VSEL_MASK,
+		.voltages = mc13783_vrfdig_voltage,
 	},
 	[MC13783_REGU_VRFREF] = {
 		.desc = {
 			.name	= "REGU_VRFREF",
+			.n_voltages = ARRAY_SIZE(mc13783_vrfref_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VRFREF,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VRFREF_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VRFREF_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VRFREF_VSEL_MASK,
+		.voltages = mc13783_vrfref_voltage,
 	},
 	[MC13783_REGU_VRFCP] = {
 		.desc = {
 			.name	= "REGU_VRFCP",
+			.n_voltages = ARRAY_SIZE(mc13783_vrfcp_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VRFCP,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_0,
+		.control_reg = MC13783_REG_REGULATOR_MODE_0,
 		.enable_bit = MC13783_REGCTRL_VRFCP_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VRFCP_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VRFCP_VSEL_MASK,
+		.voltages = mc13783_vrfcp_voltage,
 	},
 	[MC13783_REGU_VSIM] = {
 		.desc = {
 			.name	= "REGU_VSIM",
+			.n_voltages = ARRAY_SIZE(mc13783_vsim_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VSIM,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VSIM_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VSIM_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VSIM_VSEL_MASK,
+		.voltages = mc13783_vsim_voltage,
 	},
 	[MC13783_REGU_VESIM] = {
 		.desc = {
 			.name	= "REGU_VESIM",
+			.n_voltages = ARRAY_SIZE(mc13783_vesim_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VESIM,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VESIM_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VESIM_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VESIM_VSEL_MASK,
+		.voltages = mc13783_vesim_voltage,
 	},
 	[MC13783_REGU_VCAM] = {
 		.desc = {
 			.name	= "REGU_VCAM",
+			.n_voltages = ARRAY_SIZE(mc13783_vcam_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VCAM,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VCAM_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_0,
+		.vsel_shift = MC13783_REGSET_VCAM_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VCAM_VSEL_MASK,
+		.voltages = mc13783_vcam_voltage,
 	},
 	[MC13783_REGU_VRFBG] = {
 		.desc = {
 			.name	= "REGU_VRFBG",
+			.n_voltages = ARRAY_SIZE(mc13783_vrfbg_voltages),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VRFBG,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VRFBG_EN,
+		.voltages = mc13783_vrfbg_voltages
 	},
 	[MC13783_REGU_VVIB] = {
 		.desc = {
 			.name	= "REGU_VVIB",
+			.n_voltages = ARRAY_SIZE(mc13783_vvib_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VVIB,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VVIB_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_1,
+		.vsel_shift = MC13783_REGSET_VVIB_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VVIB_VSEL_MASK,
+		.voltages = mc13783_vvib_voltage,
 	},
 	[MC13783_REGU_VRF1] = {
 		.desc = {
 			.name	= "REGU_VRF1",
+			.n_voltages = ARRAY_SIZE(mc13783_vrf_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VRF1,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VRF1_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_1,
+		.vsel_shift = MC13783_REGSET_VRF1_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VRF1_VSEL_MASK,
+		.voltages = mc13783_vrf_voltage,
 	},
 	[MC13783_REGU_VRF2] = {
 		.desc = {
 			.name	= "REGU_VRF2",
+			.n_voltages = ARRAY_SIZE(mc13783_vrf_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VRF2,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VRF2_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_1,
+		.vsel_shift = MC13783_REGSET_VRF2_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VRF2_VSEL_MASK,
+		.voltages = mc13783_vrf_voltage,
 	},
 	[MC13783_REGU_VMMC1] = {
 		.desc = {
 			.name	= "REGU_VMMC1",
+			.n_voltages = ARRAY_SIZE(mc13783_vmmc_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VMMC1,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VMMC1_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_1,
+		.vsel_shift = MC13783_REGSET_VMMC1_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VMMC1_VSEL_MASK,
+		.voltages = mc13783_vmmc_voltage,
 	},
 	[MC13783_REGU_VMMC2] = {
 		.desc = {
 			.name	= "REGU_VMMC2",
+			.n_voltages = ARRAY_SIZE(mc13783_vmmc_voltage),
 			.ops	= &mc13783_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.id	= MC13783_REGU_VMMC2,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_REGULATOR_MODE_1,
+		.control_reg = MC13783_REG_REGULATOR_MODE_1,
 		.enable_bit = MC13783_REGCTRL_VMMC2_EN,
+		.vsel_reg = MC13783_REG_REGULATOR_SETTING_1,
+		.vsel_shift = MC13783_REGSET_VMMC2_VSEL_SHIFT,
+		.vsel_mask = MC13783_REGSET_VMMC2_VSEL_MASK,
+		.voltages = mc13783_vmmc_voltage,
 	},
 	[MC13783_REGU_GPO1] = {
 		.desc = {
@@ -243,7 +519,7 @@ static struct mc13783_regulator mc13783_regulators[] = {
 			.id	= MC13783_REGU_GPO1,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_POWER_MISCELLANEOUS,
+		.control_reg = MC13783_REG_POWER_MISCELLANEOUS,
 		.enable_bit = MC13783_REGCTRL_GPO1_EN,
 	},
 	[MC13783_REGU_GPO2] = {
@@ -254,7 +530,7 @@ static struct mc13783_regulator mc13783_regulators[] = {
 			.id	= MC13783_REGU_GPO2,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_POWER_MISCELLANEOUS,
+		.control_reg = MC13783_REG_POWER_MISCELLANEOUS,
 		.enable_bit = MC13783_REGCTRL_GPO2_EN,
 	},
 	[MC13783_REGU_GPO3] = {
@@ -265,7 +541,7 @@ static struct mc13783_regulator mc13783_regulators[] = {
 			.id	= MC13783_REGU_GPO3,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_POWER_MISCELLANEOUS,
+		.control_reg = MC13783_REG_POWER_MISCELLANEOUS,
 		.enable_bit = MC13783_REGCTRL_GPO3_EN,
 	},
 	[MC13783_REGU_GPO4] = {
@@ -276,7 +552,7 @@ static struct mc13783_regulator mc13783_regulators[] = {
 			.id	= MC13783_REGU_GPO4,
 			.owner	= THIS_MODULE,
 		},
-		.reg = MC13783_REG_POWER_MISCELLANEOUS,
+		.control_reg = MC13783_REG_POWER_MISCELLANEOUS,
 		.enable_bit = MC13783_REGCTRL_GPO4_EN,
 	},
 };
@@ -292,11 +568,25 @@ static int mc13783_enable(struct regulator_dev *rdev)
 	struct mc13783_priv *priv = rdev_get_drvdata(rdev);
 	int id = rdev_get_id(rdev);
 
+	/* Print out all mc13783 registers */
+	int i, ret;
+	for(i = 0; id >= MC13783_REGU_GPO1 && i < MC13783_REG_NB; i++)
+	{
+		mc13783_reg_read(priv->mc13783,i, &ret);
+		dev_dbg(rdev_get_dev(rdev), "reg: %d, val: %x\n",i , ret);
+	}
+
 	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
 
-	return mc13783_set_bits(priv->mc13783, mc13783_regulators[id].reg,
+	/* The regulator is enabled by default? */
+	if (!mc13783_regulators[id].control_reg)
+		return 0;
+
+	ret = mc13783_set_bits(priv->mc13783, mc13783_regulators[id].control_reg,
 			mc13783_regulators[id].enable_bit,
 			mc13783_regulators[id].enable_bit);
+	dev_dbg(rdev_get_dev(rdev), "%s ret: %d\n", __func__, ret);
+	return ret;
 }
 
 static int mc13783_disable(struct regulator_dev *rdev)
@@ -306,7 +596,10 @@ static int mc13783_disable(struct regulator_dev *rdev)
 
 	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
 
-	return mc13783_set_bits(priv->mc13783, mc13783_regulators[id].reg,
+	if (!mc13783_regulators[id].control_reg)
+		return -EINVAL;
+
+	return mc13783_set_bits(priv->mc13783, mc13783_regulators[id].control_reg,
 			mc13783_regulators[id].enable_bit, 0);
 }
 
@@ -316,17 +609,138 @@ static int mc13783_is_enabled(struct regulator_dev *rdev)
 	int ret, id = rdev_get_id(rdev);
 	unsigned int val;
 
-	ret = mc13783_reg_read(priv->mc13783, mc13783_regulators[id].reg, &val);
+	/* The regulator is enabled by default */
+	if (!mc13783_regulators[id].control_reg)
+		return true;
+
+	ret = mc13783_reg_read(priv->mc13783, mc13783_regulators[id].control_reg, &val);
 	if (ret)
 		return ret;
 
 	return (val & mc13783_regulators[id].enable_bit) != 0;
 }
 
+static int mc13783_list_voltage (struct regulator_dev *rdev, unsigned selector)
+{
+	int id = rdev_get_id(rdev);
+
+	if (selector >= mc13783_regulators[id].desc.n_voltages)
+		return -EINVAL;
+
+	return mc13783_regulators[id].voltages[selector];
+}
+
+static int mc13783_get_best_voltage_index(struct regulator_dev *rdev,
+					  int min_uV, int max_uV)
+{
+	int reg_id = rdev_get_id(rdev);
+	int i;
+	int bestmatch;
+	int bestindex;
+
+	/*
+	 * Locate the minimum voltage fitting the criteria on
+	 * this regulator. The switchable voltages are not
+	 * in strict falling order so we need to check them
+	 * all for the best match.
+	 */
+	bestmatch = INT_MAX;
+	bestindex = -1;
+	for (i = 0; i < mc13783_regulators[reg_id].desc.n_voltages; i++) {
+		if (mc13783_regulators[reg_id].voltages[i] <= max_uV &&
+		    mc13783_regulators[reg_id].voltages[i] >= min_uV &&
+		    mc13783_regulators[reg_id].voltages[i] < bestmatch) {
+			bestmatch = mc13783_regulators[reg_id].voltages[i];
+			bestindex = i;
+		}
+	}
+
+	if (bestindex < 0) {
+		dev_warn(&rdev->dev, "requested %d<=x<=%d uV, out of range!\n",
+			 min_uV, max_uV);
+		return -EINVAL;
+	}
+	return bestindex;
+}
+
+static int mc13783_set_voltage (struct regulator_dev *rdev, int min_uV, int max_uV)
+{
+	struct mc13783_priv *priv = rdev_get_drvdata(rdev);
+	int value, id = rdev_get_id(rdev);
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\n",
+		__func__, id, min_uV, max_uV);
+
+	dev_dbg(rdev_get_dev(rdev), "%s n_voltages: %d \n",
+		__func__, mc13783_regulators[id].desc.n_voltages);
+
+	/* If not coherent return -EINVAL */
+	if (mc13783_regulators[id].desc.n_voltages == 0)
+		return -EINVAL;
+
+	/* If it is a fixed regulator*/
+	if (mc13783_regulators[id].desc.n_voltages == 1)
+	{
+		if (min_uV > mc13783_regulators[id].voltages[0] &&
+		    max_uV < mc13783_regulators[id].voltages[0])
+			return 0;
+		else
+			return -EINVAL;
+	}
+
+	/* Find the best index */
+	value = mc13783_get_best_voltage_index(rdev, min_uV, max_uV);
+	dev_dbg(rdev_get_dev(rdev), "%s best value: %d \n",
+		__func__, value);
+	if (value < 0)
+		return value;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d best index: %d\n",
+		__func__, id, value);
+
+	return mc13783_set_bits(priv->mc13783, mc13783_regulators[id].vsel_reg,
+			mc13783_regulators[id].vsel_mask,
+			value << mc13783_regulators[id].vsel_shift);
+}
+
+static int mc13783_get_voltage (struct regulator_dev *rdev)
+{
+	struct mc13783_priv *priv = rdev_get_drvdata(rdev);
+	int ret, id = rdev_get_id(rdev);
+	unsigned int val;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+	/* If not coherent return -EINVAL */
+	if (!mc13783_regulators[id].desc.n_voltages)
+		return -EINVAL;
+
+	/* If it is a fixed voltage regulator */
+	if (mc13783_regulators[id].desc.n_voltages == 1)
+		return mc13783_regulators[id].voltages[0];
+
+	ret = mc13783_reg_read( priv->mc13783,
+				mc13783_regulators[id].vsel_reg, &val);
+	if (ret)
+		return ret;
+
+	val =(val & mc13783_regulators[id].vsel_mask)
+		>> mc13783_regulators[id].vsel_shift;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d val: %d\n", __func__, id, val);
+
+	BUG_ON(val > mc13783_regulators[id].desc.n_voltages);
+
+	return mc13783_regulators[id].voltages[val];
+}
+
 static struct regulator_ops mc13783_regulator_ops = {
 	.enable		= mc13783_enable,
 	.disable	= mc13783_disable,
 	.is_enabled	= mc13783_is_enabled,
+	.list_voltage	= mc13783_list_voltage,
+	.set_voltage	= mc13783_set_voltage,
+	.get_voltage	= mc13783_get_voltage,
 };
 
 static int __devinit mc13783_regulator_probe(struct platform_device *pdev)
@@ -345,6 +759,23 @@ static int __devinit mc13783_regulator_probe(struct platform_device *pdev)
 
 	priv->mc13783 = mc13783;
 
+	/*
+	 * IMX31PDK specific
+	 * will be removed
+	 * START
+	 */
+
+	/*most regulators are controled by standby signal*/
+	/*except violo*/
+	mc13783_set_bits(priv->mc13783, MC13783_REG_REGULATOR_MODE_0,0x492412,0x492412);
+	mc13783_set_bits(priv->mc13783, MC13783_REG_REGULATOR_MODE_1,0x492492,0x492492);
+	/*also sw3 is controled by standby signal*/
+	mc13783_set_bits(priv->mc13783, MC13783_REG_SWITCHERS_5,0x200000,0x200000);
+
+	/*
+	 * END
+	 */
+
 	for (i = 0; i < mc13783->num_regulators; i++) {
 		init_data = &mc13783->regulators[i];
 		priv->regulators[i] = regulator_register(
@@ -389,12 +820,12 @@ static struct platform_driver mc13783_regulator_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.remove		= __devexit_p(mc13783_regulator_remove),
+	.probe		= mc13783_regulator_probe,
 };
 
 static int __init mc13783_regulator_init(void)
 {
-	return platform_driver_probe(&mc13783_regulator_driver,
-			mc13783_regulator_probe);
+	return platform_driver_register(&mc13783_regulator_driver);
 }
 subsys_initcall(mc13783_regulator_init);
 
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 89c22ef..de1f323 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -18,6 +18,8 @@
  * Boston, MA  02110-1301, USA.
  */
 
+#define DEBUG 1
+
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
diff --git a/include/linux/mfd/mc13783-private.h b/include/linux/mfd/mc13783-private.h
index 47e698c..6614de9 100644
--- a/include/linux/mfd/mc13783-private.h
+++ b/include/linux/mfd/mc13783-private.h
@@ -251,6 +251,17 @@ int mc13783_register_irq(struct mc13783 *mc13783, int irq,
 #define MC13783_REGCTRL_VIBPINCTRL	(1 << 14)
 
 /*
+ * Reg Switchers
+ * 0, 1, 2, 3 (1A, 1B, 2A, 2B)
+ */
+#define MC13783_REGSET_SW_VSEL_SHIFT		0
+#define MC13783_REGSET_SW_DVS_VSEL_SHIFT	6
+#define MC13783_REGSET_SW_STBY_VSEL_SHIFT	12
+#define MC13783_REGSET_SW_VSEL_MASK		(0x3F << 0)
+#define MC13783_REGSET_SW_DVS_VSEL_MASK		(0x3F << 6)
+#define MC13783_REGSET_SW_STBY_VSEL_MASK	(0x3F << 12)
+
+/*
  * Reg Switcher 4
  */
 #define MC13783_SWCTRL_SW1A_MODE	(1 << 0)
@@ -279,12 +290,52 @@ int mc13783_register_irq(struct mc13783 *mc13783, int irq,
 #define MC13783_SWCTRL_SW2B_DVS_SPEED	(1 << 14)
 #define MC13783_SWCTRL_SW2B_PANIC_MODE	(1 << 16)
 #define MC13783_SWCTRL_SW2B_SOFTSTART	(1 << 17)
-#define MC13783_SWSET_SW3		(1 << 18)
+#define MC13783_REGSET_SW3_VSEL_SHIFT	18
+#define MC13783_REGSET_SW3_VSEL_MASK	(3 << 18)
 #define MC13783_SWCTRL_SW3_EN		(1 << 20)
 #define MC13783_SWCTRL_SW3_STBY		(1 << 21)
 #define MC13783_SWCTRL_SW3_MODE		(1 << 22)
 
 /*
+ * Reg Setting 0
+ */
+#define MC13783_REGSET_VIOLO_VSEL_SHIFT		2
+#define MC13783_REGSET_VDIG_VSEL_SHIFT		4
+#define MC13783_REGSET_VGEN_VSEL_SHIFT		6
+#define MC13783_REGSET_VRFDIG_VSEL_SHIFT	9
+#define MC13783_REGSET_VRFREF_VSEL_SHIFT	11
+#define MC13783_REGSET_VRFCP_VSEL_SHIFT		13
+#define MC13783_REGSET_VSIM_VSEL_SHIFT		14
+#define MC13783_REGSET_VESIM_VSEL_SHIFT		15
+#define MC13783_REGSET_VCAM_VSEL_SHIFT		16
+
+#define MC13783_REGSET_VIOLO_VSEL_MASK	(3 << 2)
+#define MC13783_REGSET_VDIG_VSEL_MASK	(3 << 4)
+#define MC13783_REGSET_VGEN_VSEL_MASK	(7 << 6)
+#define MC13783_REGSET_VRFDIG_VSEL_MASK	(3 << 9)
+#define MC13783_REGSET_VRFREF_VSEL_MASK	(3 << 11)
+#define MC13783_REGSET_VRFCP_VSEL_MASK	(1 << 13)
+#define MC13783_REGSET_VSIM_VSEL_MASK	(1 << 14)
+#define MC13783_REGSET_VESIM_VSEL_MASK	(1 << 15)
+#define MC13783_REGSET_VCAM_VSEL_MASK	(7 << 16)
+
+/*
+ * Reg Setting 1
+ */
+#define MC13783_REGSET_VVIB_VSEL_SHIFT	0
+#define MC13783_REGSET_VRF1_VSEL_SHIFT	2
+#define MC13783_REGSET_VRF2_VSEL_SHIFT	4
+#define MC13783_REGSET_VMMC1_VSEL_SHIFT	6
+#define MC13783_REGSET_VMMC2_VSEL_SHIFT	9
+
+#define MC13783_REGSET_VVIB_VSEL_MASK	(3 << 0)
+#define MC13783_REGSET_VRF1_VSEL_MASK	(3 << 2)
+#define MC13783_REGSET_VRF2_VSEL_MASK	(3 << 4)
+#define MC13783_REGSET_VMMC1_VSEL_MASK	(7 << 6)
+#define MC13783_REGSET_VMMC2_VSEL_MASK	(7 << 9)
+
+
+/*
  * ADC/Touch
  */
 #define MC13783_ADC0_LICELLCON		(1 << 0)
-- 
1.6.3.3
