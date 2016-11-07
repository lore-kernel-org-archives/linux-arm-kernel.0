From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  7 Nov 2016 18:17:44 +0000
Subject: [PATCH v11 13/14] dmaengine: st_fdma: Fix the error return code in
 st_fdma_probe()
In-Reply-To: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
References: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1478542665-17089-14-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function st_slim_rproc_alloc() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/st_fdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 232d354..bfb79bd 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -792,7 +792,7 @@ static int st_fdma_probe(struct platform_device *pdev)
 	}
 
 	fdev->slim_rproc = st_slim_rproc_alloc(pdev, fdev->fw_name);
-	if (!fdev->slim_rproc) {
+	if (IS_ERR(fdev->slim_rproc)) {
 		ret = PTR_ERR(fdev->slim_rproc);
 		dev_err(&pdev->dev, "slim_rproc_alloc failed (%d)\n", ret);
 		goto err;
-- 
2.7.4
