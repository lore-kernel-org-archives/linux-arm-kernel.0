From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:27:17 +0100
Subject: [PATCH 2/9] clk: amba bus: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T0X-0003wM-3Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/amba/bus.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 84bdaac..bd230e8 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -460,9 +460,17 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
 	if (IS_ERR(pclk))
 		return PTR_ERR(pclk);
 
+	ret = clk_prepare(pclk);
+	if (ret) {
+		clk_put(pclk);
+		return ret;
+	}
+
 	ret = clk_enable(pclk);
-	if (ret)
+	if (ret) {
+		clk_unprepare(pclk);
 		clk_put(pclk);
+	}
 
 	return ret;
 }
@@ -472,6 +480,7 @@ static void amba_put_disable_pclk(struct amba_device *pcdev)
 	struct clk *pclk = pcdev->pclk;
 
 	clk_disable(pclk);
+	clk_unprepare(pclk);
 	clk_put(pclk);
 }
 
-- 
1.7.4.4
