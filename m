From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:05:09 +0100
Subject: [PATCH] ravb: Support 1Gbps on R-Car H3 ES1.1+ and R-Car M3-W
In-Reply-To: <cover.1479390880.git.horms+renesas@verge.net.au>
References: <cover.1479390880.git.horms+renesas@verge.net.au>
Message-ID: <735ea633e42060546cabe8430efbc00d4be1790a.1479390880.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The limitation to 10/100Mbit speeds on R-Car Gen3 is valid for R-Car H3
ES1.0 only. Check for the exact SoC model to allow 1Gbps on newer
revisions of R-Car H3, and on R-Car M3-W.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/net/ethernet/renesas/ravb_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 630536bc72f9..83c45edba6ef 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -31,6 +31,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sys_soc.h>
 
 #include <asm/div64.h>
 
@@ -977,6 +978,11 @@ static void ravb_adjust_link(struct net_device *ndev)
 		phy_print_status(phydev);
 }
 
+static const struct soc_device_attribute r8a7795es10[] = {
+	{ .soc_id = "r8a7795", .revision = "ES1.0", },
+	{ /* sentinel */ }
+};
+
 /* PHY init function */
 static int ravb_phy_init(struct net_device *ndev)
 {
@@ -1011,10 +1017,10 @@ static int ravb_phy_init(struct net_device *ndev)
 		return -ENOENT;
 	}
 
-	/* This driver only support 10/100Mbit speeds on Gen3
+	/* This driver only support 10/100Mbit speeds on R-Car H3 ES1.0
 	 * at this time.
 	 */
-	if (priv->chip_id == RCAR_GEN3) {
+	if (soc_device_match(r8a7795es10)) {
 		int err;
 
 		err = phy_set_max_speed(phydev, SPEED_100);
-- 
2.7.0.rc3.207.g0ac5344
