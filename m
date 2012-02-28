From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue, 28 Feb 2012 17:31:51 +0100
Subject: [PATCH v2 4/4] i.MX27: visstrim_m10: Add video support.
In-Reply-To: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
References: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1330446711-6970-5-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vista Silicon Visstrim_m10 board has a tvp5150
video decoder attached to the CSI interface

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |  100 +++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3d82133..8102e7f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -320,6 +320,7 @@ config MACH_IMX27_VISSTRIM_M10
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MX2_CAMERA
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 479d9e8..7208a9e 100644
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
 
@@ -100,8 +105,99 @@ static const int visstrim_m10_pins[] __initconst = {
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
@@ -267,6 +363,9 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_fec(NULL);
 	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
+				      &iclink_tvp5150, sizeof(iclink_tvp5150));
+	visstrim_camera_init();
 }
 
 static void __init visstrim_m10_timer_init(void)
@@ -280,6 +379,7 @@ static struct sys_timer visstrim_m10_timer = {
 
 MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
 	.atag_offset = 0x100,
+	.reserve = visstrim_reserve,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-- 
1.7.0.4
