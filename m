From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:28:37 +0100
Subject: [PATCH 6/9] clk: mmci: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T1p-0003wc-Gy@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/mmci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5e142b7..7be8db0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1160,10 +1160,14 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		goto host_free;
 	}
 
-	ret = clk_enable(host->clk);
+	ret = clk_prepare(host->clk);
 	if (ret)
 		goto clk_free;
 
+	ret = clk_enable(host->clk);
+	if (ret)
+		goto clk_unprep;
+
 	host->plat = plat;
 	host->variant = variant;
 	host->mclk = clk_get_rate(host->clk);
@@ -1351,6 +1355,8 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	iounmap(host->base);
  clk_disable:
 	clk_disable(host->clk);
+ clk_unprep:
+	clk_unprepare(host->clk);
  clk_free:
 	clk_put(host->clk);
  host_free:
@@ -1398,6 +1404,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 
 		iounmap(host->base);
 		clk_disable(host->clk);
+		clk_unprepare(host->clk);
 		clk_put(host->clk);
 
 		if (host->vcc)
-- 
1.7.4.4
