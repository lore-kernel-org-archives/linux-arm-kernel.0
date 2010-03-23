From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 23 Mar 2010 19:51:45 +0100
Subject: [PATCH 4/8] MXC: mach-mx31_3ds: add support for freescale mc13783
	power management device.
In-Reply-To: <1269370228.3276.169.camel@realization>
References: <1269369741.3276.162.camel@realization>
	<1269370017.3276.165.camel@realization>
	<1269370175.3276.168.camel@realization>
	<1269370228.3276.169.camel@realization>
Message-ID: <1269370305.3276.171.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Power Gates must to be always enabled.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   45 +++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 80179cf..f54af1e 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -23,6 +23,9 @@
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -60,6 +63,33 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
 	MX31_PIN_CSPI2_SS0__SS0,
 	MX31_PIN_CSPI2_SS2__SS2, /*CS for MC13783 */
+	/* MC13783 IRQ */
+	IOMUX_MODE(MX31_PIN_GPIO1_3, IOMUX_CONFIG_GPIO),
+};
+
+/* Regulators */
+static struct regulator_init_data pwgtx_init = {
+	.constraints = {
+		.boot_on	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
+	{
+		.id = MC13783_REGU_PWGT1SPI, /* Power Gate for ARM core. */
+		.init_data = &pwgtx_init,
+	}, {
+		.id = MC13783_REGU_PWGT2SPI, /* Power Gate for L2 Cache. */
+		.init_data = &pwgtx_init,
+	},
+};
+
+/* MC13783 */
+static struct mc13783_platform_data mc13783_pdata __initdata = {
+	.regulators = mx31_3ds_regulators,
+	.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
+	.flags  = MC13783_USE_REGULATOR,
 };
 
 /* SPI */
@@ -73,6 +103,18 @@ static struct spi_imx_master spi1_pdata = {
 	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
 };
 
+static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
+	{
+		.modalias	= "mc13783",
+		.max_speed_hz	= 1000000,
+		.bus_num	= 1,
+		.chip_select	= 1, /* SS2 */
+		.platform_data	= &mc13783_pdata,
+		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		.mode = SPI_CS_HIGH,
+	},
+};
+
 /*
  * NAND Flash
  */
@@ -268,7 +310,10 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_nand_device, &imx31_3ds_nand_flash_pdata);
+
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
+	spi_register_board_info(mx31_3ds_spi_devs,
+						ARRAY_SIZE(mx31_3ds_spi_devs));
 
 	if (!mx31_3ds_init_expio())
 		platform_device_register(&smsc911x_device);
-- 
1.6.3.3
