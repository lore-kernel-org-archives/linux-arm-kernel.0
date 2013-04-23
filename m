From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Apr 2013 16:03:07 +0100
Subject: [PATCH 03/10] usb: musb: ux500: take the dma_mask from
 coherent_dma_mask
In-Reply-To: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366729394-11406-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_mask will always be the same as the coherent_dma_mask, so let's
cut down on the platform_data burden and set it as such in the driver.
This also saves us from supporting it separately when we come to enable
this driver for Device Tree.

Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/usb.c |    3 ---
 drivers/usb/musb/ux500.c  |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index 4f68a9c..e6c4a05 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -74,8 +74,6 @@ static struct ux500_musb_board_data musb_board_data = {
 	.dma_filter = stedma40_filter,
 };
 
-static u64 ux500_musb_dmamask = DMA_BIT_MASK(32);
-
 static struct musb_hdrc_platform_data musb_platform_data = {
 	.mode = MUSB_OTG,
 	.board_data = &musb_board_data,
@@ -98,7 +96,6 @@ struct platform_device ux500_musb_device = {
 	.id = 0,
 	.dev = {
 		.platform_data = &musb_platform_data,
-		.dma_mask = &ux500_musb_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources = ARRAY_SIZE(usb_resources),
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 4a8f5c9..7ddb132 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -122,7 +122,7 @@ static int ux500_probe(struct platform_device *pdev)
 	}
 
 	musb->dev.parent		= &pdev->dev;
-	musb->dev.dma_mask		= pdev->dev.dma_mask;
+	musb->dev.dma_mask		= &pdev->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= pdev->dev.coherent_dma_mask;
 
 	glue->dev			= &pdev->dev;
-- 
1.7.10.4
