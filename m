From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 25 Nov 2010 22:28:32 +0800
Subject: [PATCH 1/1] arm: imx: share imx5x_register_gpios for mach-mx5
Message-ID: <1290695312-30031-1-git-send-email-linuxzsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@freescale.com>

Add variable mx5x_gpio_port_cnt, and init in machine init function.
It can be share by mx51, mx53 and coming mx50.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>

diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 5ff5522..cd7bd4c 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -242,6 +242,8 @@ __setup("otg_mode=", eukrea_cpuimx51_otg_mode);
  */
 static void __init eukrea_cpuimx51_init(void)
 {
+	mx5x_gpio_port_cnt = 4;
+
 	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx51_pads,
 					ARRAY_SIZE(eukrea_cpuimx51_pads));
 
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ff1f45e..e47345a 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -262,6 +262,8 @@ static struct platform_device *platform_devices[] __initdata = {
 
 static void __init eukrea_cpuimx51sd_init(void)
 {
+	mx5x_gpio_port_cnt = 4;
+
 	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx51sd_pads,
 					ARRAY_SIZE(eukrea_cpuimx51sd_pads));
 
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 6cc2805..cb22fc3 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -160,6 +160,8 @@ static struct spi_board_info mx51_3ds_spi_nor_device[] = {
  */
 static void __init mxc_board_init(void)
 {
+	mx5x_gpio_port_cnt = 4;
+
 	mxc_iomux_v3_setup_multiple_pads(mx51_3ds_pads,
 					ARRAY_SIZE(mx51_3ds_pads));
 	mxc_init_imx_uart();
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index ef32843..8054c09 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -347,9 +347,12 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
  */
 static void __init mxc_board_init(void)
 {
+	mx5x_gpio_port_cnt = 4;
+
 	iomux_v3_cfg_t usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
 	iomux_v3_cfg_t power_key = MX51_PAD_EIM_A27__GPIO_2_21;
 
+	mx5x_gpio_port_cnt = 4;
 #if defined(CONFIG_CPU_FREQ_IMX)
 	get_cpu_op = mx51_get_cpu_op;
 #endif
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index 4b2718b..cf315cb 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -314,6 +314,8 @@ void mx51_efikamx_reset(void)
 
 static void __init mxc_board_init(void)
 {
+	mx5x_gpio_port_cnt = 4;
+
 	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
 					ARRAY_SIZE(mx51efikamx_pads));
 	mx51_efikamx_board_id();
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index d926203..b8371d2 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -183,13 +183,11 @@ static struct mxc_gpio_port mxc_gpio_ports[] = {
 	},
 };
 
-int __init imx51_register_gpios(void)
-{
-	return mxc_gpio_init(mxc_gpio_ports, 4);
-}
+int mx5x_gpio_port_cnt;
 
-int __init imx53_register_gpios(void)
+int __init imx5x_register_gpios(void)
 {
-	return mxc_gpio_init(mxc_gpio_ports, ARRAY_SIZE(mxc_gpio_ports));
+	if (mx5x_gpio_port_cnt)
+		return mxc_gpio_init(mxc_gpio_ports, mx5x_gpio_port_cnt);
+	return -EINVAL;
 }
-
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index af1d07c..d3411dc 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -4,3 +4,5 @@ extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_hsi2c_device;
 extern struct platform_device mxc_keypad_device;
+
+extern int mx5x_gpio_port_cnt;
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index e57f968..b0ea57b 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -61,7 +61,7 @@ void __init mx53_map_io(void)
 	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
 }
 
-int imx51_register_gpios(void);
+int imx5x_register_gpios(void);
 
 void __init mx51_init_irq(void)
 {
@@ -78,11 +78,9 @@ void __init mx51_init_irq(void)
 		panic("unable to map TZIC interrupt controller\n");
 
 	tzic_init_irq(tzic_virt);
-	imx51_register_gpios();
+	imx5x_register_gpios();
 }
 
-int imx53_register_gpios(void);
-
 void __init mx53_init_irq(void)
 {
 	unsigned long tzic_addr;
@@ -95,5 +93,5 @@ void __init mx53_init_irq(void)
 		panic("unable to map TZIC interrupt controller\n");
 
 	tzic_init_irq(tzic_virt);
-	imx53_register_gpios();
+	imx5x_register_gpios();
 }
-- 
1.7.1
