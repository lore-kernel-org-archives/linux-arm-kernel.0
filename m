From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 5 Jan 2015 15:59:19 +0800
Subject: [PATCH next] mmc: sdhci-pxav3: Remove checks for optional core clock
 in error/remove path
Message-ID: <1420444759-3812-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 63589e92c2d9 ("clk: Ignore error and NULL pointers passed to
clk_{unprepare, disable}()") allows NULL or error pointer to be passed
unconditionally.

This patch is to simplify probe error and remove code paths.

However, we reserve the core clock checks in runtime suspend/resume code
because we want a little smaller latency.

This patch can be applied after the sdhci-pxav3 unbalanced pm/clock issues
patches being merged.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313103.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 4de39fb..63967b8 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -398,8 +398,7 @@ err_of_parse:
 err_cd_req:
 err_mbus_win:
 	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
 err_clk_get:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -418,8 +417,7 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, 1);
 
 	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
 
 	sdhci_pltfm_free(pdev);
 
-- 
2.1.4
