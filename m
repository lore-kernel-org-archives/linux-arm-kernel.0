From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Oct 2012 00:29:29 -0300
Subject: [PATCH 1/2] ARM: mx27_3ds: Reserve memory for camera usage
Message-ID: <1349839770-13848-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Reserve dedicated memory block for camera usage.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |   32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 05996f3..d3b9a60 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
 #include <linux/spi/l4f00242t03.h>
+#include <asm/memblock.h>
 
 #include <media/soc_camera.h>
 
@@ -165,6 +166,9 @@ static const int mx27pdk_pins[] __initconst = {
 	PC19_PF_SSI4_CLK,
 };
 
+static phys_addr_t mx2_camera_base __initdata;
+#define MX27PDK_CAM_BUF_SIZE	SZ_8M
+
 static struct gpio mx27_3ds_camera_gpios[] = {
 	{ CSI_PWRDWN, GPIOF_OUT_INIT_HIGH, "camera-power" },
 	{ CSI_RESET, GPIOF_OUT_INIT_HIGH, "camera-reset" },
@@ -478,6 +482,24 @@ static const struct mx2_camera_platform_data mx27_3ds_cam_pdata __initconst = {
 	.clk = 26000000,
 };
 
+static void __init mx27pdk_init_camera(void)
+{
+	struct platform_device *pdev;
+	int dma;
+
+	pdev = imx27_add_mx2_camera(&mx27_3ds_cam_pdata);
+
+	if (IS_ERR(pdev))
+		return;
+
+	dma = dma_declare_coherent_memory(&pdev->dev,
+				mx2_camera_base, mx2_camera_base,
+				MX27PDK_CAM_BUF_SIZE,
+				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (!(dma & DMA_MEMORY_MAP))
+		return;
+}
+
 static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
@@ -527,7 +549,7 @@ static void __init mx27pdk_init(void)
 		iclink_ov2640.power = NULL;
 	}
 
-	imx27_add_mx2_camera(&mx27_3ds_cam_pdata);
+	mx27pdk_init_camera();
 	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
 
 	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
@@ -542,6 +564,13 @@ static struct sys_timer mx27pdk_timer = {
 	.init	= mx27pdk_timer_init,
 };
 
+static void __init mx27pdk_reserve(void)
+{
+	/* reserve MX27_3DS_CAMERA_BUF_SIZE bytes for mx2-camera */
+	mx2_camera_base = arm_memblock_steal(MX27PDK_CAM_BUF_SIZE,
+						MX27PDK_CAM_BUF_SIZE);
+}
+
 MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	/* maintainer: Freescale Semiconductor, Inc. */
 	.atag_offset = 0x100,
@@ -551,5 +580,6 @@ MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	.handle_irq = imx27_handle_irq,
 	.timer = &mx27pdk_timer,
 	.init_machine = mx27pdk_init,
+	.reserve = mx27pdk_reserve,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
1.7.9.5
