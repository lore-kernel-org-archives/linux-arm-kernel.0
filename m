From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:13:35 +0100
Subject: [PATCH 2/9] spi: rspi: Convert to clk_prepare_enable/disable_unprepare
In-Reply-To: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389525222-3482-3-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Get the driver ready for the migration to the common clock framework by
calling clk_prepare_enable() and clk_disable_unprepare().

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 5ce2127b2b43..b6439c9505ac 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1066,7 +1066,7 @@ static int rspi_remove(struct platform_device *pdev)
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	rspi_release_dma(rspi);
-	clk_disable(rspi->clk);
+	clk_disable_unprepare(rspi->clk);
 
 	return 0;
 }
@@ -1115,7 +1115,12 @@ static int rspi_probe(struct platform_device *pdev)
 		ret = PTR_ERR(rspi->clk);
 		goto error1;
 	}
-	clk_enable(rspi->clk);
+
+	ret = clk_prepare_enable(rspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to prepare/enable clock\n");
+		goto error1;
+	}
 
 	INIT_LIST_HEAD(&rspi->queue);
 	spin_lock_init(&rspi->lock);
@@ -1177,7 +1182,7 @@ static int rspi_probe(struct platform_device *pdev)
 error3:
 	rspi_release_dma(rspi);
 error2:
-	clk_disable(rspi->clk);
+	clk_disable_unprepare(rspi->clk);
 error1:
 	spi_master_put(master);
 
-- 
1.7.9.5
