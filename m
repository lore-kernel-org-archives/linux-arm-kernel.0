From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 23 Aug 2013 12:23:43 +0300
Subject: [patch] dmaengine: ste_dma40: off by one in d40_of_probe()
Message-ID: <20130823092343.GF31293@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If "num_disabled" is equal to STEDMA40_MAX_PHYS (32) then we would write
one space beyond the end of the pdata->disable_channels[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0036756..e0157c8 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3516,7 +3516,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 	list = of_get_property(np, "disabled-channels", &num_disabled);
 	num_disabled /= sizeof(*list);
 
-	if (num_disabled > STEDMA40_MAX_PHYS || num_disabled < 0) {
+	if (num_disabled >= STEDMA40_MAX_PHYS || num_disabled < 0) {
 		d40_err(&pdev->dev,
 			"Invalid number of disabled channels specified (%d)\n",
 			num_disabled);
