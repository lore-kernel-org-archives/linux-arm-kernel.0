From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 11 Oct 2013 11:01:04 +0200
Subject: [PATCH RESEND 2/3] dmaengine: s3c24xx-dma: add support for the
 s3c2410 type of controller
In-Reply-To: <201310111059.19791.heiko@sntech.de>
References: <201310111059.19791.heiko@sntech.de>
Message-ID: <201310111101.04721.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The earliest variants of the dma controller did not contain support for
controlling clocks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/dma/s3c24xx-dma.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 56c9253..4cb1279 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1078,6 +1078,13 @@ static void s3c24xx_dma_free_virtual_channels(struct dma_device *dmadev)
 		list_del(&chan->vc.chan.device_node);
 }
 
+/* s3c2410, s3c2440 and s3c2442 have a 0x40 stride without separate clocks */
+static struct soc_data soc_s3c2410 = {
+	.stride = 0x40,
+	.has_reqsel = false,
+	.has_clocks = false,
+};
+
 /* s3c2412 and s3c2413 have a 0x40 stride and dmareqsel mechanism */
 static struct soc_data soc_s3c2412 = {
 	.stride = 0x40,
@@ -1094,6 +1101,9 @@ static struct soc_data soc_s3c2443 = {
 
 static struct platform_device_id s3c24xx_dma_driver_ids[] = {
 	{
+		.name		= "s3c2410-dma",
+		.driver_data	= (kernel_ulong_t)&soc_s3c2410,
+	}, {
 		.name		= "s3c2412-dma",
 		.driver_data	= (kernel_ulong_t)&soc_s3c2412,
 	}, {
-- 
1.7.10.4
