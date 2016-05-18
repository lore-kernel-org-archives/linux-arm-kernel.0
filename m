From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 May 2016 16:46:23 +0300
Subject: [PATCH 01/14] clk: twl6040: Correct clk_ops
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1463579196-5484-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the drover only supports prepare callbacks, the use of is_enabled is
not correct, it should be handling is_prepared.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/clk-twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 697c66757400..e167e0bbaff5 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -34,7 +34,7 @@ struct twl6040_clk {
 	int enabled;
 };
 
-static int twl6040_bitclk_is_enabled(struct clk_hw *hw)
+static int twl6040_bitclk_is_prepared(struct clk_hw *hw)
 {
 	struct twl6040_clk *twl6040_clk = container_of(hw, struct twl6040_clk,
 						       mcpdm_fclk);
@@ -66,7 +66,7 @@ static void twl6040_bitclk_unprepare(struct clk_hw *hw)
 }
 
 static const struct clk_ops twl6040_mcpdm_ops = {
-	.is_enabled = twl6040_bitclk_is_enabled,
+	.is_prepared = twl6040_bitclk_is_prepared,
 	.prepare = twl6040_bitclk_prepare,
 	.unprepare = twl6040_bitclk_unprepare,
 };
-- 
2.8.2
