From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 10 Dec 2009 19:56:44 +0100
Subject: [PATCH 4/4] MXC: imx31pdk: Trying to enabling regulators on mc13783
In-Reply-To: <1260471013.2141.49.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
	<1260470743.2141.45.camel@climbing-alby>
	<1260471013.2141.49.camel@climbing-alby>
Message-ID: <1260471404.2141.56.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch register the mc13783 power management chip on the mx31pdk board.
I know that there are too many regulators registered but this is
a trying for best match the resulting internal mc13783 registers with
the state achieved by the freescale kernel immediately before enabling
the GPO1 output. 

Signed-off-by: Alberto Panizzo <alberto.panizzo@gmail.com>
---
 arch/arm/mach-mx3/mx31pdk.c |  287 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 287 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31pdk.c b/arch/arm/mach-mx3/mx31pdk.c
index 5771d0e..3f65050 100644
--- a/arch/arm/mach-mx3/mx31pdk.c
+++ b/arch/arm/mach-mx3/mx31pdk.c
@@ -23,6 +23,9 @@
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -60,6 +63,8 @@ static int mx31pdk_pins[] = {
 	MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
 	MX31_PIN_CSPI2_SS0__SS0,
 	MX31_PIN_CSPI2_SS2__SS2, /*CS for MC13783 */
+	/* MC13783 IRQ */
+	IOMUX_MODE(MX31_PIN_GPIO1_3, IOMUX_CONFIG_GPIO),
 };
 
 /* SPI */
@@ -74,6 +79,286 @@ static struct spi_imx_master spi1_pdata = {
 	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
 };
 
+/* MC13783 */
+#define mV_to_uV(mV) (mV * 1000)
+
+static struct regulator_consumer_supply gpo_consumers[] = {
+	{
+		.supply = "REGU_GPO1",
+	}
+};
+
+static struct regulator_init_data gpo1_init = {
+	.constraints = {
+		.boot_on = 1, /* Enable it! */
+	},
+};
+
+static struct regulator_init_data gpo_init = {
+	.constraints = {
+	},
+	.num_consumer_supplies = ARRAY_SIZE(gpo_consumers),
+	.consumer_supplies = gpo_consumers,
+};
+
+static struct regulator_init_data violo_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1200), /* mc13783 allows min of 1200. */
+		.max_uV = mV_to_uV(1800), /* mc13783 allows max of 1800. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vdig_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1200), /* mc13783 allows min of 1200. */
+		.max_uV = mV_to_uV(1800), /* mc13783 allows max of 1800. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vgen_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1800), /* mc13783 allows min of 1100. */
+		.max_uV = mV_to_uV(1800), /* mc13783 allows max of 2775. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+		.apply_uV = 1,
+	}
+};
+
+static struct regulator_init_data vrfdig_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1200), /* mc13783 allows min of 1200. */
+		.max_uV = mV_to_uV(1875), /* mc13783 allows max of 1875. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vrfref_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(2475), /* mc13783 allows min of 2475. */
+		.max_uV = mV_to_uV(2775), /* mc13783 allows max of 2775. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vrfcp_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(2700), /* mc13783 allows min of 2700. */
+		.max_uV = mV_to_uV(2775), /* mc13783 allows max of 2775. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vsim_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1800), /* mc13783 allows min of 1800. */
+		.max_uV = mV_to_uV(2900), /* mc13783 allows max of 2900. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+	}
+};
+
+static struct regulator_init_data vesim_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1800), /* mc13783 allows min of 1800. */
+		.max_uV = mV_to_uV(2900), /* mc13783 allows max of 2900. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+	}
+};
+
+static struct regulator_init_data vcam_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1500), /* mc13783 allows min of 1500. */
+		.max_uV = mV_to_uV(3000), /* mc13783 allows max of 3000. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+	}
+};
+
+static struct regulator_init_data vvib_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1300), /* mc13783 allows min of 1300. */
+		.max_uV = mV_to_uV(3000), /* mc13783 allows max of 3000. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+	}
+};
+
+static struct regulator_init_data vrf_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1500), /* mc13783 allows min of 1500. */
+		.max_uV = mV_to_uV(2775), /* mc13783 allows max of 2775. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vmmc_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1600), /* mc13783 allows min of 1600. */
+		.max_uV = mV_to_uV(3000), /* mc13783 allows max of 3000. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+	}
+};
+
+static struct regulator_init_data sw3_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(5000), /* mc13783 allows min of 5000. */
+		.max_uV = mV_to_uV(5500), /* mc13783 allows max of 5500. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data sw1_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1625), /* mc13783 allows min of 1200. */
+		.max_uV = mV_to_uV(1625), /* mc13783 allows max of 1600. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		/*		  | REGULATOR_CHANGE_MODE,
+		.valid_modes_mask = REGULATOR_MODE_FAST
+				    | REGULATOR_MODE_NORMAL
+				    | REGULATOR_MODE_IDLE
+				    | REGULATOR_MODE_STANDBY,*/
+		.always_on = 1,
+		.boot_on = 1,
+		.apply_uV = 1,
+		/*.initial_state = PM_SUSPEND_MEM,
+		.state_mem = {
+			.uV = mV_to_uV(1250),
+			.mode = REGULATOR_MODE_NORMAL,
+			.enabled = 1,
+		},*/
+	}
+};
+
+static struct regulator_init_data sw_init = {
+	.constraints = {
+		.min_uV = mV_to_uV(1200), /* mc13783 allows min of 900. */
+		.max_uV = mV_to_uV(2200), /* mc13783 allows max of 2200. */
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vaudio_init = {
+	.constraints = {
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data viohi_init = {
+	.constraints = {
+		.boot_on = 1,
+	}
+};
+
+static struct regulator_init_data vrfbg_init = {
+	.constraints = {
+		.boot_on = 1,
+	}
+};
+
+static struct mc13783_regulator_init_data mx31pdk_regulators[] = {
+	{
+		.id = MC13783_SW_SW1A,
+		.init_data = &sw1_init,
+	},{
+		.id = MC13783_SW_SW1B,
+		.init_data = &sw_init,
+	},{
+		.id = MC13783_SW_SW2A,
+		.init_data = &sw_init,
+	},{
+		.id = MC13783_SW_SW2B,
+		.init_data = &sw_init,
+	},{
+		.id = MC13783_SW_SW3,
+		.init_data = &sw3_init,
+	},{
+		.id = MC13783_REGU_VVIB,
+		.init_data = &vvib_init,
+	},{
+		.id = MC13783_REGU_VAUDIO,
+		.init_data = &vaudio_init,
+	},{
+		.id = MC13783_REGU_VIOHI,
+		.init_data = &viohi_init,
+	},{
+		.id = MC13783_REGU_VIOLO,
+		.init_data = &violo_init,
+	},{
+		.id = MC13783_REGU_VRFCP,
+		.init_data = &vrfcp_init,
+	},{
+		.id = MC13783_REGU_VDIG,
+		.init_data = &vdig_init,
+	},{
+		.id = MC13783_REGU_VGEN,
+		.init_data = &vgen_init,
+	},{
+		.id = MC13783_REGU_VRFDIG,
+		.init_data = &vrfdig_init,
+	},{
+		.id = MC13783_REGU_VRFREF,
+		.init_data = &vrfref_init,
+	},{
+		.id = MC13783_REGU_VSIM,
+		.init_data = &vsim_init,
+	},{
+		.id = MC13783_REGU_VESIM,
+		.init_data = &vesim_init,
+	},{
+		.id = MC13783_REGU_VCAM,
+		.init_data = &vcam_init,
+	},{
+		.id = MC13783_REGU_VRF1,
+		.init_data = &vrf_init,
+	},{
+		.id = MC13783_REGU_VRF2,
+		.init_data = &vrf_init,
+	},{
+		.id = MC13783_REGU_VMMC1,
+		.init_data = &vmmc_init,
+	},{
+		.id = MC13783_REGU_VMMC2,
+		.init_data = &vmmc_init,
+	},{
+		.id = MC13783_REGU_GPO3, /* GPO3 -> enables SW2B 1.8V out
+					  * this becomes 1V8 on personality
+					  * board.
+					  */
+		.init_data = &gpo_init,
+	},{
+		.id = MC13783_REGU_GPO1, /* Power Enable */
+		.init_data = &gpo1_init,
+	},
+};
+
+static struct mc13783_platform_data mc13783_pdata __initdata = {
+	.regulators = mx31pdk_regulators,
+	.num_regulators = ARRAY_SIZE(mx31pdk_regulators),
+	.flags  = MC13783_USE_REGULATOR | MC13783_USE_RTC
+		| MC13783_USE_ADC,
+};
+
+static struct spi_board_info mx31pdk_spi_devs[] __initdata = {
+	{
+		.modalias	= "mc13783",
+		.max_speed_hz	= 500000,
+		.bus_num	= 1,
+		.chip_select	= 1, /* SS2 */
+		.platform_data	= &mc13783_pdata,
+		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		.mode = SPI_CS_HIGH,
+	},
+};
+
+
 
 /*
  * NAND Flash
@@ -272,7 +557,9 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_nand_device, &imx31pdk_nand_flash_pdata);
+
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
+	spi_register_board_info(mx31pdk_spi_devs, ARRAY_SIZE(mx31pdk_spi_devs));
 
 	if (!mx31pdk_init_expio())
 		platform_device_register(&smsc911x_device);
-- 
1.6.3.3
