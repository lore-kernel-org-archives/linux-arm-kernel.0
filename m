From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 16 Feb 2012 17:24:22 +0100
Subject: [PATCH] i.MX27: visstrim_m10: Add video support.
Message-ID: <1329409462-20072-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vista Silicon Visstrim_m10 board has a tvp5150
video decoder attached to the CSI interface.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |  113 ++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4defb97..f994f10 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -322,6 +322,7 @@ config MACH_IMX27_VISSTRIM_M10
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MX2_CAMERA
 	help
 	  Include support for Visstrim_m10 platform and its different variants.
 	  This includes specific configurations for the board and its
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index c2766ae..40da83a 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -30,6 +30,9 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/memblock.h>
+#include <media/soc_camera.h>
 #include <sound/tlv320aic32x4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +42,8 @@
 
 #include "devices-imx27.h"
 
+#define TVP5150_RSTN (GPIO_PORTC + 18)
+#define TVP5150_PWDN (GPIO_PORTC + 19)
 #define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
 #define SDHC1_IRQ IRQ_GPIOB(25)
 
@@ -100,8 +105,108 @@ static const int visstrim_m10_pins[] __initconst = {
 	PE1_PF_USBOTG_STP,
 	PB23_PF_USB_PWR,
 	PB24_PF_USB_OC,
+	/* CSI */
+	PB10_PF_CSI_D0,
+	PB11_PF_CSI_D1,
+	PB12_PF_CSI_D2,
+	PB13_PF_CSI_D3,
+	PB14_PF_CSI_D4,
+	PB15_PF_CSI_MCLK,
+	PB16_PF_CSI_PIXCLK,
+	PB17_PF_CSI_D5,
+	PB18_PF_CSI_D6,
+	PB19_PF_CSI_D7,
+	PB20_PF_CSI_VSYNC,
+	PB21_PF_CSI_HSYNC,
 };
 
+/* Camera */
+static int visstrim_camera_power(struct device *dev, int on)
+{
+	gpio_set_value(TVP5150_PWDN, on);
+
+	return 0;
+};
+
+static int visstrim_camera_reset(struct device *dev)
+{
+	gpio_set_value(TVP5150_RSTN, 0);
+	ndelay(500);
+	gpio_set_value(TVP5150_RSTN, 1);
+
+	return 0;
+};
+
+static struct i2c_board_info visstrim_i2c_camera =  {
+	I2C_BOARD_INFO("tvp5150", 0x5d),
+};
+
+static struct soc_camera_link iclink_tvp5150 = {
+	.bus_id         = 0,
+	.board_info     = &visstrim_i2c_camera,
+	.i2c_adapter_id = 0,
+	.power = visstrim_camera_power,
+	.reset = visstrim_camera_reset,
+};
+
+static struct platform_device visstrim_tvp5150 = {
+	.name   = "soc-camera-pdrv",
+	.id     = 0,
+	.dev    = {
+		.platform_data = &iclink_tvp5150,
+	},
+};
+
+
+static struct mx2_camera_platform_data visstrim_camera = {
+	.flags = MX2_CAMERA_CCIR | MX2_CAMERA_CCIR_INTERLACE |
+			MX2_CAMERA_SWAP16 | MX2_CAMERA_PCLK_SAMPLE_RISING,
+	.clk = 100000,
+};
+
+static phys_addr_t mx2_camera_base __initdata;
+#define MX2_CAMERA_BUF_SIZE SZ_8M
+
+static void __init visstrim_camera_init(void)
+{
+	struct platform_device *pdev;
+	int dma;
+
+	/* Initialize tvp5150 gpios */
+	mxc_gpio_mode(TVP5150_RSTN | GPIO_GPIO | GPIO_OUT);
+	mxc_gpio_mode(TVP5150_PWDN | GPIO_GPIO | GPIO_OUT);
+	gpio_set_value(TVP5150_RSTN, 1);
+	gpio_set_value(TVP5150_PWDN, 0);
+	ndelay(1);
+
+	gpio_set_value(TVP5150_PWDN, 1);
+	ndelay(1);
+	gpio_set_value(TVP5150_RSTN, 0);
+	ndelay(500);
+	gpio_set_value(TVP5150_RSTN, 1);
+	ndelay(200000);
+
+	pdev = imx27_add_mx2_camera(&visstrim_camera);
+	if (IS_ERR(pdev))
+		return;
+
+	dma = dma_declare_coherent_memory(&pdev->dev,
+				mx2_camera_base, mx2_camera_base,
+				MX2_CAMERA_BUF_SIZE,
+				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (!(dma & DMA_MEMORY_MAP))
+		return;
+}
+
+static void __init visstrim_reserve(void)
+{
+	/* reserve 4 MiB for mx2-camera */
+	mx2_camera_base = memblock_alloc(MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE);
+	memblock_free(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
+	memblock_remove(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
+}
+
 /* GPIOs used as events for applications */
 static struct gpio_keys_button visstrim_gpio_keys[] = {
 	{
@@ -180,6 +285,7 @@ static struct platform_device visstrim_m10_nor_mtd_device = {
 
 static struct platform_device *platform_devices[] __initdata = {
 	&visstrim_m10_nor_mtd_device,
+	&visstrim_tvp5150,
 };
 
 /* Visstrim_M10 uses UART0 as console */
@@ -254,15 +360,17 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_imx_ssi(0, &visstrim_m10_ssi_pdata);
 	imx27_add_imx_uart0(&uart_pdata);
 
-	i2c_register_board_info(0, visstrim_m10_i2c_devices,
-				ARRAY_SIZE(visstrim_m10_i2c_devices));
 	imx27_add_imx_i2c(0, &visstrim_m10_i2c_data);
 	imx27_add_imx_i2c(1, &visstrim_m10_i2c_data);
+	i2c_register_board_info(0, visstrim_m10_i2c_devices,
+				ARRAY_SIZE(visstrim_m10_i2c_devices));
+
 	imx27_add_mxc_mmc(0, &visstrim_m10_sdhc_pdata);
 	imx27_add_mxc_ehci_otg(&visstrim_m10_usbotg_pdata);
 	imx27_add_fec(NULL);
 	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	visstrim_camera_init();
 }
 
 static void __init visstrim_m10_timer_init(void)
@@ -276,6 +384,7 @@ static struct sys_timer visstrim_m10_timer = {
 
 MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
 	.atag_offset = 0x100,
+	.reserve = visstrim_reserve,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-- 
1.7.0.4
