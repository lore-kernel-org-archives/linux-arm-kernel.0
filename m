From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 28 Jun 2017 15:53:45 +0200
Subject: [PATCH] clk: scpi: error when clock fails to register
Message-ID: <20170628135345.9337-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation of scpi_clk_add just print a warning when clock
fails to register but then keep going as if nothing happened. The
provider is then registered with bogus data.

This may latter lead to an Oops in __clk_create_clk when
hlist_add_head(&clk->clks_node, &hw->core->clks) is called.

This patch fixes the issue and errors if a clock fails to register.

Fixes: cd52c2a4b5c4 ("clk: add support for clocks provided by SCP(System Control Processor)")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-scpi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 96d37175d0ad..e44b5ca91fed 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -245,10 +245,12 @@ static int scpi_clk_add(struct device *dev, struct device_node *np,
 		sclk->id = val;
 
 		err = scpi_clk_ops_init(dev, match, sclk, name);
-		if (err)
+		if (err) {
 			dev_err(dev, "failed to register clock '%s'\n", name);
-		else
-			dev_dbg(dev, "Registered clock '%s'\n", name);
+			return err;
+		}
+
+		dev_dbg(dev, "Registered clock '%s'\n", name);
 		clk_data->clk[idx] = sclk;
 	}
 
-- 
2.9.4
