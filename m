From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 14 Nov 2012 16:20:36 -0200
Subject: [PATCH v2 1/2] ARM: mx27: Add VPU support
Message-ID: <1352917238-29694-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27 has a VPU (Video Processing Unit) block that allows doing H264/MPEG4
decoding and encoding in hardware.

Add support for it in a common SoC file instead of per board file.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Javier,

I removed dma_declare_coherent_memory call, as per Sascha's suggestion on my
first submission of adding mx27pdk VPU support. Hope this is ok with you.

Changes since v1:
- Call imx27_add_coda() on a common mx27 location instead of per board.
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   18 ------------------
 arch/arm/mach-imx/mm-imx27.c                |    3 ++-
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index b744226..ee9cbff 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -434,23 +434,6 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 	.flags			= IMX_SSI_DMA | IMX_SSI_SYN,
 };
 
-/* coda */
-
-static void __init visstrim_coda_init(void)
-{
-	struct platform_device *pdev;
-	int dma;
-
-	pdev = imx27_add_coda();
-	dma = dma_declare_coherent_memory(&pdev->dev,
-					  mx2_camera_base + MX2_CAMERA_BUF_SIZE,
-					  mx2_camera_base + MX2_CAMERA_BUF_SIZE,
-					  MX2_CAMERA_BUF_SIZE,
-					  DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
-	if (!(dma & DMA_MEMORY_MAP))
-		return;
-}
-
 /* DMA deinterlace */
 static struct platform_device visstrim_deinterlace = {
 	.name = "m2m-deinterlace",
@@ -548,7 +531,6 @@ static void __init visstrim_m10_board_init(void)
 	gpio_led_register_device(0, &visstrim_m10_led_data);
 	visstrim_deinterlace_init();
 	visstrim_camera_init();
-	visstrim_coda_init();
 }
 
 static void __init visstrim_m10_timer_init(void)
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 4f1be65..fddadb1 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -25,9 +25,9 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include "devices/devices-common.h"
 #include "hardware.h"
 #include "iomux-v1.h"
+#include "devices-imx27.h"
 
 /* MX27 memory map definition */
 static struct map_desc imx27_io_desc[] __initdata = {
@@ -98,4 +98,5 @@ void __init imx27_soc_init(void)
 	/* imx27 has the imx21 type audmux */
 	platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
 					ARRAY_SIZE(imx27_audmux_res));
+	imx27_add_coda();
 }
-- 
1.7.9.5
