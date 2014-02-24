From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 24 Feb 2014 11:25:55 +0100
Subject: [PATCH 1/3] fs_enet: update clock names to comply with FEC binding
Message-ID: <1393237557-31406-1-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a recent FEC binding document update that was motivated by i.MX
development revealed that ARM and PowerPC implementations in Linux
did not agree on the clock names to use for the FEC nodes

change the OF clock lookup to prefer "ipg" over "per", which
improves compliance with the binding, and keeps compatibility
with former device trees

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 62f042d4aaa9..ce20184b96cb 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1037,11 +1037,20 @@ static int fs_enet_probe(struct platform_device *ofdev)
 			fpi->use_rmii = 1;
 	}
 
-	/* make clock lookup non-fatal (the driver is shared among platforms),
+	/* the driver is shared across several PowerPC platforms, not all
+	 * of them provide COMMON_CLK support, and newer kernels are supposed
+	 * to keep working with older DT blobs, so clock lookup is non-fatal
+	 *
 	 * but require enable to succeed when a clock was specified/found,
 	 * keep a reference to the clock upon successful acquisition
+	 *
+	 * the FEC binding is shared with ARM platforms, so we lookup several
+	 * clock names to prefer the common naming convention yet support
+	 * names that were used before unification
 	 */
-	clk = devm_clk_get(&ofdev->dev, "per");
+	clk = devm_clk_get(&ofdev->dev, "ipg");
+	if (IS_ERR(clk))
+		clk = devm_clk_get(&ofdev->dev, "per");
 	if (!IS_ERR(clk)) {
 		err = clk_prepare_enable(clk);
 		if (err) {
-- 
1.7.10.4
