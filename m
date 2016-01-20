From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 Jan 2016 19:27:23 +0800
Subject: [PATCH v3 2/4] net: mvneta: Try to get named core clock first
In-Reply-To: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
References: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
Message-ID: <1453289245-2061-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms may provide more than one clk for the mvneta IP, for
example Marvell BG4CT provides one clk for the mac core, and one
clk for the AXI bus logic.

To support for more than one clock, we'll need to distinguish between
the clock by name. Change clock probing to first try to get "core"
clock before falling back to unnamed clock.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 8e85a53..736a9ec 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3605,7 +3605,9 @@ static int mvneta_probe(struct platform_device *pdev)
 
 	pp->indir[0] = rxq_def;
 
-	pp->clk = devm_clk_get(&pdev->dev, NULL);
+	pp->clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(pp->clk))
+		pp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pp->clk)) {
 		err = PTR_ERR(pp->clk);
 		goto err_put_phy_node;
-- 
2.7.0.rc3
