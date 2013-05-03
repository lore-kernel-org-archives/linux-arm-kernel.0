From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:31 +0100
Subject: [PATCH 45/63] usb: musb: ux500: move the MUSB HDRC configuration into
 the driver
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-46-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MUSB HDRC configuration never changes between each of the ux500
supported platforms, so there's little point passing it though platform
data. If we set it in the driver instead, we can make good use of it
when booting with either ATAGs or Device Tree.

Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb at vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/usb.c |    8 --------
 drivers/usb/musb/ux500.c  |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index 8aff9a4..4f68a9c 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -76,16 +76,8 @@ static struct ux500_musb_board_data musb_board_data = {
 
 static u64 ux500_musb_dmamask = DMA_BIT_MASK(32);
 
-static struct musb_hdrc_config musb_hdrc_config = {
-	.multipoint	= true,
-	.dyn_fifo	= true,
-	.num_eps	= 16,
-	.ram_bits	= 16,
-};
-
 static struct musb_hdrc_platform_data musb_platform_data = {
 	.mode = MUSB_OTG,
-	.config = &musb_hdrc_config,
 	.board_data = &musb_board_data,
 };
 
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 13a3929..4a8f5c9 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -29,6 +29,13 @@
 
 #include "musb_core.h"
 
+static struct musb_hdrc_config ux500_musb_hdrc_config = {
+	.multipoint	= true,
+	.dyn_fifo	= true,
+	.num_eps	= 16,
+	.ram_bits	= 16,
+};
+
 struct ux500_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
@@ -123,6 +130,7 @@ static int ux500_probe(struct platform_device *pdev)
 	glue->clk			= clk;
 
 	pdata->platform_ops		= &ux500_ops;
+	pdata->config 			= &ux500_musb_hdrc_config;
 
 	platform_set_drvdata(pdev, glue);
 
-- 
1.7.10.4
