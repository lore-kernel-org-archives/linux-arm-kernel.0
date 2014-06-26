From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jun 2014 18:48:25 +0300
Subject: [PATCH] clk: tegra: export clock names for debugging
Message-ID: <1403797705-26910-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When writing a module for testing or debugging purposes, there is no way to
get hold of clk handles. This patch solves this by exposing all valid clocks
as clkdev's for the virtual device tegra-clk-debug.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index c0a7d77..3315fca 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -277,6 +277,12 @@ void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
 	for (i = 0; i < num; i++, dev_clks++)
 		clk_register_clkdev(clks[dev_clks->dt_id], dev_clks->con_id,
 				dev_clks->dev_id);
+
+	for (i = 0; i < clk_num; i++) {
+		if (!IS_ERR(clks[i]) || !clks[i])
+			clk_register_clkdev(clks[i], __clk_get_name(clks[i]),
+				"tegra-clk-debug");
+	}
 }
 
 struct clk ** __init tegra_lookup_dt_id(int clk_id,
-- 
1.7.7.rc0.72.g4b5ea.dirty
