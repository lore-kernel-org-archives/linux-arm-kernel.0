From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 14 May 2014 15:30:55 -0700
Subject: [RFC PATCH 5/5] net: macb: Use clk_round_rate_nearest() API
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1400106655-22465-6-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current way of rounding clock frequencies always rounds down and
doesn't allow deviations above the requested frequency. For the Ethernet
case though, it is more important to minimize deviations than not
exceeding the requested frequency.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index e9daa072ebb4..4fdbfcbc38bc 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -223,7 +223,7 @@ static void macb_set_tx_clk(struct clk *clk, int speed, struct net_device *dev)
 		return;
 	}
 
-	rate_rounded = clk_round_rate(clk, rate);
+	rate_rounded = clk_round_rate_nearest(clk, rate);
 	if (rate_rounded < 0)
 		return;
 
-- 
1.9.3.1.ga73a6ad
