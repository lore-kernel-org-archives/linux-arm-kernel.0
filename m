From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 24 Aug 2015 11:45:17 +0800
Subject: [PATCH v3 3/4] spi: mediatek: add PM clk_prepare_enable fail flow
In-Reply-To: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
References: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1440387918-22191-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PM clk_prepare_enable fail flow.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index f81618c..e14f583 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -665,8 +665,10 @@ static int mtk_spi_resume(struct device *dev)
 
 	if (!pm_runtime_suspended(dev)) {
 		ret = clk_prepare_enable(mdata->spi_clk);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 			return ret;
+		}
 	}
 
 	ret = spi_master_resume(master);
@@ -692,8 +694,15 @@ static int mtk_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(mdata->spi_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
+		return ret;
+	}
 
-	return clk_prepare_enable(mdata->spi_clk);
+	return 0;
 }
 #endif /* CONFIG_PM */
 
-- 
1.8.1.1.dirty
