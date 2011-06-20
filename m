From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 20 Jun 2011 13:48:38 -0300
Subject: [PATCH 2/6] ARM: mach-imx/mx27_3ds: Fix regulator support
In-Reply-To: <1308588522-16586-1-git-send-email-fabio.estevam@freescale.com>
References: <1308588522-16586-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308588522-16586-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the 2.8V (VMMC1) and 1.8V (VGEN) voltage generation on mx27_3ds.

Also configure the IOMUX for the PMIC interrupt pin and for the CSPI chip select that is connected
to the MC13783 PMIC.
 
In order to get the voltage for the LCD (2.8V and 1.8V) it is also necessary to turn on GPO1 and GPO3 
supplies because they are connected to switches that enable these two voltages.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 5b1e0fc..be68e2d 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -46,6 +46,7 @@
 #define OTG_PHY_RESET_GPIO 	IMX_GPIO_NR(2, 23)
 #define SPI2_SS0 		IMX_GPIO_NR(4, 21)
 #define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTC + 28)
+#define PMIC_INT		IMX_GPIO_NR(3, 14)
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
@@ -193,6 +194,13 @@ static int __init mx27_3ds_otg_mode(char *options)
 __setup("otg_mode=", mx27_3ds_otg_mode);
 
 /* Regulators */
+static struct regulator_init_data gpo_init = {
+	.constraints = {
+		.boot_on = 1,
+		.always_on = 1,
+	}
+};
+
 static struct regulator_consumer_supply vmmc1_consumers[] = {
 	REGULATOR_SUPPLY("lcd_2v8", NULL),
 };
@@ -201,7 +209,9 @@ static struct regulator_init_data vmmc1_init = {
 	.constraints = {
 		.min_uV	= 2800000,
 		.max_uV = 2800000,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies = ARRAY_SIZE(vmmc1_consumers),
 	.consumer_supplies = vmmc1_consumers,
@@ -215,7 +225,9 @@ static struct regulator_init_data vgen_init = {
 	.constraints = {
 		.min_uV	= 1800000,
 		.max_uV = 1800000,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies = ARRAY_SIZE(vgen_consumers),
 	.consumer_supplies = vgen_consumers,
@@ -228,6 +240,12 @@ static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_VGEN,
 		.init_data = &vgen_init,
+	}, {
+		.id = MC13783_REG_GPO1, /* Turn on 1.8V */
+		.init_data = &gpo_init,
+	}, {
+		.id = MC13783_REG_GPO3, /* Turn on 3.3V */
+		.init_data = &gpo_init,
 	},
 };
 
@@ -287,6 +305,9 @@ static void __init mx27pdk_init(void)
 
 	if (!otg_mode_host)
 		imx27_add_fsl_usb2_udc(&otg_device_pdata);
+
+	mxc_gpio_mode(SPI2_SS0 | GPIO_GPIO | GPIO_OUT);
+	mxc_gpio_mode(PMIC_INT | GPIO_GPIO | GPIO_IN);
 
 	imx27_add_spi_imx1(&spi2_pdata);
 	spi_register_board_info(mx27_3ds_spi_devs,
-- 
1.6.0.4
