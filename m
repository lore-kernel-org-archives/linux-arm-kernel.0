From: javier.martin@vista-silicon.com (Javier Martin)
Date: Mon,  9 Jul 2012 11:17:17 +0200
Subject: [PATCH v2 3/3] Visstrim M10: Add support for Coda.
In-Reply-To: <1341825437-23420-1-git-send-email-javier.martin@vista-silicon.com>
References: <1341825437-23420-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1341825437-23420-2-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the codadx6 that is included in
the i.MX27 SoC.
---
Changes since v1:
 - Use 'arm_memblock_steal'.

---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index f76edb9..214e4ff 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -32,12 +32,12 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/leds.h>
-#include <linux/memblock.h>
 #include <media/soc_camera.h>
 #include <sound/tlv320aic32x4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/memblock.h>
 #include <asm/system.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
@@ -232,10 +232,8 @@ static void __init visstrim_camera_init(void)
 static void __init visstrim_reserve(void)
 {
 	/* reserve 4 MiB for mx2-camera */
-	mx2_camera_base = memblock_alloc(MX2_CAMERA_BUF_SIZE,
+	mx2_camera_base = arm_memblock_steal(2 * MX2_CAMERA_BUF_SIZE,
 			MX2_CAMERA_BUF_SIZE);
-	memblock_free(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
-	memblock_remove(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
 }
 
 /* GPIOs used as events for applications */
@@ -404,6 +402,23 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 	.flags			= IMX_SSI_DMA | IMX_SSI_SYN,
 };
 
+/* coda */
+
+static void __init visstrim_coda_init(void)
+{
+	struct platform_device *pdev;
+	int dma;
+
+	pdev = imx27_add_coda();
+	dma = dma_declare_coherent_memory(&pdev->dev,
+					  mx2_camera_base + MX2_CAMERA_BUF_SIZE,
+					  mx2_camera_base + MX2_CAMERA_BUF_SIZE,
+					  MX2_CAMERA_BUF_SIZE,
+					  DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (!(dma & DMA_MEMORY_MAP))
+		return;
+}
+
 static void __init visstrim_m10_revision(void)
 {
 	int exp_version = 0;
@@ -467,6 +482,7 @@ static void __init visstrim_m10_board_init(void)
 				      &iclink_tvp5150, sizeof(iclink_tvp5150));
 	gpio_led_register_device(0, &visstrim_m10_led_data);
 	visstrim_camera_init();
+	visstrim_coda_init();
 }
 
 static void __init visstrim_m10_timer_init(void)
-- 
1.7.9.5
