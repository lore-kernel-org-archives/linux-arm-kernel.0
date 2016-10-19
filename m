From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 19 Oct 2016 13:23:50 +0000
Subject: [PATCH -next] dmaengine: st_fdma: Fix the error return code in
 st_fdma_probe()
Message-ID: <1476883430-11970-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function st_slim_rproc_alloc() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/dma/st_fdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 515e1d4..a66a57b 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -802,7 +802,7 @@ static int st_fdma_probe(struct platform_device *pdev)
 	}
 
 	fdev->slim_rproc = st_slim_rproc_alloc(pdev, fdev->fw_name);
-	if (!fdev->slim_rproc) {
+	if (IS_ERR(fdev->slim_rproc)) {
 		ret = PTR_ERR(fdev->slim_rproc);
 		dev_err(&pdev->dev, "slim_rproc_alloc failed (%d)\n", ret);
 		goto err;
