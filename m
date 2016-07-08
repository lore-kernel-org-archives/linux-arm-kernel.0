From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 23:46:38 +0900
Subject: [PATCH v2 4/7] spi: s3c64xx: use error code from clk_prepare_enable()
In-Reply-To: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467989201-14661-5-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If clk_prepare_enable() fails do not return -EBUSY but use the
value provided by the function itself.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0784a4d..3a65adf 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1126,9 +1126,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err_deref_master;
 	}
 
-	if (clk_prepare_enable(sdd->clk)) {
+	ret = clk_prepare_enable(sdd->clk);
+	if (ret) {
 		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
-		ret = -EBUSY;
 		goto err_deref_master;
 	}
 
@@ -1141,9 +1141,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	if (clk_prepare_enable(sdd->src_clk)) {
+	ret = clk_prepare_enable(sdd->src_clk);
+	if (ret) {
 		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
-		ret = -EBUSY;
 		goto err_disable_clk;
 	}
 
-- 
2.8.1
