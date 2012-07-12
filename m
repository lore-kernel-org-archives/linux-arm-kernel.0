From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 12 Jul 2012 13:35:29 +0200
Subject: [PATCH 2/2 v2] i.MX27: Visstrim_M10: Add support for deinterlacing
 driver.
In-Reply-To: <1342092929-31590-1-git-send-email-javier.martin@vista-silicon.com>
References: <1342092929-31590-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1342092929-31590-2-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visstrim_M10 have a tvp5150 whose video output must be deinterlaced.
The new mem2mem deinterlacing driver is very useful for that purpose.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
Changes since v1:
 - Removed commented out code.

---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 214e4ff..dbef59d 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -232,7 +232,7 @@ static void __init visstrim_camera_init(void)
 static void __init visstrim_reserve(void)
 {
 	/* reserve 4 MiB for mx2-camera */
-	mx2_camera_base = arm_memblock_steal(2 * MX2_CAMERA_BUF_SIZE,
+	mx2_camera_base = arm_memblock_steal(3 * MX2_CAMERA_BUF_SIZE,
 			MX2_CAMERA_BUF_SIZE);
 }
 
@@ -419,6 +419,30 @@ static void __init visstrim_coda_init(void)
 		return;
 }
 
+/* DMA deinterlace */
+static struct platform_device visstrim_deinterlace = {
+	.name = "m2m-deinterlace",
+	.id = 0,
+};
+
+static void __init visstrim_deinterlace_init(void)
+{
+	int ret = -ENOMEM;
+	struct platform_device *pdev = &visstrim_deinterlace;
+	int dma;
+
+	ret = platform_device_register(pdev);
+
+	dma = dma_declare_coherent_memory(&pdev->dev,
+					  mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
+					  mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
+					  MX2_CAMERA_BUF_SIZE,
+					  DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (!(dma & DMA_MEMORY_MAP))
+		return;
+}
+
+
 static void __init visstrim_m10_revision(void)
 {
 	int exp_version = 0;
@@ -481,6 +505,7 @@ static void __init visstrim_m10_board_init(void)
 	platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
 				      &iclink_tvp5150, sizeof(iclink_tvp5150));
 	gpio_led_register_device(0, &visstrim_m10_led_data);
+	visstrim_deinterlace_init();
 	visstrim_camera_init();
 	visstrim_coda_init();
 }
-- 
1.7.9.5
