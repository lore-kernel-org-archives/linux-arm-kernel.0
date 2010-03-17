From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 17:33:22 -0400
Subject: [PATCH] [ARM] mmp: enable ssp in aspenite
Message-ID: <mailman.252.1269014121.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure both ssp and wm8753 in aspenite.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index a2d307e..244655d 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -59,6 +59,13 @@ static unsigned long common_pin_config[] __initdata = {
 	/* UART1 */
 	GPIO107_UART1_RXD,
 	GPIO108_UART1_TXD,
+
+	/* SSP1 */
+	GPIO113_I2S_MCLK,
+	GPIO114_I2S_FRM,
+	GPIO115_I2S_BCLK,
+	GPIO116_I2S_RXD,
+	GPIO117_I2S_TXD,
 };

 static struct smc91x_platdata smc91x_info = {
@@ -123,12 +130,18 @@ static struct pxa3xx_nand_platform_data
aspenite_nand_info = {
 	.nr_parts	= ARRAY_SIZE(aspenite_nand_partitions),
 };

+static struct i2c_board_info aspenite_i2c_info[] __initdata = {
+	{ I2C_BOARD_INFO("wm8753", 0x1b), },
+};
+
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));

 	/* on-chip devices */
 	pxa168_add_uart(1);
+	pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
+	pxa168_add_ssp(1);
 	pxa168_add_nand(&aspenite_nand_info);

 	/* off-chip devices */
-- 
1.5.6.5
