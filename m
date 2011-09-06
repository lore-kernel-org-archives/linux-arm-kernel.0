From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Tue, 6 Sep 2011 16:01:36 -0300
Subject: [PATCH 4/4] ARM: mx53_ard: Add flexcan support
In-Reply-To: <1315335696-20499-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1315335696-20499-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1315335696-20499-4-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding flexcan support on i.MX53 ARD

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index fb4c503..7c911d1 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -205,6 +205,7 @@ config MACH_MX53_LOCO
 config MACH_MX53_ARD
 	bool "Support MX53 ARD platforms"
 	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..e5f174b 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -44,6 +44,8 @@
 #define ARD_BACK			IMX_GPIO_NR(5, 11)
 #define ARD_PROG			IMX_GPIO_NR(5, 12)
 #define ARD_VOLUMEUP		IMX_GPIO_NR(5, 13)
+#define ARD_CAN_EN		IMX_GPIO_NR(7, 6)
+#define ARD_CAN_STBY		IMX_GPIO_NR(4, 15)
 
 static iomux_v3_cfg_t mx53_ard_pads[] = {
 	/* UART1 */
@@ -102,6 +104,13 @@ static iomux_v3_cfg_t mx53_ard_pads[] = {
 	MX53_PAD_DISP0_DAT18__GPIO5_12,	/* prog */
 	MX53_PAD_DISP0_DAT19__GPIO5_13,	/* vol up */
 	MX53_PAD_GPIO_10__GPIO4_0,		/* vol down */
+	/* CAN */
+	MX53_PAD_KEY_COL2__CAN1_TXCAN,
+	MX53_PAD_KEY_ROW2__CAN1_RXCAN,
+	MX53_PAD_PATA_RESET_B__CAN2_TXCAN,
+	MX53_PAD_PATA_IORDY__CAN2_RXCAN,
+	MX53_PAD_PATA_DA_0__GPIO7_6,
+	MX53_PAD_KEY_ROW4__GPIO4_15,
 };
 
 #define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
@@ -171,6 +180,8 @@ static struct imxi2c_platform_data mx53_ard_i2c3_data = {
 
 static void __init mx53_ard_io_init(void)
 {
+	int ret;
+
 	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
 				ARRAY_SIZE(mx53_ard_pads));
 
@@ -179,6 +190,14 @@ static void __init mx53_ard_io_init(void)
 
 	gpio_request(ARD_I2CPORTEXP_B, "i2cptexp-rst");
 	gpio_direction_output(ARD_I2CPORTEXP_B, 1);
+
+	ret = gpio_request_one(ARD_CAN_EN, GPIOF_OUT_INIT_HIGH, "can-en");
+	if (ret)
+		pr_err("Cannot request ARD_CAN_EN pin: %d\n", ret);
+
+	ret = gpio_request_one(ARD_CAN_STBY, GPIOF_OUT_INIT_HIGH, "can-stby");
+	if (ret)
+		pr_err("Cannot request ARD_CAN_STBY pin: %d\n", ret);
 }
 
 /* Config CS1 settings for ethernet controller */
@@ -234,6 +253,8 @@ static void __init mx53_ard_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
 	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
 	imx_add_gpio_keys(&ard_button_data);
+	imx53_add_flexcan0(NULL);
+	imx53_add_flexcan1(NULL);
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1
