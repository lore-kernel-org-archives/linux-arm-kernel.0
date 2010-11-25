From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 25 Nov 2010 16:21:35 +0800
Subject: [PATCH] mc13892 regulator enable on mx51 babbage board
Message-ID: <mailman.41.1291737743.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to suggestions of Sascha Hauer and Arnaud Patard, some macro
definitions are moved to a seperated head file to benifit both mc13892
and mc13793.

Signed-off-by: Yong Shen <yong.shen@linaro.org>
---
=A0arch/arm/mach-mx5/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +-
=A0arch/arm/mach-mx5/babbage_regulator_mc13892.c | =A0371 +++++++++++
=A0arch/arm/mach-mx5/board-mx51_babbage.c =A0 =A0 =A0 =A0| =A0 =A03 +
=A0drivers/regulator/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A07 +
=A0drivers/regulator/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
=A0drivers/regulator/mc13783-regulator.c =A0 =A0 =A0 =A0 | =A0 62 +--
=A0drivers/regulator/mc13892-regulator.c =A0 =A0 =A0 =A0 | =A0875 +++++++++=
++++++++++++++++
=A0include/linux/mfd/mc13783.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 67=
 +-
=A0include/linux/mfd/mc13892.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 38=
 ++
=A0include/linux/regulator/mc13xxx.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 81 +++
=A010 files changed, 1430 insertions(+), 77 deletions(-)
=A0create mode 100644 arch/arm/mach-mx5/babbage_regulator_mc13892.c
=A0create mode 100644 drivers/regulator/mc13892-regulator.c
=A0create mode 100644 include/linux/mfd/mc13892.h
=A0create mode 100644 include/linux/regulator/mc13xxx.h

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 026cd85..1594c9f 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -6,7 +6,7 @@
=A0obj-y =A0 :=3D cpu.o mm.o clock-mx51-mx53.o devices.o

=A0obj-$(CONFIG_CPU_FREQ_IMX) =A0 =A0+=3D cpu_op-mx51.o
-obj-$(CONFIG_MACH_MX51_BABBAGE) +=3D board-mx51_babbage.o
+obj-$(CONFIG_MACH_MX51_BABBAGE) +=3D board-mx51_babbage.o
babbage_regulator_mc13892.o
=A0obj-$(CONFIG_MACH_MX51_3DS) +=3D board-mx51_3ds.o
=A0obj-$(CONFIG_MACH_EUKREA_CPUIMX51) +=3D board-cpuimx51.o
=A0obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) +=3D eukrea_mbimx51-baseboar=
d.o
diff --git a/arch/arm/mach-mx5/babbage_regulator_mc13892.c
b/arch/arm/mach-mx5/babbage_regulator_mc13892.c
new file mode 100644
index 0000000..14923d6
--- /dev/null
+++ b/arch/arm/mach-mx5/babbage_regulator_mc13892.c
@@ -0,0 +1,371 @@
+/*
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
+ * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserv=
ed.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/err.h>
+#include <linux/regulator/machine.h>
+#include <linux/mfd/mc13xxx.h>
+#include <linux/mfd/mc13892.h>
+#include <mach/gpio.h>
+
+#define BABBAGE_PMIC =A0 =A0 =A0 =A0 =A0 (2*32 + 8)
+
+static struct regulator_consumer_supply sw1_consumers[] =3D {
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "cpu_vcc",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_consumer_supply vdig_consumers[] =3D {
+ =A0 =A0 =A0 /* sgtl5000 */
+ =A0 =A0 =A0 REGULATOR_SUPPLY("VDDA", "1-000a"),
+ =A0 =A0 =A0 REGULATOR_SUPPLY("VDDD", "1-000a"),
+};
+
+static struct regulator_consumer_supply vvideo_consumers[] =3D {
+ =A0 =A0 =A0 /* sgtl5000 */
+ =A0 =A0 =A0 REGULATOR_SUPPLY("VDDIO", "1-000a"),
+};
+
+static struct regulator_consumer_supply vsd_consumers[] =3D {
+ =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx.0"),
+ =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx.1"),
+};
+
+static struct regulator_consumer_supply pwgt1_consumer[] =3D {
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "pwgt1",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_consumer_supply pwgt2_consumer[] =3D {
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "pwgt2",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_consumer_supply coincell_consumer[] =3D {
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "coincell",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data sw1_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "SW1",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 600000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1375000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_VOLTAGE,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D 0,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .state_mem =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uV =3D 850000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mode =3D REGULATOR_MODE_NORM=
AL,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enabled =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(sw1_consumers),
+ =A0 =A0 =A0 .consumer_supplies =3D sw1_consumers,
+};
+
+static struct regulator_init_data sw2_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "SW2",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 900000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1850000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_VOLTAGE,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .state_mem =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uV =3D 950000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mode =3D REGULATOR_MODE_NORM=
AL,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enabled =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data sw3_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "SW3",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1100000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1850000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_VOLTAGE,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data sw4_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "SW4",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1100000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1850000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_VOLTAGE,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data viohi_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VIOHI",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vusb_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VUSB",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data swbst_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "SWBST",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vdig_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VDIG",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1050000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vdig_consumers),
+ =A0 =A0 =A0 .consumer_supplies =3D vdig_consumers,
+};
+
+static struct regulator_init_data vpll_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VPLL",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1050000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vusb2_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VUSB2",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 2400000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 2775000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_VOLTAGE,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vvideo_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VVIDEO",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 2775000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 2775000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =3D 1,
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vvideo_consumers),
+ =A0 =A0 =A0 .consumer_supplies =3D vvideo_consumers,
+};
+
+static struct regulator_init_data vaudio_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VAUDIO",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 2300000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3000000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vsd_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VSD",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3150000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vsd_consumers),
+ =A0 =A0 =A0 .consumer_supplies =3D vsd_consumers,
+};
+
+static struct regulator_init_data vcam_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VCAM",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 2500000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3000000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_MODE | REGUL=
ATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_MODE_FAST | R=
EGULATOR_MODE_NORMAL,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vgen1_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VGEN1",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1200000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3150000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vgen2_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VGEN2",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1200000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3150000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data vgen3_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VGEN3",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 2900000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =3D 1,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =3D 1,
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data gpo1_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "GPO1",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data gpo2_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "GPO2",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data gpo3_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "GPO3",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data gpo4_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "GPO4",
+ =A0 =A0 =A0 }
+};
+
+static struct regulator_init_data pwgt1_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =A0 =A0 =A0 =A0=3D 1,
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(pwgt1_consumer),
+ =A0 =A0 =A0 .consumer_supplies =3D pwgt1_consumer,
+};
+
+static struct regulator_init_data pwgt2_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .boot_on =A0 =A0 =A0 =A0=3D 1,
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(pwgt2_consumer),
+ =A0 =A0 =A0 .consumer_supplies =3D pwgt2_consumer,
+};
+
+static struct regulator_init_data vcoincell_init =3D {
+ =A0 =A0 =A0 .constraints =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "COINCELL",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 3000000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3000000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REGULATOR_CHANGE_VOLTAGE | RE=
GULATOR_CHANGE_STATUS,
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(coincell_consumer),
+ =A0 =A0 =A0 .consumer_supplies =3D coincell_consumer,
+};
+static struct mc13xxx_regulator_init_data mx51_bbg_regulators[] =3D {
+ =A0 =A0 =A0 { .id =3D MC13892_SW1, =A0 =A0 =A0 =A0 =A0 =A0.init_data =3D =
=A0&sw1_init },
+ =A0 =A0 =A0 { .id =3D MC13892_SW2, =A0 =A0 =A0 =A0 =A0 =A0.init_data =3D =
=A0&sw2_init },
+ =A0 =A0 =A0 { .id =3D MC13892_SW3, =A0 =A0 =A0 =A0 =A0 =A0.init_data =3D =
=A0&sw3_init },
+ =A0 =A0 =A0 { .id =3D MC13892_SW4, =A0 =A0 =A0 =A0 =A0 =A0.init_data =3D =
=A0&sw4_init },
+ =A0 =A0 =A0 { .id =3D MC13892_SWBST, =A0.init_data =3D =A0&swbst_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VIOHI, =A0.init_data =3D =A0&viohi_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VPLL, =A0 .init_data =3D =A0&vpll_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VDIG, =A0 .init_data =3D =A0&vdig_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VSD, =A0 =A0.init_data =3D =A0&vsd_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VUSB2, =A0.init_data =3D =A0&vusb2_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VVIDEO, .init_data =3D =A0&vvideo_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VAUDIO, .init_data =3D =A0&vaudio_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VCAM, =A0 .init_data =3D =A0&vcam_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VGEN1, =A0.init_data =3D =A0&vgen1_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VGEN2, =A0.init_data =3D =A0&vgen2_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VGEN3, =A0.init_data =3D =A0&vgen3_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VUSB, =A0 .init_data =3D =A0&vusb_init },
+ =A0 =A0 =A0 { .id =3D MC13892_GPO1, =A0 .init_data =3D =A0&gpo1_init },
+ =A0 =A0 =A0 { .id =3D MC13892_GPO2, =A0 .init_data =3D =A0&gpo2_init },
+ =A0 =A0 =A0 { .id =3D MC13892_GPO3, =A0 .init_data =3D =A0&gpo3_init },
+ =A0 =A0 =A0 { .id =3D MC13892_GPO4, =A0 .init_data =3D =A0&gpo4_init },
+ =A0 =A0 =A0 { .id =3D MC13892_PWGT1SPI, =A0 =A0 =A0 .init_data =3D &pwgt1=
_init },
+ =A0 =A0 =A0 { .id =3D MC13892_PWGT2SPI, =A0 =A0 =A0 .init_data =3D &pwgt2=
_init },
+ =A0 =A0 =A0 { .id =3D MC13892_VCOINCELL, =A0 =A0 =A0.init_data =3D &vcoin=
cell_init },
+};
+
+static struct mc13xxx_platform_data mx51_bbg_mc13892_data =3D {
+ =A0 =A0 =A0 .flags =3D MC13XXX_USE_RTC | MC13XXX_USE_REGULATOR,
+ =A0 =A0 =A0 .num_regulators =3D ARRAY_SIZE(mx51_bbg_regulators),
+ =A0 =A0 =A0 .regulators =3D mx51_bbg_regulators,
+};
+
+static struct spi_board_info mx51_bbg_spi_board_info[] __initdata =3D {
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modalias =3D "mc13892",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_speed_hz =3D 6000000,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_num =3D 0,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip_select =3D 0,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &mx51_bbg_mc13892_data,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =3D gpio_to_irq(BABBAGE_PMIC),
+ =A0 =A0 =A0 },
+};
+
+int __init mx51_babbage_init_mc13892(void)
+{
+ =A0 =A0 =A0 return spi_register_board_info(mx51_bbg_spi_board_info,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(mx51_bbg_spi_board_info));
+}
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c
b/arch/arm/mach-mx5/board-mx51_babbage.c
index ef32843..9cf16d1 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -1,4 +1,5 @@
=A0/*
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
=A0* Copyright 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
=A0* Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
=A0*
@@ -342,6 +343,7 @@ static const struct spi_imx_master
mx51_babbage_spi_pdata __initconst =3D {
=A0 =A0 =A0 =A0.num_chipselect =3D ARRAY_SIZE(mx51_babbage_spi_cs),
=A0};

+extern int __init mx51_babbage_init_mc13892(void);
=A0/*
=A0* Board specific initialization.
=A0*/
@@ -384,6 +386,7 @@ static void __init mxc_board_init(void)
=A0 =A0 =A0 =A0imx51_add_sdhci_esdhc_imx(0, NULL);
=A0 =A0 =A0 =A0imx51_add_sdhci_esdhc_imx(1, NULL);

+ =A0 =A0 =A0 mx51_babbage_init_mc13892();
=A0 =A0 =A0 =A0spi_register_board_info(mx51_babbage_spi_board_info,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(mx51_babbage_spi_board_info));
=A0 =A0 =A0 =A0imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index dd30e88..f074b82 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -193,6 +193,13 @@ config REGULATOR_MC13783
=A0 =A0 =A0 =A0 =A0Say y here to support the regulators found on the Freesc=
ale MC13783
=A0 =A0 =A0 =A0 =A0PMIC.

+config REGULATOR_MC13892
+ =A0 =A0 =A0 tristate "Support regulators on Freescale MC13892 PMIC"
+ =A0 =A0 =A0 depends on MFD_MC13XXX
+ =A0 =A0 =A0 help
+ =A0 =A0 =A0 =A0 Say y here to support the regulators found on the Freesca=
le MC13892
+ =A0 =A0 =A0 =A0 PMIC.
+
=A0config REGULATOR_AB3100
=A0 =A0 =A0 =A0tristate "ST-Ericsson AB3100 Regulator functions"
=A0 =A0 =A0 =A0depends on AB3100_CORE
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index bff8157..b601ddb 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_REGULATOR_DA903X) =A0 =A0 =A0 =A0+=3D da903x=
.o
=A0obj-$(CONFIG_REGULATOR_PCF50633) +=3D pcf50633-regulator.o
=A0obj-$(CONFIG_REGULATOR_PCAP) +=3D pcap-regulator.o
=A0obj-$(CONFIG_REGULATOR_MC13783) +=3D mc13783-regulator.o
+obj-$(CONFIG_REGULATOR_MC13892) +=3D mc13892-regulator.o
=A0obj-$(CONFIG_REGULATOR_AB3100) +=3D ab3100.o

=A0obj-$(CONFIG_REGULATOR_TPS65023) +=3D tps65023-regulator.o
diff --git a/drivers/regulator/mc13783-regulator.c
b/drivers/regulator/mc13783-regulator.c
index 4597d50..ea94ca7 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -1,6 +1,7 @@
=A0/*
=A0* Regulator Driver for Freescale MC13783 PMIC
=A0*
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
=A0* Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
=A0* Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
=A0*
@@ -10,6 +11,7 @@
=A0*/

=A0#include <linux/mfd/mc13783.h>
+#include <linux/regulator/mc13xxx.h>
=A0#include <linux/regulator/machine.h>
=A0#include <linux/regulator/driver.h>
=A0#include <linux/platform_device.h>
@@ -89,16 +91,6 @@
=A0#define MC13783_REG_POWERMISC_PWGTSPI_M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(3 << 15)


-struct mc13783_regulator {
- =A0 =A0 =A0 struct regulator_desc desc;
- =A0 =A0 =A0 int reg;
- =A0 =A0 =A0 int enable_bit;
- =A0 =A0 =A0 int vsel_reg;
- =A0 =A0 =A0 int vsel_shift;
- =A0 =A0 =A0 int vsel_mask;
- =A0 =A0 =A0 int const *voltages;
-};
-
=A0/* Voltage Values */
=A0static const int const mc13783_sw3_val[] =3D {
=A0 =A0 =A0 =A05000000, 5000000, 5000000, 5500000,
@@ -179,6 +171,7 @@ static struct regulator_ops mc13783_regulator_ops;
=A0static struct regulator_ops mc13783_fixed_regulator_ops;
=A0static struct regulator_ops mc13783_gpo_regulator_ops;

+/*
=A0#define MC13783_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages) =A0 =
=A0 =A0\
=A0 =A0 =A0 =A0[MC13783_ ## prefix ## _ ## _name] =3D { =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.desc =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
@@ -196,43 +189,26 @@ static struct regulator_ops mc13783_gpo_regulator_ops=
;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vsel_mask =3D MC13783_REG_ ## _vsel_reg ## =
_ ## _name ## VSEL_M,\
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.voltages =3D =A0_voltages, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
=A0 =A0 =A0 =A0}
+ =A0 =A0 =A0 */

-#define MC13783_FIXED_DEFINE(prefix, _name, _reg, _voltages) =A0 =A0 =A0 =
=A0 =A0 \
- =A0 =A0 =A0 [MC13783_ ## prefix ## _ ## _name] =3D { =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D #prefix "_" #_name,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .n_voltages =3D ARRAY_SIZE(_v=
oltages), =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =3D &mc13783_fixed_regul=
ator_ops, =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D REGULATOR_VOLTAGE, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =3D MC13783_ ## prefix ##=
 _ ## _name, =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg =3D MC13783_REG_ ## _reg, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable_bit =3D MC13783_REG_ ## _reg ## _ ## =
_name ## EN, \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltages =3D =A0_voltages, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 }
+#define MC13783_DEFINE(prefix, name, reg, vsel_reg, voltages) =A0\
+ =A0 =A0 =A0 MC13xxx_DEFINE(MC13783_REG_, name, reg, vsel_reg, voltages, \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13783_regulator_ops)

-#define MC13783_GPO_DEFINE(prefix, _name, _reg, =A0_voltages) =A0 =A0 =A0 =
=A0 =A0 =A0\
- =A0 =A0 =A0 [MC13783_ ## prefix ## _ ## _name] =3D { =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D #prefix "_" #_name,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .n_voltages =3D ARRAY_SIZE(_v=
oltages), =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =3D &mc13783_gpo_regulat=
or_ops, =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D REGULATOR_VOLTAGE, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =3D MC13783_ ## prefix ##=
 _ ## _name, =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg =3D MC13783_REG_ ## _reg, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable_bit =3D MC13783_REG_ ## _reg ## _ ## =
_name ## EN, \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltages =3D =A0_voltages, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
- =A0 =A0 =A0 }
+#define MC13783_FIXED_DEFINE(prefix, name, reg, voltages) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0\
+ =A0 =A0 =A0 MC13xxx_FIXED_DEFINE(MC13783_REG_, name, reg, voltages, \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13783_fixed_regulator_ops)
+
+#define MC13783_GPO_DEFINE(prefix, name, reg, voltages) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 MC13xxx_GPO_DEFINE(MC13783_REG_, name, reg, voltages, \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13783_gpo_regulator_ops)

=A0#define MC13783_DEFINE_SW(_name, _reg, _vsel_reg, _voltages) =A0 =A0 =A0=
 =A0 =A0 \
=A0 =A0 =A0 =A0MC13783_DEFINE(SW, _name, _reg, _vsel_reg, _voltages)
=A0#define MC13783_DEFINE_REGU(_name, _reg, _vsel_reg, _voltages) =A0 =A0 =
=A0 =A0 \
=A0 =A0 =A0 =A0MC13783_DEFINE(REGU, _name, _reg, _vsel_reg, _voltages)

-static struct mc13783_regulator mc13783_regulators[] =3D {
+static struct mc13xxx_regulator mc13783_regulators[] =3D {
=A0 =A0 =A0 =A0MC13783_DEFINE_SW(SW3, SWITCHERS5, SWITCHERS5, mc13783_sw3_v=
al),

=A0 =A0 =A0 =A0MC13783_FIXED_DEFINE(REGU, VAUDIO, REGULATORMODE0, mc13783_v=
audio_val),
@@ -502,8 +478,8 @@ static int mc13783_gpo_regulator_enable(struct
regulator_dev *rdev)
=A0 =A0 =A0 =A0dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);

=A0 =A0 =A0 =A0/* Power Gate enable value is 0 */
- =A0 =A0 =A0 if (id =3D=3D MC13783_REGU_PWGT1SPI ||
- =A0 =A0 =A0 =A0 =A0 id =3D=3D MC13783_REGU_PWGT2SPI)
+ =A0 =A0 =A0 if (id =3D=3D MC13783_REG_PWGT1SPI ||
+ =A0 =A0 =A0 =A0 =A0 id =3D=3D MC13783_REG_PWGT2SPI)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0en_val =3D 0;

=A0 =A0 =A0 =A0mc13783_lock(priv->mc13783);
@@ -524,8 +500,8 @@ static int mc13783_gpo_regulator_disable(struct
regulator_dev *rdev)
=A0 =A0 =A0 =A0dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);

=A0 =A0 =A0 =A0/* Power Gate disable value is 1 */
- =A0 =A0 =A0 if (id =3D=3D MC13783_REGU_PWGT1SPI ||
- =A0 =A0 =A0 =A0 =A0 id =3D=3D MC13783_REGU_PWGT2SPI)
+ =A0 =A0 =A0 if (id =3D=3D MC13783_REG_PWGT1SPI ||
+ =A0 =A0 =A0 =A0 =A0 id =3D=3D MC13783_REG_PWGT2SPI)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dis_val =3D mc13783_regulators[id].enable_bi=
t;

=A0 =A0 =A0 =A0mc13783_lock(priv->mc13783);
diff --git a/drivers/regulator/mc13892-regulator.c
b/drivers/regulator/mc13892-regulator.c
new file mode 100644
index 0000000..0716827
--- /dev/null
+++ b/drivers/regulator/mc13892-regulator.c
@@ -0,0 +1,875 @@
+/*
+ * Regulator Driver for Freescale MC13892 PMIC
+ *
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
+ * Copyright 2010 Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * Based on mc13783 regulator driver :
+ * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
+ *
+ * TODO: look if mc13783 & this driver can be merged. they share a lot
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Regs infos taken from mc13892 drivers from freescale and mc13892.pdf fi=
le
+ * from freescale
+ */
+
+#define DEBUG
+
+#include <linux/mfd/mc13892.h>
+#include <linux/regulator/mc13xxx.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+
+
+#define mc13892_reg_read =A0 =A0 =A0 mc13xxx_reg_read
+#define mc13892_reg_write =A0 =A0 =A0mc13xxx_reg_write
+#define mc13892_reg_rmw =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mc13xxx_reg_rmw
+
+#define MC13892_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 7
+
+#define MC13892_POWERCTL0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A013
+#define MC13892_POWERCTL0_USEROFFSPI =A0 =A0 =A0 =A0 =A0 3
+#define MC13892_POWERCTL0_VCOINCELLVSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A020
+#define MC13892_POWERCTL0_VCOINCELLVSEL_M =A0 =A0 =A0 =A0 =A0 =A0 =A0(7<<2=
0)
+#define MC13892_POWERCTL0_VCOINCELLEN =A0 =A0 =A0 =A0 =A0(1<<23)
+
+#define MC13892_SWITCHERS0_SWxHI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<23)
+
+#define MC13892_SWITCHERS0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 24
+#define MC13892_SWITCHERS0_SW1VSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0
+#define MC13892_SWITCHERS0_SW1VSEL_M =A0 =A0 =A0 =A0 =A0 (0x1f<<0)
+#define MC13892_SWITCHERS0_SW1HI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<23)
+#define MC13892_SWITCHERS0_SW1EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 /*no use*/
+
+#define MC13892_SWITCHERS1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 25
+#define MC13892_SWITCHERS1_SW2VSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0
+#define MC13892_SWITCHERS1_SW2VSEL_M =A0 =A0 =A0 =A0 =A0 (0x1f<<0)
+#define MC13892_SWITCHERS1_SW2HI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<23)
+#define MC13892_SWITCHERS1_SW2EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 /*no use*/
+
+#define MC13892_SWITCHERS2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 26
+#define MC13892_SWITCHERS2_SW3VSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0
+#define MC13892_SWITCHERS2_SW3VSEL_M =A0 =A0 =A0 =A0 =A0 (0x1f<<0)
+#define MC13892_SWITCHERS2_SW3HI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<23)
+#define MC13892_SWITCHERS2_SW3EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 0/*no use*/
+
+#define MC13892_SWITCHERS3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 27
+#define MC13892_SWITCHERS3_SW4VSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0
+#define MC13892_SWITCHERS3_SW4VSEL_M =A0 =A0 =A0 =A0 =A0 (0x1f<<0)
+#define MC13892_SWITCHERS3_SW4HI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<23)
+#define MC13892_SWITCHERS3_SW4EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 0/*no use*/
+
+#define MC13892_SWITCHERS4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 28
+#define MC13892_SWITCHERS4_SW1MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0
+#define MC13892_SWITCHERS4_SW1MODE_AUTO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(8<=
<0)
+#define MC13892_SWITCHERS4_SW1MODE_M =A0 =A0 =A0 =A0 =A0 (0xf<<0)
+#define MC13892_SWITCHERS4_SW2MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 10
+#define MC13892_SWITCHERS4_SW2MODE_AUTO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(8<=
<10)
+#define MC13892_SWITCHERS4_SW2MODE_M =A0 =A0 =A0 =A0 =A0 (0xf<<10)
+
+#define MC13892_SWITCHERS5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 29
+#define MC13892_SWITCHERS5_SW3MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0
+#define MC13892_SWITCHERS5_SW3MODE_AUTO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(8<=
<0)
+#define MC13892_SWITCHERS5_SW3MODE_M =A0 =A0 =A0 =A0 =A0 (0xf<<0)
+#define MC13892_SWITCHERS5_SW4MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 8
+#define MC13892_SWITCHERS5_SW4MODE_AUTO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(8<=
<8)
+#define MC13892_SWITCHERS5_SW4MODE_M =A0 =A0 =A0 =A0 =A0 (0xf<<8)
+#define MC13892_SWITCHERS5_SWBSTEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<20)
+
+
+#define MC13892_REGULATORSETTING0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A030
+#define MC13892_REGULATORSETTING0_VGEN1VSEL =A0 =A0 =A0 =A0 =A0 =A00
+#define MC13892_REGULATORSETTING0_VDIGVSEL =A0 =A0 =A0 =A0 =A0 =A0 4
+#define MC13892_REGULATORSETTING0_VGEN2VSEL =A0 =A0 =A0 =A0 =A0 =A06
+#define MC13892_REGULATORSETTING0_VPLLVSEL =A0 =A0 =A0 =A0 =A0 =A0 9
+#define MC13892_REGULATORSETTING0_VUSB2VSEL =A0 =A0 =A0 =A0 =A0 =A011
+#define MC13892_REGULATORSETTING0_VGEN3VSEL =A0 =A0 =A0 =A0 =A0 =A014
+#define MC13892_REGULATORSETTING0_VCAMVSEL =A0 =A0 =A0 =A0 =A0 =A0 16
+
+#define MC13892_REGULATORSETTING0_VGEN1VSEL_M =A0(3<<0)
+#define MC13892_REGULATORSETTING0_VDIGVSEL_M =A0 (3<<4)
+#define MC13892_REGULATORSETTING0_VGEN2VSEL_M =A0(7<<6)
+#define MC13892_REGULATORSETTING0_VPLLVSEL_M =A0 (3<<9)
+#define MC13892_REGULATORSETTING0_VUSB2VSEL_M =A0(3<<11)
+#define MC13892_REGULATORSETTING0_VGEN3VSEL_M =A0(1<<14)
+#define MC13892_REGULATORSETTING0_VCAMVSEL_M =A0 (3<<16)
+
+#define MC13892_REGULATORSETTING1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A031
+#define MC13892_REGULATORSETTING1_VVIDEOVSEL =A0 2
+#define MC13892_REGULATORSETTING1_VAUDIOVSEL =A0 4
+#define MC13892_REGULATORSETTING1_VSDVSEL =A0 =A0 =A0 =A0 =A0 =A0 =A06
+
+#define MC13892_REGULATORSETTING1_VVIDEOVSEL_M (3<<2)
+#define MC13892_REGULATORSETTING1_VAUDIOVSEL_M (3<<4)
+#define MC13892_REGULATORSETTING1_VSDVSEL_M =A0 =A0 =A0 =A0 =A0 =A0(7<<6)
+
+/* according to MC13783IGPLDRM.pdf : =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0*/
+/* standby is using to allow low power mode through standby pin */
+/* mode is using to set in low power mode if standby disabled =A0 */
+#define MC13892_REGULATORMODE0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 32
+#define MC13892_REGULATORMODE0_VGEN1EN =A0 =A0 =A0 =A0 (1<<0)
+#define MC13892_REGULATORMODE0_VGEN1STDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<1=
)
+#define MC13892_REGULATORMODE0_VGEN1MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<2=
)
+#define MC13892_REGULATORMODE0_VIOHIEN =A0 =A0 =A0 =A0 (1<<3)
+#define MC13892_REGULATORMODE0_VIOHISTDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<4=
)
+#define MC13892_REGULATORMODE0_VIOHIMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<5=
)
+#define MC13892_REGULATORMODE0_VDIGEN =A0 =A0 =A0 =A0 =A0(1<<9)
+#define MC13892_REGULATORMODE0_VDIGSTDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<1=
0)
+#define MC13892_REGULATORMODE0_VDIGMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<11)
+#define MC13892_REGULATORMODE0_VGEN2EN =A0 =A0 =A0 =A0 (1<<12)
+#define MC13892_REGULATORMODE0_VGEN2STDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<1=
3)
+#define MC13892_REGULATORMODE0_VGEN2MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<1=
4)
+#define MC13892_REGULATORMODE0_VPLLEN =A0 =A0 =A0 =A0 =A0(1<<15)
+#define MC13892_REGULATORMODE0_VPLLSTDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<1=
6)
+#define MC13892_REGULATORMODE0_VPLLMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<17)
+#define MC13892_REGULATORMODE0_VUSB2EN =A0 =A0 =A0 =A0 (1<<18)
+#define MC13892_REGULATORMODE0_VUSB2STDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<1=
9)
+#define MC13892_REGULATORMODE0_VUSB2MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<2=
0)
+
+#define MC13892_REGULATORMODE1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 33
+#define MC13892_REGULATORMODE1_VGEN3EN =A0 =A0 =A0 =A0 (1<<0)
+#define MC13892_REGULATORMODE1_VGEN3STDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<1=
)
+#define MC13892_REGULATORMODE1_VGEN3MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<2=
)
+#define MC13892_REGULATORMODE1_VCAMEN =A0 =A0 =A0 =A0 =A0(1<<6)
+#define MC13892_REGULATORMODE1_VCAMSTDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<7=
)
+#define MC13892_REGULATORMODE1_VCAMMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<8)
+#define MC13892_REGULATORMODE1_VCAMCONFIGEN =A0 =A0 =A0 =A0 =A0 =A0(1<<9)
+#define MC13892_REGULATORMODE1_VVIDEOEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<12)
+#define MC13892_REGULATORMODE1_VVIDEOSTDBY =A0 =A0 =A0 =A0 =A0 =A0 (1<<13)
+#define MC13892_REGULATORMODE1_VVIDEOMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<1=
4)
+#define MC13892_REGULATORMODE1_VAUDIOEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<15)
+#define MC13892_REGULATORMODE1_VAUDIOSTDBY =A0 =A0 =A0 =A0 =A0 =A0 (1<<16)
+#define MC13892_REGULATORMODE1_VAUDIOMODE =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<1=
7)
+#define MC13892_REGULATORMODE1_VSDEN =A0 =A0 =A0 =A0 =A0 (1<<18)
+#define MC13892_REGULATORMODE1_VSDSTDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<19)
+#define MC13892_REGULATORMODE1_VSDMODE =A0 =A0 =A0 =A0 (1<<20)
+
+#define MC13892_POWERMISC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A034
+#define MC13892_POWERMISC_GPO1EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<6)
+#define MC13892_POWERMISC_GPO2EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<8)
+#define MC13892_POWERMISC_GPO3EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<10)
+#define MC13892_POWERMISC_GPO4EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1<<12)
+#define MC13892_POWERMISC_PWGT1SPIEN =A0 =A0 =A0 =A0 =A0 (1<<15)
+#define MC13892_POWERMISC_PWGT2SPIEN =A0 =A0 =A0 =A0 =A0 (1<<16)
+#define MC13892_POWERMISC_GPO4ADINEN =A0 =A0 =A0 =A0 =A0 (1<<21)
+
+#define MC13892_POWERMISC_PWGTSPI_M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(3 << 15)
+
+#define MC13892_USB1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5=
0
+#define MC13892_USB1_VUSBEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1<<3)
+
+static const int mc13892_vcoincell[] =3D {
+ =A0 =A0 =A0 2500000, 2700000, 2800000, 2900000, 3000000, 3100000,
+ =A0 =A0 =A0 3200000, 3300000,
+};
+
+/* 0.6 -> 1.375 steps 0.025 */
+static const int mc13892_sw1[] =3D {
+ =A0 =A0 =A0 600000, =A0 625000, =A0650000, =A0675000, =A0700000, =A072500=
0,
+ =A0 =A0 =A0 750000, =A0 775000, =A0800000, =A0825000, =A0850000, =A087500=
0,
+ =A0 =A0 =A0 900000, =A0 925000, =A0950000, =A0975000, 1000000, 1025000,
+ =A0 =A0 =A0 1050000, 1075000, 1100000, 1125000, 1150000, 1175000,
+ =A0 =A0 =A0 1200000, 1225000, 1250000, 1275000, 1300000, 1325000,
+ =A0 =A0 =A0 1350000, 1375000
+};
+
+/* 0.6 -> 1.85 steps 0.025 */
+static const int mc13892_sw[] =3D {
+ =A0 =A0 =A0 600000, =A0 625000, =A0650000, =A0675000, =A0700000, =A072500=
0,
+ =A0 =A0 =A0 750000, =A0 775000, =A0800000, =A0825000, =A0850000, =A087500=
0,
+ =A0 =A0 =A0 900000, =A0 925000, =A0950000, =A0975000, 1000000, 1025000,
+ =A0 =A0 =A0 1050000, 1075000, 1100000, 1125000, 1150000, 1175000,
+ =A0 =A0 =A0 1200000, 1225000, 1250000, 1275000, 1300000, 1325000,
+ =A0 =A0 =A0 1350000, 1375000, 1400000, 1425000, 1450000, 1475000,
+ =A0 =A0 =A0 1500000, 1525000, 1550000, 1575000, 1600000, 1625000,
+ =A0 =A0 =A0 1650000, 1675000, 1700000, 1725000, 1750000, 1775000,
+ =A0 =A0 =A0 1800000, 1825000, 1850000, 1875000
+};
+
+static const int mc13892_swbst[] =3D {
+ =A0 =A0 =A0 5000000,
+};
+
+static const int mc13892_viohi[] =3D {
+ =A0 =A0 =A0 2775000,
+};
+
+static const int mc13892_vpll[] =3D {
+ =A0 =A0 =A0 1050000, 1250000, 1650000, 1800000,
+};
+
+static const int mc13892_vdig[] =3D {
+ =A0 =A0 =A0 1050000, 1250000, 1650000, 1800000,
+};
+
+static const int mc13892_vsd[] =3D {
+ =A0 =A0 =A0 1800000, 2000000, 2600000, 2700000,
+ =A0 =A0 =A0 2800000, 2900000, 3000000, 3150000,
+};
+
+static const int mc13892_vusb2[] =3D {
+ =A0 =A0 =A0 2400000, 2600000, 2700000, 2775000,
+};
+
+static const int mc13892_vvideo[] =3D {
+ =A0 =A0 =A0 2500000, 2600000, 270000, 2775000,
+};
+
+static const int mc13892_vaudio[] =3D {
+ =A0 =A0 =A0 2300000, 2500000, 2775000, 3000000,
+};
+
+static const int mc13892_vcam[] =3D {
+ =A0 =A0 =A0 2500000, 2600000, 2750000, 3000000,
+};
+
+static const int mc13892_vgen1[] =3D {
+ =A0 =A0 =A0 1200000, 1500000, 2775000, 3150000,
+};
+
+static const int mc13892_vgen2[] =3D {
+ =A0 =A0 =A0 1200000, 1500000, 1600000, 1800000,
+ =A0 =A0 =A0 2700000, 2800000, 3000000, 3150000,
+};
+
+static const int mc13892_vgen3[] =3D {
+ =A0 =A0 =A0 1800000, 2900000,
+};
+
+/* to check */
+static const int mc13892_vusb[] =3D {
+ =A0 =A0 =A0 3300000,
+};
+
+/* to check */
+static const int mc13892_gpo[] =3D {
+ =A0 =A0 =A0 2750000,
+};
+
+/* to check */
+static const int mc13892_pwgtdrv[] =3D {
+ =A0 =A0 =A0 5000000,
+};
+
+static struct regulator_ops mc13892_regulator_ops;
+static struct regulator_ops mc13892_fixed_regulator_ops;
+static struct regulator_ops mc13892_gpo_regulator_ops;
+/* sw regulators need special care due to the "hi bit" */
+static struct regulator_ops mc13892_sw_regulator_ops;
+
+
+#define MC13892_FIXED_DEFINE(name, reg, voltages)\
+ =A0 =A0 =A0 MC13xxx_FIXED_DEFINE(MC13892_, name, reg, voltages, \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_fixed_regulator_ops)
+
+#define MC13892_GPO_DEFINE(name, reg, voltages) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0\
+ =A0 =A0 =A0 MC13xxx_GPO_DEFINE(MC13892_, name, reg, voltages, \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_gpo_regulator_ops)
+
+#define MC13892_SW_DEFINE(name, reg, vsel_reg, voltages) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 \
+ =A0 =A0 =A0 MC13xxx_DEFINE(MC13892_, name, reg, vsel_reg, voltages, \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_sw_regulator_ops)
+
+#define MC13892_DEFINE_REGU(name, reg, vsel_reg, voltages) =A0 =A0 =A0 =A0=
 =A0 =A0 \
+ =A0 =A0 =A0 MC13xxx_DEFINE(MC13892_, name, reg, vsel_reg, voltages, \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regulator_ops)
+
+static struct mc13xxx_regulator mc13892_regulators[] =3D {
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VCOINCELL, POWERCTL0, POWERCTL0, =A0 =A0 =
=A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vcoincell),
+ =A0 =A0 =A0 MC13892_SW_DEFINE(SW1, SWITCHERS0, SWITCHERS0, mc13892_sw1),
+ =A0 =A0 =A0 MC13892_SW_DEFINE(SW2, SWITCHERS1, SWITCHERS1, mc13892_sw),
+ =A0 =A0 =A0 MC13892_SW_DEFINE(SW3, SWITCHERS2, SWITCHERS2, mc13892_sw),
+ =A0 =A0 =A0 MC13892_SW_DEFINE(SW4, SWITCHERS3, SWITCHERS3, mc13892_sw),
+ =A0 =A0 =A0 MC13892_FIXED_DEFINE(SWBST, SWITCHERS5, mc13892_swbst),
+ =A0 =A0 =A0 MC13892_FIXED_DEFINE(VIOHI, REGULATORMODE0, mc13892_viohi),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VPLL, REGULATORMODE0, REGULATORSETTING0, =
=A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vpll),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VDIG, REGULATORMODE0, REGULATORSETTING0, =
=A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vdig),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VSD, REGULATORMODE1, REGULATORSETTING1, =
=A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vsd),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VUSB2, REGULATORMODE0, REGULATORSETTING0,=
 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vusb2),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VVIDEO, REGULATORMODE1, REGULATORSETTING1=
, =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vvideo),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VAUDIO, REGULATORMODE1, REGULATORSETTING1=
, =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vaudio),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VCAM, REGULATORMODE1, REGULATORSETTING0, =
\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vcam),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VGEN1, REGULATORMODE0, REGULATORSETTING0,=
 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vgen1),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VGEN2, REGULATORMODE0, REGULATORSETTING0,=
 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vgen2),
+ =A0 =A0 =A0 MC13892_DEFINE_REGU(VGEN3, REGULATORMODE1, REGULATORSETTING0,=
 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_vgen3),
+ =A0 =A0 =A0 MC13892_FIXED_DEFINE(VUSB, USB1, mc13892_vusb),
+ =A0 =A0 =A0 MC13892_GPO_DEFINE(GPO1, POWERMISC, mc13892_gpo),
+ =A0 =A0 =A0 MC13892_GPO_DEFINE(GPO2, POWERMISC, mc13892_gpo),
+ =A0 =A0 =A0 MC13892_GPO_DEFINE(GPO3, POWERMISC, mc13892_gpo),
+ =A0 =A0 =A0 MC13892_GPO_DEFINE(GPO4, POWERMISC, mc13892_gpo),
+ =A0 =A0 =A0 MC13892_GPO_DEFINE(PWGT1SPI, POWERMISC, mc13892_pwgtdrv),
+ =A0 =A0 =A0 MC13892_GPO_DEFINE(PWGT2SPI, POWERMISC, mc13892_pwgtdrv),
+};
+
+struct mc13892_regulator_priv {
+ =A0 =A0 =A0 struct mc13xxx *mc13892;
+ =A0 =A0 =A0 u32 powermisc_pwgt_state;
+ =A0 =A0 =A0 struct regulator_dev *regulators[];
+};
+
+static int mc13892_regulator_enable(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 int ret;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_rmw(priv->mc13892, mc13892_regulators[id]=
.reg,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regulators[id].enable=
_bit,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regulators[id].enable=
_bit);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 return ret;
+}
+
+static int mc13892_regulator_disable(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 int ret;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_rmw(priv->mc13892, mc13892_regulators[id]=
.reg,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regulators[id].enable=
_bit, 0);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 return ret;
+}
+
+static int mc13892_regulator_is_enabled(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int ret, id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 unsigned int val;
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(priv->mc13892, mc13892_regulators[id=
].reg, &val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
+
+ =A0 =A0 =A0 return (val & mc13892_regulators[id].enable_bit) !=3D 0;
+}
+
+static int mc13892_regulator_list_voltage(struct regulator_dev *rdev,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 unsigned selector)
+{
+ =A0 =A0 =A0 int id =3D rdev_get_id(rdev);
+
+ =A0 =A0 =A0 if (selector >=3D mc13892_regulators[id].desc.n_voltages)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
+
+ =A0 =A0 =A0 return mc13892_regulators[id].voltages[selector];
+}
+
+static int mc13892_get_best_voltage_index(struct regulator_dev *rdev,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 int min_uV, int max_uV)
+{
+ =A0 =A0 =A0 int reg_id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 int i;
+ =A0 =A0 =A0 int bestmatch;
+ =A0 =A0 =A0 int bestindex;
+
+ =A0 =A0 =A0 /*
+ =A0 =A0 =A0 =A0* Locate the minimum voltage fitting the criteria on
+ =A0 =A0 =A0 =A0* this regulator. The switchable voltages are not
+ =A0 =A0 =A0 =A0* in strict falling order so we need to check them
+ =A0 =A0 =A0 =A0* all for the best match.
+ =A0 =A0 =A0 =A0*/
+ =A0 =A0 =A0 bestmatch =3D INT_MAX;
+ =A0 =A0 =A0 bestindex =3D -1;
+ =A0 =A0 =A0 for (i =3D 0; i < mc13892_regulators[reg_id].desc.n_voltages;=
 i++) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mc13892_regulators[reg_id].voltages[i] >=
=3D min_uV &&
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regulators[reg_id].voltages[i=
] < bestmatch) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bestmatch =3D mc13892_regulat=
ors[reg_id].voltages[i];
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bestindex =3D i;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 if (bestindex < 0 || bestmatch > max_uV) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&rdev->dev, "no possible value for %=
d<=3Dx<=3D%d uV\n",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_uV, max_u=
V);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
+ =A0 =A0 =A0 }
+ =A0 =A0 =A0 return bestindex;
+}
+
+static int mc13892_regulator_set_voltage(struct regulator_dev *rdev,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 int min_uV, int max_uV)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int value, id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 int ret;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\=
n",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, id, min_uV, max_uV);
+
+ =A0 =A0 =A0 /* Find the best index */
+ =A0 =A0 =A0 value =3D mc13892_get_best_voltage_index(rdev, min_uV, max_uV=
);
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s best value: %d\n", __func__, =
value);
+ =A0 =A0 =A0 if (value < 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value;
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_rmw(priv->mc13892, mc13892_regulators[id]=
.vsel_reg,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regulators[id].vsel_m=
ask,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value << mc13892_regulators[i=
d].vsel_shift);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 return ret;
+}
+
+static int mc13892_regulator_get_voltage(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int ret, id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 unsigned int val;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(priv->mc13892,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regul=
ators[id].vsel_reg, &val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
+
+ =A0 =A0 =A0 val =3D (val & mc13892_regulators[id].vsel_mask)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> mc13892_regulators[id].vsel_shift;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d val: %d\n", __func__, =
id, val);
+
+ =A0 =A0 =A0 BUG_ON(val < 0 || val > mc13892_regulators[id].desc.n_voltage=
s);
+
+ =A0 =A0 =A0 return mc13892_regulators[id].voltages[val];
+}
+
+static struct regulator_ops mc13892_regulator_ops =3D {
+ =A0 =A0 =A0 .enable =3D mc13892_regulator_enable,
+ =A0 =A0 =A0 .disable =3D mc13892_regulator_disable,
+ =A0 =A0 =A0 .is_enabled =3D mc13892_regulator_is_enabled,
+ =A0 =A0 =A0 .list_voltage =3D mc13892_regulator_list_voltage,
+ =A0 =A0 =A0 .set_voltage =3D mc13892_regulator_set_voltage,
+ =A0 =A0 =A0 .get_voltage =3D mc13892_regulator_get_voltage,
+};
+
+static int mc13892_fixed_regulator_set_voltage(struct regulator_dev *rdev,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 int min_uV, int max_uV)
+{
+ =A0 =A0 =A0 int id =3D rdev_get_id(rdev);
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\=
n",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, id, min_uV, max_uV);
+
+ =A0 =A0 =A0 if (min_uV >=3D mc13892_regulators[id].voltages[0] &&
+ =A0 =A0 =A0 =A0 =A0 max_uV <=3D mc13892_regulators[id].voltages[0])
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
+}
+
+static int mc13892_fixed_regulator_get_voltage(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 int id =3D rdev_get_id(rdev);
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+ =A0 =A0 =A0 return mc13892_regulators[id].voltages[0];
+}
+
+static struct regulator_ops mc13892_fixed_regulator_ops =3D {
+ =A0 =A0 =A0 .enable =3D mc13892_regulator_enable,
+ =A0 =A0 =A0 .disable =3D mc13892_regulator_disable,
+ =A0 =A0 =A0 .is_enabled =3D mc13892_regulator_is_enabled,
+ =A0 =A0 =A0 .list_voltage =3D mc13892_regulator_list_voltage,
+ =A0 =A0 =A0 .set_voltage =3D mc13892_fixed_regulator_set_voltage,
+ =A0 =A0 =A0 .get_voltage =3D mc13892_fixed_regulator_get_voltage,
+};
+
+int mc13892_powermisc_rmw(struct mc13892_regulator_priv *priv, u32 mask,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 val=
)
+{
+ =A0 =A0 =A0 struct mc13xxx *mc13892 =3D priv->mc13892;
+ =A0 =A0 =A0 int ret;
+ =A0 =A0 =A0 u32 valread;
+
+ =A0 =A0 =A0 BUG_ON(val & ~mask);
+
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(mc13892, MC13892_POWERMISC, &valread=
);
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
+
+ =A0 =A0 =A0 /* Update the stored state for Power Gates. */
+ =A0 =A0 =A0 priv->powermisc_pwgt_state =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (priv->powerm=
isc_pwgt_state & ~mask) | val;
+ =A0 =A0 =A0 priv->powermisc_pwgt_state &=3D MC13892_POWERMISC_PWGTSPI_M;
+
+ =A0 =A0 =A0 /* Construct the new register value */
+ =A0 =A0 =A0 valread =3D (valread & ~mask) | val;
+ =A0 =A0 =A0 /* Overwrite the PWGTxEN with the stored version */
+ =A0 =A0 =A0 valread =3D (valread & ~MC13892_POWERMISC_PWGTSPI_M) |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 priv->powermisc_pwgt_state;
+
+ =A0 =A0 =A0 return mc13892_reg_write(mc13892, MC13892_POWERMISC, valread)=
;
+}
+
+static int mc13892_gpo_regulator_enable(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 int ret;
+ =A0 =A0 =A0 u32 en_val =3D mc13892_regulators[id].enable_bit;
+ =A0 =A0 =A0 u32 mask =3D mc13892_regulators[id].enable_bit;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+ =A0 =A0 =A0 /* Power Gate enable value is 0 */
+ =A0 =A0 =A0 if (id =3D=3D MC13892_PWGT1SPI ||
+ =A0 =A0 =A0 =A0 =A0 id =3D=3D MC13892_PWGT2SPI)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 en_val =3D 0;
+
+ =A0 =A0 =A0 if (id =3D=3D MC13892_GPO4)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mask |=3D MC13892_POWERMISC_GPO4ADINEN;
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_powermisc_rmw(priv, mask, en_val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 return ret;
+}
+
+static int mc13892_gpo_regulator_disable(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 int ret;
+ =A0 =A0 =A0 u32 dis_val =3D 0;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+ =A0 =A0 =A0 /* Power Gate disable value is 1 */
+ =A0 =A0 =A0 if (id =3D=3D MC13892_PWGT1SPI ||
+ =A0 =A0 =A0 =A0 =A0 id =3D=3D MC13892_PWGT2SPI)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dis_val =3D mc13892_regulators[id].enable_bit=
;
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_powermisc_rmw(priv, mc13892_regulators[id].en=
able_bit,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 dis_val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 return ret;
+}
+
+static int mc13892_gpo_regulator_is_enabled(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int ret, id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 unsigned int val;
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(priv->mc13892, mc13892_regulators[id=
].reg, &val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
+
+ =A0 =A0 =A0 /* Power Gates state is stored in powermisc_pwgt_state
+ =A0 =A0 =A0 =A0* where the meaning of bits is negated */
+ =A0 =A0 =A0 val =3D (val & ~MC13892_POWERMISC_PWGTSPI_M) |
+ =A0 =A0 =A0 =A0 =A0 =A0 (priv->powermisc_pwgt_state ^ MC13892_POWERMISC_P=
WGTSPI_M);
+
+ =A0 =A0 =A0 return (val & mc13892_regulators[id].enable_bit) !=3D 0;
+}
+
+
+static struct regulator_ops mc13892_gpo_regulator_ops =3D {
+ =A0 =A0 =A0 .enable =3D mc13892_gpo_regulator_enable,
+ =A0 =A0 =A0 .disable =3D mc13892_gpo_regulator_disable,
+ =A0 =A0 =A0 .is_enabled =3D mc13892_gpo_regulator_is_enabled,
+ =A0 =A0 =A0 .list_voltage =3D mc13892_regulator_list_voltage,
+ =A0 =A0 =A0 .set_voltage =3D mc13892_fixed_regulator_set_voltage,
+ =A0 =A0 =A0 .get_voltage =3D mc13892_fixed_regulator_get_voltage,
+};
+
+static int mc13892_vcam_set_mode(struct regulator_dev *rdev, unsigned int =
mode)
+{
+ =A0 =A0 =A0 unsigned int en_val =3D 0;
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int ret, id =3D rdev_get_id(rdev);
+
+ =A0 =A0 =A0 if (mode =3D=3D REGULATOR_MODE_FAST)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 en_val =3D MC13892_REGULATORMODE1_VCAMCONFIGE=
N;
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_rmw(priv->mc13892, mc13892_regulators[id]=
.reg,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_REGULATORMODE1_VCAMCO=
NFIGEN,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 en_val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 return ret;
+}
+
+unsigned int mc13892_vcam_get_mode(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int ret, id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 unsigned int val;
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(priv->mc13892, mc13892_regulators[id=
].reg, &val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
+
+ =A0 =A0 =A0 if (val & MC13892_REGULATORMODE1_VCAMCONFIGEN)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return REGULATOR_MODE_FAST;
+
+ =A0 =A0 =A0 return REGULATOR_MODE_NORMAL;
+}
+
+static int mc13892_sw_regulator(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 return 0;
+}
+
+static int mc13892_sw_regulator_is_enabled(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 return 1;
+}
+
+static int mc13892_sw_regulator_get_voltage(struct regulator_dev *rdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int ret, id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 unsigned int val, hi;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(priv->mc13892,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regul=
ators[id].vsel_reg, &val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
+
+ =A0 =A0 =A0 hi =A0=3D val & MC13892_SWITCHERS0_SWxHI;
+ =A0 =A0 =A0 val =3D (val & mc13892_regulators[id].vsel_mask)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> mc13892_regulators[id].vsel_shift;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d val: %d\n", __func__, =
id, val);
+
+ =A0 =A0 =A0 if (hi)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (25000 * val) + 1100000;
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (25000 * val) + 600000;
+
+ =A0 =A0 =A0 return val;
+}
+
+static int mc13892_sw_regulator_set_voltage(struct regulator_dev *rdev,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 int min_uV, int max_uV)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D rdev_get_drvdata(rdev=
);
+ =A0 =A0 =A0 int hi, value, val, mask, id =3D rdev_get_id(rdev);
+ =A0 =A0 =A0 int ret;
+
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\=
n",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, id, min_uV, max_uV);
+
+ =A0 =A0 =A0 /* Find the best index */
+ =A0 =A0 =A0 value =3D mc13892_get_best_voltage_index(rdev, min_uV, max_uV=
);
+ =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "%s best value: %d\n", __func__, =
value);
+ =A0 =A0 =A0 if (value < 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value;
+
+ =A0 =A0 =A0 value =3D mc13892_regulators[id].voltages[value];
+
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(priv->mc13892,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regul=
ators[id].vsel_reg, &val);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
+
+ =A0 =A0 =A0 hi =A0=3D val & MC13892_SWITCHERS0_SWxHI;
+ =A0 =A0 =A0 if (value > 1375)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 hi =3D 1;
+ =A0 =A0 =A0 if (value < 1100)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 hi =3D 0;
+
+ =A0 =A0 =A0 if (hi) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D (value - 1100000) / 25000;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 value |=3D MC13892_SWITCHERS0_SWxHI;
+ =A0 =A0 =A0 } else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D (value - 600000) / 25000;
+
+ =A0 =A0 =A0 mask =3D mc13892_regulators[id].vsel_mask | MC13892_SWITCHERS=
0_SWxHI;
+ =A0 =A0 =A0 mc13xxx_lock(priv->mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_rmw(priv->mc13892, mc13892_regulators[id]=
.vsel_reg,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mask,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value << mc13892_regulators[i=
d].vsel_shift);
+ =A0 =A0 =A0 mc13xxx_unlock(priv->mc13892);
+
+ =A0 =A0 =A0 return ret;
+}
+
+static struct regulator_ops mc13892_sw_regulator_ops =3D {
+ =A0 =A0 =A0 .enable =3D mc13892_sw_regulator,
+ =A0 =A0 =A0 .disable =3D mc13892_sw_regulator,
+ =A0 =A0 =A0 .is_enabled =3D mc13892_sw_regulator_is_enabled,
+ =A0 =A0 =A0 .list_voltage =3D mc13892_regulator_list_voltage,
+ =A0 =A0 =A0 .set_voltage =3D mc13892_sw_regulator_set_voltage,
+ =A0 =A0 =A0 .get_voltage =3D mc13892_sw_regulator_get_voltage,
+};
+
+
+static int __devinit mc13892_regulator_probe(struct platform_device *pdev)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv;
+ =A0 =A0 =A0 struct mc13xxx *mc13892 =3D dev_get_drvdata(pdev->dev.parent)=
;
+ =A0 =A0 =A0 struct mc13xxx_regulator_platform_data *pdata =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_get_platdata(&pdev->dev);
+ =A0 =A0 =A0 struct mc13xxx_regulator_init_data *init_data;
+ =A0 =A0 =A0 int i, ret;
+ =A0 =A0 =A0 u32 val;
+
+ =A0 =A0 =A0 priv =3D kzalloc(sizeof(*priv) +
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_regulators * sizeo=
f(priv->regulators[0]),
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
+ =A0 =A0 =A0 if (!priv)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
+
+ =A0 =A0 =A0 priv->mc13892 =3D mc13892;
+
+ =A0 =A0 =A0 mc13xxx_lock(mc13892);
+ =A0 =A0 =A0 ret =3D mc13892_reg_read(mc13892, MC13892_REVISION, &val);
+ =A0 =A0 =A0 mc13xxx_unlock(mc13892);
+ =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
+
+ =A0 =A0 =A0 /* enable switch auto mode - ENGR00120510, ENGR00121057 */
+ =A0 =A0 =A0 /* no doc with regs description means no way to know if */
+ =A0 =A0 =A0 /* there's a better way to do it =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0*/
+ =A0 =A0 =A0 if ((val & 0x0000FFFF) =3D=3D 0x45d0) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13xxx_lock(mc13892);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mc13892_reg_rmw(mc13892, MC13892_SWIT=
CHERS4,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS4_SW1MODE_M =
|
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS4_SW2MODE_M,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS4_SW1MODE_AU=
TO |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS4_SW2MODE_AU=
TO);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13xxx_unlock(mc13892);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13xxx_lock(mc13892);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_reg_rmw(mc13892, MC13892_SWITCHERS5,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS5_SW3MODE_M =
|
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS5_SW4MODE_M,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS5_SW3MODE_AU=
TO |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MC13892_SWITCHERS5_SW4MODE_AU=
TO);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13xxx_unlock(mc13892);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 mc13892_regulators[MC13892_VCAM].desc.ops->set_mode
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mc13892_vcam_set_mode;
+ =A0 =A0 =A0 mc13892_regulators[MC13892_VCAM].desc.ops->get_mode
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mc13892_vcam_get_mode;
+ =A0 =A0 =A0 for (i =3D 0; i < pdata->num_regulators; i++) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_data =3D &pdata->regulators[i];
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->regulators[i] =3D regulator_register(
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &mc13892_regu=
lators[init_data->id].desc,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pdev->dev, i=
nit_data->init_data, priv);
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(priv->regulators[i])) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed t=
o register regulator %s\n",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mc13892_regul=
ators[i].desc.name);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(priv->regulat=
ors[i]);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 platform_set_drvdata(pdev, priv);
+
+ =A0 =A0 =A0 return 0;
+err:
+ =A0 =A0 =A0 while (--i >=3D 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_unregister(priv->regulators[i]);
+
+err_alloc:
+ =A0 =A0 =A0 kfree(priv);
+
+ =A0 =A0 =A0 return ret;
+}
+
+static int __devexit mc13892_regulator_remove(struct platform_device *pdev=
)
+{
+ =A0 =A0 =A0 struct mc13892_regulator_priv *priv =3D platform_get_drvdata(=
pdev);
+ =A0 =A0 =A0 struct mc13xxx_regulator_platform_data *pdata =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_get_platdata(&pdev->dev);
+ =A0 =A0 =A0 int i;
+
+ =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
+
+ =A0 =A0 =A0 for (i =3D 0; i < pdata->num_regulators; i++)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_unregister(priv->regulators[i]);
+
+ =A0 =A0 =A0 kfree(priv);
+ =A0 =A0 =A0 return 0;
+}
+
+static struct platform_driver mc13892_regulator_driver =3D {
+ =A0 =A0 =A0 .driver =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "mc13892-regulator",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(mc13892_regulator_rem=
ove),
+ =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mc13892_regulator_probe,
+};
+
+static int __init mc13892_regulator_init(void)
+{
+ =A0 =A0 =A0 return platform_driver_register(&mc13892_regulator_driver);
+}
+subsys_initcall(mc13892_regulator_init);
+
+static void __exit mc13892_regulator_exit(void)
+{
+ =A0 =A0 =A0 platform_driver_unregister(&mc13892_regulator_driver);
+}
+module_exit(mc13892_regulator_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>, "
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Yong Shen <yong.shen@linaro.org>");
+MODULE_DESCRIPTION("Regulator Driver for Freescale MC13892 PMIC");
+MODULE_ALIAS("platform:mc13892-regulator");
diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.h
index b4c741e..7d0f3d6 100644
--- a/include/linux/mfd/mc13783.h
+++ b/include/linux/mfd/mc13783.h
@@ -1,4 +1,5 @@
=A0/*
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
=A0* Copyright 2009-2010 Pengutronix
=A0* Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
=A0*
@@ -122,39 +123,39 @@ int mc13783_adc_do_conversion(struct mc13783
*mc13783, unsigned int mode,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int channel, unsigned int *sample);


-#define =A0 =A0 =A0 =A0MC13783_SW_SW1A =A0 =A0 =A0 =A0 0
-#define =A0 =A0 =A0 =A0MC13783_SW_SW1B =A0 =A0 =A0 =A0 1
-#define =A0 =A0 =A0 =A0MC13783_SW_SW2A =A0 =A0 =A0 =A0 2
-#define =A0 =A0 =A0 =A0MC13783_SW_SW2B =A0 =A0 =A0 =A0 3
-#define =A0 =A0 =A0 =A0MC13783_SW_SW3 =A0 =A0 =A0 =A0 =A04
-#define =A0 =A0 =A0 =A0MC13783_SW_PLL =A0 =A0 =A0 =A0 =A05
-#define =A0 =A0 =A0 =A0MC13783_REGU_VAUDIO =A0 =A0 6
-#define =A0 =A0 =A0 =A0MC13783_REGU_VIOHI =A0 =A0 =A07
-#define =A0 =A0 =A0 =A0MC13783_REGU_VIOLO =A0 =A0 =A08
-#define =A0 =A0 =A0 =A0MC13783_REGU_VDIG =A0 =A0 =A0 9
-#define =A0 =A0 =A0 =A0MC13783_REGU_VGEN =A0 =A0 =A0 10
-#define =A0 =A0 =A0 =A0MC13783_REGU_VRFDIG =A0 =A0 11
-#define =A0 =A0 =A0 =A0MC13783_REGU_VRFREF =A0 =A0 12
-#define =A0 =A0 =A0 =A0MC13783_REGU_VRFCP =A0 =A0 =A013
-#define =A0 =A0 =A0 =A0MC13783_REGU_VSIM =A0 =A0 =A0 14
-#define =A0 =A0 =A0 =A0MC13783_REGU_VESIM =A0 =A0 =A015
-#define =A0 =A0 =A0 =A0MC13783_REGU_VCAM =A0 =A0 =A0 16
-#define =A0 =A0 =A0 =A0MC13783_REGU_VRFBG =A0 =A0 =A017
-#define =A0 =A0 =A0 =A0MC13783_REGU_VVIB =A0 =A0 =A0 18
-#define =A0 =A0 =A0 =A0MC13783_REGU_VRF1 =A0 =A0 =A0 19
-#define =A0 =A0 =A0 =A0MC13783_REGU_VRF2 =A0 =A0 =A0 20
-#define =A0 =A0 =A0 =A0MC13783_REGU_VMMC1 =A0 =A0 =A021
-#define =A0 =A0 =A0 =A0MC13783_REGU_VMMC2 =A0 =A0 =A022
-#define =A0 =A0 =A0 =A0MC13783_REGU_GPO1 =A0 =A0 =A0 23
-#define =A0 =A0 =A0 =A0MC13783_REGU_GPO2 =A0 =A0 =A0 24
-#define =A0 =A0 =A0 =A0MC13783_REGU_GPO3 =A0 =A0 =A0 25
-#define =A0 =A0 =A0 =A0MC13783_REGU_GPO4 =A0 =A0 =A0 26
-#define =A0 =A0 =A0 =A0MC13783_REGU_V1 =A0 =A0 =A0 =A0 27
-#define =A0 =A0 =A0 =A0MC13783_REGU_V2 =A0 =A0 =A0 =A0 28
-#define =A0 =A0 =A0 =A0MC13783_REGU_V3 =A0 =A0 =A0 =A0 29
-#define =A0 =A0 =A0 =A0MC13783_REGU_V4 =A0 =A0 =A0 =A0 30
-#define =A0 =A0 =A0 =A0MC13783_REGU_PWGT1SPI =A0 31
-#define =A0 =A0 =A0 =A0MC13783_REGU_PWGT2SPI =A0 32
+#define =A0 =A0 =A0 =A0MC13783_REG_SW1A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
+#define =A0 =A0 =A0 =A0MC13783_REG_SW1B =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
+#define =A0 =A0 =A0 =A0MC13783_REG_SW2A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
+#define =A0 =A0 =A0 =A0MC13783_REG_SW2B =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
+#define =A0 =A0 =A0 =A0MC13783_REG_SW3 =A0 =A0 =A0 =A0 4
+#define =A0 =A0 =A0 =A0MC13783_REG_PLL =A0 =A0 =A0 =A0 5
+#define =A0 =A0 =A0 =A0MC13783_REG_VAUDIO =A0 =A0 =A06
+#define =A0 =A0 =A0 =A0MC13783_REG_VIOHI =A0 =A0 =A0 7
+#define =A0 =A0 =A0 =A0MC13783_REG_VIOLO =A0 =A0 =A0 8
+#define =A0 =A0 =A0 =A0MC13783_REG_VDIG =A0 =A0 =A0 =A09
+#define =A0 =A0 =A0 =A0MC13783_REG_VGEN =A0 =A0 =A0 =A010
+#define =A0 =A0 =A0 =A0MC13783_REG_VRFDIG =A0 =A0 =A011
+#define =A0 =A0 =A0 =A0MC13783_REG_VRFREF =A0 =A0 =A012
+#define =A0 =A0 =A0 =A0MC13783_REG_VRFCP =A0 =A0 =A0 13
+#define =A0 =A0 =A0 =A0MC13783_REG_VSIM =A0 =A0 =A0 =A014
+#define =A0 =A0 =A0 =A0MC13783_REG_VESIM =A0 =A0 =A0 15
+#define =A0 =A0 =A0 =A0MC13783_REG_VCAM =A0 =A0 =A0 =A016
+#define =A0 =A0 =A0 =A0MC13783_REG_VRFBG =A0 =A0 =A0 17
+#define =A0 =A0 =A0 =A0MC13783_REG_VVIB =A0 =A0 =A0 =A018
+#define =A0 =A0 =A0 =A0MC13783_REG_VRF1 =A0 =A0 =A0 =A019
+#define =A0 =A0 =A0 =A0MC13783_REG_VRF2 =A0 =A0 =A0 =A020
+#define =A0 =A0 =A0 =A0MC13783_REG_VMMC1 =A0 =A0 =A0 21
+#define =A0 =A0 =A0 =A0MC13783_REG_VMMC2 =A0 =A0 =A0 22
+#define =A0 =A0 =A0 =A0MC13783_REG_GPO1 =A0 =A0 =A0 =A023
+#define =A0 =A0 =A0 =A0MC13783_REG_GPO2 =A0 =A0 =A0 =A024
+#define =A0 =A0 =A0 =A0MC13783_REG_GPO3 =A0 =A0 =A0 =A025
+#define =A0 =A0 =A0 =A0MC13783_REG_GPO4 =A0 =A0 =A0 =A026
+#define =A0 =A0 =A0 =A0MC13783_REG_V1 =A0 =A0 =A0 =A0 =A027
+#define =A0 =A0 =A0 =A0MC13783_REG_V2 =A0 =A0 =A0 =A0 =A028
+#define =A0 =A0 =A0 =A0MC13783_REG_V3 =A0 =A0 =A0 =A0 =A029
+#define =A0 =A0 =A0 =A0MC13783_REG_V4 =A0 =A0 =A0 =A0 =A030
+#define =A0 =A0 =A0 =A0MC13783_REG_PWGT1SPI =A0 =A031
+#define =A0 =A0 =A0 =A0MC13783_REG_PWGT2SPI =A0 =A032

=A0#define MC13783_IRQ_ADCDONE =A0 =A0MC13XXX_IRQ_ADCDONE
=A0#define MC13783_IRQ_ADCBISDONE MC13XXX_IRQ_ADCBISDONE
diff --git a/include/linux/mfd/mc13892.h b/include/linux/mfd/mc13892.h
new file mode 100644
index 0000000..7df13e8
--- /dev/null
+++ b/include/linux/mfd/mc13892.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
modify it under
+ * the terms of the GNU General Public License version 2 as published by t=
he
+ * Free Software Foundation.
+ */
+
+#ifndef __LINUX_MFD_MC13892_H
+#define __LINUX_MFD_MC13892_H
+#include <linux/mfd/mc13xxx.h>
+
+#define MC13892_SW1 =A0 =A0 =A0 =A0 =A0 =A00
+#define MC13892_SW2 =A0 =A0 =A0 =A0 =A0 =A01
+#define MC13892_SW3 =A0 =A0 =A0 =A0 =A0 =A02
+#define MC13892_SW4 =A0 =A0 =A0 =A0 =A0 =A03
+#define MC13892_SWBST =A04
+#define MC13892_VIOHI =A05
+#define MC13892_VPLL =A0 6
+#define MC13892_VDIG =A0 7
+#define MC13892_VSD =A0 =A08
+#define MC13892_VUSB2 =A09
+#define MC13892_VVIDEO 10
+#define MC13892_VAUDIO 11
+#define MC13892_VCAM =A0 12
+#define MC13892_VGEN1 =A013
+#define MC13892_VGEN2 =A014
+#define MC13892_VGEN3 =A015
+#define MC13892_VUSB =A0 16
+#define MC13892_GPO1 =A0 17
+#define MC13892_GPO2 =A0 18
+#define MC13892_GPO3 =A0 19
+#define MC13892_GPO4 =A0 20
+#define MC13892_PWGT1SPI =A0 =A0 =A0 21
+#define MC13892_PWGT2SPI =A0 =A0 =A0 22
+#define MC13892_VCOINCELL =A0 =A0 =A023
+
+#endif
diff --git a/include/linux/regulator/mc13xxx.h
b/include/linux/regulator/mc13xxx.h
new file mode 100644
index 0000000..cb9501e
--- /dev/null
+++ b/include/linux/regulator/mc13xxx.h
@@ -0,0 +1,81 @@
+/*
+ * mc13xxx.h - regulators for the Freescale mc13xxx PMIC
+ *
+ * =A0Copyright (C) 2010 Yong Shen <yong.shen@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_REGULATOR_MC13XXX_H
+#define __LINUX_REGULATOR_MC13XXX_H
+
+#include <linux/regulator/driver.h>
+
+struct mc13xxx_regulator {
+ =A0 =A0 =A0 struct regulator_desc desc;
+ =A0 =A0 =A0 int reg;
+ =A0 =A0 =A0 int enable_bit;
+ =A0 =A0 =A0 int vsel_reg;
+ =A0 =A0 =A0 int vsel_shift;
+ =A0 =A0 =A0 int vsel_mask;
+ =A0 =A0 =A0 int hi_bit;
+ =A0 =A0 =A0 int const *voltages;
+};
+
+#define MC13xxx_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages,
_ops) =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 [prefix ## _name] =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D #prefix "_" #_name,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .n_voltages =3D ARRAY_SIZE(_v=
oltages), =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =3D &_ops, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D REGULATOR_VOLTAGE, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =3D prefix ## _name, =A0 =
=A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg =3D prefix ## _reg, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable_bit =3D prefix ## _reg ## _ ## _name =
## EN, =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsel_reg =3D prefix ## _vsel_reg, =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsel_shift =3D prefix ## _vsel_reg ## _ ## _=
name ## VSEL,\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsel_mask =3D prefix ## _vsel_reg ## _ ## _n=
ame ## VSEL_M,\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltages =3D =A0_voltages, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 }
+
+#define MC13xxx_FIXED_DEFINE(prefix, _name, _reg, _voltages, _ops) =A0 =A0=
 \
+ =A0 =A0 =A0 [prefix ## _name] =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D #prefix "_" #_name,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .n_voltages =3D ARRAY_SIZE(_v=
oltages), =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =3D &_ops, =A0 =A0 =A0 =
=A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D REGULATOR_VOLTAGE, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =3D prefix ## _name, =A0 =
=A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg =3D prefix ## _reg, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable_bit =3D prefix ## _reg ## _ ## _name =
## EN, =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltages =3D =A0_voltages, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 }
+
+#define MC13xxx_GPO_DEFINE(prefix, _name, _reg, =A0_voltages, _ops) =A0 =
=A0 =A0\
+ =A0 =A0 =A0 [prefix ## _name] =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D #prefix "_" #_name,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .n_voltages =3D ARRAY_SIZE(_v=
oltages), =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =3D &_ops, =A0 =A0 =A0 =
=A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D REGULATOR_VOLTAGE, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =3D prefix ## _name, =A0 =
=A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg =3D prefix ## _reg, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable_bit =3D prefix ## _reg ## _ ## _name =
## EN, =A0 =A0 =A0 \
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .voltages =3D =A0_voltages, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
+ =A0 =A0 =A0 }
+
+#define MC13xxx_DEFINE_SW(_name, _reg, _vsel_reg, _voltages, ops) =A0 =A0 =
=A0\
+ =A0 =A0 =A0 MC13xxx_DEFINE(SW, _name, _reg, _vsel_reg, _voltages, ops)
+#define MC13xxx_DEFINE_REGU(_name, _reg, _vsel_reg, _voltages, ops) =A0 =
=A0\
+ =A0 =A0 =A0 MC13xxx_DEFINE(REGU, _name, _reg, _vsel_reg, _voltages, ops)
+
+#endif
--
1.7.0.4

--000e0cd47e5cd50c070495ddbba0
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-mc13892-regulator-enable-on-mx51-babbage-board.patch"
Content-Disposition: attachment; 
	filename="0001-mc13892-regulator-enable-on-mx51-babbage-board.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggxh408t0

RnJvbSBhZGQyYzcxM2RiM2E0NDA4MmVhMzFhNjdiNjZmYWEwYjE1MjE3YTNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nIFNoZW4gPHlvbmcuc2hlbkBsaW5hcm8ub3JnPgpEYXRl
OiBUaHUsIDI1IE5vdiAyMDEwIDE2OjIxOjM1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbWMxMzg5
MiByZWd1bGF0b3IgZW5hYmxlIG9uIG14NTEgYmFiYmFnZSBib2FyZAoKQWNjb3JkaW5nIHRvIHN1
Z2dlc3Rpb25zIG9mIFNhc2NoYSBIYXVlciBhbmQgQXJuYXVkIFBhdGFyZCwgc29tZSBtYWNybwpk
ZWZpbml0aW9ucyBhcmUgbW92ZWQgdG8gYSBzZXBlcmF0ZWQgaGVhZCBmaWxlIHRvIGJlbmlmaXQg
Ym90aCBtYzEzODkyCmFuZCBtYzEzNzkzLgoKU2lnbmVkLW9mZi1ieTogWW9uZyBTaGVuIDx5b25n
LnNoZW5AbGluYXJvLm9yZz4KLS0tCiBhcmNoL2FybS9tYWNoLW14NS9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgICAgfCAgICAyICstCiBhcmNoL2FybS9tYWNoLW14NS9iYWJiYWdlX3JlZ3VsYXRv
cl9tYzEzODkyLmMgfCAgMzcxICsrKysrKysrKysrCiBhcmNoL2FybS9tYWNoLW14NS9ib2FyZC1t
eDUxX2JhYmJhZ2UuYyAgICAgICAgfCAgICAzICsKIGRyaXZlcnMvcmVndWxhdG9yL0tjb25maWcg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDcgKwogZHJpdmVycy9yZWd1bGF0b3IvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICAgIHwgICAgMSArCiBkcml2ZXJzL3JlZ3VsYXRvci9tYzEzNzgzLXJl
Z3VsYXRvci5jICAgICAgICAgfCAgIDYyICstLQogZHJpdmVycy9yZWd1bGF0b3IvbWMxMzg5Mi1y
ZWd1bGF0b3IuYyAgICAgICAgIHwgIDg3NSArKysrKysrKysrKysrKysrKysrKysrKysrCiBpbmNs
dWRlL2xpbnV4L21mZC9tYzEzNzgzLmggICAgICAgICAgICAgICAgICAgfCAgIDY3ICstCiBpbmNs
dWRlL2xpbnV4L21mZC9tYzEzODkyLmggICAgICAgICAgICAgICAgICAgfCAgIDM4ICsrCiBpbmNs
dWRlL2xpbnV4L3JlZ3VsYXRvci9tYzEzeHh4LmggICAgICAgICAgICAgfCAgIDgxICsrKwogMTAg
ZmlsZXMgY2hhbmdlZCwgMTQzMCBpbnNlcnRpb25zKCspLCA3NyBkZWxldGlvbnMoLSkKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLW14NS9iYWJiYWdlX3JlZ3VsYXRvcl9tYzEzODky
LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3JlZ3VsYXRvci9tYzEzODkyLXJlZ3VsYXRv
ci5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvbWMxMzg5Mi5oCiBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbWMxM3h4eC5oCgpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1teDUvTWFrZWZpbGUgYi9hcmNoL2FybS9tYWNoLW14NS9NYWtl
ZmlsZQppbmRleCAwMjZjZDg1Li4xNTk0YzlmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW14
NS9NYWtlZmlsZQorKysgYi9hcmNoL2FybS9tYWNoLW14NS9NYWtlZmlsZQpAQCAtNiw3ICs2LDcg
QEAKIG9iai15ICAgOj0gY3B1Lm8gbW0ubyBjbG9jay1teDUxLW14NTMubyBkZXZpY2VzLm8KIAog
b2JqLSQoQ09ORklHX0NQVV9GUkVRX0lNWCkgICAgKz0gY3B1X29wLW14NTEubwotb2JqLSQoQ09O
RklHX01BQ0hfTVg1MV9CQUJCQUdFKSArPSBib2FyZC1teDUxX2JhYmJhZ2Uubworb2JqLSQoQ09O
RklHX01BQ0hfTVg1MV9CQUJCQUdFKSArPSBib2FyZC1teDUxX2JhYmJhZ2UubyBiYWJiYWdlX3Jl
Z3VsYXRvcl9tYzEzODkyLm8KIG9iai0kKENPTkZJR19NQUNIX01YNTFfM0RTKSArPSBib2FyZC1t
eDUxXzNkcy5vCiBvYmotJChDT05GSUdfTUFDSF9FVUtSRUFfQ1BVSU1YNTEpICs9IGJvYXJkLWNw
dWlteDUxLm8KIG9iai0kKENPTkZJR19NQUNIX0VVS1JFQV9NQklNWDUxX0JBU0VCT0FSRCkgKz0g
ZXVrcmVhX21iaW14NTEtYmFzZWJvYXJkLm8KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbXg1
L2JhYmJhZ2VfcmVndWxhdG9yX21jMTM4OTIuYyBiL2FyY2gvYXJtL21hY2gtbXg1L2JhYmJhZ2Vf
cmVndWxhdG9yX21jMTM4OTIuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4x
NDkyM2Q2Ci0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vbWFjaC1teDUvYmFiYmFnZV9yZWd1
bGF0b3JfbWMxMzg5Mi5jCkBAIC0wLDAgKzEsMzcxIEBACisvKgorICogQ29weXJpZ2h0IDIwMTAg
WW9uZyBTaGVuIDx5b25nLnNoZW5AbGluYXJvLm9yZz4KKyAqIENvcHlyaWdodCAoQykgMjAwOS0y
MDEwIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisg
Ki8KKworLyoKKyAqIFRoZSBjb2RlIGNvbnRhaW5lZCBoZXJlaW4gaXMgbGljZW5zZWQgdW5kZXIg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICogTGljZW5zZS4gWW91IG1heSBvYnRhaW4gYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogVmVyc2lvbiAyIG9yIGxhdGVy
IGF0IHRoZSBmb2xsb3dpbmcgbG9jYXRpb25zOgorICoKKyAqIGh0dHA6Ly93d3cub3BlbnNvdXJj
ZS5vcmcvbGljZW5zZXMvZ3BsLWxpY2Vuc2UuaHRtbAorICogaHR0cDovL3d3dy5nbnUub3JnL2Nv
cHlsZWZ0L2dwbC5odG1sCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1
ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNp
bmNsdWRlIDxsaW51eC9zcGkvc3BpLmg+CisjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5jbHVk
ZSA8bGludXgvcmVndWxhdG9yL21hY2hpbmUuaD4KKyNpbmNsdWRlIDxsaW51eC9tZmQvbWMxM3h4
eC5oPgorI2luY2x1ZGUgPGxpbnV4L21mZC9tYzEzODkyLmg+CisjaW5jbHVkZSA8bWFjaC9ncGlv
Lmg+CisKKyNkZWZpbmUgQkFCQkFHRV9QTUlDCQkoMiozMiArIDgpCisKK3N0YXRpYyBzdHJ1Y3Qg
cmVndWxhdG9yX2NvbnN1bWVyX3N1cHBseSBzdzFfY29uc3VtZXJzW10gPSB7CisJeworCQkuc3Vw
cGx5ID0gImNwdV92Y2MiLAorCX0KK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2NvbnN1
bWVyX3N1cHBseSB2ZGlnX2NvbnN1bWVyc1tdID0geworCS8qIHNndGw1MDAwICovCisJUkVHVUxB
VE9SX1NVUFBMWSgiVkREQSIsICIxLTAwMGEiKSwKKwlSRUdVTEFUT1JfU1VQUExZKCJWREREIiwg
IjEtMDAwYSIpLAorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3JfY29uc3VtZXJfc3VwcGx5
IHZ2aWRlb19jb25zdW1lcnNbXSA9IHsKKwkvKiBzZ3RsNTAwMCAqLworCVJFR1VMQVRPUl9TVVBQ
TFkoIlZERElPIiwgIjEtMDAwYSIpLAorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3JfY29u
c3VtZXJfc3VwcGx5IHZzZF9jb25zdW1lcnNbXSA9IHsKKwlSRUdVTEFUT1JfU1VQUExZKCJ2bW1j
IiwgInNkaGNpLWVzZGhjLWlteC4wIiksCisJUkVHVUxBVE9SX1NVUFBMWSgidm1tYyIsICJzZGhj
aS1lc2RoYy1pbXguMSIpLAorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3JfY29uc3VtZXJf
c3VwcGx5IHB3Z3QxX2NvbnN1bWVyW10gPSB7CisJeworCQkuc3VwcGx5ID0gInB3Z3QxIiwKKwl9
Cit9OworCitzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9jb25zdW1lcl9zdXBwbHkgcHdndDJfY29u
c3VtZXJbXSA9IHsKKwl7CisJCS5zdXBwbHkgPSAicHdndDIiLAorCX0KK307CisKK3N0YXRpYyBz
dHJ1Y3QgcmVndWxhdG9yX2NvbnN1bWVyX3N1cHBseSBjb2luY2VsbF9jb25zdW1lcltdID0gewor
CXsKKwkJLnN1cHBseSA9ICJjb2luY2VsbCIsCisJfQorfTsKKworc3RhdGljIHN0cnVjdCByZWd1
bGF0b3JfaW5pdF9kYXRhIHN3MV9pbml0ID0geworCS5jb25zdHJhaW50cyA9IHsKKwkJLm5hbWUg
PSAiU1cxIiwKKwkJLm1pbl91ViA9IDYwMDAwMCwKKwkJLm1heF91ViA9IDEzNzUwMDAsCisJCS52
YWxpZF9vcHNfbWFzayA9IFJFR1VMQVRPUl9DSEFOR0VfVk9MVEFHRSwKKwkJLnZhbGlkX21vZGVz
X21hc2sgPSAwLAorCQkuYWx3YXlzX29uID0gMSwKKwkJLmJvb3Rfb24gPSAxLAorCQkuc3RhdGVf
bWVtID0geworCQkJLnVWID0gODUwMDAwLAorCQkJLm1vZGUgPSBSRUdVTEFUT1JfTU9ERV9OT1JN
QUwsCisJCQkuZW5hYmxlZCA9IDEsCisJCX0sCisJfSwKKwkubnVtX2NvbnN1bWVyX3N1cHBsaWVz
ID0gQVJSQVlfU0laRShzdzFfY29uc3VtZXJzKSwKKwkuY29uc3VtZXJfc3VwcGxpZXMgPSBzdzFf
Y29uc3VtZXJzLAorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3JfaW5pdF9kYXRhIHN3Ml9p
bml0ID0geworCS5jb25zdHJhaW50cyA9IHsKKwkJLm5hbWUgPSAiU1cyIiwKKwkJLm1pbl91ViA9
IDkwMDAwMCwKKwkJLm1heF91ViA9IDE4NTAwMDAsCisJCS52YWxpZF9vcHNfbWFzayA9IFJFR1VM
QVRPUl9DSEFOR0VfVk9MVEFHRSwKKwkJLmFsd2F5c19vbiA9IDEsCisJCS5ib290X29uID0gMSwK
KwkJLnN0YXRlX21lbSA9IHsKKwkJCS51ViA9IDk1MDAwMCwKKwkJCS5tb2RlID0gUkVHVUxBVE9S
X01PREVfTk9STUFMLAorCQkJLmVuYWJsZWQgPSAxLAorCQl9LAorCX0KK307CisKK3N0YXRpYyBz
dHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0YSBzdzNfaW5pdCA9IHsKKwkuY29uc3RyYWludHMgPSB7
CisJCS5uYW1lID0gIlNXMyIsCisJCS5taW5fdVYgPSAxMTAwMDAwLAorCQkubWF4X3VWID0gMTg1
MDAwMCwKKwkJLnZhbGlkX29wc19tYXNrID0gUkVHVUxBVE9SX0NIQU5HRV9WT0xUQUdFLAorCQku
YWx3YXlzX29uID0gMSwKKwkJLmJvb3Rfb24gPSAxLAorCX0KK307CisKK3N0YXRpYyBzdHJ1Y3Qg
cmVndWxhdG9yX2luaXRfZGF0YSBzdzRfaW5pdCA9IHsKKwkuY29uc3RyYWludHMgPSB7CisJCS5u
YW1lID0gIlNXNCIsCisJCS5taW5fdVYgPSAxMTAwMDAwLAorCQkubWF4X3VWID0gMTg1MDAwMCwK
KwkJLnZhbGlkX29wc19tYXNrID0gUkVHVUxBVE9SX0NIQU5HRV9WT0xUQUdFLAorCQkuYWx3YXlz
X29uID0gMSwKKwkJLmJvb3Rfb24gPSAxLAorCX0KK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVndWxh
dG9yX2luaXRfZGF0YSB2aW9oaV9pbml0ID0geworCS5jb25zdHJhaW50cyA9IHsKKwkJLm5hbWUg
PSAiVklPSEkiLAorCQkuYm9vdF9vbiA9IDEsCisJCS5hbHdheXNfb24gPSAxLAorCX0KK307CisK
K3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0YSB2dXNiX2luaXQgPSB7CisJLmNvbnN0
cmFpbnRzID0geworCQkubmFtZSA9ICJWVVNCIiwKKwkJLmJvb3Rfb24gPSAxLAorCQkuYWx3YXlz
X29uID0gMSwKKwl9Cit9OworCitzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgc3di
c3RfaW5pdCA9IHsKKwkuY29uc3RyYWludHMgPSB7CisJCS5uYW1lID0gIlNXQlNUIiwKKwl9Cit9
OworCitzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgdmRpZ19pbml0ID0geworCS5j
b25zdHJhaW50cyA9IHsKKwkJLm5hbWUgPSAiVkRJRyIsCisJCS5taW5fdVYgPSAxMDUwMDAwLAor
CQkubWF4X3VWID0gMTgwMDAwMCwKKwkJLnZhbGlkX29wc19tYXNrID0KKwkJCVJFR1VMQVRPUl9D
SEFOR0VfVk9MVEFHRSB8IFJFR1VMQVRPUl9DSEFOR0VfU1RBVFVTLAorCQkuYm9vdF9vbiA9IDEs
CisJCS5hbHdheXNfb24gPSAxLAorCX0sCisJLm51bV9jb25zdW1lcl9zdXBwbGllcyA9IEFSUkFZ
X1NJWkUodmRpZ19jb25zdW1lcnMpLAorCS5jb25zdW1lcl9zdXBwbGllcyA9IHZkaWdfY29uc3Vt
ZXJzLAorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3JfaW5pdF9kYXRhIHZwbGxfaW5pdCA9
IHsKKwkuY29uc3RyYWludHMgPSB7CisJCS5uYW1lID0gIlZQTEwiLAorCQkubWluX3VWID0gMTA1
MDAwMCwKKwkJLm1heF91ViA9IDE4MDAwMDAsCisJCS52YWxpZF9vcHNfbWFzayA9CisJCQlSRUdV
TEFUT1JfQ0hBTkdFX1ZPTFRBR0UgfCBSRUdVTEFUT1JfQ0hBTkdFX1NUQVRVUywKKwkJLmJvb3Rf
b24gPSAxLAorCQkuYWx3YXlzX29uID0gMSwKKwl9Cit9OworCitzdGF0aWMgc3RydWN0IHJlZ3Vs
YXRvcl9pbml0X2RhdGEgdnVzYjJfaW5pdCA9IHsKKwkuY29uc3RyYWludHMgPSB7CisJCS5uYW1l
ID0gIlZVU0IyIiwKKwkJLm1pbl91ViA9IDI0MDAwMDAsCisJCS5tYXhfdVYgPSAyNzc1MDAwLAor
CQkudmFsaWRfb3BzX21hc2sgPSBSRUdVTEFUT1JfQ0hBTkdFX1ZPTFRBR0UsCisJCS5ib290X29u
ID0gMSwKKwkJLmFsd2F5c19vbiA9IDEsCisJfQorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0
b3JfaW5pdF9kYXRhIHZ2aWRlb19pbml0ID0geworCS5jb25zdHJhaW50cyA9IHsKKwkJLm5hbWUg
PSAiVlZJREVPIiwKKwkJLm1pbl91ViA9IDI3NzUwMDAsCisJCS5tYXhfdVYgPSAyNzc1MDAwLAor
CQkudmFsaWRfb3BzX21hc2sgPQorCQkJUkVHVUxBVE9SX0NIQU5HRV9WT0xUQUdFIHwgUkVHVUxB
VE9SX0NIQU5HRV9TVEFUVVMsCisJCS5ib290X29uID0gMSwKKwkJLmFwcGx5X3VWID0gMSwKKwl9
LAorCS5udW1fY29uc3VtZXJfc3VwcGxpZXMgPSBBUlJBWV9TSVpFKHZ2aWRlb19jb25zdW1lcnMp
LAorCS5jb25zdW1lcl9zdXBwbGllcyA9IHZ2aWRlb19jb25zdW1lcnMsCit9OworCitzdGF0aWMg
c3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgdmF1ZGlvX2luaXQgPSB7CisJLmNvbnN0cmFpbnRz
ID0geworCQkubmFtZSA9ICJWQVVESU8iLAorCQkubWluX3VWID0gMjMwMDAwMCwKKwkJLm1heF91
ViA9IDMwMDAwMDAsCisJCS52YWxpZF9vcHNfbWFzayA9CisJCQlSRUdVTEFUT1JfQ0hBTkdFX1ZP
TFRBR0UgfCBSRUdVTEFUT1JfQ0hBTkdFX1NUQVRVUywKKwkJLmJvb3Rfb24gPSAxLAorCX0KK307
CisKK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0YSB2c2RfaW5pdCA9IHsKKwkuY29u
c3RyYWludHMgPSB7CisJCS5uYW1lID0gIlZTRCIsCisJCS5taW5fdVYgPSAxODAwMDAwLAorCQku
bWF4X3VWID0gMzE1MDAwMCwKKwkJLnZhbGlkX29wc19tYXNrID0KKwkJCVJFR1VMQVRPUl9DSEFO
R0VfVk9MVEFHRSwKKwkJLmJvb3Rfb24gPSAxLAorCX0sCisJLm51bV9jb25zdW1lcl9zdXBwbGll
cyA9IEFSUkFZX1NJWkUodnNkX2NvbnN1bWVycyksCisJLmNvbnN1bWVyX3N1cHBsaWVzID0gdnNk
X2NvbnN1bWVycywKK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0YSB2Y2Ft
X2luaXQgPSB7CisJLmNvbnN0cmFpbnRzID0geworCQkubmFtZSA9ICJWQ0FNIiwKKwkJLm1pbl91
ViA9IDI1MDAwMDAsCisJCS5tYXhfdVYgPSAzMDAwMDAwLAorCQkudmFsaWRfb3BzX21hc2sgPQor
CQkJUkVHVUxBVE9SX0NIQU5HRV9WT0xUQUdFIHwKKwkJCVJFR1VMQVRPUl9DSEFOR0VfTU9ERSB8
IFJFR1VMQVRPUl9DSEFOR0VfU1RBVFVTLAorCQkudmFsaWRfbW9kZXNfbWFzayA9IFJFR1VMQVRP
Ul9NT0RFX0ZBU1QgfCBSRUdVTEFUT1JfTU9ERV9OT1JNQUwsCisJCS5ib290X29uID0gMSwKKwl9
Cit9OworCitzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgdmdlbjFfaW5pdCA9IHsK
KwkuY29uc3RyYWludHMgPSB7CisJCS5uYW1lID0gIlZHRU4xIiwKKwkJLm1pbl91ViA9IDEyMDAw
MDAsCisJCS5tYXhfdVYgPSAzMTUwMDAwLAorCQkudmFsaWRfb3BzX21hc2sgPQorCQkJUkVHVUxB
VE9SX0NIQU5HRV9WT0xUQUdFIHwgUkVHVUxBVE9SX0NIQU5HRV9TVEFUVVMsCisJCS5ib290X29u
ID0gMSwKKwkJLmFsd2F5c19vbiA9IDEsCisJfQorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0
b3JfaW5pdF9kYXRhIHZnZW4yX2luaXQgPSB7CisJLmNvbnN0cmFpbnRzID0geworCQkubmFtZSA9
ICJWR0VOMiIsCisJCS5taW5fdVYgPSAxMjAwMDAwLAorCQkubWF4X3VWID0gMzE1MDAwMCwKKwkJ
LnZhbGlkX29wc19tYXNrID0KKwkJCVJFR1VMQVRPUl9DSEFOR0VfVk9MVEFHRSB8IFJFR1VMQVRP
Ul9DSEFOR0VfU1RBVFVTLAorCQkuYm9vdF9vbiA9IDEsCisJCS5hbHdheXNfb24gPSAxLAorCX0K
K307CisKK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0YSB2Z2VuM19pbml0ID0gewor
CS5jb25zdHJhaW50cyA9IHsKKwkJLm5hbWUgPSAiVkdFTjMiLAorCQkubWluX3VWID0gMTgwMDAw
MCwKKwkJLm1heF91ViA9IDI5MDAwMDAsCisJCS52YWxpZF9vcHNfbWFzayA9CisJCQlSRUdVTEFU
T1JfQ0hBTkdFX1ZPTFRBR0UgfCBSRUdVTEFUT1JfQ0hBTkdFX1NUQVRVUywKKwkJLmJvb3Rfb24g
PSAxLAorCQkuYWx3YXlzX29uID0gMSwKKwl9Cit9OworCitzdGF0aWMgc3RydWN0IHJlZ3VsYXRv
cl9pbml0X2RhdGEgZ3BvMV9pbml0ID0geworCS5jb25zdHJhaW50cyA9IHsKKwkJLm5hbWUgPSAi
R1BPMSIsCisJfQorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3JfaW5pdF9kYXRhIGdwbzJf
aW5pdCA9IHsKKwkuY29uc3RyYWludHMgPSB7CisJCS5uYW1lID0gIkdQTzIiLAorCX0KK307CisK
K3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0YSBncG8zX2luaXQgPSB7CisJLmNvbnN0
cmFpbnRzID0geworCQkubmFtZSA9ICJHUE8zIiwKKwl9Cit9OworCitzdGF0aWMgc3RydWN0IHJl
Z3VsYXRvcl9pbml0X2RhdGEgZ3BvNF9pbml0ID0geworCS5jb25zdHJhaW50cyA9IHsKKwkJLm5h
bWUgPSAiR1BPNCIsCisJfQorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3JfaW5pdF9kYXRh
IHB3Z3QxX2luaXQgPSB7CisJLmNvbnN0cmFpbnRzID0geworCQkudmFsaWRfb3BzX21hc2sgPSBS
RUdVTEFUT1JfQ0hBTkdFX1NUQVRVUywKKwkJLmJvb3Rfb24gICAgICAgID0gMSwKKwl9LAorCS5u
dW1fY29uc3VtZXJfc3VwcGxpZXMgPSBBUlJBWV9TSVpFKHB3Z3QxX2NvbnN1bWVyKSwKKwkuY29u
c3VtZXJfc3VwcGxpZXMgPSBwd2d0MV9jb25zdW1lciwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVn
dWxhdG9yX2luaXRfZGF0YSBwd2d0Ml9pbml0ID0geworCS5jb25zdHJhaW50cyA9IHsKKwkJLnZh
bGlkX29wc19tYXNrID0gUkVHVUxBVE9SX0NIQU5HRV9TVEFUVVMsCisJCS5ib290X29uICAgICAg
ICA9IDEsCisJfSwKKwkubnVtX2NvbnN1bWVyX3N1cHBsaWVzID0gQVJSQVlfU0laRShwd2d0Ml9j
b25zdW1lciksCisJLmNvbnN1bWVyX3N1cHBsaWVzID0gcHdndDJfY29uc3VtZXIsCit9OworCitz
dGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgdmNvaW5jZWxsX2luaXQgPSB7CisJLmNv
bnN0cmFpbnRzID0geworCQkubmFtZSA9ICJDT0lOQ0VMTCIsCisJCS5taW5fdVYgPSAzMDAwMDAw
LAorCQkubWF4X3VWID0gMzAwMDAwMCwKKwkJLnZhbGlkX29wc19tYXNrID0KKwkJCVJFR1VMQVRP
Ul9DSEFOR0VfVk9MVEFHRSB8IFJFR1VMQVRPUl9DSEFOR0VfU1RBVFVTLAorCX0sCisJLm51bV9j
b25zdW1lcl9zdXBwbGllcyA9IEFSUkFZX1NJWkUoY29pbmNlbGxfY29uc3VtZXIpLAorCS5jb25z
dW1lcl9zdXBwbGllcyA9IGNvaW5jZWxsX2NvbnN1bWVyLAorfTsKK3N0YXRpYyBzdHJ1Y3QgbWMx
M3h4eF9yZWd1bGF0b3JfaW5pdF9kYXRhIG14NTFfYmJnX3JlZ3VsYXRvcnNbXSA9IHsKKwl7IC5p
ZCA9IE1DMTM4OTJfU1cxLAkJLmluaXRfZGF0YSA9ICAmc3cxX2luaXQgfSwKKwl7IC5pZCA9IE1D
MTM4OTJfU1cyLAkJLmluaXRfZGF0YSA9ICAmc3cyX2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4OTJf
U1czLAkJLmluaXRfZGF0YSA9ICAmc3czX2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4OTJfU1c0LAkJ
LmluaXRfZGF0YSA9ICAmc3c0X2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4OTJfU1dCU1QsCS5pbml0
X2RhdGEgPSAgJnN3YnN0X2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4OTJfVklPSEksCS5pbml0X2Rh
dGEgPSAgJnZpb2hpX2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4OTJfVlBMTCwJLmluaXRfZGF0YSA9
ICAmdnBsbF9pbml0IH0sCisJeyAuaWQgPSBNQzEzODkyX1ZESUcsCS5pbml0X2RhdGEgPSAgJnZk
aWdfaW5pdCB9LAorCXsgLmlkID0gTUMxMzg5Ml9WU0QsCS5pbml0X2RhdGEgPSAgJnZzZF9pbml0
IH0sCisJeyAuaWQgPSBNQzEzODkyX1ZVU0IyLAkuaW5pdF9kYXRhID0gICZ2dXNiMl9pbml0IH0s
CisJeyAuaWQgPSBNQzEzODkyX1ZWSURFTywJLmluaXRfZGF0YSA9ICAmdnZpZGVvX2luaXQgfSwK
Kwl7IC5pZCA9IE1DMTM4OTJfVkFVRElPLAkuaW5pdF9kYXRhID0gICZ2YXVkaW9faW5pdCB9LAor
CXsgLmlkID0gTUMxMzg5Ml9WQ0FNLAkuaW5pdF9kYXRhID0gICZ2Y2FtX2luaXQgfSwKKwl7IC5p
ZCA9IE1DMTM4OTJfVkdFTjEsCS5pbml0X2RhdGEgPSAgJnZnZW4xX2luaXQgfSwKKwl7IC5pZCA9
IE1DMTM4OTJfVkdFTjIsCS5pbml0X2RhdGEgPSAgJnZnZW4yX2luaXQgfSwKKwl7IC5pZCA9IE1D
MTM4OTJfVkdFTjMsCS5pbml0X2RhdGEgPSAgJnZnZW4zX2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4
OTJfVlVTQiwJLmluaXRfZGF0YSA9ICAmdnVzYl9pbml0IH0sCisJeyAuaWQgPSBNQzEzODkyX0dQ
TzEsCS5pbml0X2RhdGEgPSAgJmdwbzFfaW5pdCB9LAorCXsgLmlkID0gTUMxMzg5Ml9HUE8yLAku
aW5pdF9kYXRhID0gICZncG8yX2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4OTJfR1BPMywJLmluaXRf
ZGF0YSA9ICAmZ3BvM19pbml0IH0sCisJeyAuaWQgPSBNQzEzODkyX0dQTzQsCS5pbml0X2RhdGEg
PSAgJmdwbzRfaW5pdCB9LAorCXsgLmlkID0gTUMxMzg5Ml9QV0dUMVNQSSwJLmluaXRfZGF0YSA9
ICZwd2d0MV9pbml0IH0sCisJeyAuaWQgPSBNQzEzODkyX1BXR1QyU1BJLAkuaW5pdF9kYXRhID0g
JnB3Z3QyX2luaXQgfSwKKwl7IC5pZCA9IE1DMTM4OTJfVkNPSU5DRUxMLAkuaW5pdF9kYXRhID0g
JnZjb2luY2VsbF9pbml0IH0sCit9OworCitzdGF0aWMgc3RydWN0IG1jMTN4eHhfcGxhdGZvcm1f
ZGF0YSBteDUxX2JiZ19tYzEzODkyX2RhdGEgPSB7CisJLmZsYWdzID0gTUMxM1hYWF9VU0VfUlRD
IHwgTUMxM1hYWF9VU0VfUkVHVUxBVE9SLAorCS5udW1fcmVndWxhdG9ycyA9IEFSUkFZX1NJWkUo
bXg1MV9iYmdfcmVndWxhdG9ycyksCisJLnJlZ3VsYXRvcnMgPSBteDUxX2JiZ19yZWd1bGF0b3Jz
LAorfTsKKworc3RhdGljIHN0cnVjdCBzcGlfYm9hcmRfaW5mbyBteDUxX2JiZ19zcGlfYm9hcmRf
aW5mb1tdIF9faW5pdGRhdGEgPSB7CisJeworCQkubW9kYWxpYXMgPSAibWMxMzg5MiIsCisJCS5t
YXhfc3BlZWRfaHogPSA2MDAwMDAwLAorCQkuYnVzX251bSA9IDAsCisJCS5jaGlwX3NlbGVjdCA9
IDAsCisJCS5wbGF0Zm9ybV9kYXRhID0gJm14NTFfYmJnX21jMTM4OTJfZGF0YSwKKwkJLmlycSA9
IGdwaW9fdG9faXJxKEJBQkJBR0VfUE1JQyksCisJfSwKK307CisKK2ludCBfX2luaXQgbXg1MV9i
YWJiYWdlX2luaXRfbWMxMzg5Mih2b2lkKQoreworCXJldHVybiBzcGlfcmVnaXN0ZXJfYm9hcmRf
aW5mbyhteDUxX2JiZ19zcGlfYm9hcmRfaW5mbywKKwkJQVJSQVlfU0laRShteDUxX2JiZ19zcGlf
Ym9hcmRfaW5mbykpOworfQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1teDUvYm9hcmQtbXg1
MV9iYWJiYWdlLmMgYi9hcmNoL2FybS9tYWNoLW14NS9ib2FyZC1teDUxX2JhYmJhZ2UuYwppbmRl
eCBlZjMyODQzLi45Y2YxNmQxIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW14NS9ib2FyZC1t
eDUxX2JhYmJhZ2UuYworKysgYi9hcmNoL2FybS9tYWNoLW14NS9ib2FyZC1teDUxX2JhYmJhZ2Uu
YwpAQCAtMSw0ICsxLDUgQEAKIC8qCisgKiBDb3B5cmlnaHQgMjAxMCBZb25nIFNoZW4gPHlvbmcu
c2hlbkBsaW5hcm8ub3JnPgogICogQ29weXJpZ2h0IDIwMDktMjAxMCBGcmVlc2NhbGUgU2VtaWNv
bmR1Y3RvciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgogICogQ29weXJpZ2h0IChDKSAyMDA5
LTIwMTAgQW1pdCBLdWNoZXJpYSA8YW1pdC5rdWNoZXJpYUBjYW5vbmljYWwuY29tPgogICoKQEAg
LTM0Miw2ICszNDMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9pbXhfbWFzdGVyIG14NTFf
YmFiYmFnZV9zcGlfcGRhdGEgX19pbml0Y29uc3QgPSB7CiAJLm51bV9jaGlwc2VsZWN0ID0gQVJS
QVlfU0laRShteDUxX2JhYmJhZ2Vfc3BpX2NzKSwKIH07CiAKK2V4dGVybiBpbnQgX19pbml0IG14
NTFfYmFiYmFnZV9pbml0X21jMTM4OTIodm9pZCk7CiAvKgogICogQm9hcmQgc3BlY2lmaWMgaW5p
dGlhbGl6YXRpb24uCiAgKi8KQEAgLTM4NCw2ICszODYsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
bXhjX2JvYXJkX2luaXQodm9pZCkKIAlpbXg1MV9hZGRfc2RoY2lfZXNkaGNfaW14KDAsIE5VTEwp
OwogCWlteDUxX2FkZF9zZGhjaV9lc2RoY19pbXgoMSwgTlVMTCk7CiAKKwlteDUxX2JhYmJhZ2Vf
aW5pdF9tYzEzODkyKCk7CiAJc3BpX3JlZ2lzdGVyX2JvYXJkX2luZm8obXg1MV9iYWJiYWdlX3Nw
aV9ib2FyZF9pbmZvLAogCQlBUlJBWV9TSVpFKG14NTFfYmFiYmFnZV9zcGlfYm9hcmRfaW5mbykp
OwogCWlteDUxX2FkZF9lY3NwaSgwLCAmbXg1MV9iYWJiYWdlX3NwaV9wZGF0YSk7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9LY29uZmlnIGIvZHJpdmVycy9yZWd1bGF0b3IvS2NvbmZp
ZwppbmRleCBkZDMwZTg4Li5mMDc0YjgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9L
Y29uZmlnCisrKyBiL2RyaXZlcnMvcmVndWxhdG9yL0tjb25maWcKQEAgLTE5Myw2ICsxOTMsMTMg
QEAgY29uZmlnIFJFR1VMQVRPUl9NQzEzNzgzCiAJICBTYXkgeSBoZXJlIHRvIHN1cHBvcnQgdGhl
IHJlZ3VsYXRvcnMgZm91bmQgb24gdGhlIEZyZWVzY2FsZSBNQzEzNzgzCiAJICBQTUlDLgogCitj
b25maWcgUkVHVUxBVE9SX01DMTM4OTIKKwl0cmlzdGF0ZSAiU3VwcG9ydCByZWd1bGF0b3JzIG9u
IEZyZWVzY2FsZSBNQzEzODkyIFBNSUMiCisJZGVwZW5kcyBvbiBNRkRfTUMxM1hYWAorCWhlbHAK
KwkgIFNheSB5IGhlcmUgdG8gc3VwcG9ydCB0aGUgcmVndWxhdG9ycyBmb3VuZCBvbiB0aGUgRnJl
ZXNjYWxlIE1DMTM4OTIKKwkgIFBNSUMuCisKIGNvbmZpZyBSRUdVTEFUT1JfQUIzMTAwCiAJdHJp
c3RhdGUgIlNULUVyaWNzc29uIEFCMzEwMCBSZWd1bGF0b3IgZnVuY3Rpb25zIgogCWRlcGVuZHMg
b24gQUIzMTAwX0NPUkUKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL01ha2VmaWxlIGIv
ZHJpdmVycy9yZWd1bGF0b3IvTWFrZWZpbGUKaW5kZXggYmZmODE1Ny4uYjYwMWRkYiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9yZWd1bGF0b3Iv
TWFrZWZpbGUKQEAgLTMwLDYgKzMwLDcgQEAgb2JqLSQoQ09ORklHX1JFR1VMQVRPUl9EQTkwM1gp
CSs9IGRhOTAzeC5vCiBvYmotJChDT05GSUdfUkVHVUxBVE9SX1BDRjUwNjMzKSArPSBwY2Y1MDYz
My1yZWd1bGF0b3Iubwogb2JqLSQoQ09ORklHX1JFR1VMQVRPUl9QQ0FQKSArPSBwY2FwLXJlZ3Vs
YXRvci5vCiBvYmotJChDT05GSUdfUkVHVUxBVE9SX01DMTM3ODMpICs9IG1jMTM3ODMtcmVndWxh
dG9yLm8KK29iai0kKENPTkZJR19SRUdVTEFUT1JfTUMxMzg5MikgKz0gbWMxMzg5Mi1yZWd1bGF0
b3Iubwogb2JqLSQoQ09ORklHX1JFR1VMQVRPUl9BQjMxMDApICs9IGFiMzEwMC5vCiAKIG9iai0k
KENPTkZJR19SRUdVTEFUT1JfVFBTNjUwMjMpICs9IHRwczY1MDIzLXJlZ3VsYXRvci5vCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9tYzEzNzgzLXJlZ3VsYXRvci5jIGIvZHJpdmVycy9y
ZWd1bGF0b3IvbWMxMzc4My1yZWd1bGF0b3IuYwppbmRleCA0NTk3ZDUwLi5lYTk0Y2E3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9tYzEzNzgzLXJlZ3VsYXRvci5jCisrKyBiL2RyaXZl
cnMvcmVndWxhdG9yL21jMTM3ODMtcmVndWxhdG9yLmMKQEAgLTEsNiArMSw3IEBACiAvKgogICog
UmVndWxhdG9yIERyaXZlciBmb3IgRnJlZXNjYWxlIE1DMTM3ODMgUE1JQwogICoKKyAqIENvcHly
aWdodCAyMDEwIFlvbmcgU2hlbiA8eW9uZy5zaGVuQGxpbmFyby5vcmc+CiAgKiBDb3B5cmlnaHQg
KEMpIDIwMDggU2FzY2hhIEhhdWVyLCBQZW5ndXRyb25peCA8cy5oYXVlckBwZW5ndXRyb25peC5k
ZT4KICAqIENvcHlyaWdodCAyMDA5IEFsYmVydG8gUGFuaXp6byA8bWFyYW1hb3BlcmNoZXNlaW1v
cnRvQGdtYWlsLmNvbT4KICAqCkBAIC0xMCw2ICsxMSw3IEBACiAgKi8KIAogI2luY2x1ZGUgPGxp
bnV4L21mZC9tYzEzNzgzLmg+CisjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL21jMTN4eHguaD4K
ICNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvbWFjaGluZS5oPgogI2luY2x1ZGUgPGxpbnV4L3Jl
Z3VsYXRvci9kcml2ZXIuaD4KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KQEAg
LTg5LDE2ICs5MSw2IEBACiAjZGVmaW5lIE1DMTM3ODNfUkVHX1BPV0VSTUlTQ19QV0dUU1BJX00J
CQkoMyA8PCAxNSkKIAogCi1zdHJ1Y3QgbWMxMzc4M19yZWd1bGF0b3IgewotCXN0cnVjdCByZWd1
bGF0b3JfZGVzYyBkZXNjOwotCWludCByZWc7Ci0JaW50IGVuYWJsZV9iaXQ7Ci0JaW50IHZzZWxf
cmVnOwotCWludCB2c2VsX3NoaWZ0OwotCWludCB2c2VsX21hc2s7Ci0JaW50IGNvbnN0ICp2b2x0
YWdlczsKLX07Ci0KIC8qIFZvbHRhZ2UgVmFsdWVzICovCiBzdGF0aWMgY29uc3QgaW50IGNvbnN0
IG1jMTM3ODNfc3czX3ZhbFtdID0gewogCTUwMDAwMDAsIDUwMDAwMDAsIDUwMDAwMDAsIDU1MDAw
MDAsCkBAIC0xNzksNiArMTcxLDcgQEAgc3RhdGljIHN0cnVjdCByZWd1bGF0b3Jfb3BzIG1jMTM3
ODNfcmVndWxhdG9yX29wczsKIHN0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX29wcyBtYzEzNzgzX2Zp
eGVkX3JlZ3VsYXRvcl9vcHM7CiBzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9vcHMgbWMxMzc4M19n
cG9fcmVndWxhdG9yX29wczsKIAorLyoKICNkZWZpbmUgTUMxMzc4M19ERUZJTkUocHJlZml4LCBf
bmFtZSwgX3JlZywgX3ZzZWxfcmVnLCBfdm9sdGFnZXMpCVwKIAlbTUMxMzc4M18gIyMgcHJlZml4
ICMjIF8gIyMgX25hbWVdID0gewkJCQlcCiAJCS5kZXNjID0gewkJCQkJCVwKQEAgLTE5Niw0MyAr
MTg5LDI2IEBAIHN0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX29wcyBtYzEzNzgzX2dwb19yZWd1bGF0
b3Jfb3BzOwogCQkudnNlbF9tYXNrID0gTUMxMzc4M19SRUdfICMjIF92c2VsX3JlZyAjIyBfICMj
IF9uYW1lICMjIFZTRUxfTSxcCiAJCS52b2x0YWdlcyA9ICBfdm9sdGFnZXMsCQkJCQlcCiAJfQor
CSovCiAKLSNkZWZpbmUgTUMxMzc4M19GSVhFRF9ERUZJTkUocHJlZml4LCBfbmFtZSwgX3JlZywg
X3ZvbHRhZ2VzKQkJXAotCVtNQzEzNzgzXyAjIyBwcmVmaXggIyMgXyAjIyBfbmFtZV0gPSB7CQkJ
CVwKLQkJLmRlc2MgPSB7CQkJCQkJXAotCQkJLm5hbWUgPSAjcHJlZml4ICJfIiAjX25hbWUsCQkJ
XAotCQkJLm5fdm9sdGFnZXMgPSBBUlJBWV9TSVpFKF92b2x0YWdlcyksCQlcCi0JCQkub3BzID0g
Jm1jMTM3ODNfZml4ZWRfcmVndWxhdG9yX29wcywJCVwKLQkJCS50eXBlID0gUkVHVUxBVE9SX1ZP
TFRBR0UsCQkJXAotCQkJLmlkID0gTUMxMzc4M18gIyMgcHJlZml4ICMjIF8gIyMgX25hbWUsCQlc
Ci0JCQkub3duZXIgPSBUSElTX01PRFVMRSwJCQkJXAotCQl9LAkJCQkJCQlcCi0JCS5yZWcgPSBN
QzEzNzgzX1JFR18gIyMgX3JlZywJCQkJXAotCQkuZW5hYmxlX2JpdCA9IE1DMTM3ODNfUkVHXyAj
IyBfcmVnICMjIF8gIyMgX25hbWUgIyMgRU4sCVwKLQkJLnZvbHRhZ2VzID0gIF92b2x0YWdlcywJ
CQkJCVwKLQl9CisjZGVmaW5lIE1DMTM3ODNfREVGSU5FKHByZWZpeCwgbmFtZSwgcmVnLCB2c2Vs
X3JlZywgdm9sdGFnZXMpCVwKKwlNQzEzeHh4X0RFRklORShNQzEzNzgzX1JFR18sIG5hbWUsIHJl
ZywgdnNlbF9yZWcsIHZvbHRhZ2VzLCBcCisJCQltYzEzNzgzX3JlZ3VsYXRvcl9vcHMpCiAKLSNk
ZWZpbmUgTUMxMzc4M19HUE9fREVGSU5FKHByZWZpeCwgX25hbWUsIF9yZWcsICBfdm9sdGFnZXMp
CQlcCi0JW01DMTM3ODNfICMjIHByZWZpeCAjIyBfICMjIF9uYW1lXSA9IHsJCQkJXAotCQkuZGVz
YyA9IHsJCQkJCQlcCi0JCQkubmFtZSA9ICNwcmVmaXggIl8iICNfbmFtZSwJCQlcCi0JCQkubl92
b2x0YWdlcyA9IEFSUkFZX1NJWkUoX3ZvbHRhZ2VzKSwJCVwKLQkJCS5vcHMgPSAmbWMxMzc4M19n
cG9fcmVndWxhdG9yX29wcywJCVwKLQkJCS50eXBlID0gUkVHVUxBVE9SX1ZPTFRBR0UsCQkJXAot
CQkJLmlkID0gTUMxMzc4M18gIyMgcHJlZml4ICMjIF8gIyMgX25hbWUsCQlcCi0JCQkub3duZXIg
PSBUSElTX01PRFVMRSwJCQkJXAotCQl9LAkJCQkJCQlcCi0JCS5yZWcgPSBNQzEzNzgzX1JFR18g
IyMgX3JlZywJCQkJXAotCQkuZW5hYmxlX2JpdCA9IE1DMTM3ODNfUkVHXyAjIyBfcmVnICMjIF8g
IyMgX25hbWUgIyMgRU4sCVwKLQkJLnZvbHRhZ2VzID0gIF92b2x0YWdlcywJCQkJCVwKLQl9Cisj
ZGVmaW5lIE1DMTM3ODNfRklYRURfREVGSU5FKHByZWZpeCwgbmFtZSwgcmVnLCB2b2x0YWdlcykJ
CVwKKwlNQzEzeHh4X0ZJWEVEX0RFRklORShNQzEzNzgzX1JFR18sIG5hbWUsIHJlZywgdm9sdGFn
ZXMsIFwKKwkJCW1jMTM3ODNfZml4ZWRfcmVndWxhdG9yX29wcykKKworI2RlZmluZSBNQzEzNzgz
X0dQT19ERUZJTkUocHJlZml4LCBuYW1lLCByZWcsIHZvbHRhZ2VzKQkJXAorCU1DMTN4eHhfR1BP
X0RFRklORShNQzEzNzgzX1JFR18sIG5hbWUsIHJlZywgdm9sdGFnZXMsIFwKKwkJCW1jMTM3ODNf
Z3BvX3JlZ3VsYXRvcl9vcHMpCiAKICNkZWZpbmUgTUMxMzc4M19ERUZJTkVfU1coX25hbWUsIF9y
ZWcsIF92c2VsX3JlZywgX3ZvbHRhZ2VzKQkJXAogCU1DMTM3ODNfREVGSU5FKFNXLCBfbmFtZSwg
X3JlZywgX3ZzZWxfcmVnLCBfdm9sdGFnZXMpCiAjZGVmaW5lIE1DMTM3ODNfREVGSU5FX1JFR1Uo
X25hbWUsIF9yZWcsIF92c2VsX3JlZywgX3ZvbHRhZ2VzKQkJXAogCU1DMTM3ODNfREVGSU5FKFJF
R1UsIF9uYW1lLCBfcmVnLCBfdnNlbF9yZWcsIF92b2x0YWdlcykKIAotc3RhdGljIHN0cnVjdCBt
YzEzNzgzX3JlZ3VsYXRvciBtYzEzNzgzX3JlZ3VsYXRvcnNbXSA9IHsKK3N0YXRpYyBzdHJ1Y3Qg
bWMxM3h4eF9yZWd1bGF0b3IgbWMxMzc4M19yZWd1bGF0b3JzW10gPSB7CiAJTUMxMzc4M19ERUZJ
TkVfU1coU1czLCBTV0lUQ0hFUlM1LCBTV0lUQ0hFUlM1LCBtYzEzNzgzX3N3M192YWwpLAogCiAJ
TUMxMzc4M19GSVhFRF9ERUZJTkUoUkVHVSwgVkFVRElPLCBSRUdVTEFUT1JNT0RFMCwgbWMxMzc4
M192YXVkaW9fdmFsKSwKQEAgLTUwMiw4ICs0NzgsOCBAQCBzdGF0aWMgaW50IG1jMTM3ODNfZ3Bv
X3JlZ3VsYXRvcl9lbmFibGUoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYpCiAJZGV2X2RiZyhy
ZGV2X2dldF9kZXYocmRldiksICIlcyBpZDogJWRcbiIsIF9fZnVuY19fLCBpZCk7CiAKIAkvKiBQ
b3dlciBHYXRlIGVuYWJsZSB2YWx1ZSBpcyAwICovCi0JaWYgKGlkID09IE1DMTM3ODNfUkVHVV9Q
V0dUMVNQSSB8fAotCSAgICBpZCA9PSBNQzEzNzgzX1JFR1VfUFdHVDJTUEkpCisJaWYgKGlkID09
IE1DMTM3ODNfUkVHX1BXR1QxU1BJIHx8CisJICAgIGlkID09IE1DMTM3ODNfUkVHX1BXR1QyU1BJ
KQogCQllbl92YWwgPSAwOwogCiAJbWMxMzc4M19sb2NrKHByaXYtPm1jMTM3ODMpOwpAQCAtNTI0
LDggKzUwMCw4IEBAIHN0YXRpYyBpbnQgbWMxMzc4M19ncG9fcmVndWxhdG9yX2Rpc2FibGUoc3Ry
dWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYpCiAJZGV2X2RiZyhyZGV2X2dldF9kZXYocmRldiksICIl
cyBpZDogJWRcbiIsIF9fZnVuY19fLCBpZCk7CiAKIAkvKiBQb3dlciBHYXRlIGRpc2FibGUgdmFs
dWUgaXMgMSAqLwotCWlmIChpZCA9PSBNQzEzNzgzX1JFR1VfUFdHVDFTUEkgfHwKLQkgICAgaWQg
PT0gTUMxMzc4M19SRUdVX1BXR1QyU1BJKQorCWlmIChpZCA9PSBNQzEzNzgzX1JFR19QV0dUMVNQ
SSB8fAorCSAgICBpZCA9PSBNQzEzNzgzX1JFR19QV0dUMlNQSSkKIAkJZGlzX3ZhbCA9IG1jMTM3
ODNfcmVndWxhdG9yc1tpZF0uZW5hYmxlX2JpdDsKIAogCW1jMTM3ODNfbG9jayhwcml2LT5tYzEz
NzgzKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL21jMTM4OTItcmVndWxhdG9yLmMg
Yi9kcml2ZXJzL3JlZ3VsYXRvci9tYzEzODkyLXJlZ3VsYXRvci5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLjA3MTY4MjcKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL3Jl
Z3VsYXRvci9tYzEzODkyLXJlZ3VsYXRvci5jCkBAIC0wLDAgKzEsODc1IEBACisvKgorICogUmVn
dWxhdG9yIERyaXZlciBmb3IgRnJlZXNjYWxlIE1DMTM4OTIgUE1JQworICoKKyAqIENvcHlyaWdo
dCAyMDEwIFlvbmcgU2hlbiA8eW9uZy5zaGVuQGxpbmFyby5vcmc+CisgKiBDb3B5cmlnaHQgMjAx
MCBBcm5hdWQgUGF0YXJkIDxhcm5hdWQucGF0YXJkQHJ0cC1uZXQub3JnPgorICoKKyAqIEJhc2Vk
IG9uIG1jMTM3ODMgcmVndWxhdG9yIGRyaXZlciA6CisgKiBDb3B5cmlnaHQgKEMpIDIwMDggU2Fz
Y2hhIEhhdWVyLCBQZW5ndXRyb25peCA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KKyAqIENvcHly
aWdodCAyMDA5IEFsYmVydG8gUGFuaXp6byA8bWFyYW1hb3BlcmNoZXNlaW1vcnRvQGdtYWlsLmNv
bT4KKyAqCisgKiBUT0RPOiBsb29rIGlmIG1jMTM3ODMgJiB0aGlzIGRyaXZlciBjYW4gYmUgbWVy
Z2VkLiB0aGV5IHNoYXJlIGEgbG90CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCisg
KiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBSZWdz
IGluZm9zIHRha2VuIGZyb20gbWMxMzg5MiBkcml2ZXJzIGZyb20gZnJlZXNjYWxlIGFuZCBtYzEz
ODkyLnBkZiBmaWxlCisgKiBmcm9tIGZyZWVzY2FsZQorICovCisKKyNkZWZpbmUgREVCVUcKKwor
I2luY2x1ZGUgPGxpbnV4L21mZC9tYzEzODkyLmg+CisjaW5jbHVkZSA8bGludXgvcmVndWxhdG9y
L21jMTN4eHguaD4KKyNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvbWFjaGluZS5oPgorI2luY2x1
ZGUgPGxpbnV4L3JlZ3VsYXRvci9kcml2ZXIuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgorCisK
KyNkZWZpbmUgbWMxMzg5Ml9yZWdfcmVhZAltYzEzeHh4X3JlZ19yZWFkCisjZGVmaW5lIG1jMTM4
OTJfcmVnX3dyaXRlCW1jMTN4eHhfcmVnX3dyaXRlCisjZGVmaW5lIG1jMTM4OTJfcmVnX3JtdwkJ
bWMxM3h4eF9yZWdfcm13CisKKyNkZWZpbmUgTUMxMzg5Ml9SRVZJU0lPTgkJCQk3CisKKyNkZWZp
bmUgTUMxMzg5Ml9QT1dFUkNUTDAJCQkJMTMKKyNkZWZpbmUgTUMxMzg5Ml9QT1dFUkNUTDBfVVNF
Uk9GRlNQSQkJMworI2RlZmluZSBNQzEzODkyX1BPV0VSQ1RMMF9WQ09JTkNFTExWU0VMCQkyMAor
I2RlZmluZSBNQzEzODkyX1BPV0VSQ1RMMF9WQ09JTkNFTExWU0VMX00JCSg3PDwyMCkKKyNkZWZp
bmUgTUMxMzg5Ml9QT1dFUkNUTDBfVkNPSU5DRUxMRU4JCSgxPDwyMykKKworI2RlZmluZSBNQzEz
ODkyX1NXSVRDSEVSUzBfU1d4SEkJCQkoMTw8MjMpCisKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hF
UlMwCQkJCTI0CisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTMF9TVzFWU0VMCQkJMAorI2RlZmlu
ZSBNQzEzODkyX1NXSVRDSEVSUzBfU1cxVlNFTF9NCQkoMHgxZjw8MCkKKyNkZWZpbmUgTUMxMzg5
Ml9TV0lUQ0hFUlMwX1NXMUhJCQkJKDE8PDIzKQorI2RlZmluZSBNQzEzODkyX1NXSVRDSEVSUzBf
U1cxRU4JCTAgLypubyB1c2UqLworCisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTMQkJCQkyNQor
I2RlZmluZSBNQzEzODkyX1NXSVRDSEVSUzFfU1cyVlNFTAkJCTAKKyNkZWZpbmUgTUMxMzg5Ml9T
V0lUQ0hFUlMxX1NXMlZTRUxfTQkJKDB4MWY8PDApCisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJT
MV9TVzJISQkJCSgxPDwyMykKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hFUlMxX1NXMkVOCQkwIC8q
bm8gdXNlKi8KKworI2RlZmluZSBNQzEzODkyX1NXSVRDSEVSUzIJCQkJMjYKKyNkZWZpbmUgTUMx
Mzg5Ml9TV0lUQ0hFUlMyX1NXM1ZTRUwJCQkwCisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTMl9T
VzNWU0VMX00JCSgweDFmPDwwKQorI2RlZmluZSBNQzEzODkyX1NXSVRDSEVSUzJfU1czSEkJCQko
MTw8MjMpCisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTMl9TVzNFTgkJMC8qbm8gdXNlKi8KKwor
I2RlZmluZSBNQzEzODkyX1NXSVRDSEVSUzMJCQkJMjcKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hF
UlMzX1NXNFZTRUwJCQkwCisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTM19TVzRWU0VMX00JCSgw
eDFmPDwwKQorI2RlZmluZSBNQzEzODkyX1NXSVRDSEVSUzNfU1c0SEkJCQkoMTw8MjMpCisjZGVm
aW5lIE1DMTM4OTJfU1dJVENIRVJTM19TVzRFTgkJMC8qbm8gdXNlKi8KKworI2RlZmluZSBNQzEz
ODkyX1NXSVRDSEVSUzQJCQkJMjgKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hFUlM0X1NXMU1PREUJ
CQkwCisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTNF9TVzFNT0RFX0FVVE8JCSg4PDwwKQorI2Rl
ZmluZSBNQzEzODkyX1NXSVRDSEVSUzRfU1cxTU9ERV9NCQkoMHhmPDwwKQorI2RlZmluZSBNQzEz
ODkyX1NXSVRDSEVSUzRfU1cyTU9ERQkJCTEwCisjZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTNF9T
VzJNT0RFX0FVVE8JCSg4PDwxMCkKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hFUlM0X1NXMk1PREVf
TQkJKDB4Zjw8MTApCisKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hFUlM1CQkJCTI5CisjZGVmaW5l
IE1DMTM4OTJfU1dJVENIRVJTNV9TVzNNT0RFCQkJMAorI2RlZmluZSBNQzEzODkyX1NXSVRDSEVS
UzVfU1czTU9ERV9BVVRPCQkoODw8MCkKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hFUlM1X1NXM01P
REVfTQkJKDB4Zjw8MCkKKyNkZWZpbmUgTUMxMzg5Ml9TV0lUQ0hFUlM1X1NXNE1PREUJCQk4Cisj
ZGVmaW5lIE1DMTM4OTJfU1dJVENIRVJTNV9TVzRNT0RFX0FVVE8JCSg4PDw4KQorI2RlZmluZSBN
QzEzODkyX1NXSVRDSEVSUzVfU1c0TU9ERV9NCQkoMHhmPDw4KQorI2RlZmluZSBNQzEzODkyX1NX
SVRDSEVSUzVfU1dCU1RFTgkJCSgxPDwyMCkKKworCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9S
U0VUVElORzAJCQkzMAorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUlNFVFRJTkcwX1ZHRU4xVlNF
TAkJMAorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUlNFVFRJTkcwX1ZESUdWU0VMCQk0CisjZGVm
aW5lIE1DMTM4OTJfUkVHVUxBVE9SU0VUVElORzBfVkdFTjJWU0VMCQk2CisjZGVmaW5lIE1DMTM4
OTJfUkVHVUxBVE9SU0VUVElORzBfVlBMTFZTRUwJCTkKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFU
T1JTRVRUSU5HMF9WVVNCMlZTRUwJCTExCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9SU0VUVElO
RzBfVkdFTjNWU0VMCQkxNAorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUlNFVFRJTkcwX1ZDQU1W
U0VMCQkxNgorCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9SU0VUVElORzBfVkdFTjFWU0VMX00J
KDM8PDApCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9SU0VUVElORzBfVkRJR1ZTRUxfTQkoMzw8
NCkKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JTRVRUSU5HMF9WR0VOMlZTRUxfTQkoNzw8NikK
KyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JTRVRUSU5HMF9WUExMVlNFTF9NCSgzPDw5KQorI2Rl
ZmluZSBNQzEzODkyX1JFR1VMQVRPUlNFVFRJTkcwX1ZVU0IyVlNFTF9NCSgzPDwxMSkKKyNkZWZp
bmUgTUMxMzg5Ml9SRUdVTEFUT1JTRVRUSU5HMF9WR0VOM1ZTRUxfTQkoMTw8MTQpCisjZGVmaW5l
IE1DMTM4OTJfUkVHVUxBVE9SU0VUVElORzBfVkNBTVZTRUxfTQkoMzw8MTYpCisKKyNkZWZpbmUg
TUMxMzg5Ml9SRUdVTEFUT1JTRVRUSU5HMQkJCTMxCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9S
U0VUVElORzFfVlZJREVPVlNFTAkyCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9SU0VUVElORzFf
VkFVRElPVlNFTAk0CisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9SU0VUVElORzFfVlNEVlNFTAkJ
NgorCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9SU0VUVElORzFfVlZJREVPVlNFTF9NCSgzPDwy
KQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUlNFVFRJTkcxX1ZBVURJT1ZTRUxfTQkoMzw8NCkK
KyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JTRVRUSU5HMV9WU0RWU0VMX00JCSg3PDw2KQorCisv
KiBhY2NvcmRpbmcgdG8gTUMxMzc4M0lHUExEUk0ucGRmIDogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKi8KKy8qIHN0YW5kYnkgaXMgdXNpbmcgdG8gYWxsb3cgbG93IHBvd2VyIG1vZGUgdGhy
b3VnaCBzdGFuZGJ5IHBpbiAqLworLyogbW9kZSBpcyB1c2luZyB0byBzZXQgaW4gbG93IHBvd2Vy
IG1vZGUgaWYgc3RhbmRieSBkaXNhYmxlZCAgICovCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9S
TU9ERTAJCQkzMgorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUwX1ZHRU4xRU4JCSgxPDww
KQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUwX1ZHRU4xU1REQlkJCSgxPDwxKQorI2Rl
ZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUwX1ZHRU4xTU9ERQkJKDE8PDIpCisjZGVmaW5lIE1D
MTM4OTJfUkVHVUxBVE9STU9ERTBfVklPSElFTgkJKDE8PDMpCisjZGVmaW5lIE1DMTM4OTJfUkVH
VUxBVE9STU9ERTBfVklPSElTVERCWQkJKDE8PDQpCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9S
TU9ERTBfVklPSElNT0RFCQkoMTw8NSkKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JNT0RFMF9W
RElHRU4JCSgxPDw5KQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUwX1ZESUdTVERCWQkJ
KDE8PDEwKQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUwX1ZESUdNT0RFCQkoMTw8MTEp
CisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9STU9ERTBfVkdFTjJFTgkJKDE8PDEyKQorI2RlZmlu
ZSBNQzEzODkyX1JFR1VMQVRPUk1PREUwX1ZHRU4yU1REQlkJCSgxPDwxMykKKyNkZWZpbmUgTUMx
Mzg5Ml9SRUdVTEFUT1JNT0RFMF9WR0VOMk1PREUJCSgxPDwxNCkKKyNkZWZpbmUgTUMxMzg5Ml9S
RUdVTEFUT1JNT0RFMF9WUExMRU4JCSgxPDwxNSkKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JN
T0RFMF9WUExMU1REQlkJCSgxPDwxNikKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JNT0RFMF9W
UExMTU9ERQkJKDE8PDE3KQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUwX1ZVU0IyRU4J
CSgxPDwxOCkKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JNT0RFMF9WVVNCMlNUREJZCQkoMTw8
MTkpCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9STU9ERTBfVlVTQjJNT0RFCQkoMTw8MjApCisK
KyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JNT0RFMQkJCTMzCisjZGVmaW5lIE1DMTM4OTJfUkVH
VUxBVE9STU9ERTFfVkdFTjNFTgkJKDE8PDApCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9STU9E
RTFfVkdFTjNTVERCWQkJKDE8PDEpCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9STU9ERTFfVkdF
TjNNT0RFCQkoMTw8MikKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JNT0RFMV9WQ0FNRU4JCSgx
PDw2KQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUxX1ZDQU1TVERCWQkJKDE8PDcpCisj
ZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9STU9ERTFfVkNBTU1PREUJCSgxPDw4KQorI2RlZmluZSBN
QzEzODkyX1JFR1VMQVRPUk1PREUxX1ZDQU1DT05GSUdFTgkJKDE8PDkpCisjZGVmaW5lIE1DMTM4
OTJfUkVHVUxBVE9STU9ERTFfVlZJREVPRU4JCSgxPDwxMikKKyNkZWZpbmUgTUMxMzg5Ml9SRUdV
TEFUT1JNT0RFMV9WVklERU9TVERCWQkJKDE8PDEzKQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRP
Uk1PREUxX1ZWSURFT01PREUJCSgxPDwxNCkKKyNkZWZpbmUgTUMxMzg5Ml9SRUdVTEFUT1JNT0RF
MV9WQVVESU9FTgkJKDE8PDE1KQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUxX1ZBVURJ
T1NUREJZCQkoMTw8MTYpCisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9STU9ERTFfVkFVRElPTU9E
RQkJKDE8PDE3KQorI2RlZmluZSBNQzEzODkyX1JFR1VMQVRPUk1PREUxX1ZTREVOCQkoMTw8MTgp
CisjZGVmaW5lIE1DMTM4OTJfUkVHVUxBVE9STU9ERTFfVlNEU1REQlkJCSgxPDwxOSkKKyNkZWZp
bmUgTUMxMzg5Ml9SRUdVTEFUT1JNT0RFMV9WU0RNT0RFCQkoMTw8MjApCisKKyNkZWZpbmUgTUMx
Mzg5Ml9QT1dFUk1JU0MJCQkJMzQKKyNkZWZpbmUgTUMxMzg5Ml9QT1dFUk1JU0NfR1BPMUVOCQkJ
KDE8PDYpCisjZGVmaW5lIE1DMTM4OTJfUE9XRVJNSVNDX0dQTzJFTgkJCSgxPDw4KQorI2RlZmlu
ZSBNQzEzODkyX1BPV0VSTUlTQ19HUE8zRU4JCQkoMTw8MTApCisjZGVmaW5lIE1DMTM4OTJfUE9X
RVJNSVNDX0dQTzRFTgkJCSgxPDwxMikKKyNkZWZpbmUgTUMxMzg5Ml9QT1dFUk1JU0NfUFdHVDFT
UElFTgkJKDE8PDE1KQorI2RlZmluZSBNQzEzODkyX1BPV0VSTUlTQ19QV0dUMlNQSUVOCQkoMTw8
MTYpCisjZGVmaW5lIE1DMTM4OTJfUE9XRVJNSVNDX0dQTzRBRElORU4JCSgxPDwyMSkKKworI2Rl
ZmluZSBNQzEzODkyX1BPV0VSTUlTQ19QV0dUU1BJX00JCQkoMyA8PCAxNSkKKworI2RlZmluZSBN
QzEzODkyX1VTQjEJCQkJNTAKKyNkZWZpbmUgTUMxMzg5Ml9VU0IxX1ZVU0JFTgkJCQkoMTw8MykK
Kworc3RhdGljIGNvbnN0IGludCBtYzEzODkyX3Zjb2luY2VsbFtdID0geworCTI1MDAwMDAsIDI3
MDAwMDAsIDI4MDAwMDAsIDI5MDAwMDAsIDMwMDAwMDAsIDMxMDAwMDAsCisJMzIwMDAwMCwgMzMw
MDAwMCwKK307CisKKy8qIDAuNiAtPiAxLjM3NSBzdGVwcyAwLjAyNSAqLworc3RhdGljIGNvbnN0
IGludCBtYzEzODkyX3N3MVtdID0geworCTYwMDAwMCwgICA2MjUwMDAsICA2NTAwMDAsICA2NzUw
MDAsICA3MDAwMDAsICA3MjUwMDAsCisJNzUwMDAwLCAgIDc3NTAwMCwgIDgwMDAwMCwgIDgyNTAw
MCwgIDg1MDAwMCwgIDg3NTAwMCwKKwk5MDAwMDAsICAgOTI1MDAwLCAgOTUwMDAwLCAgOTc1MDAw
LCAxMDAwMDAwLCAxMDI1MDAwLAorCTEwNTAwMDAsIDEwNzUwMDAsIDExMDAwMDAsIDExMjUwMDAs
IDExNTAwMDAsIDExNzUwMDAsCisJMTIwMDAwMCwgMTIyNTAwMCwgMTI1MDAwMCwgMTI3NTAwMCwg
MTMwMDAwMCwgMTMyNTAwMCwKKwkxMzUwMDAwLCAxMzc1MDAwCit9OworCisvKiAwLjYgLT4gMS44
NSBzdGVwcyAwLjAyNSAqLworc3RhdGljIGNvbnN0IGludCBtYzEzODkyX3N3W10gPSB7CisJNjAw
MDAwLCAgIDYyNTAwMCwgIDY1MDAwMCwgIDY3NTAwMCwgIDcwMDAwMCwgIDcyNTAwMCwKKwk3NTAw
MDAsICAgNzc1MDAwLCAgODAwMDAwLCAgODI1MDAwLCAgODUwMDAwLCAgODc1MDAwLAorCTkwMDAw
MCwgICA5MjUwMDAsICA5NTAwMDAsICA5NzUwMDAsIDEwMDAwMDAsIDEwMjUwMDAsCisJMTA1MDAw
MCwgMTA3NTAwMCwgMTEwMDAwMCwgMTEyNTAwMCwgMTE1MDAwMCwgMTE3NTAwMCwKKwkxMjAwMDAw
LCAxMjI1MDAwLCAxMjUwMDAwLCAxMjc1MDAwLCAxMzAwMDAwLCAxMzI1MDAwLAorCTEzNTAwMDAs
IDEzNzUwMDAsIDE0MDAwMDAsIDE0MjUwMDAsIDE0NTAwMDAsIDE0NzUwMDAsCisJMTUwMDAwMCwg
MTUyNTAwMCwgMTU1MDAwMCwgMTU3NTAwMCwgMTYwMDAwMCwgMTYyNTAwMCwKKwkxNjUwMDAwLCAx
Njc1MDAwLCAxNzAwMDAwLCAxNzI1MDAwLCAxNzUwMDAwLCAxNzc1MDAwLAorCTE4MDAwMDAsIDE4
MjUwMDAsIDE4NTAwMDAsIDE4NzUwMDAKK307CisKK3N0YXRpYyBjb25zdCBpbnQgbWMxMzg5Ml9z
d2JzdFtdID0geworCTUwMDAwMDAsCit9OworCitzdGF0aWMgY29uc3QgaW50IG1jMTM4OTJfdmlv
aGlbXSA9IHsKKwkyNzc1MDAwLAorfTsKKworc3RhdGljIGNvbnN0IGludCBtYzEzODkyX3ZwbGxb
XSA9IHsKKwkxMDUwMDAwLCAxMjUwMDAwLCAxNjUwMDAwLCAxODAwMDAwLAorfTsKKworc3RhdGlj
IGNvbnN0IGludCBtYzEzODkyX3ZkaWdbXSA9IHsKKwkxMDUwMDAwLCAxMjUwMDAwLCAxNjUwMDAw
LCAxODAwMDAwLAorfTsKKworc3RhdGljIGNvbnN0IGludCBtYzEzODkyX3ZzZFtdID0geworCTE4
MDAwMDAsIDIwMDAwMDAsIDI2MDAwMDAsIDI3MDAwMDAsCisJMjgwMDAwMCwgMjkwMDAwMCwgMzAw
MDAwMCwgMzE1MDAwMCwKK307CisKK3N0YXRpYyBjb25zdCBpbnQgbWMxMzg5Ml92dXNiMltdID0g
eworCTI0MDAwMDAsIDI2MDAwMDAsIDI3MDAwMDAsIDI3NzUwMDAsCit9OworCitzdGF0aWMgY29u
c3QgaW50IG1jMTM4OTJfdnZpZGVvW10gPSB7CisJMjUwMDAwMCwgMjYwMDAwMCwgMjcwMDAwLCAy
Nzc1MDAwLAorfTsKKworc3RhdGljIGNvbnN0IGludCBtYzEzODkyX3ZhdWRpb1tdID0geworCTIz
MDAwMDAsIDI1MDAwMDAsIDI3NzUwMDAsIDMwMDAwMDAsCit9OworCitzdGF0aWMgY29uc3QgaW50
IG1jMTM4OTJfdmNhbVtdID0geworCTI1MDAwMDAsIDI2MDAwMDAsIDI3NTAwMDAsIDMwMDAwMDAs
Cit9OworCitzdGF0aWMgY29uc3QgaW50IG1jMTM4OTJfdmdlbjFbXSA9IHsKKwkxMjAwMDAwLCAx
NTAwMDAwLCAyNzc1MDAwLCAzMTUwMDAwLAorfTsKKworc3RhdGljIGNvbnN0IGludCBtYzEzODky
X3ZnZW4yW10gPSB7CisJMTIwMDAwMCwgMTUwMDAwMCwgMTYwMDAwMCwgMTgwMDAwMCwKKwkyNzAw
MDAwLCAyODAwMDAwLCAzMDAwMDAwLCAzMTUwMDAwLAorfTsKKworc3RhdGljIGNvbnN0IGludCBt
YzEzODkyX3ZnZW4zW10gPSB7CisJMTgwMDAwMCwgMjkwMDAwMCwKK307CisKKy8qIHRvIGNoZWNr
ICovCitzdGF0aWMgY29uc3QgaW50IG1jMTM4OTJfdnVzYltdID0geworCTMzMDAwMDAsCit9Owor
CisvKiB0byBjaGVjayAqLworc3RhdGljIGNvbnN0IGludCBtYzEzODkyX2dwb1tdID0geworCTI3
NTAwMDAsCit9OworCisvKiB0byBjaGVjayAqLworc3RhdGljIGNvbnN0IGludCBtYzEzODkyX3B3
Z3RkcnZbXSA9IHsKKwk1MDAwMDAwLAorfTsKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3Jfb3Bz
IG1jMTM4OTJfcmVndWxhdG9yX29wczsKK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX29wcyBtYzEz
ODkyX2ZpeGVkX3JlZ3VsYXRvcl9vcHM7CitzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9vcHMgbWMx
Mzg5Ml9ncG9fcmVndWxhdG9yX29wczsKKy8qIHN3IHJlZ3VsYXRvcnMgbmVlZCBzcGVjaWFsIGNh
cmUgZHVlIHRvIHRoZSAiaGkgYml0IiAqLworc3RhdGljIHN0cnVjdCByZWd1bGF0b3Jfb3BzIG1j
MTM4OTJfc3dfcmVndWxhdG9yX29wczsKKworCisjZGVmaW5lIE1DMTM4OTJfRklYRURfREVGSU5F
KG5hbWUsIHJlZywgdm9sdGFnZXMpXAorCU1DMTN4eHhfRklYRURfREVGSU5FKE1DMTM4OTJfLCBu
YW1lLCByZWcsIHZvbHRhZ2VzLCBcCisJCQltYzEzODkyX2ZpeGVkX3JlZ3VsYXRvcl9vcHMpCisK
KyNkZWZpbmUgTUMxMzg5Ml9HUE9fREVGSU5FKG5hbWUsIHJlZywgdm9sdGFnZXMpCQlcCisJTUMx
M3h4eF9HUE9fREVGSU5FKE1DMTM4OTJfLCBuYW1lLCByZWcsIHZvbHRhZ2VzLCBcCisJCQltYzEz
ODkyX2dwb19yZWd1bGF0b3Jfb3BzKQorCisjZGVmaW5lIE1DMTM4OTJfU1dfREVGSU5FKG5hbWUs
IHJlZywgdnNlbF9yZWcsIHZvbHRhZ2VzKQkJXAorCU1DMTN4eHhfREVGSU5FKE1DMTM4OTJfLCBu
YW1lLCByZWcsIHZzZWxfcmVnLCB2b2x0YWdlcywgXAorCQkJbWMxMzg5Ml9zd19yZWd1bGF0b3Jf
b3BzKQorCisjZGVmaW5lIE1DMTM4OTJfREVGSU5FX1JFR1UobmFtZSwgcmVnLCB2c2VsX3JlZywg
dm9sdGFnZXMpCQlcCisJTUMxM3h4eF9ERUZJTkUoTUMxMzg5Ml8sIG5hbWUsIHJlZywgdnNlbF9y
ZWcsIHZvbHRhZ2VzLCBcCisJCQltYzEzODkyX3JlZ3VsYXRvcl9vcHMpCisKK3N0YXRpYyBzdHJ1
Y3QgbWMxM3h4eF9yZWd1bGF0b3IgbWMxMzg5Ml9yZWd1bGF0b3JzW10gPSB7CisJTUMxMzg5Ml9E
RUZJTkVfUkVHVShWQ09JTkNFTEwsIFBPV0VSQ1RMMCwgUE9XRVJDVEwwLAkJXAorCQkJICAgIG1j
MTM4OTJfdmNvaW5jZWxsKSwKKwlNQzEzODkyX1NXX0RFRklORShTVzEsIFNXSVRDSEVSUzAsIFNX
SVRDSEVSUzAsIG1jMTM4OTJfc3cxKSwKKwlNQzEzODkyX1NXX0RFRklORShTVzIsIFNXSVRDSEVS
UzEsIFNXSVRDSEVSUzEsIG1jMTM4OTJfc3cpLAorCU1DMTM4OTJfU1dfREVGSU5FKFNXMywgU1dJ
VENIRVJTMiwgU1dJVENIRVJTMiwgbWMxMzg5Ml9zdyksCisJTUMxMzg5Ml9TV19ERUZJTkUoU1c0
LCBTV0lUQ0hFUlMzLCBTV0lUQ0hFUlMzLCBtYzEzODkyX3N3KSwKKwlNQzEzODkyX0ZJWEVEX0RF
RklORShTV0JTVCwgU1dJVENIRVJTNSwgbWMxMzg5Ml9zd2JzdCksCisJTUMxMzg5Ml9GSVhFRF9E
RUZJTkUoVklPSEksIFJFR1VMQVRPUk1PREUwLCBtYzEzODkyX3Zpb2hpKSwKKwlNQzEzODkyX0RF
RklORV9SRUdVKFZQTEwsIFJFR1VMQVRPUk1PREUwLCBSRUdVTEFUT1JTRVRUSU5HMCwJXAorCQkJ
ICAgIG1jMTM4OTJfdnBsbCksCisJTUMxMzg5Ml9ERUZJTkVfUkVHVShWRElHLCBSRUdVTEFUT1JN
T0RFMCwgUkVHVUxBVE9SU0VUVElORzAsCVwKKwkJCSAgICBtYzEzODkyX3ZkaWcpLAorCU1DMTM4
OTJfREVGSU5FX1JFR1UoVlNELCBSRUdVTEFUT1JNT0RFMSwgUkVHVUxBVE9SU0VUVElORzEsCVwK
KwkJCSAgICBtYzEzODkyX3ZzZCksCisJTUMxMzg5Ml9ERUZJTkVfUkVHVShWVVNCMiwgUkVHVUxB
VE9STU9ERTAsIFJFR1VMQVRPUlNFVFRJTkcwLAlcCisJCQkgICAgbWMxMzg5Ml92dXNiMiksCisJ
TUMxMzg5Ml9ERUZJTkVfUkVHVShWVklERU8sIFJFR1VMQVRPUk1PREUxLCBSRUdVTEFUT1JTRVRU
SU5HMSwJXAorCQkJICAgIG1jMTM4OTJfdnZpZGVvKSwKKwlNQzEzODkyX0RFRklORV9SRUdVKFZB
VURJTywgUkVHVUxBVE9STU9ERTEsIFJFR1VMQVRPUlNFVFRJTkcxLAlcCisJCQkgICAgbWMxMzg5
Ml92YXVkaW8pLAorCU1DMTM4OTJfREVGSU5FX1JFR1UoVkNBTSwgUkVHVUxBVE9STU9ERTEsIFJF
R1VMQVRPUlNFVFRJTkcwLCBcCisJCQkgICAgbWMxMzg5Ml92Y2FtKSwKKwlNQzEzODkyX0RFRklO
RV9SRUdVKFZHRU4xLCBSRUdVTEFUT1JNT0RFMCwgUkVHVUxBVE9SU0VUVElORzAsCVwKKwkJCSAg
ICBtYzEzODkyX3ZnZW4xKSwKKwlNQzEzODkyX0RFRklORV9SRUdVKFZHRU4yLCBSRUdVTEFUT1JN
T0RFMCwgUkVHVUxBVE9SU0VUVElORzAsCVwKKwkJCSAgICBtYzEzODkyX3ZnZW4yKSwKKwlNQzEz
ODkyX0RFRklORV9SRUdVKFZHRU4zLCBSRUdVTEFUT1JNT0RFMSwgUkVHVUxBVE9SU0VUVElORzAs
CVwKKwkJCSAgICBtYzEzODkyX3ZnZW4zKSwKKwlNQzEzODkyX0ZJWEVEX0RFRklORShWVVNCLCBV
U0IxLCBtYzEzODkyX3Z1c2IpLAorCU1DMTM4OTJfR1BPX0RFRklORShHUE8xLCBQT1dFUk1JU0Ms
IG1jMTM4OTJfZ3BvKSwKKwlNQzEzODkyX0dQT19ERUZJTkUoR1BPMiwgUE9XRVJNSVNDLCBtYzEz
ODkyX2dwbyksCisJTUMxMzg5Ml9HUE9fREVGSU5FKEdQTzMsIFBPV0VSTUlTQywgbWMxMzg5Ml9n
cG8pLAorCU1DMTM4OTJfR1BPX0RFRklORShHUE80LCBQT1dFUk1JU0MsIG1jMTM4OTJfZ3BvKSwK
KwlNQzEzODkyX0dQT19ERUZJTkUoUFdHVDFTUEksIFBPV0VSTUlTQywgbWMxMzg5Ml9wd2d0ZHJ2
KSwKKwlNQzEzODkyX0dQT19ERUZJTkUoUFdHVDJTUEksIFBPV0VSTUlTQywgbWMxMzg5Ml9wd2d0
ZHJ2KSwKK307CisKK3N0cnVjdCBtYzEzODkyX3JlZ3VsYXRvcl9wcml2IHsKKwlzdHJ1Y3QgbWMx
M3h4eCAqbWMxMzg5MjsKKwl1MzIgcG93ZXJtaXNjX3B3Z3Rfc3RhdGU7CisJc3RydWN0IHJlZ3Vs
YXRvcl9kZXYgKnJlZ3VsYXRvcnNbXTsKK307CisKK3N0YXRpYyBpbnQgbWMxMzg5Ml9yZWd1bGF0
b3JfZW5hYmxlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQoreworCXN0cnVjdCBtYzEzODky
X3JlZ3VsYXRvcl9wcml2ICpwcml2ID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsKKwlpbnQgaWQg
PSByZGV2X2dldF9pZChyZGV2KTsKKwlpbnQgcmV0OworCisJZGV2X2RiZyhyZGV2X2dldF9kZXYo
cmRldiksICIlcyBpZDogJWRcbiIsIF9fZnVuY19fLCBpZCk7CisKKwltYzEzeHh4X2xvY2socHJp
di0+bWMxMzg5Mik7CisJcmV0ID0gbWMxMzg5Ml9yZWdfcm13KHByaXYtPm1jMTM4OTIsIG1jMTM4
OTJfcmVndWxhdG9yc1tpZF0ucmVnLAorCQkJbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS5lbmFibGVf
Yml0LAorCQkJbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS5lbmFibGVfYml0KTsKKwltYzEzeHh4X3Vu
bG9jayhwcml2LT5tYzEzODkyKTsKKworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgbWMx
Mzg5Ml9yZWd1bGF0b3JfZGlzYWJsZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldikKK3sKKwlz
dHJ1Y3QgbWMxMzg5Ml9yZWd1bGF0b3JfcHJpdiAqcHJpdiA9IHJkZXZfZ2V0X2RydmRhdGEocmRl
dik7CisJaW50IGlkID0gcmRldl9nZXRfaWQocmRldik7CisJaW50IHJldDsKKworCWRldl9kYmco
cmRldl9nZXRfZGV2KHJkZXYpLCAiJXMgaWQ6ICVkXG4iLCBfX2Z1bmNfXywgaWQpOworCisJbWMx
M3h4eF9sb2NrKHByaXYtPm1jMTM4OTIpOworCXJldCA9IG1jMTM4OTJfcmVnX3Jtdyhwcml2LT5t
YzEzODkyLCBtYzEzODkyX3JlZ3VsYXRvcnNbaWRdLnJlZywKKwkJCW1jMTM4OTJfcmVndWxhdG9y
c1tpZF0uZW5hYmxlX2JpdCwgMCk7CisJbWMxM3h4eF91bmxvY2socHJpdi0+bWMxMzg5Mik7CisK
KwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IG1jMTM4OTJfcmVndWxhdG9yX2lzX2VuYWJs
ZWQoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYpCit7CisJc3RydWN0IG1jMTM4OTJfcmVndWxh
dG9yX3ByaXYgKnByaXYgPSByZGV2X2dldF9kcnZkYXRhKHJkZXYpOworCWludCByZXQsIGlkID0g
cmRldl9nZXRfaWQocmRldik7CisJdW5zaWduZWQgaW50IHZhbDsKKworCW1jMTN4eHhfbG9jayhw
cml2LT5tYzEzODkyKTsKKwlyZXQgPSBtYzEzODkyX3JlZ19yZWFkKHByaXYtPm1jMTM4OTIsIG1j
MTM4OTJfcmVndWxhdG9yc1tpZF0ucmVnLCAmdmFsKTsKKwltYzEzeHh4X3VubG9jayhwcml2LT5t
YzEzODkyKTsKKworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlyZXR1cm4gKHZhbCAmIG1j
MTM4OTJfcmVndWxhdG9yc1tpZF0uZW5hYmxlX2JpdCkgIT0gMDsKK30KKworc3RhdGljIGludCBt
YzEzODkyX3JlZ3VsYXRvcl9saXN0X3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYs
CisJCQkJCQl1bnNpZ25lZCBzZWxlY3RvcikKK3sKKwlpbnQgaWQgPSByZGV2X2dldF9pZChyZGV2
KTsKKworCWlmIChzZWxlY3RvciA+PSBtYzEzODkyX3JlZ3VsYXRvcnNbaWRdLmRlc2Mubl92b2x0
YWdlcykKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlyZXR1cm4gbWMxMzg5Ml9yZWd1bGF0b3JzW2lk
XS52b2x0YWdlc1tzZWxlY3Rvcl07Cit9CisKK3N0YXRpYyBpbnQgbWMxMzg5Ml9nZXRfYmVzdF92
b2x0YWdlX2luZGV4KHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LAorCQkJCQkJaW50IG1pbl91
ViwgaW50IG1heF91VikKK3sKKwlpbnQgcmVnX2lkID0gcmRldl9nZXRfaWQocmRldik7CisJaW50
IGk7CisJaW50IGJlc3RtYXRjaDsKKwlpbnQgYmVzdGluZGV4OworCisJLyoKKwkgKiBMb2NhdGUg
dGhlIG1pbmltdW0gdm9sdGFnZSBmaXR0aW5nIHRoZSBjcml0ZXJpYSBvbgorCSAqIHRoaXMgcmVn
dWxhdG9yLiBUaGUgc3dpdGNoYWJsZSB2b2x0YWdlcyBhcmUgbm90CisJICogaW4gc3RyaWN0IGZh
bGxpbmcgb3JkZXIgc28gd2UgbmVlZCB0byBjaGVjayB0aGVtCisJICogYWxsIGZvciB0aGUgYmVz
dCBtYXRjaC4KKwkgKi8KKwliZXN0bWF0Y2ggPSBJTlRfTUFYOworCWJlc3RpbmRleCA9IC0xOwor
CWZvciAoaSA9IDA7IGkgPCBtYzEzODkyX3JlZ3VsYXRvcnNbcmVnX2lkXS5kZXNjLm5fdm9sdGFn
ZXM7IGkrKykgeworCQlpZiAobWMxMzg5Ml9yZWd1bGF0b3JzW3JlZ19pZF0udm9sdGFnZXNbaV0g
Pj0gbWluX3VWICYmCisJCSAgICBtYzEzODkyX3JlZ3VsYXRvcnNbcmVnX2lkXS52b2x0YWdlc1tp
XSA8IGJlc3RtYXRjaCkgeworCQkJYmVzdG1hdGNoID0gbWMxMzg5Ml9yZWd1bGF0b3JzW3JlZ19p
ZF0udm9sdGFnZXNbaV07CisJCQliZXN0aW5kZXggPSBpOworCQl9CisJfQorCisJaWYgKGJlc3Rp
bmRleCA8IDAgfHwgYmVzdG1hdGNoID4gbWF4X3VWKSB7CisJCWRldl93YXJuKCZyZGV2LT5kZXYs
ICJubyBwb3NzaWJsZSB2YWx1ZSBmb3IgJWQ8PXg8PSVkIHVWXG4iLAorCQkJCW1pbl91ViwgbWF4
X3VWKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCXJldHVybiBiZXN0aW5kZXg7Cit9CisKK3N0
YXRpYyBpbnQgbWMxMzg5Ml9yZWd1bGF0b3Jfc2V0X3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9k
ZXYgKnJkZXYsCisJCQkJCQlpbnQgbWluX3VWLCBpbnQgbWF4X3VWKQoreworCXN0cnVjdCBtYzEz
ODkyX3JlZ3VsYXRvcl9wcml2ICpwcml2ID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsKKwlpbnQg
dmFsdWUsIGlkID0gcmRldl9nZXRfaWQocmRldik7CisJaW50IHJldDsKKworCWRldl9kYmcocmRl
dl9nZXRfZGV2KHJkZXYpLCAiJXMgaWQ6ICVkIG1pbl91VjogJWQgbWF4X3VWOiAlZFxuIiwKKwkJ
X19mdW5jX18sIGlkLCBtaW5fdVYsIG1heF91Vik7CisKKwkvKiBGaW5kIHRoZSBiZXN0IGluZGV4
ICovCisJdmFsdWUgPSBtYzEzODkyX2dldF9iZXN0X3ZvbHRhZ2VfaW5kZXgocmRldiwgbWluX3VW
LCBtYXhfdVYpOworCWRldl9kYmcocmRldl9nZXRfZGV2KHJkZXYpLCAiJXMgYmVzdCB2YWx1ZTog
JWRcbiIsIF9fZnVuY19fLCB2YWx1ZSk7CisJaWYgKHZhbHVlIDwgMCkKKwkJcmV0dXJuIHZhbHVl
OworCisJbWMxM3h4eF9sb2NrKHByaXYtPm1jMTM4OTIpOworCXJldCA9IG1jMTM4OTJfcmVnX3Jt
dyhwcml2LT5tYzEzODkyLCBtYzEzODkyX3JlZ3VsYXRvcnNbaWRdLnZzZWxfcmVnLAorCQkJbWMx
Mzg5Ml9yZWd1bGF0b3JzW2lkXS52c2VsX21hc2ssCisJCQl2YWx1ZSA8PCBtYzEzODkyX3JlZ3Vs
YXRvcnNbaWRdLnZzZWxfc2hpZnQpOworCW1jMTN4eHhfdW5sb2NrKHByaXYtPm1jMTM4OTIpOwor
CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCBtYzEzODkyX3JlZ3VsYXRvcl9nZXRfdm9s
dGFnZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldikKK3sKKwlzdHJ1Y3QgbWMxMzg5Ml9yZWd1
bGF0b3JfcHJpdiAqcHJpdiA9IHJkZXZfZ2V0X2RydmRhdGEocmRldik7CisJaW50IHJldCwgaWQg
PSByZGV2X2dldF9pZChyZGV2KTsKKwl1bnNpZ25lZCBpbnQgdmFsOworCisJZGV2X2RiZyhyZGV2
X2dldF9kZXYocmRldiksICIlcyBpZDogJWRcbiIsIF9fZnVuY19fLCBpZCk7CisKKwltYzEzeHh4
X2xvY2socHJpdi0+bWMxMzg5Mik7CisJcmV0ID0gbWMxMzg5Ml9yZWdfcmVhZChwcml2LT5tYzEz
ODkyLAorCQkJCW1jMTM4OTJfcmVndWxhdG9yc1tpZF0udnNlbF9yZWcsICZ2YWwpOworCW1jMTN4
eHhfdW5sb2NrKHByaXYtPm1jMTM4OTIpOworCisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwor
CXZhbCA9ICh2YWwgJiBtYzEzODkyX3JlZ3VsYXRvcnNbaWRdLnZzZWxfbWFzaykKKwkJPj4gbWMx
Mzg5Ml9yZWd1bGF0b3JzW2lkXS52c2VsX3NoaWZ0OworCisJZGV2X2RiZyhyZGV2X2dldF9kZXYo
cmRldiksICIlcyBpZDogJWQgdmFsOiAlZFxuIiwgX19mdW5jX18sIGlkLCB2YWwpOworCisJQlVH
X09OKHZhbCA8IDAgfHwgdmFsID4gbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS5kZXNjLm5fdm9sdGFn
ZXMpOworCisJcmV0dXJuIG1jMTM4OTJfcmVndWxhdG9yc1tpZF0udm9sdGFnZXNbdmFsXTsKK30K
Kworc3RhdGljIHN0cnVjdCByZWd1bGF0b3Jfb3BzIG1jMTM4OTJfcmVndWxhdG9yX29wcyA9IHsK
KwkuZW5hYmxlID0gbWMxMzg5Ml9yZWd1bGF0b3JfZW5hYmxlLAorCS5kaXNhYmxlID0gbWMxMzg5
Ml9yZWd1bGF0b3JfZGlzYWJsZSwKKwkuaXNfZW5hYmxlZCA9IG1jMTM4OTJfcmVndWxhdG9yX2lz
X2VuYWJsZWQsCisJLmxpc3Rfdm9sdGFnZSA9IG1jMTM4OTJfcmVndWxhdG9yX2xpc3Rfdm9sdGFn
ZSwKKwkuc2V0X3ZvbHRhZ2UgPSBtYzEzODkyX3JlZ3VsYXRvcl9zZXRfdm9sdGFnZSwKKwkuZ2V0
X3ZvbHRhZ2UgPSBtYzEzODkyX3JlZ3VsYXRvcl9nZXRfdm9sdGFnZSwKK307CisKK3N0YXRpYyBp
bnQgbWMxMzg5Ml9maXhlZF9yZWd1bGF0b3Jfc2V0X3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9k
ZXYgKnJkZXYsCisJCQkJCQlpbnQgbWluX3VWLCBpbnQgbWF4X3VWKQoreworCWludCBpZCA9IHJk
ZXZfZ2V0X2lkKHJkZXYpOworCisJZGV2X2RiZyhyZGV2X2dldF9kZXYocmRldiksICIlcyBpZDog
JWQgbWluX3VWOiAlZCBtYXhfdVY6ICVkXG4iLAorCQlfX2Z1bmNfXywgaWQsIG1pbl91ViwgbWF4
X3VWKTsKKworCWlmIChtaW5fdVYgPj0gbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS52b2x0YWdlc1sw
XSAmJgorCSAgICBtYXhfdVYgPD0gbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS52b2x0YWdlc1swXSkK
KwkJcmV0dXJuIDA7CisJZWxzZQorCQlyZXR1cm4gLUVJTlZBTDsKK30KKworc3RhdGljIGludCBt
YzEzODkyX2ZpeGVkX3JlZ3VsYXRvcl9nZXRfdm9sdGFnZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAq
cmRldikKK3sKKwlpbnQgaWQgPSByZGV2X2dldF9pZChyZGV2KTsKKworCWRldl9kYmcocmRldl9n
ZXRfZGV2KHJkZXYpLCAiJXMgaWQ6ICVkXG4iLCBfX2Z1bmNfXywgaWQpOworCisJcmV0dXJuIG1j
MTM4OTJfcmVndWxhdG9yc1tpZF0udm9sdGFnZXNbMF07Cit9CisKK3N0YXRpYyBzdHJ1Y3QgcmVn
dWxhdG9yX29wcyBtYzEzODkyX2ZpeGVkX3JlZ3VsYXRvcl9vcHMgPSB7CisJLmVuYWJsZSA9IG1j
MTM4OTJfcmVndWxhdG9yX2VuYWJsZSwKKwkuZGlzYWJsZSA9IG1jMTM4OTJfcmVndWxhdG9yX2Rp
c2FibGUsCisJLmlzX2VuYWJsZWQgPSBtYzEzODkyX3JlZ3VsYXRvcl9pc19lbmFibGVkLAorCS5s
aXN0X3ZvbHRhZ2UgPSBtYzEzODkyX3JlZ3VsYXRvcl9saXN0X3ZvbHRhZ2UsCisJLnNldF92b2x0
YWdlID0gbWMxMzg5Ml9maXhlZF9yZWd1bGF0b3Jfc2V0X3ZvbHRhZ2UsCisJLmdldF92b2x0YWdl
ID0gbWMxMzg5Ml9maXhlZF9yZWd1bGF0b3JfZ2V0X3ZvbHRhZ2UsCit9OworCitpbnQgbWMxMzg5
Ml9wb3dlcm1pc2Nfcm13KHN0cnVjdCBtYzEzODkyX3JlZ3VsYXRvcl9wcml2ICpwcml2LCB1MzIg
bWFzaywKKwkJCQkJCQkJCXUzMiB2YWwpCit7CisJc3RydWN0IG1jMTN4eHggKm1jMTM4OTIgPSBw
cml2LT5tYzEzODkyOworCWludCByZXQ7CisJdTMyIHZhbHJlYWQ7CisKKwlCVUdfT04odmFsICYg
fm1hc2spOworCisJcmV0ID0gbWMxMzg5Ml9yZWdfcmVhZChtYzEzODkyLCBNQzEzODkyX1BPV0VS
TUlTQywgJnZhbHJlYWQpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwkvKiBVcGRhdGUg
dGhlIHN0b3JlZCBzdGF0ZSBmb3IgUG93ZXIgR2F0ZXMuICovCisJcHJpdi0+cG93ZXJtaXNjX3B3
Z3Rfc3RhdGUgPQorCQkJCShwcml2LT5wb3dlcm1pc2NfcHdndF9zdGF0ZSAmIH5tYXNrKSB8IHZh
bDsKKwlwcml2LT5wb3dlcm1pc2NfcHdndF9zdGF0ZSAmPSBNQzEzODkyX1BPV0VSTUlTQ19QV0dU
U1BJX007CisKKwkvKiBDb25zdHJ1Y3QgdGhlIG5ldyByZWdpc3RlciB2YWx1ZSAqLworCXZhbHJl
YWQgPSAodmFscmVhZCAmIH5tYXNrKSB8IHZhbDsKKwkvKiBPdmVyd3JpdGUgdGhlIFBXR1R4RU4g
d2l0aCB0aGUgc3RvcmVkIHZlcnNpb24gKi8KKwl2YWxyZWFkID0gKHZhbHJlYWQgJiB+TUMxMzg5
Ml9QT1dFUk1JU0NfUFdHVFNQSV9NKSB8CisJCQkJCQlwcml2LT5wb3dlcm1pc2NfcHdndF9zdGF0
ZTsKKworCXJldHVybiBtYzEzODkyX3JlZ193cml0ZShtYzEzODkyLCBNQzEzODkyX1BPV0VSTUlT
QywgdmFscmVhZCk7Cit9CisKK3N0YXRpYyBpbnQgbWMxMzg5Ml9ncG9fcmVndWxhdG9yX2VuYWJs
ZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldikKK3sKKwlzdHJ1Y3QgbWMxMzg5Ml9yZWd1bGF0
b3JfcHJpdiAqcHJpdiA9IHJkZXZfZ2V0X2RydmRhdGEocmRldik7CisJaW50IGlkID0gcmRldl9n
ZXRfaWQocmRldik7CisJaW50IHJldDsKKwl1MzIgZW5fdmFsID0gbWMxMzg5Ml9yZWd1bGF0b3Jz
W2lkXS5lbmFibGVfYml0OworCXUzMiBtYXNrID0gbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS5lbmFi
bGVfYml0OworCisJZGV2X2RiZyhyZGV2X2dldF9kZXYocmRldiksICIlcyBpZDogJWRcbiIsIF9f
ZnVuY19fLCBpZCk7CisKKwkvKiBQb3dlciBHYXRlIGVuYWJsZSB2YWx1ZSBpcyAwICovCisJaWYg
KGlkID09IE1DMTM4OTJfUFdHVDFTUEkgfHwKKwkgICAgaWQgPT0gTUMxMzg5Ml9QV0dUMlNQSSkK
KwkJZW5fdmFsID0gMDsKKworCWlmIChpZCA9PSBNQzEzODkyX0dQTzQpCisJCW1hc2sgfD0gTUMx
Mzg5Ml9QT1dFUk1JU0NfR1BPNEFESU5FTjsKKworCW1jMTN4eHhfbG9jayhwcml2LT5tYzEzODky
KTsKKwlyZXQgPSBtYzEzODkyX3Bvd2VybWlzY19ybXcocHJpdiwgbWFzaywgZW5fdmFsKTsKKwlt
YzEzeHh4X3VubG9jayhwcml2LT5tYzEzODkyKTsKKworCXJldHVybiByZXQ7Cit9CisKK3N0YXRp
YyBpbnQgbWMxMzg5Ml9ncG9fcmVndWxhdG9yX2Rpc2FibGUoc3RydWN0IHJlZ3VsYXRvcl9kZXYg
KnJkZXYpCit7CisJc3RydWN0IG1jMTM4OTJfcmVndWxhdG9yX3ByaXYgKnByaXYgPSByZGV2X2dl
dF9kcnZkYXRhKHJkZXYpOworCWludCBpZCA9IHJkZXZfZ2V0X2lkKHJkZXYpOworCWludCByZXQ7
CisJdTMyIGRpc192YWwgPSAwOworCisJZGV2X2RiZyhyZGV2X2dldF9kZXYocmRldiksICIlcyBp
ZDogJWRcbiIsIF9fZnVuY19fLCBpZCk7CisKKwkvKiBQb3dlciBHYXRlIGRpc2FibGUgdmFsdWUg
aXMgMSAqLworCWlmIChpZCA9PSBNQzEzODkyX1BXR1QxU1BJIHx8CisJICAgIGlkID09IE1DMTM4
OTJfUFdHVDJTUEkpCisJCWRpc192YWwgPSBtYzEzODkyX3JlZ3VsYXRvcnNbaWRdLmVuYWJsZV9i
aXQ7CisKKwltYzEzeHh4X2xvY2socHJpdi0+bWMxMzg5Mik7CisJcmV0ID0gbWMxMzg5Ml9wb3dl
cm1pc2Nfcm13KHByaXYsIG1jMTM4OTJfcmVndWxhdG9yc1tpZF0uZW5hYmxlX2JpdCwKKwkJCQkJ
ZGlzX3ZhbCk7CisJbWMxM3h4eF91bmxvY2socHJpdi0+bWMxMzg5Mik7CisKKwlyZXR1cm4gcmV0
OworfQorCitzdGF0aWMgaW50IG1jMTM4OTJfZ3BvX3JlZ3VsYXRvcl9pc19lbmFibGVkKHN0cnVj
dCByZWd1bGF0b3JfZGV2ICpyZGV2KQoreworCXN0cnVjdCBtYzEzODkyX3JlZ3VsYXRvcl9wcml2
ICpwcml2ID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsKKwlpbnQgcmV0LCBpZCA9IHJkZXZfZ2V0
X2lkKHJkZXYpOworCXVuc2lnbmVkIGludCB2YWw7CisKKwltYzEzeHh4X2xvY2socHJpdi0+bWMx
Mzg5Mik7CisJcmV0ID0gbWMxMzg5Ml9yZWdfcmVhZChwcml2LT5tYzEzODkyLCBtYzEzODkyX3Jl
Z3VsYXRvcnNbaWRdLnJlZywgJnZhbCk7CisJbWMxM3h4eF91bmxvY2socHJpdi0+bWMxMzg5Mik7
CisKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJLyogUG93ZXIgR2F0ZXMgc3RhdGUgaXMg
c3RvcmVkIGluIHBvd2VybWlzY19wd2d0X3N0YXRlCisJICogd2hlcmUgdGhlIG1lYW5pbmcgb2Yg
Yml0cyBpcyBuZWdhdGVkICovCisJdmFsID0gKHZhbCAmIH5NQzEzODkyX1BPV0VSTUlTQ19QV0dU
U1BJX00pIHwKKwkgICAgICAocHJpdi0+cG93ZXJtaXNjX3B3Z3Rfc3RhdGUgXiBNQzEzODkyX1BP
V0VSTUlTQ19QV0dUU1BJX00pOworCisJcmV0dXJuICh2YWwgJiBtYzEzODkyX3JlZ3VsYXRvcnNb
aWRdLmVuYWJsZV9iaXQpICE9IDA7Cit9CisKKworc3RhdGljIHN0cnVjdCByZWd1bGF0b3Jfb3Bz
IG1jMTM4OTJfZ3BvX3JlZ3VsYXRvcl9vcHMgPSB7CisJLmVuYWJsZSA9IG1jMTM4OTJfZ3BvX3Jl
Z3VsYXRvcl9lbmFibGUsCisJLmRpc2FibGUgPSBtYzEzODkyX2dwb19yZWd1bGF0b3JfZGlzYWJs
ZSwKKwkuaXNfZW5hYmxlZCA9IG1jMTM4OTJfZ3BvX3JlZ3VsYXRvcl9pc19lbmFibGVkLAorCS5s
aXN0X3ZvbHRhZ2UgPSBtYzEzODkyX3JlZ3VsYXRvcl9saXN0X3ZvbHRhZ2UsCisJLnNldF92b2x0
YWdlID0gbWMxMzg5Ml9maXhlZF9yZWd1bGF0b3Jfc2V0X3ZvbHRhZ2UsCisJLmdldF92b2x0YWdl
ID0gbWMxMzg5Ml9maXhlZF9yZWd1bGF0b3JfZ2V0X3ZvbHRhZ2UsCit9OworCitzdGF0aWMgaW50
IG1jMTM4OTJfdmNhbV9zZXRfbW9kZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldiwgdW5zaWdu
ZWQgaW50IG1vZGUpCit7CisJdW5zaWduZWQgaW50IGVuX3ZhbCA9IDA7CisJc3RydWN0IG1jMTM4
OTJfcmVndWxhdG9yX3ByaXYgKnByaXYgPSByZGV2X2dldF9kcnZkYXRhKHJkZXYpOworCWludCBy
ZXQsIGlkID0gcmRldl9nZXRfaWQocmRldik7CisKKwlpZiAobW9kZSA9PSBSRUdVTEFUT1JfTU9E
RV9GQVNUKQorCQllbl92YWwgPSBNQzEzODkyX1JFR1VMQVRPUk1PREUxX1ZDQU1DT05GSUdFTjsK
KworCW1jMTN4eHhfbG9jayhwcml2LT5tYzEzODkyKTsKKwlyZXQgPSBtYzEzODkyX3JlZ19ybXco
cHJpdi0+bWMxMzg5MiwgbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS5yZWcsCisJCQlNQzEzODkyX1JF
R1VMQVRPUk1PREUxX1ZDQU1DT05GSUdFTiwKKwkJCWVuX3ZhbCk7CisJbWMxM3h4eF91bmxvY2so
cHJpdi0+bWMxMzg5Mik7CisKKwlyZXR1cm4gcmV0OworfQorCit1bnNpZ25lZCBpbnQgbWMxMzg5
Ml92Y2FtX2dldF9tb2RlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQoreworCXN0cnVjdCBt
YzEzODkyX3JlZ3VsYXRvcl9wcml2ICpwcml2ID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsKKwlp
bnQgcmV0LCBpZCA9IHJkZXZfZ2V0X2lkKHJkZXYpOworCXVuc2lnbmVkIGludCB2YWw7CisKKwlt
YzEzeHh4X2xvY2socHJpdi0+bWMxMzg5Mik7CisJcmV0ID0gbWMxMzg5Ml9yZWdfcmVhZChwcml2
LT5tYzEzODkyLCBtYzEzODkyX3JlZ3VsYXRvcnNbaWRdLnJlZywgJnZhbCk7CisJbWMxM3h4eF91
bmxvY2socHJpdi0+bWMxMzg5Mik7CisKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJaWYg
KHZhbCAmIE1DMTM4OTJfUkVHVUxBVE9STU9ERTFfVkNBTUNPTkZJR0VOKQorCQlyZXR1cm4gUkVH
VUxBVE9SX01PREVfRkFTVDsKKworCXJldHVybiBSRUdVTEFUT1JfTU9ERV9OT1JNQUw7Cit9CisK
K3N0YXRpYyBpbnQgbWMxMzg5Ml9zd19yZWd1bGF0b3Ioc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJk
ZXYpCit7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgbWMxMzg5Ml9zd19yZWd1bGF0b3Jf
aXNfZW5hYmxlZChzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldikKK3sKKwlyZXR1cm4gMTsKK30K
Kworc3RhdGljIGludCBtYzEzODkyX3N3X3JlZ3VsYXRvcl9nZXRfdm9sdGFnZShzdHJ1Y3QgcmVn
dWxhdG9yX2RldiAqcmRldikKK3sKKwlzdHJ1Y3QgbWMxMzg5Ml9yZWd1bGF0b3JfcHJpdiAqcHJp
diA9IHJkZXZfZ2V0X2RydmRhdGEocmRldik7CisJaW50IHJldCwgaWQgPSByZGV2X2dldF9pZChy
ZGV2KTsKKwl1bnNpZ25lZCBpbnQgdmFsLCBoaTsKKworCWRldl9kYmcocmRldl9nZXRfZGV2KHJk
ZXYpLCAiJXMgaWQ6ICVkXG4iLCBfX2Z1bmNfXywgaWQpOworCisJbWMxM3h4eF9sb2NrKHByaXYt
Pm1jMTM4OTIpOworCXJldCA9IG1jMTM4OTJfcmVnX3JlYWQocHJpdi0+bWMxMzg5MiwKKwkJCQlt
YzEzODkyX3JlZ3VsYXRvcnNbaWRdLnZzZWxfcmVnLCAmdmFsKTsKKwltYzEzeHh4X3VubG9jayhw
cml2LT5tYzEzODkyKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJaGkgID0gdmFsICYg
TUMxMzg5Ml9TV0lUQ0hFUlMwX1NXeEhJOworCXZhbCA9ICh2YWwgJiBtYzEzODkyX3JlZ3VsYXRv
cnNbaWRdLnZzZWxfbWFzaykKKwkJPj4gbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS52c2VsX3NoaWZ0
OworCisJZGV2X2RiZyhyZGV2X2dldF9kZXYocmRldiksICIlcyBpZDogJWQgdmFsOiAlZFxuIiwg
X19mdW5jX18sIGlkLCB2YWwpOworCisJaWYgKGhpKQorCQl2YWwgPSAoMjUwMDAgKiB2YWwpICsg
MTEwMDAwMDsKKwllbHNlCisJCXZhbCA9ICgyNTAwMCAqIHZhbCkgKyA2MDAwMDA7CisKKwlyZXR1
cm4gdmFsOworfQorCitzdGF0aWMgaW50IG1jMTM4OTJfc3dfcmVndWxhdG9yX3NldF92b2x0YWdl
KHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LAorCQkJCQkJaW50IG1pbl91ViwgaW50IG1heF91
VikKK3sKKwlzdHJ1Y3QgbWMxMzg5Ml9yZWd1bGF0b3JfcHJpdiAqcHJpdiA9IHJkZXZfZ2V0X2Ry
dmRhdGEocmRldik7CisJaW50IGhpLCB2YWx1ZSwgdmFsLCBtYXNrLCBpZCA9IHJkZXZfZ2V0X2lk
KHJkZXYpOworCWludCByZXQ7CisKKwlkZXZfZGJnKHJkZXZfZ2V0X2RldihyZGV2KSwgIiVzIGlk
OiAlZCBtaW5fdVY6ICVkIG1heF91VjogJWRcbiIsCisJCV9fZnVuY19fLCBpZCwgbWluX3VWLCBt
YXhfdVYpOworCisJLyogRmluZCB0aGUgYmVzdCBpbmRleCAqLworCXZhbHVlID0gbWMxMzg5Ml9n
ZXRfYmVzdF92b2x0YWdlX2luZGV4KHJkZXYsIG1pbl91ViwgbWF4X3VWKTsKKwlkZXZfZGJnKHJk
ZXZfZ2V0X2RldihyZGV2KSwgIiVzIGJlc3QgdmFsdWU6ICVkXG4iLCBfX2Z1bmNfXywgdmFsdWUp
OworCWlmICh2YWx1ZSA8IDApCisJCXJldHVybiB2YWx1ZTsKKworCXZhbHVlID0gbWMxMzg5Ml9y
ZWd1bGF0b3JzW2lkXS52b2x0YWdlc1t2YWx1ZV07CisKKwltYzEzeHh4X2xvY2socHJpdi0+bWMx
Mzg5Mik7CisJcmV0ID0gbWMxMzg5Ml9yZWdfcmVhZChwcml2LT5tYzEzODkyLAorCQkJCW1jMTM4
OTJfcmVndWxhdG9yc1tpZF0udnNlbF9yZWcsICZ2YWwpOworCW1jMTN4eHhfdW5sb2NrKHByaXYt
Pm1jMTM4OTIpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwloaSAgPSB2YWwgJiBNQzEz
ODkyX1NXSVRDSEVSUzBfU1d4SEk7CisJaWYgKHZhbHVlID4gMTM3NSkKKwkJaGkgPSAxOworCWlm
ICh2YWx1ZSA8IDExMDApCisJCWhpID0gMDsKKworCWlmIChoaSkgeworCQl2YWx1ZSA9ICh2YWx1
ZSAtIDExMDAwMDApIC8gMjUwMDA7CisJCXZhbHVlIHw9IE1DMTM4OTJfU1dJVENIRVJTMF9TV3hI
STsKKwl9IGVsc2UKKwkJdmFsdWUgPSAodmFsdWUgLSA2MDAwMDApIC8gMjUwMDA7CisKKwltYXNr
ID0gbWMxMzg5Ml9yZWd1bGF0b3JzW2lkXS52c2VsX21hc2sgfCBNQzEzODkyX1NXSVRDSEVSUzBf
U1d4SEk7CisJbWMxM3h4eF9sb2NrKHByaXYtPm1jMTM4OTIpOworCXJldCA9IG1jMTM4OTJfcmVn
X3Jtdyhwcml2LT5tYzEzODkyLCBtYzEzODkyX3JlZ3VsYXRvcnNbaWRdLnZzZWxfcmVnLAorCQkJ
bWFzaywKKwkJCXZhbHVlIDw8IG1jMTM4OTJfcmVndWxhdG9yc1tpZF0udnNlbF9zaGlmdCk7CisJ
bWMxM3h4eF91bmxvY2socHJpdi0+bWMxMzg5Mik7CisKKwlyZXR1cm4gcmV0OworfQorCitzdGF0
aWMgc3RydWN0IHJlZ3VsYXRvcl9vcHMgbWMxMzg5Ml9zd19yZWd1bGF0b3Jfb3BzID0geworCS5l
bmFibGUgPSBtYzEzODkyX3N3X3JlZ3VsYXRvciwKKwkuZGlzYWJsZSA9IG1jMTM4OTJfc3dfcmVn
dWxhdG9yLAorCS5pc19lbmFibGVkID0gbWMxMzg5Ml9zd19yZWd1bGF0b3JfaXNfZW5hYmxlZCwK
KwkubGlzdF92b2x0YWdlID0gbWMxMzg5Ml9yZWd1bGF0b3JfbGlzdF92b2x0YWdlLAorCS5zZXRf
dm9sdGFnZSA9IG1jMTM4OTJfc3dfcmVndWxhdG9yX3NldF92b2x0YWdlLAorCS5nZXRfdm9sdGFn
ZSA9IG1jMTM4OTJfc3dfcmVndWxhdG9yX2dldF92b2x0YWdlLAorfTsKKworCitzdGF0aWMgaW50
IF9fZGV2aW5pdCBtYzEzODkyX3JlZ3VsYXRvcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQoreworCXN0cnVjdCBtYzEzODkyX3JlZ3VsYXRvcl9wcml2ICpwcml2OworCXN0cnVj
dCBtYzEzeHh4ICptYzEzODkyID0gZGV2X2dldF9kcnZkYXRhKHBkZXYtPmRldi5wYXJlbnQpOwor
CXN0cnVjdCBtYzEzeHh4X3JlZ3VsYXRvcl9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9CisJCWRldl9n
ZXRfcGxhdGRhdGEoJnBkZXYtPmRldik7CisJc3RydWN0IG1jMTN4eHhfcmVndWxhdG9yX2luaXRf
ZGF0YSAqaW5pdF9kYXRhOworCWludCBpLCByZXQ7CisJdTMyIHZhbDsKKworCXByaXYgPSBremFs
bG9jKHNpemVvZigqcHJpdikgKworCQkJcGRhdGEtPm51bV9yZWd1bGF0b3JzICogc2l6ZW9mKHBy
aXYtPnJlZ3VsYXRvcnNbMF0pLAorCQkJR0ZQX0tFUk5FTCk7CisJaWYgKCFwcml2KQorCQlyZXR1
cm4gLUVOT01FTTsKKworCXByaXYtPm1jMTM4OTIgPSBtYzEzODkyOworCisJbWMxM3h4eF9sb2Nr
KG1jMTM4OTIpOworCXJldCA9IG1jMTM4OTJfcmVnX3JlYWQobWMxMzg5MiwgTUMxMzg5Ml9SRVZJ
U0lPTiwgJnZhbCk7CisJbWMxM3h4eF91bmxvY2sobWMxMzg5Mik7CisJaWYgKHJldCkKKwkJZ290
byBlcnJfYWxsb2M7CisKKwkvKiBlbmFibGUgc3dpdGNoIGF1dG8gbW9kZSAtIEVOR1IwMDEyMDUx
MCwgRU5HUjAwMTIxMDU3ICovCisJLyogbm8gZG9jIHdpdGggcmVncyBkZXNjcmlwdGlvbiBtZWFu
cyBubyB3YXkgdG8ga25vdyBpZiAqLworCS8qIHRoZXJlJ3MgYSBiZXR0ZXIgd2F5IHRvIGRvIGl0
CQkJKi8KKwlpZiAoKHZhbCAmIDB4MDAwMEZGRkYpID09IDB4NDVkMCkgeworCQltYzEzeHh4X2xv
Y2sobWMxMzg5Mik7CisJCXJldCA9IG1jMTM4OTJfcmVnX3JtdyhtYzEzODkyLCBNQzEzODkyX1NX
SVRDSEVSUzQsCisJCQlNQzEzODkyX1NXSVRDSEVSUzRfU1cxTU9ERV9NIHwKKwkJCU1DMTM4OTJf
U1dJVENIRVJTNF9TVzJNT0RFX00sCisJCQlNQzEzODkyX1NXSVRDSEVSUzRfU1cxTU9ERV9BVVRP
IHwKKwkJCU1DMTM4OTJfU1dJVENIRVJTNF9TVzJNT0RFX0FVVE8pOworCQltYzEzeHh4X3VubG9j
ayhtYzEzODkyKTsKKwkJaWYgKHJldCkKKwkJCWdvdG8gZXJyX2FsbG9jOworCisJCW1jMTN4eHhf
bG9jayhtYzEzODkyKTsKKwkJbWMxMzg5Ml9yZWdfcm13KG1jMTM4OTIsIE1DMTM4OTJfU1dJVENI
RVJTNSwKKwkJCU1DMTM4OTJfU1dJVENIRVJTNV9TVzNNT0RFX00gfAorCQkJTUMxMzg5Ml9TV0lU
Q0hFUlM1X1NXNE1PREVfTSwKKwkJCU1DMTM4OTJfU1dJVENIRVJTNV9TVzNNT0RFX0FVVE8gfAor
CQkJTUMxMzg5Ml9TV0lUQ0hFUlM1X1NXNE1PREVfQVVUTyk7CisJCW1jMTN4eHhfdW5sb2NrKG1j
MTM4OTIpOworCQlpZiAocmV0KQorCQkJZ290byBlcnJfYWxsb2M7CisJfQorCisJbWMxMzg5Ml9y
ZWd1bGF0b3JzW01DMTM4OTJfVkNBTV0uZGVzYy5vcHMtPnNldF9tb2RlCisJCT0gbWMxMzg5Ml92
Y2FtX3NldF9tb2RlOworCW1jMTM4OTJfcmVndWxhdG9yc1tNQzEzODkyX1ZDQU1dLmRlc2Mub3Bz
LT5nZXRfbW9kZQorCQk9IG1jMTM4OTJfdmNhbV9nZXRfbW9kZTsKKwlmb3IgKGkgPSAwOyBpIDwg
cGRhdGEtPm51bV9yZWd1bGF0b3JzOyBpKyspIHsKKwkJaW5pdF9kYXRhID0gJnBkYXRhLT5yZWd1
bGF0b3JzW2ldOworCQlwcml2LT5yZWd1bGF0b3JzW2ldID0gcmVndWxhdG9yX3JlZ2lzdGVyKAor
CQkJCSZtYzEzODkyX3JlZ3VsYXRvcnNbaW5pdF9kYXRhLT5pZF0uZGVzYywKKwkJCQkmcGRldi0+
ZGV2LCBpbml0X2RhdGEtPmluaXRfZGF0YSwgcHJpdik7CisKKwkJaWYgKElTX0VSUihwcml2LT5y
ZWd1bGF0b3JzW2ldKSkgeworCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlZ2lz
dGVyIHJlZ3VsYXRvciAlc1xuIiwKKwkJCQltYzEzODkyX3JlZ3VsYXRvcnNbaV0uZGVzYy5uYW1l
KTsKKwkJCXJldCA9IFBUUl9FUlIocHJpdi0+cmVndWxhdG9yc1tpXSk7CisJCQlnb3RvIGVycjsK
KwkJfQorCX0KKworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHByaXYpOworCisJcmV0dXJu
IDA7CitlcnI6CisJd2hpbGUgKC0taSA+PSAwKQorCQlyZWd1bGF0b3JfdW5yZWdpc3Rlcihwcml2
LT5yZWd1bGF0b3JzW2ldKTsKKworZXJyX2FsbG9jOgorCWtmcmVlKHByaXYpOworCisJcmV0dXJu
IHJldDsKK30KKworc3RhdGljIGludCBfX2RldmV4aXQgbWMxMzg5Ml9yZWd1bGF0b3JfcmVtb3Zl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IG1jMTM4OTJfcmVndWxh
dG9yX3ByaXYgKnByaXYgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlzdHJ1Y3QgbWMx
M3h4eF9yZWd1bGF0b3JfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPQorCQlkZXZfZ2V0X3BsYXRkYXRh
KCZwZGV2LT5kZXYpOworCWludCBpOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVM
TCk7CisKKwlmb3IgKGkgPSAwOyBpIDwgcGRhdGEtPm51bV9yZWd1bGF0b3JzOyBpKyspCisJCXJl
Z3VsYXRvcl91bnJlZ2lzdGVyKHByaXYtPnJlZ3VsYXRvcnNbaV0pOworCisJa2ZyZWUocHJpdik7
CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG1jMTM4OTJf
cmVndWxhdG9yX2RyaXZlciA9IHsKKwkuZHJpdmVyCT0geworCQkubmFtZQk9ICJtYzEzODkyLXJl
Z3VsYXRvciIsCisJCS5vd25lcgk9IFRISVNfTU9EVUxFLAorCX0sCisJLnJlbW92ZQkJPSBfX2Rl
dmV4aXRfcChtYzEzODkyX3JlZ3VsYXRvcl9yZW1vdmUpLAorCS5wcm9iZQkJPSBtYzEzODkyX3Jl
Z3VsYXRvcl9wcm9iZSwKK307CisKK3N0YXRpYyBpbnQgX19pbml0IG1jMTM4OTJfcmVndWxhdG9y
X2luaXQodm9pZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZtYzEzODky
X3JlZ3VsYXRvcl9kcml2ZXIpOworfQorc3Vic3lzX2luaXRjYWxsKG1jMTM4OTJfcmVndWxhdG9y
X2luaXQpOworCitzdGF0aWMgdm9pZCBfX2V4aXQgbWMxMzg5Ml9yZWd1bGF0b3JfZXhpdCh2b2lk
KQoreworCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZtYzEzODkyX3JlZ3VsYXRvcl9kcml2
ZXIpOworfQorbW9kdWxlX2V4aXQobWMxMzg5Ml9yZWd1bGF0b3JfZXhpdCk7CisKK01PRFVMRV9M
SUNFTlNFKCJHUEwgdjIiKTsKK01PRFVMRV9BVVRIT1IoIkFybmF1ZCBQYXRhcmQgPGFybmF1ZC5w
YXRhcmRAcnRwLW5ldC5vcmc+LCAiCisJCSJZb25nIFNoZW4gPHlvbmcuc2hlbkBsaW5hcm8ub3Jn
PiIpOworTU9EVUxFX0RFU0NSSVBUSU9OKCJSZWd1bGF0b3IgRHJpdmVyIGZvciBGcmVlc2NhbGUg
TUMxMzg5MiBQTUlDIik7CitNT0RVTEVfQUxJQVMoInBsYXRmb3JtOm1jMTM4OTItcmVndWxhdG9y
Iik7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9tYzEzNzgzLmggYi9pbmNsdWRlL2xp
bnV4L21mZC9tYzEzNzgzLmgKaW5kZXggYjRjNzQxZS4uN2QwZjNkNiAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9tZmQvbWMxMzc4My5oCisrKyBiL2luY2x1ZGUvbGludXgvbWZkL21jMTM3ODMu
aApAQCAtMSw0ICsxLDUgQEAKIC8qCisgKiBDb3B5cmlnaHQgMjAxMCBZb25nIFNoZW4gPHlvbmcu
c2hlbkBsaW5hcm8ub3JnPgogICogQ29weXJpZ2h0IDIwMDktMjAxMCBQZW5ndXRyb25peAogICog
VXdlIEtsZWluZS1Lb2VuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KICAqCkBA
IC0xMjIsMzkgKzEyMywzOSBAQCBpbnQgbWMxMzc4M19hZGNfZG9fY29udmVyc2lvbihzdHJ1Y3Qg
bWMxMzc4MyAqbWMxMzc4MywgdW5zaWduZWQgaW50IG1vZGUsCiAJCXVuc2lnbmVkIGludCBjaGFu
bmVsLCB1bnNpZ25lZCBpbnQgKnNhbXBsZSk7CiAKIAotI2RlZmluZQlNQzEzNzgzX1NXX1NXMUEJ
CTAKLSNkZWZpbmUJTUMxMzc4M19TV19TVzFCCQkxCi0jZGVmaW5lCU1DMTM3ODNfU1dfU1cyQQkJ
MgotI2RlZmluZQlNQzEzNzgzX1NXX1NXMkIJCTMKLSNkZWZpbmUJTUMxMzc4M19TV19TVzMJCTQK
LSNkZWZpbmUJTUMxMzc4M19TV19QTEwJCTUKLSNkZWZpbmUJTUMxMzc4M19SRUdVX1ZBVURJTwk2
Ci0jZGVmaW5lCU1DMTM3ODNfUkVHVV9WSU9ISQk3Ci0jZGVmaW5lCU1DMTM3ODNfUkVHVV9WSU9M
Twk4Ci0jZGVmaW5lCU1DMTM3ODNfUkVHVV9WRElHCTkKLSNkZWZpbmUJTUMxMzc4M19SRUdVX1ZH
RU4JMTAKLSNkZWZpbmUJTUMxMzc4M19SRUdVX1ZSRkRJRwkxMQotI2RlZmluZQlNQzEzNzgzX1JF
R1VfVlJGUkVGCTEyCi0jZGVmaW5lCU1DMTM3ODNfUkVHVV9WUkZDUAkxMwotI2RlZmluZQlNQzEz
NzgzX1JFR1VfVlNJTQkxNAotI2RlZmluZQlNQzEzNzgzX1JFR1VfVkVTSU0JMTUKLSNkZWZpbmUJ
TUMxMzc4M19SRUdVX1ZDQU0JMTYKLSNkZWZpbmUJTUMxMzc4M19SRUdVX1ZSRkJHCTE3Ci0jZGVm
aW5lCU1DMTM3ODNfUkVHVV9WVklCCTE4Ci0jZGVmaW5lCU1DMTM3ODNfUkVHVV9WUkYxCTE5Ci0j
ZGVmaW5lCU1DMTM3ODNfUkVHVV9WUkYyCTIwCi0jZGVmaW5lCU1DMTM3ODNfUkVHVV9WTU1DMQky
MQotI2RlZmluZQlNQzEzNzgzX1JFR1VfVk1NQzIJMjIKLSNkZWZpbmUJTUMxMzc4M19SRUdVX0dQ
TzEJMjMKLSNkZWZpbmUJTUMxMzc4M19SRUdVX0dQTzIJMjQKLSNkZWZpbmUJTUMxMzc4M19SRUdV
X0dQTzMJMjUKLSNkZWZpbmUJTUMxMzc4M19SRUdVX0dQTzQJMjYKLSNkZWZpbmUJTUMxMzc4M19S
RUdVX1YxCQkyNwotI2RlZmluZQlNQzEzNzgzX1JFR1VfVjIJCTI4Ci0jZGVmaW5lCU1DMTM3ODNf
UkVHVV9WMwkJMjkKLSNkZWZpbmUJTUMxMzc4M19SRUdVX1Y0CQkzMAotI2RlZmluZQlNQzEzNzgz
X1JFR1VfUFdHVDFTUEkJMzEKLSNkZWZpbmUJTUMxMzc4M19SRUdVX1BXR1QyU1BJCTMyCisjZGVm
aW5lCU1DMTM3ODNfUkVHX1NXMUEJCTAKKyNkZWZpbmUJTUMxMzc4M19SRUdfU1cxQgkJMQorI2Rl
ZmluZQlNQzEzNzgzX1JFR19TVzJBCQkyCisjZGVmaW5lCU1DMTM3ODNfUkVHX1NXMkIJCTMKKyNk
ZWZpbmUJTUMxMzc4M19SRUdfU1czCQk0CisjZGVmaW5lCU1DMTM3ODNfUkVHX1BMTAkJNQorI2Rl
ZmluZQlNQzEzNzgzX1JFR19WQVVESU8JNgorI2RlZmluZQlNQzEzNzgzX1JFR19WSU9ISQk3Cisj
ZGVmaW5lCU1DMTM3ODNfUkVHX1ZJT0xPCTgKKyNkZWZpbmUJTUMxMzc4M19SRUdfVkRJRwk5Cisj
ZGVmaW5lCU1DMTM3ODNfUkVHX1ZHRU4JMTAKKyNkZWZpbmUJTUMxMzc4M19SRUdfVlJGRElHCTEx
CisjZGVmaW5lCU1DMTM3ODNfUkVHX1ZSRlJFRgkxMgorI2RlZmluZQlNQzEzNzgzX1JFR19WUkZD
UAkxMworI2RlZmluZQlNQzEzNzgzX1JFR19WU0lNCTE0CisjZGVmaW5lCU1DMTM3ODNfUkVHX1ZF
U0lNCTE1CisjZGVmaW5lCU1DMTM3ODNfUkVHX1ZDQU0JMTYKKyNkZWZpbmUJTUMxMzc4M19SRUdf
VlJGQkcJMTcKKyNkZWZpbmUJTUMxMzc4M19SRUdfVlZJQgkxOAorI2RlZmluZQlNQzEzNzgzX1JF
R19WUkYxCTE5CisjZGVmaW5lCU1DMTM3ODNfUkVHX1ZSRjIJMjAKKyNkZWZpbmUJTUMxMzc4M19S
RUdfVk1NQzEJMjEKKyNkZWZpbmUJTUMxMzc4M19SRUdfVk1NQzIJMjIKKyNkZWZpbmUJTUMxMzc4
M19SRUdfR1BPMQkyMworI2RlZmluZQlNQzEzNzgzX1JFR19HUE8yCTI0CisjZGVmaW5lCU1DMTM3
ODNfUkVHX0dQTzMJMjUKKyNkZWZpbmUJTUMxMzc4M19SRUdfR1BPNAkyNgorI2RlZmluZQlNQzEz
NzgzX1JFR19WMQkJMjcKKyNkZWZpbmUJTUMxMzc4M19SRUdfVjIJCTI4CisjZGVmaW5lCU1DMTM3
ODNfUkVHX1YzCQkyOQorI2RlZmluZQlNQzEzNzgzX1JFR19WNAkJMzAKKyNkZWZpbmUJTUMxMzc4
M19SRUdfUFdHVDFTUEkJMzEKKyNkZWZpbmUJTUMxMzc4M19SRUdfUFdHVDJTUEkJMzIKIAogI2Rl
ZmluZSBNQzEzNzgzX0lSUV9BRENET05FCU1DMTNYWFhfSVJRX0FEQ0RPTkUKICNkZWZpbmUgTUMx
Mzc4M19JUlFfQURDQklTRE9ORQlNQzEzWFhYX0lSUV9BRENCSVNET05FCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L21mZC9tYzEzODkyLmggYi9pbmNsdWRlL2xpbnV4L21mZC9tYzEzODkyLmgK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uN2RmMTNlOAotLS0gL2Rldi9udWxs
CisrKyBiL2luY2x1ZGUvbGludXgvbWZkL21jMTM4OTIuaApAQCAtMCwwICsxLDM4IEBACisvKgor
ICogQ29weXJpZ2h0IDIwMTAgWW9uZyBTaGVuIDx5b25nLnNoZW5AbGluYXJvLm9yZz4KKyAqCisg
KiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQg
YW5kL29yIG1vZGlmeSBpdCB1bmRlcgorICogdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMgcHVibGlzaGVkIGJ5IHRoZQorICogRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uLgorICovCisKKyNpZm5kZWYgX19MSU5VWF9NRkRfTUMxMzg5Ml9ICisj
ZGVmaW5lIF9fTElOVVhfTUZEX01DMTM4OTJfSAorI2luY2x1ZGUgPGxpbnV4L21mZC9tYzEzeHh4
Lmg+CisKKyNkZWZpbmUgTUMxMzg5Ml9TVzEJCTAKKyNkZWZpbmUgTUMxMzg5Ml9TVzIJCTEKKyNk
ZWZpbmUgTUMxMzg5Ml9TVzMJCTIKKyNkZWZpbmUgTUMxMzg5Ml9TVzQJCTMKKyNkZWZpbmUgTUMx
Mzg5Ml9TV0JTVAk0CisjZGVmaW5lIE1DMTM4OTJfVklPSEkJNQorI2RlZmluZSBNQzEzODkyX1ZQ
TEwJNgorI2RlZmluZSBNQzEzODkyX1ZESUcJNworI2RlZmluZSBNQzEzODkyX1ZTRAk4CisjZGVm
aW5lIE1DMTM4OTJfVlVTQjIJOQorI2RlZmluZSBNQzEzODkyX1ZWSURFTwkxMAorI2RlZmluZSBN
QzEzODkyX1ZBVURJTwkxMQorI2RlZmluZSBNQzEzODkyX1ZDQU0JMTIKKyNkZWZpbmUgTUMxMzg5
Ml9WR0VOMQkxMworI2RlZmluZSBNQzEzODkyX1ZHRU4yCTE0CisjZGVmaW5lIE1DMTM4OTJfVkdF
TjMJMTUKKyNkZWZpbmUgTUMxMzg5Ml9WVVNCCTE2CisjZGVmaW5lIE1DMTM4OTJfR1BPMQkxNwor
I2RlZmluZSBNQzEzODkyX0dQTzIJMTgKKyNkZWZpbmUgTUMxMzg5Ml9HUE8zCTE5CisjZGVmaW5l
IE1DMTM4OTJfR1BPNAkyMAorI2RlZmluZSBNQzEzODkyX1BXR1QxU1BJCTIxCisjZGVmaW5lIE1D
MTM4OTJfUFdHVDJTUEkJMjIKKyNkZWZpbmUgTUMxMzg5Ml9WQ09JTkNFTEwJMjMKKworI2VuZGlm
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3JlZ3VsYXRvci9tYzEzeHh4LmggYi9pbmNsdWRl
L2xpbnV4L3JlZ3VsYXRvci9tYzEzeHh4LmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMC4uY2I5NTAxZQotLS0gL2Rldi9udWxsCisrKyBiL2luY2x1ZGUvbGludXgvcmVndWxhdG9y
L21jMTN4eHguaApAQCAtMCwwICsxLDgxIEBACisvKgorICogbWMxM3h4eC5oIC0gcmVndWxhdG9y
cyBmb3IgdGhlIEZyZWVzY2FsZSBtYzEzeHh4IFBNSUMKKyAqCisgKiAgQ29weXJpZ2h0IChDKSAy
MDEwIFlvbmcgU2hlbiA8eW9uZy5zaGVuQGxpbmFyby5vcmc+CisgKgorICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkK
KyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YXMgcHVibGlzaGVkIGJ5CisgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIg
dmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0
ZXIgdmVyc2lvbi4KKyAqLworCisjaWZuZGVmIF9fTElOVVhfUkVHVUxBVE9SX01DMTNYWFhfSAor
I2RlZmluZSBfX0xJTlVYX1JFR1VMQVRPUl9NQzEzWFhYX0gKKworI2luY2x1ZGUgPGxpbnV4L3Jl
Z3VsYXRvci9kcml2ZXIuaD4KKworc3RydWN0IG1jMTN4eHhfcmVndWxhdG9yIHsKKwlzdHJ1Y3Qg
cmVndWxhdG9yX2Rlc2MgZGVzYzsKKwlpbnQgcmVnOworCWludCBlbmFibGVfYml0OworCWludCB2
c2VsX3JlZzsKKwlpbnQgdnNlbF9zaGlmdDsKKwlpbnQgdnNlbF9tYXNrOworCWludCBoaV9iaXQ7
CisJaW50IGNvbnN0ICp2b2x0YWdlczsKK307CisKKyNkZWZpbmUgTUMxM3h4eF9ERUZJTkUocHJl
Zml4LCBfbmFtZSwgX3JlZywgX3ZzZWxfcmVnLCBfdm9sdGFnZXMsIF9vcHMpCVwKKwlbcHJlZml4
ICMjIF9uYW1lXSA9IHsJCQkJXAorCQkuZGVzYyA9IHsJCQkJCQlcCisJCQkubmFtZSA9ICNwcmVm
aXggIl8iICNfbmFtZSwJCQlcCisJCQkubl92b2x0YWdlcyA9IEFSUkFZX1NJWkUoX3ZvbHRhZ2Vz
KSwJCVwKKwkJCS5vcHMgPSAmX29wcywJCQlcCisJCQkudHlwZSA9IFJFR1VMQVRPUl9WT0xUQUdF
LAkJCVwKKwkJCS5pZCA9IHByZWZpeCAjIyBfbmFtZSwJCVwKKwkJCS5vd25lciA9IFRISVNfTU9E
VUxFLAkJCQlcCisJCX0sCQkJCQkJCVwKKwkJLnJlZyA9IHByZWZpeCAjIyBfcmVnLAkJCQlcCisJ
CS5lbmFibGVfYml0ID0gcHJlZml4ICMjIF9yZWcgIyMgXyAjIyBfbmFtZSAjIyBFTiwJXAorCQku
dnNlbF9yZWcgPSBwcmVmaXggIyMgX3ZzZWxfcmVnLAkJCVwKKwkJLnZzZWxfc2hpZnQgPSBwcmVm
aXggIyMgX3ZzZWxfcmVnICMjIF8gIyMgX25hbWUgIyMgVlNFTCxcCisJCS52c2VsX21hc2sgPSBw
cmVmaXggIyMgX3ZzZWxfcmVnICMjIF8gIyMgX25hbWUgIyMgVlNFTF9NLFwKKwkJLnZvbHRhZ2Vz
ID0gIF92b2x0YWdlcywJCQkJCVwKKwl9CisKKyNkZWZpbmUgTUMxM3h4eF9GSVhFRF9ERUZJTkUo
cHJlZml4LCBfbmFtZSwgX3JlZywgX3ZvbHRhZ2VzLCBfb3BzKQlcCisJW3ByZWZpeCAjIyBfbmFt
ZV0gPSB7CQkJCVwKKwkJLmRlc2MgPSB7CQkJCQkJXAorCQkJLm5hbWUgPSAjcHJlZml4ICJfIiAj
X25hbWUsCQkJXAorCQkJLm5fdm9sdGFnZXMgPSBBUlJBWV9TSVpFKF92b2x0YWdlcyksCQlcCisJ
CQkub3BzID0gJl9vcHMsCQlcCisJCQkudHlwZSA9IFJFR1VMQVRPUl9WT0xUQUdFLAkJCVwKKwkJ
CS5pZCA9IHByZWZpeCAjIyBfbmFtZSwJCVwKKwkJCS5vd25lciA9IFRISVNfTU9EVUxFLAkJCQlc
CisJCX0sCQkJCQkJCVwKKwkJLnJlZyA9IHByZWZpeCAjIyBfcmVnLAkJCQlcCisJCS5lbmFibGVf
Yml0ID0gcHJlZml4ICMjIF9yZWcgIyMgXyAjIyBfbmFtZSAjIyBFTiwJXAorCQkudm9sdGFnZXMg
PSAgX3ZvbHRhZ2VzLAkJCQkJXAorCX0KKworI2RlZmluZSBNQzEzeHh4X0dQT19ERUZJTkUocHJl
Zml4LCBfbmFtZSwgX3JlZywgIF92b2x0YWdlcywgX29wcykJXAorCVtwcmVmaXggIyMgX25hbWVd
ID0gewkJCQlcCisJCS5kZXNjID0gewkJCQkJCVwKKwkJCS5uYW1lID0gI3ByZWZpeCAiXyIgI19u
YW1lLAkJCVwKKwkJCS5uX3ZvbHRhZ2VzID0gQVJSQVlfU0laRShfdm9sdGFnZXMpLAkJXAorCQkJ
Lm9wcyA9ICZfb3BzLAkJXAorCQkJLnR5cGUgPSBSRUdVTEFUT1JfVk9MVEFHRSwJCQlcCisJCQku
aWQgPSBwcmVmaXggIyMgX25hbWUsCQlcCisJCQkub3duZXIgPSBUSElTX01PRFVMRSwJCQkJXAor
CQl9LAkJCQkJCQlcCisJCS5yZWcgPSBwcmVmaXggIyMgX3JlZywJCQkJXAorCQkuZW5hYmxlX2Jp
dCA9IHByZWZpeCAjIyBfcmVnICMjIF8gIyMgX25hbWUgIyMgRU4sCVwKKwkJLnZvbHRhZ2VzID0g
IF92b2x0YWdlcywJCQkJCVwKKwl9CisKKyNkZWZpbmUgTUMxM3h4eF9ERUZJTkVfU1coX25hbWUs
IF9yZWcsIF92c2VsX3JlZywgX3ZvbHRhZ2VzLCBvcHMpCVwKKwlNQzEzeHh4X0RFRklORShTVywg
X25hbWUsIF9yZWcsIF92c2VsX3JlZywgX3ZvbHRhZ2VzLCBvcHMpCisjZGVmaW5lIE1DMTN4eHhf
REVGSU5FX1JFR1UoX25hbWUsIF9yZWcsIF92c2VsX3JlZywgX3ZvbHRhZ2VzLCBvcHMpCVwKKwlN
QzEzeHh4X0RFRklORShSRUdVLCBfbmFtZSwgX3JlZywgX3ZzZWxfcmVnLCBfdm9sdGFnZXMsIG9w
cykKKworI2VuZGlmCi0tIAoxLjcuMC40Cgo=
--000e0cd47e5cd50c070495ddbba0--
