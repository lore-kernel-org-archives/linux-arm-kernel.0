From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 11:03:36 +0200
Subject: [PATCH 2/3] dmaengine i.MX SDMA: set firmware scripts addresses to
	negative value initially
In-Reply-To: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
References: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314263017-18099-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we do not have a firmare script for a given transfer,
the setup of this channel must fail. For this the script
addresses have to be < 0 initially, not 0.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f50c87c..8abf8c1 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1281,6 +1281,7 @@ static int __init sdma_probe(struct platform_device *pdev)
 	struct sdma_platform_data *pdata = pdev->dev.platform_data;
 	int i;
 	struct sdma_engine *sdma;
+	s32 *saddr_arr;
 
 	sdma = kzalloc(sizeof(*sdma), GFP_KERNEL);
 	if (!sdma)
@@ -1324,6 +1325,11 @@ static int __init sdma_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	/* initially no scripts available */
+	saddr_arr = (s32 *)sdma->script_addrs;
+	for (i = 0; i < SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1; i++)
+		saddr_arr[i] = -EINVAL;
+
 	if (of_id)
 		pdev->id_entry = of_id->data;
 	sdma->devtype = pdev->id_entry->driver_data;
-- 
1.7.5.4
