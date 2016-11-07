From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  7 Nov 2016 18:17:43 +0000
Subject: [PATCH v11 12/14] dmaengine: st_fdma: fix uninitialized variable
 access
In-Reply-To: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
References: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1478542665-17089-13-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added st_fdma driver introduces a build warning for
allmodconfig when we add '-Wmaybe-uninitialized':

drivers/dma/st_fdma.c: In function 'st_fdma_probe':
drivers/dma/st_fdma.c:777:5: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The warning is correct, though this can't happen in practice
as the check is redundant (we don't get to this function if
the pointer is NULL). Even if the function were called with a
NULL of_node, the check is not needed because of_property_read_u32
can deal with a NULL argument by returning an error.

Removing the unnecessary code simplifies the function and avoids
the condition that we get the warning for.

Fixes: 6b4cd727eaf1 ("dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/st_fdma.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 515e1d4..232d354 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -720,21 +720,11 @@ static int st_fdma_parse_dt(struct platform_device *pdev,
 			const struct st_fdma_driverdata *drvdata,
 			struct st_fdma_dev *fdev)
 {
-	struct device_node *np = pdev->dev.of_node;
-	int ret;
-
-	if (!np)
-		goto err;
-
-	ret = of_property_read_u32(np, "dma-channels", &fdev->nr_channels);
-	if (ret)
-		goto err;
-
 	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf",
 		drvdata->name, drvdata->id);
 
-err:
-	return ret;
+	return of_property_read_u32(pdev->dev.of_node, "dma-channels",
+				    &fdev->nr_channels);
 }
 #define FDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
-- 
2.7.4
