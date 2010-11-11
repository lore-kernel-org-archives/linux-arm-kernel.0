From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 11 Nov 2010 04:42:40 -0800 (PST)
Subject: [PATCH] mx51_babbage: Add initial PMIC support
Message-ID: <86142.50086.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX51 Babbage board has a MC13892 PMIC.

Add the initial support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 66b07d8..a48f7c4 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -22,6 +22,8 @@
 #include <linux/input.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <linux/mfd/mc13xxx.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -45,6 +47,8 @@
 #define BABBAGE_POWER_KEY	(1*32 + 21)	/* GPIO_2_21 */
 #define BABBAGE_ECSPI1_CS0	(3*32 + 24)	/* GPIO_4_24 */
 #define BABBAGE_ECSPI1_CS1	(3*32 + 25)	/* GPIO_4_25 */
+#define BABBAGE_PMIC_GPIO	(0*32 + 8)	/* GPIO_1_8 */
+#define BABBAGE_PMIC_IRQ	(MXC_INTERNAL_IRQS + BABBAGE_PMIC_GPIO)
 
 /* USB_CTRL_1 */
 #define MX51_USB_CTRL_1_OFFSET			0x10
@@ -158,6 +162,9 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
 	MX51_PAD_CSPI1_SS0__GPIO_4_24,
 	MX51_PAD_CSPI1_SS1__GPIO_4_25,
+
+	/* PMIC Interrupt */
+	MX51_PAD_GPIO_1_8__GPIO_1_8,
 };
 
 /* Serial ports */
@@ -321,6 +328,17 @@ static int __init babbage_otg_mode(char *options)
 }
 __setup("otg_mode=", babbage_otg_mode);
 
+static struct mc13xxx_regulator_init_data mx51_babbage_regulators[] = {
+
+/*TODO: Add regulator list */
+
+};
+
+static struct mc13xxx_platform_data mc13xxx_pdata __initdata = {
+	.regulators = mx51_babbage_regulators,
+	.num_regulators = ARRAY_SIZE(mx51_babbage_regulators),
+	.flags  = MC13XXX_USE_REGULATOR,
+};
 static struct spi_board_info mx51_babbage_spi_board_info[] __initdata = {
 	{
 		.modalias = "mtd_dataflash",
@@ -329,6 +347,13 @@ static struct spi_board_info mx51_babbage_spi_board_info[] __initdata = {
 		.chip_select = 1,
 		.mode = SPI_MODE_0,
 		.platform_data = NULL,
+	}, {
+		.modalias = "mc13892",
+		.max_speed_hz = 6000000,
+		.bus_num = 0,
+		.chip_select = 0,
+		.irq = BABBAGE_PMIC_IRQ,
+		.platform_data = &mc13xxx_pdata,
 	},
 };
 
-- 
1.6.0.4



      
