From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Jun 2011 09:25:24 -0300
Subject: [PATCH v2 2/6] ARM: mach-imx/mx27_3ds: Fix regulator support
In-Reply-To: <1308745528-22089-1-git-send-email-fabio.estevam@freescale.com>
References: <1308745528-22089-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308745528-22089-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the 2.8V (VMMC1) and 1.8V (VGEN) voltage generation on mx27_3ds.

Also configure the IOMUX for the PMIC interrupt pin and for the CSPI chip select that is connected
to the MC13783 PMIC.
 
In order to get the voltage for the LCD (2.8V and 1.8V) it is also necessary to turn on GPO1 and GPO3 
supplies because they are connected to switches that enable these two voltages.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased on Sascha's for-next branch
- Place GPIOs IOMUX into static array

 arch/arm/mach-imx/mach-mx27_3ds.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 3a58448..eb66310 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -46,6 +46,7 @@
 #define OTG_PHY_RESET_GPIO	IMX_GPIO_NR(2, 23)
 #define SPI2_SS0		IMX_GPIO_NR(4, 21)
 #define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(3, 28))
+#define PMIC_INT		IMX_GPIO_NR(3, 14)
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
@@ -98,9 +99,12 @@ static const int mx27pdk_pins[] __initconst = {
 	PD22_PF_CSPI2_SCLK,
 	PD23_PF_CSPI2_MISO,
 	PD24_PF_CSPI2_MOSI,
+	SPI2_SS0 | GPIO_GPIO | GPIO_OUT,
 	/* I2C1 */
 	PD17_PF_I2C_DATA,
 	PD18_PF_I2C_CLK,
+	/* PMIC INT */
+	PMIC_INT | GPIO_GPIO | GPIO_IN,
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -193,6 +197,13 @@ static int __init mx27_3ds_otg_mode(char *options)
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
@@ -201,7 +212,9 @@ static struct regulator_init_data vmmc1_init = {
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
@@ -228,6 +241,12 @@ static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
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
 
-- 
1.6.0.4
