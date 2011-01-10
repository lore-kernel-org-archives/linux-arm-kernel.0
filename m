From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 10 Jan 2011 11:05:06 +0000
Subject: [PATCH] spi: tegra: don't treat NULL clk as an error
Message-ID: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms have been known to return NULL from clk_get() if they
support only a single struct clk.  Whilst tegra doesn't do this, make
the drivers consistent with others.

Cc: Erik Gilling <konkers@android.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

 drivers/spi/spi_tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
index bb7df02..891e590 100644
--- a/drivers/spi/spi_tegra.c
+++ b/drivers/spi/spi_tegra.c
@@ -513,7 +513,7 @@ static int __init spi_tegra_probe(struct platform_device *pdev)
 	}
 
 	tspi->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR_OR_NULL(tspi->clk)) {
+	if (IS_ERR(tspi->clk)) {
 		dev_err(&pdev->dev, "can not get clock\n");
 		ret = PTR_ERR(tspi->clk);
 		goto err2;
-- 
1.7.3.4
