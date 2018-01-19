From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 19 Jan 2018 16:18:21 +0100
Subject: [PATCH 3/3] soc/tegra: pmc: Use of_clk_get_parent_count() instead of
 open coding
In-Reply-To: <1516375101-29836-1-git-send-email-geert+renesas@glider.be>
References: <1516375101-29836-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1516375101-29836-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of_clk_get_parent_count() returns zero on failure, while
of_count_phandle_with_args() might return a negative error code, this
also fixes the issue of possibly using a very big number in the
allocation below.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/tegra/pmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ce62a47a6647a817..4379e4d602bc5428 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -21,6 +21,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -743,7 +744,7 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
 	unsigned int i, count;
 	int err;
 
-	count = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	count = of_clk_get_parent_count(np);
 	if (count == 0)
 		return -ENODEV;
 
-- 
2.7.4
