From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Oct 2012 00:29:30 -0300
Subject: [PATCH 2/2] ARM: mx27_3ds: Add VPU support
In-Reply-To: <1349839770-13848-1-git-send-email-festevam@gmail.com>
References: <1349839770-13848-1-git-send-email-festevam@gmail.com>
Message-ID: <1349839770-13848-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mx27 has a VPU (Video Processing Unit) block that allows doing H264/MPEG4
decoding and encoding in hardware.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index d3b9a60..3ef8548 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -500,6 +500,21 @@ static void __init mx27pdk_init_camera(void)
 		return;
 }
 
+static void __init mx27pdk_init_vpu(void)
+{
+	struct platform_device *pdev;
+	int dma;
+
+	pdev = imx27_add_coda();
+	dma = dma_declare_coherent_memory(&pdev->dev,
+					  mx2_camera_base + MX27PDK_CAM_BUF_SIZE,
+					  mx2_camera_base + MX27PDK_CAM_BUF_SIZE,
+					  MX27PDK_CAM_BUF_SIZE,
+					  DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (!(dma & DMA_MEMORY_MAP))
+		return;
+}
+
 static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
@@ -553,6 +568,7 @@ static void __init mx27pdk_init(void)
 	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
 
 	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
+	mx27pdk_init_vpu();
 }
 
 static void __init mx27pdk_timer_init(void)
@@ -567,7 +583,7 @@ static struct sys_timer mx27pdk_timer = {
 static void __init mx27pdk_reserve(void)
 {
 	/* reserve MX27_3DS_CAMERA_BUF_SIZE bytes for mx2-camera */
-	mx2_camera_base = arm_memblock_steal(MX27PDK_CAM_BUF_SIZE,
+	mx2_camera_base = arm_memblock_steal(3 * MX27PDK_CAM_BUF_SIZE,
 						MX27PDK_CAM_BUF_SIZE);
 }
 
-- 
1.7.9.5
