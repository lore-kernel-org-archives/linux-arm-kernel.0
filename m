From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 15:07:54 +0800
Subject: [PATCH] ARM: imx: fix error handling in ipu device registration
Message-ID: <1400483274-13680-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Goode <emilgoode@gmail.com>

If we fail to allocate struct platform_device pdev we
dereference it after the goto label err.

This bug was found using coccinelle.

Fixes: afa77ef (ARM: mx3: dynamically allocate "ipu-core" devices)
Signed-off-by: Emil Goode <emilgoode@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Arnd, Olof,

Please consider to apply this fix for 3.15.  Thanks.

Shawn

 arch/arm/mach-imx/devices/platform-ipu-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
index fc4dd7c..6bd7c3f 100644
--- a/arch/arm/mach-imx/devices/platform-ipu-core.c
+++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
@@ -77,7 +77,7 @@ struct platform_device *__init imx_alloc_mx3_camera(
 
 	pdev = platform_device_alloc("mx3-camera", 0);
 	if (!pdev)
-		goto err;
+		return ERR_PTR(-ENOMEM);
 
 	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
 	if (!pdev->dev.dma_mask)
-- 
1.8.3.2
