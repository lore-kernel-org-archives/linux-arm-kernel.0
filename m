From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 15:59:48 +0200
Subject: [PATCH 2/4] ARM: ux500: move ab8500_regulator_plat_data into driver
In-Reply-To: <1462888794-2793296-1-git-send-email-arnd@arndb.de>
References: <1462888794-2793296-1-git-send-email-arnd@arndb.de>
Message-ID: <1462888794-2793296-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one instance of ab8500_regulator_platform_data, and it's
safe to assume we won't ever merge another one, so it's rather pointless
to pass it through multiple levels of platform data pointers.

This moves the structure and everything referenced by it into the
driver that uses it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/Makefile                  |   3 +-
 arch/arm/mach-ux500/board-mop500-regulators.c | 465 --------------------------
 arch/arm/mach-ux500/board-mop500-regulators.h |  16 -
 arch/arm/mach-ux500/cpu-db8500.c              |   2 -
 drivers/regulator/ab8500-ext.c                | 465 +++++++++++++++++++++++++-
 5 files changed, 452 insertions(+), 499 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-regulators.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500-regulators.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index edfff1ae1f8d..ea8893fd128f 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -5,8 +5,7 @@
 obj-y				:= cpu.o id.o pm.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
-obj-$(CONFIG_MACH_MOP500)	+= board-mop500-regulators.o \
-				board-mop500-audio.o
+obj-$(CONFIG_MACH_MOP500)	+= board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
deleted file mode 100644
index eff141ddeea5..000000000000
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ /dev/null
@@ -1,465 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License Terms: GNU General Public License v2
- *
- * Authors: Sundar Iyer <sundar.iyer@stericsson.com>
- *          Bengt Jonsson <bengt.g.jonsson@stericsson.com>
- *          Daniel Willerud <daniel.willerud@stericsson.com>
- *
- * MOP500 board specific initialization for regulators
- */
-#include <linux/kernel.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/ab8500.h>
-#include "board-mop500-regulators.h"
-
-static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
-	/* Main display, u8500 R3 uib */
-	REGULATOR_SUPPLY("vddi", "mcde_disp_sony_acx424akp.0"),
-	/* Main display, u8500 uib and ST uib */
-	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.0"),
-	/* Secondary display, ST uib */
-	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.1"),
-	/* SFH7741 proximity sensor */
-	REGULATOR_SUPPLY("vcc", "gpio-keys.0"),
-	/* BH1780GLS ambient light sensor */
-	REGULATOR_SUPPLY("vcc", "2-0029"),
-	/* lsm303dlh accelerometer */
-	REGULATOR_SUPPLY("vdd", "2-0018"),
-	/* lsm303dlhc accelerometer */
-	REGULATOR_SUPPLY("vdd", "2-0019"),
-	/* lsm303dlh magnetometer */
-	REGULATOR_SUPPLY("vdd", "2-001e"),
-	/* Rohm BU21013 Touchscreen devices */
-	REGULATOR_SUPPLY("avdd", "3-005c"),
-	REGULATOR_SUPPLY("avdd", "3-005d"),
-	/* Synaptics RMI4 Touchscreen device */
-	REGULATOR_SUPPLY("vdd", "3-004b"),
-	/* L3G4200D Gyroscope device */
-	REGULATOR_SUPPLY("vdd", "2-0068"),
-	/* Ambient light sensor device */
-	REGULATOR_SUPPLY("vdd", "3-0029"),
-	/* Pressure sensor device */
-	REGULATOR_SUPPLY("vdd", "2-005c"),
-	/* Cypress TrueTouch Touchscreen device */
-	REGULATOR_SUPPLY("vcpin", "spi8.0"),
-	/* Camera device */
-	REGULATOR_SUPPLY("vaux12v5", "mmio_camera"),
-};
-
-static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
-	/* On-board eMMC power */
-	REGULATOR_SUPPLY("vmmc", "sdi4"),
-	/* AB8500 audio codec */
-	REGULATOR_SUPPLY("vcc-N2158", "ab8500-codec.0"),
-	/* AB8500 accessory detect 1 */
-	REGULATOR_SUPPLY("vcc-N2158", "ab8500-acc-det.0"),
-	/* AB8500 Tv-out device */
-	REGULATOR_SUPPLY("vcc-N2158", "mcde_tv_ab8500.4"),
-	/* AV8100 HDMI device */
-	REGULATOR_SUPPLY("vcc-N2158", "av8100_hdmi.3"),
-};
-
-static struct regulator_consumer_supply ab8500_vaux3_consumers[] = {
-	REGULATOR_SUPPLY("v-SD-STM", "stm"),
-	/* External MMC slot power */
-	REGULATOR_SUPPLY("vmmc", "sdi0"),
-};
-
-static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
-	/* TV-out DENC supply */
-	REGULATOR_SUPPLY("vtvout", "ab8500-denc.0"),
-	/* Internal general-purpose ADC */
-	REGULATOR_SUPPLY("vddadc", "ab8500-gpadc.0"),
-	/* ADC for charger */
-	REGULATOR_SUPPLY("vddadc", "ab8500-charger.0"),
-	/* AB8500 Tv-out device */
-	REGULATOR_SUPPLY("vtvout", "mcde_tv_ab8500.4"),
-};
-
-static struct regulator_consumer_supply ab8500_vaud_consumers[] = {
-	/* AB8500 audio-codec main supply */
-	REGULATOR_SUPPLY("vaud", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vamic1_consumers[] = {
-	/* AB8500 audio-codec Mic1 supply */
-	REGULATOR_SUPPLY("vamic1", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vamic2_consumers[] = {
-	/* AB8500 audio-codec Mic2 supply */
-	REGULATOR_SUPPLY("vamic2", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vdmic_consumers[] = {
-	/* AB8500 audio-codec DMic supply */
-	REGULATOR_SUPPLY("vdmic", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vintcore_consumers[] = {
-	/* SoC core supply, no device */
-	REGULATOR_SUPPLY("v-intcore", NULL),
-	/* USB Transceiver */
-	REGULATOR_SUPPLY("vddulpivio18", "ab8500-usb.0"),
-	/* Handled by abx500 clk driver */
-	REGULATOR_SUPPLY("v-intcore", "abx500-clk.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vana_consumers[] = {
-	/* DB8500 DSI */
-	REGULATOR_SUPPLY("vdddsi1v2", "mcde"),
-	REGULATOR_SUPPLY("vdddsi1v2", "b2r2_core"),
-	REGULATOR_SUPPLY("vdddsi1v2", "b2r2_1_core"),
-	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.0"),
-	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.1"),
-	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.2"),
-	/* DB8500 CSI */
-	REGULATOR_SUPPLY("vddcsi1v2", "mmio_camera"),
-};
-
-/* ab8500 regulator register initialization */
-static struct ab8500_regulator_reg_init ab8500_reg_init[] = {
-	/*
-	 * VanaRequestCtrl          = HP/LP depending on VxRequest
-	 * VextSupply1RequestCtrl   = HP/LP depending on VxRequest
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL2,       0xf0, 0x00),
-	/*
-	 * VextSupply2RequestCtrl   = HP/LP depending on VxRequest
-	 * VextSupply3RequestCtrl   = HP/LP depending on VxRequest
-	 * Vaux1RequestCtrl         = HP/LP depending on VxRequest
-	 * Vaux2RequestCtrl         = HP/LP depending on VxRequest
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL3,       0xff, 0x00),
-	/*
-	 * Vaux3RequestCtrl         = HP/LP depending on VxRequest
-	 * SwHPReq                  = Control through SWValid disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL4,       0x07, 0x00),
-	/*
-	 * VanaSysClkReq1HPValid    = disabled
-	 * Vaux1SysClkReq1HPValid   = disabled
-	 * Vaux2SysClkReq1HPValid   = disabled
-	 * Vaux3SysClkReq1HPValid   = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQ1HPVALID1, 0xe8, 0x00),
-	/*
-	 * VextSupply1SysClkReq1HPValid = disabled
-	 * VextSupply2SysClkReq1HPValid = disabled
-	 * VextSupply3SysClkReq1HPValid = SysClkReq1 controlled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQ1HPVALID2, 0x70, 0x40),
-	/*
-	 * VanaHwHPReq1Valid        = disabled
-	 * Vaux1HwHPreq1Valid       = disabled
-	 * Vaux2HwHPReq1Valid       = disabled
-	 * Vaux3HwHPReqValid        = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ1VALID1,     0xe8, 0x00),
-	/*
-	 * VextSupply1HwHPReq1Valid = disabled
-	 * VextSupply2HwHPReq1Valid = disabled
-	 * VextSupply3HwHPReq1Valid = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ1VALID2,     0x07, 0x00),
-	/*
-	 * VanaHwHPReq2Valid        = disabled
-	 * Vaux1HwHPReq2Valid       = disabled
-	 * Vaux2HwHPReq2Valid       = disabled
-	 * Vaux3HwHPReq2Valid       = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ2VALID1,     0xe8, 0x00),
-	/*
-	 * VextSupply1HwHPReq2Valid = disabled
-	 * VextSupply2HwHPReq2Valid = disabled
-	 * VextSupply3HwHPReq2Valid = HWReq2 controlled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ2VALID2,     0x07, 0x04),
-	/*
-	 * VanaSwHPReqValid         = disabled
-	 * Vaux1SwHPReqValid        = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSWHPREQVALID1,      0xa0, 0x00),
-	/*
-	 * Vaux2SwHPReqValid        = disabled
-	 * Vaux3SwHPReqValid        = disabled
-	 * VextSupply1SwHPReqValid  = disabled
-	 * VextSupply2SwHPReqValid  = disabled
-	 * VextSupply3SwHPReqValid  = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSWHPREQVALID2,      0x1f, 0x00),
-	/*
-	 * SysClkReq2Valid1         = SysClkReq2 controlled
-	 * SysClkReq3Valid1         = disabled
-	 * SysClkReq4Valid1         = SysClkReq4 controlled
-	 * SysClkReq5Valid1         = disabled
-	 * SysClkReq6Valid1         = SysClkReq6 controlled
-	 * SysClkReq7Valid1         = disabled
-	 * SysClkReq8Valid1         = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQVALID1,    0xfe, 0x2a),
-	/*
-	 * SysClkReq2Valid2         = disabled
-	 * SysClkReq3Valid2         = disabled
-	 * SysClkReq4Valid2         = disabled
-	 * SysClkReq5Valid2         = disabled
-	 * SysClkReq6Valid2         = SysClkReq6 controlled
-	 * SysClkReq7Valid2         = disabled
-	 * SysClkReq8Valid2         = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQVALID2,    0xfe, 0x20),
-	/*
-	 * VTVoutEna                = disabled
-	 * Vintcore12Ena            = disabled
-	 * Vintcore12Sel            = 1.25 V
-	 * Vintcore12LP             = inactive (HP)
-	 * VTVoutLP                 = inactive (HP)
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUMISC1,              0xfe, 0x10),
-	/*
-	 * VaudioEna                = disabled
-	 * VdmicEna                 = disabled
-	 * Vamic1Ena                = disabled
-	 * Vamic2Ena                = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUDIOSUPPLY,           0x1e, 0x00),
-	/*
-	 * Vamic1_dzout             = high-Z when Vamic1 is disabled
-	 * Vamic2_dzout             = high-Z when Vamic2 is disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRL1VAMIC,         0x03, 0x00),
-	/*
-	 * VPll                     = Hw controlled (NOTE! PRCMU bits)
-	 * VanaRegu                 = force off
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VPLLVANAREGU,           0x0f, 0x02),
-	/*
-	 * VrefDDREna               = disabled
-	 * VrefDDRSleepMode         = inactive (no pulldown)
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VREFDDR,                0x03, 0x00),
-	/*
-	 * VextSupply1Regu          = force LP
-	 * VextSupply2Regu          = force OFF
-	 * VextSupply3Regu          = force HP (-> STBB2=LP and TPS=LP)
-	 * ExtSupply2Bypass         = ExtSupply12LPn ball is 0 when Ena is 0
-	 * ExtSupply3Bypass         = ExtSupply3LPn ball is 0 when Ena is 0
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_EXTSUPPLYREGU,          0xff, 0x13),
-	/*
-	 * Vaux1Regu                = force HP
-	 * Vaux2Regu                = force off
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUX12REGU,             0x0f, 0x01),
-	/*
-	 * Vaux3Regu                = force off
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VRF1VAUX3REGU,          0x03, 0x00),
-	/*
-	 * Vaux1Sel                 = 2.8 V
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUX1SEL,               0x0f, 0x0C),
-	/*
-	 * Vaux2Sel                 = 2.9 V
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUX2SEL,               0x0f, 0x0d),
-	/*
-	 * Vaux3Sel                 = 2.91 V
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VRF1VAUX3SEL,           0x07, 0x07),
-	/*
-	 * VextSupply12LP           = disabled (no LP)
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRL2SPARE,         0x01, 0x00),
-	/*
-	 * Vaux1Disch               = short discharge time
-	 * Vaux2Disch               = short discharge time
-	 * Vaux3Disch               = short discharge time
-	 * Vintcore12Disch          = short discharge time
-	 * VTVoutDisch              = short discharge time
-	 * VaudioDisch              = short discharge time
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRLDISCH,          0xfc, 0x00),
-	/*
-	 * VanaDisch                = short discharge time
-	 * VdmicPullDownEna         = pulldown disabled when Vdmic is disabled
-	 * VdmicDisch               = short discharge time
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRLDISCH2,         0x16, 0x00),
-};
-
-/* AB8500 regulators */
-static struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
-	/* supplies to the display/camera */
-	[AB8500_LDO_AUX1] = {
-		.supply_regulator = "ab8500-ext-supply3",
-		.constraints = {
-			.name = "V-DISPLAY",
-			.min_uV = 2800000,
-			.max_uV = 3300000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS,
-			.boot_on = 1, /* display is on at boot */
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux1_consumers),
-		.consumer_supplies = ab8500_vaux1_consumers,
-	},
-	/* supplies to the on-board eMMC */
-	[AB8500_LDO_AUX2] = {
-		.supply_regulator = "ab8500-ext-supply3",
-		.constraints = {
-			.name = "V-eMMC1",
-			.min_uV = 1100000,
-			.max_uV = 3300000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS |
-					  REGULATOR_CHANGE_MODE,
-			.valid_modes_mask = REGULATOR_MODE_NORMAL |
-					    REGULATOR_MODE_IDLE,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux2_consumers),
-		.consumer_supplies = ab8500_vaux2_consumers,
-	},
-	/* supply for VAUX3, supplies to SDcard slots */
-	[AB8500_LDO_AUX3] = {
-		.supply_regulator = "ab8500-ext-supply3",
-		.constraints = {
-			.name = "V-MMC-SD",
-			.min_uV = 1100000,
-			.max_uV = 3300000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS |
-					  REGULATOR_CHANGE_MODE,
-			.valid_modes_mask = REGULATOR_MODE_NORMAL |
-					    REGULATOR_MODE_IDLE,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux3_consumers),
-		.consumer_supplies = ab8500_vaux3_consumers,
-	},
-	/* supply for tvout, gpadc, TVOUT LDO */
-	[AB8500_LDO_TVOUT] = {
-		.constraints = {
-			.name = "V-TVOUT",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vtvout_consumers),
-		.consumer_supplies = ab8500_vtvout_consumers,
-	},
-	/* supply for ab8500-vaudio, VAUDIO LDO */
-	[AB8500_LDO_AUDIO] = {
-		.constraints = {
-			.name = "V-AUD",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaud_consumers),
-		.consumer_supplies = ab8500_vaud_consumers,
-	},
-	/* supply for v-anamic1 VAMic1-LDO */
-	[AB8500_LDO_ANAMIC1] = {
-		.constraints = {
-			.name = "V-AMIC1",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic1_consumers),
-		.consumer_supplies = ab8500_vamic1_consumers,
-	},
-	/* supply for v-amic2, VAMIC2 LDO, reuse constants for AMIC1 */
-	[AB8500_LDO_ANAMIC2] = {
-		.constraints = {
-			.name = "V-AMIC2",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic2_consumers),
-		.consumer_supplies = ab8500_vamic2_consumers,
-	},
-	/* supply for v-dmic, VDMIC LDO */
-	[AB8500_LDO_DMIC] = {
-		.constraints = {
-			.name = "V-DMIC",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vdmic_consumers),
-		.consumer_supplies = ab8500_vdmic_consumers,
-	},
-	/* supply for v-intcore12, VINTCORE12 LDO */
-	[AB8500_LDO_INTCORE] = {
-		.constraints = {
-			.name = "V-INTCORE",
-			.min_uV = 1250000,
-			.max_uV = 1350000,
-			.input_uV = 1800000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS |
-					  REGULATOR_CHANGE_MODE |
-					  REGULATOR_CHANGE_DRMS,
-			.valid_modes_mask = REGULATOR_MODE_NORMAL |
-					    REGULATOR_MODE_IDLE,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vintcore_consumers),
-		.consumer_supplies = ab8500_vintcore_consumers,
-	},
-	/* supply for U8500 CSI-DSI, VANA LDO */
-	[AB8500_LDO_ANA] = {
-		.constraints = {
-			.name = "V-CSI-DSI",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vana_consumers),
-		.consumer_supplies = ab8500_vana_consumers,
-	},
-};
-
-/* supply for VextSupply3 */
-static struct regulator_consumer_supply ab8500_ext_supply3_consumers[] = {
-	/* SIM supply for 3 V SIM cards */
-	REGULATOR_SUPPLY("vinvsim", "sim-detect.0"),
-};
-
-/*
- * AB8500 external regulators
- */
-static struct regulator_init_data ab8500_ext_regulators[] = {
-	/* fixed Vbat supplies VSMPS1_EXT_1V8 */
-	[AB8500_EXT_SUPPLY1] = {
-		.constraints = {
-			.name = "ab8500-ext-supply1",
-			.min_uV = 1800000,
-			.max_uV = 1800000,
-			.initial_mode = REGULATOR_MODE_IDLE,
-			.boot_on = 1,
-			.always_on = 1,
-		},
-	},
-	/* fixed Vbat supplies VSMPS2_EXT_1V36 and VSMPS5_EXT_1V15 */
-	[AB8500_EXT_SUPPLY2] = {
-		.constraints = {
-			.name = "ab8500-ext-supply2",
-			.min_uV = 1360000,
-			.max_uV = 1360000,
-		},
-	},
-	/* fixed Vbat supplies VSMPS3_EXT_3V4 and VSMPS4_EXT_3V4 */
-	[AB8500_EXT_SUPPLY3] = {
-		.constraints = {
-			.name = "ab8500-ext-supply3",
-			.min_uV = 3400000,
-			.max_uV = 3400000,
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-			.boot_on = 1,
-		},
-		.num_consumer_supplies =
-			ARRAY_SIZE(ab8500_ext_supply3_consumers),
-		.consumer_supplies = ab8500_ext_supply3_consumers,
-	},
-};
-
-struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
-	.reg_init               = ab8500_reg_init,
-	.num_reg_init           = ARRAY_SIZE(ab8500_reg_init),
-	.regulator              = ab8500_regulators,
-	.num_regulator          = ARRAY_SIZE(ab8500_regulators),
-	.ext_regulator          = ab8500_ext_regulators,
-	.num_ext_regulator      = ARRAY_SIZE(ab8500_ext_regulators),
-};
diff --git a/arch/arm/mach-ux500/board-mop500-regulators.h b/arch/arm/mach-ux500/board-mop500-regulators.h
deleted file mode 100644
index 3bbb0831b0cf..000000000000
--- a/arch/arm/mach-ux500/board-mop500-regulators.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License Terms: GNU General Public License v2
- *
- * Author: Bengt Jonsson <bengt.g.jonsson@stericsson.com> for ST-Ericsson
- *
- * MOP500 board specific initialization for regulators
- */
-
-#ifndef __BOARD_MOP500_REGULATORS_H
-#define __BOARD_MOP500_REGULATORS_H
-
-extern struct ab8500_regulator_platform_data ab8500_regulator_plat_data;
-
-#endif
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index a557955472ea..c015ef8dd535 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -28,13 +28,11 @@
 
 #include "setup.h"
 
-#include "board-mop500-regulators.h"
 #include "board-mop500.h"
 #include "db8500-regs.h"
 #include "id.h"
 
 static struct ab8500_platform_data ab8500_platdata = {
-	.regulator	= &ab8500_regulator_plat_data,
 };
 
 static struct prcmu_pdata db8500_prcmu_pdata = {
diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 84c1ee39ddae..2ca00045eb99 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -25,6 +25,456 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/regulator/ab8500.h>
 
+static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
+	/* Main display, u8500 R3 uib */
+	REGULATOR_SUPPLY("vddi", "mcde_disp_sony_acx424akp.0"),
+	/* Main display, u8500 uib and ST uib */
+	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.0"),
+	/* Secondary display, ST uib */
+	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.1"),
+	/* SFH7741 proximity sensor */
+	REGULATOR_SUPPLY("vcc", "gpio-keys.0"),
+	/* BH1780GLS ambient light sensor */
+	REGULATOR_SUPPLY("vcc", "2-0029"),
+	/* lsm303dlh accelerometer */
+	REGULATOR_SUPPLY("vdd", "2-0018"),
+	/* lsm303dlhc accelerometer */
+	REGULATOR_SUPPLY("vdd", "2-0019"),
+	/* lsm303dlh magnetometer */
+	REGULATOR_SUPPLY("vdd", "2-001e"),
+	/* Rohm BU21013 Touchscreen devices */
+	REGULATOR_SUPPLY("avdd", "3-005c"),
+	REGULATOR_SUPPLY("avdd", "3-005d"),
+	/* Synaptics RMI4 Touchscreen device */
+	REGULATOR_SUPPLY("vdd", "3-004b"),
+	/* L3G4200D Gyroscope device */
+	REGULATOR_SUPPLY("vdd", "2-0068"),
+	/* Ambient light sensor device */
+	REGULATOR_SUPPLY("vdd", "3-0029"),
+	/* Pressure sensor device */
+	REGULATOR_SUPPLY("vdd", "2-005c"),
+	/* Cypress TrueTouch Touchscreen device */
+	REGULATOR_SUPPLY("vcpin", "spi8.0"),
+	/* Camera device */
+	REGULATOR_SUPPLY("vaux12v5", "mmio_camera"),
+};
+
+static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
+	/* On-board eMMC power */
+	REGULATOR_SUPPLY("vmmc", "sdi4"),
+	/* AB8500 audio codec */
+	REGULATOR_SUPPLY("vcc-N2158", "ab8500-codec.0"),
+	/* AB8500 accessory detect 1 */
+	REGULATOR_SUPPLY("vcc-N2158", "ab8500-acc-det.0"),
+	/* AB8500 Tv-out device */
+	REGULATOR_SUPPLY("vcc-N2158", "mcde_tv_ab8500.4"),
+	/* AV8100 HDMI device */
+	REGULATOR_SUPPLY("vcc-N2158", "av8100_hdmi.3"),
+};
+
+static struct regulator_consumer_supply ab8500_vaux3_consumers[] = {
+	REGULATOR_SUPPLY("v-SD-STM", "stm"),
+	/* External MMC slot power */
+	REGULATOR_SUPPLY("vmmc", "sdi0"),
+};
+
+static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
+	/* TV-out DENC supply */
+	REGULATOR_SUPPLY("vtvout", "ab8500-denc.0"),
+	/* Internal general-purpose ADC */
+	REGULATOR_SUPPLY("vddadc", "ab8500-gpadc.0"),
+	/* ADC for charger */
+	REGULATOR_SUPPLY("vddadc", "ab8500-charger.0"),
+	/* AB8500 Tv-out device */
+	REGULATOR_SUPPLY("vtvout", "mcde_tv_ab8500.4"),
+};
+
+static struct regulator_consumer_supply ab8500_vaud_consumers[] = {
+	/* AB8500 audio-codec main supply */
+	REGULATOR_SUPPLY("vaud", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vamic1_consumers[] = {
+	/* AB8500 audio-codec Mic1 supply */
+	REGULATOR_SUPPLY("vamic1", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vamic2_consumers[] = {
+	/* AB8500 audio-codec Mic2 supply */
+	REGULATOR_SUPPLY("vamic2", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vdmic_consumers[] = {
+	/* AB8500 audio-codec DMic supply */
+	REGULATOR_SUPPLY("vdmic", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vintcore_consumers[] = {
+	/* SoC core supply, no device */
+	REGULATOR_SUPPLY("v-intcore", NULL),
+	/* USB Transceiver */
+	REGULATOR_SUPPLY("vddulpivio18", "ab8500-usb.0"),
+	/* Handled by abx500 clk driver */
+	REGULATOR_SUPPLY("v-intcore", "abx500-clk.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vana_consumers[] = {
+	/* DB8500 DSI */
+	REGULATOR_SUPPLY("vdddsi1v2", "mcde"),
+	REGULATOR_SUPPLY("vdddsi1v2", "b2r2_core"),
+	REGULATOR_SUPPLY("vdddsi1v2", "b2r2_1_core"),
+	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.0"),
+	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.1"),
+	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.2"),
+	/* DB8500 CSI */
+	REGULATOR_SUPPLY("vddcsi1v2", "mmio_camera"),
+};
+
+/* ab8500 regulator register initialization */
+static struct ab8500_regulator_reg_init ab8500_reg_init[] = {
+	/*
+	 * VanaRequestCtrl          = HP/LP depending on VxRequest
+	 * VextSupply1RequestCtrl   = HP/LP depending on VxRequest
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL2,       0xf0, 0x00),
+	/*
+	 * VextSupply2RequestCtrl   = HP/LP depending on VxRequest
+	 * VextSupply3RequestCtrl   = HP/LP depending on VxRequest
+	 * Vaux1RequestCtrl         = HP/LP depending on VxRequest
+	 * Vaux2RequestCtrl         = HP/LP depending on VxRequest
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL3,       0xff, 0x00),
+	/*
+	 * Vaux3RequestCtrl         = HP/LP depending on VxRequest
+	 * SwHPReq                  = Control through SWValid disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL4,       0x07, 0x00),
+	/*
+	 * VanaSysClkReq1HPValid    = disabled
+	 * Vaux1SysClkReq1HPValid   = disabled
+	 * Vaux2SysClkReq1HPValid   = disabled
+	 * Vaux3SysClkReq1HPValid   = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQ1HPVALID1, 0xe8, 0x00),
+	/*
+	 * VextSupply1SysClkReq1HPValid = disabled
+	 * VextSupply2SysClkReq1HPValid = disabled
+	 * VextSupply3SysClkReq1HPValid = SysClkReq1 controlled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQ1HPVALID2, 0x70, 0x40),
+	/*
+	 * VanaHwHPReq1Valid        = disabled
+	 * Vaux1HwHPreq1Valid       = disabled
+	 * Vaux2HwHPReq1Valid       = disabled
+	 * Vaux3HwHPReqValid        = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ1VALID1,     0xe8, 0x00),
+	/*
+	 * VextSupply1HwHPReq1Valid = disabled
+	 * VextSupply2HwHPReq1Valid = disabled
+	 * VextSupply3HwHPReq1Valid = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ1VALID2,     0x07, 0x00),
+	/*
+	 * VanaHwHPReq2Valid        = disabled
+	 * Vaux1HwHPReq2Valid       = disabled
+	 * Vaux2HwHPReq2Valid       = disabled
+	 * Vaux3HwHPReq2Valid       = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ2VALID1,     0xe8, 0x00),
+	/*
+	 * VextSupply1HwHPReq2Valid = disabled
+	 * VextSupply2HwHPReq2Valid = disabled
+	 * VextSupply3HwHPReq2Valid = HWReq2 controlled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ2VALID2,     0x07, 0x04),
+	/*
+	 * VanaSwHPReqValid         = disabled
+	 * Vaux1SwHPReqValid        = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUSWHPREQVALID1,      0xa0, 0x00),
+	/*
+	 * Vaux2SwHPReqValid        = disabled
+	 * Vaux3SwHPReqValid        = disabled
+	 * VextSupply1SwHPReqValid  = disabled
+	 * VextSupply2SwHPReqValid  = disabled
+	 * VextSupply3SwHPReqValid  = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUSWHPREQVALID2,      0x1f, 0x00),
+	/*
+	 * SysClkReq2Valid1         = SysClkReq2 controlled
+	 * SysClkReq3Valid1         = disabled
+	 * SysClkReq4Valid1         = SysClkReq4 controlled
+	 * SysClkReq5Valid1         = disabled
+	 * SysClkReq6Valid1         = SysClkReq6 controlled
+	 * SysClkReq7Valid1         = disabled
+	 * SysClkReq8Valid1         = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQVALID1,    0xfe, 0x2a),
+	/*
+	 * SysClkReq2Valid2         = disabled
+	 * SysClkReq3Valid2         = disabled
+	 * SysClkReq4Valid2         = disabled
+	 * SysClkReq5Valid2         = disabled
+	 * SysClkReq6Valid2         = SysClkReq6 controlled
+	 * SysClkReq7Valid2         = disabled
+	 * SysClkReq8Valid2         = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQVALID2,    0xfe, 0x20),
+	/*
+	 * VTVoutEna                = disabled
+	 * Vintcore12Ena            = disabled
+	 * Vintcore12Sel            = 1.25 V
+	 * Vintcore12LP             = inactive (HP)
+	 * VTVoutLP                 = inactive (HP)
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUMISC1,              0xfe, 0x10),
+	/*
+	 * VaudioEna                = disabled
+	 * VdmicEna                 = disabled
+	 * Vamic1Ena                = disabled
+	 * Vamic2Ena                = disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VAUDIOSUPPLY,           0x1e, 0x00),
+	/*
+	 * Vamic1_dzout             = high-Z when Vamic1 is disabled
+	 * Vamic2_dzout             = high-Z when Vamic2 is disabled
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUCTRL1VAMIC,         0x03, 0x00),
+	/*
+	 * VPll                     = Hw controlled (NOTE! PRCMU bits)
+	 * VanaRegu                 = force off
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VPLLVANAREGU,           0x0f, 0x02),
+	/*
+	 * VrefDDREna               = disabled
+	 * VrefDDRSleepMode         = inactive (no pulldown)
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VREFDDR,                0x03, 0x00),
+	/*
+	 * VextSupply1Regu          = force LP
+	 * VextSupply2Regu          = force OFF
+	 * VextSupply3Regu          = force HP (-> STBB2=LP and TPS=LP)
+	 * ExtSupply2Bypass         = ExtSupply12LPn ball is 0 when Ena is 0
+	 * ExtSupply3Bypass         = ExtSupply3LPn ball is 0 when Ena is 0
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_EXTSUPPLYREGU,          0xff, 0x13),
+	/*
+	 * Vaux1Regu                = force HP
+	 * Vaux2Regu                = force off
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VAUX12REGU,             0x0f, 0x01),
+	/*
+	 * Vaux3Regu                = force off
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VRF1VAUX3REGU,          0x03, 0x00),
+	/*
+	 * Vaux1Sel                 = 2.8 V
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VAUX1SEL,               0x0f, 0x0C),
+	/*
+	 * Vaux2Sel                 = 2.9 V
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VAUX2SEL,               0x0f, 0x0d),
+	/*
+	 * Vaux3Sel                 = 2.91 V
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_VRF1VAUX3SEL,           0x07, 0x07),
+	/*
+	 * VextSupply12LP           = disabled (no LP)
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUCTRL2SPARE,         0x01, 0x00),
+	/*
+	 * Vaux1Disch               = short discharge time
+	 * Vaux2Disch               = short discharge time
+	 * Vaux3Disch               = short discharge time
+	 * Vintcore12Disch          = short discharge time
+	 * VTVoutDisch              = short discharge time
+	 * VaudioDisch              = short discharge time
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUCTRLDISCH,          0xfc, 0x00),
+	/*
+	 * VanaDisch                = short discharge time
+	 * VdmicPullDownEna         = pulldown disabled when Vdmic is disabled
+	 * VdmicDisch               = short discharge time
+	 */
+	INIT_REGULATOR_REGISTER(AB8500_REGUCTRLDISCH2,         0x16, 0x00),
+};
+
+/* AB8500 regulators */
+static struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
+	/* supplies to the display/camera */
+	[AB8500_LDO_AUX1] = {
+		.supply_regulator = "ab8500-ext-supply3",
+		.constraints = {
+			.name = "V-DISPLAY",
+			.min_uV = 2800000,
+			.max_uV = 3300000,
+			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+					  REGULATOR_CHANGE_STATUS,
+			.boot_on = 1, /* display is on at boot */
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux1_consumers),
+		.consumer_supplies = ab8500_vaux1_consumers,
+	},
+	/* supplies to the on-board eMMC */
+	[AB8500_LDO_AUX2] = {
+		.supply_regulator = "ab8500-ext-supply3",
+		.constraints = {
+			.name = "V-eMMC1",
+			.min_uV = 1100000,
+			.max_uV = 3300000,
+			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+					  REGULATOR_CHANGE_STATUS |
+					  REGULATOR_CHANGE_MODE,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL |
+					    REGULATOR_MODE_IDLE,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux2_consumers),
+		.consumer_supplies = ab8500_vaux2_consumers,
+	},
+	/* supply for VAUX3, supplies to SDcard slots */
+	[AB8500_LDO_AUX3] = {
+		.supply_regulator = "ab8500-ext-supply3",
+		.constraints = {
+			.name = "V-MMC-SD",
+			.min_uV = 1100000,
+			.max_uV = 3300000,
+			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+					  REGULATOR_CHANGE_STATUS |
+					  REGULATOR_CHANGE_MODE,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL |
+					    REGULATOR_MODE_IDLE,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux3_consumers),
+		.consumer_supplies = ab8500_vaux3_consumers,
+	},
+	/* supply for tvout, gpadc, TVOUT LDO */
+	[AB8500_LDO_TVOUT] = {
+		.constraints = {
+			.name = "V-TVOUT",
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vtvout_consumers),
+		.consumer_supplies = ab8500_vtvout_consumers,
+	},
+	/* supply for ab8500-vaudio, VAUDIO LDO */
+	[AB8500_LDO_AUDIO] = {
+		.constraints = {
+			.name = "V-AUD",
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaud_consumers),
+		.consumer_supplies = ab8500_vaud_consumers,
+	},
+	/* supply for v-anamic1 VAMic1-LDO */
+	[AB8500_LDO_ANAMIC1] = {
+		.constraints = {
+			.name = "V-AMIC1",
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic1_consumers),
+		.consumer_supplies = ab8500_vamic1_consumers,
+	},
+	/* supply for v-amic2, VAMIC2 LDO, reuse constants for AMIC1 */
+	[AB8500_LDO_ANAMIC2] = {
+		.constraints = {
+			.name = "V-AMIC2",
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic2_consumers),
+		.consumer_supplies = ab8500_vamic2_consumers,
+	},
+	/* supply for v-dmic, VDMIC LDO */
+	[AB8500_LDO_DMIC] = {
+		.constraints = {
+			.name = "V-DMIC",
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vdmic_consumers),
+		.consumer_supplies = ab8500_vdmic_consumers,
+	},
+	/* supply for v-intcore12, VINTCORE12 LDO */
+	[AB8500_LDO_INTCORE] = {
+		.constraints = {
+			.name = "V-INTCORE",
+			.min_uV = 1250000,
+			.max_uV = 1350000,
+			.input_uV = 1800000,
+			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+					  REGULATOR_CHANGE_STATUS |
+					  REGULATOR_CHANGE_MODE |
+					  REGULATOR_CHANGE_DRMS,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL |
+					    REGULATOR_MODE_IDLE,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vintcore_consumers),
+		.consumer_supplies = ab8500_vintcore_consumers,
+	},
+	/* supply for U8500 CSI-DSI, VANA LDO */
+	[AB8500_LDO_ANA] = {
+		.constraints = {
+			.name = "V-CSI-DSI",
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vana_consumers),
+		.consumer_supplies = ab8500_vana_consumers,
+	},
+};
+
+/* supply for VextSupply3 */
+static struct regulator_consumer_supply ab8500_ext_supply3_consumers[] = {
+	/* SIM supply for 3 V SIM cards */
+	REGULATOR_SUPPLY("vinvsim", "sim-detect.0"),
+};
+
+/*
+ * AB8500 external regulators
+ */
+static struct regulator_init_data ab8500_ext_regulators[] = {
+	/* fixed Vbat supplies VSMPS1_EXT_1V8 */
+	[AB8500_EXT_SUPPLY1] = {
+		.constraints = {
+			.name = "ab8500-ext-supply1",
+			.min_uV = 1800000,
+			.max_uV = 1800000,
+			.initial_mode = REGULATOR_MODE_IDLE,
+			.boot_on = 1,
+			.always_on = 1,
+		},
+	},
+	/* fixed Vbat supplies VSMPS2_EXT_1V36 and VSMPS5_EXT_1V15 */
+	[AB8500_EXT_SUPPLY2] = {
+		.constraints = {
+			.name = "ab8500-ext-supply2",
+			.min_uV = 1360000,
+			.max_uV = 1360000,
+		},
+	},
+	/* fixed Vbat supplies VSMPS3_EXT_3V4 and VSMPS4_EXT_3V4 */
+	[AB8500_EXT_SUPPLY3] = {
+		.constraints = {
+			.name = "ab8500-ext-supply3",
+			.min_uV = 3400000,
+			.max_uV = 3400000,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.boot_on = 1,
+		},
+		.num_consumer_supplies =
+			ARRAY_SIZE(ab8500_ext_supply3_consumers),
+		.consumer_supplies = ab8500_ext_supply3_consumers,
+	},
+};
+
+static struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
+	.reg_init               = ab8500_reg_init,
+	.num_reg_init           = ARRAY_SIZE(ab8500_reg_init),
+	.regulator              = ab8500_regulators,
+	.num_regulator          = ARRAY_SIZE(ab8500_regulators),
+	.ext_regulator          = ab8500_ext_regulators,
+	.num_ext_regulator      = ARRAY_SIZE(ab8500_ext_regulators),
+};
+
 /**
  * struct ab8500_ext_regulator_info - ab8500 regulator information
  * @dev: device pointer
@@ -344,8 +794,7 @@ static struct of_regulator_match ab8500_ext_regulator_match[] = {
 static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
-	struct ab8500_platform_data *ppdata;
-	struct ab8500_regulator_platform_data *pdata;
+	struct ab8500_regulator_platform_data *pdata = &ab8500_regulator_plat_data;
 	struct device_node *np = pdev->dev.of_node;
 	struct regulator_config config = { };
 	int i, err;
@@ -366,18 +815,6 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ppdata = dev_get_platdata(ab8500->dev);
-	if (!ppdata) {
-		dev_err(&pdev->dev, "null parent pdata\n");
-		return -EINVAL;
-	}
-
-	pdata = ppdata->regulator;
-	if (!pdata) {
-		dev_err(&pdev->dev, "null pdata\n");
-		return -EINVAL;
-	}
-
 	/* make sure the platform data has the correct size */
 	if (pdata->num_ext_regulator != ARRAY_SIZE(ab8500_ext_regulator_info)) {
 		dev_err(&pdev->dev, "Configuration error: size mismatch.\n");
-- 
2.7.0
