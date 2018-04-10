From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 10 Apr 2018 14:51:39 +0200
Subject: [PATCH v2 3/5] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
In-Reply-To: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1523364701-15383-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of_clk_get_parent_count() returns zero on failure, while
of_count_phandle_with_args() might return a negative error code, this
also fixes the issue of possibly using a negative number in the
allocation below.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v2 1/5] clk: Extract OF clock helpers in
<linux/of_clk.h>".

v2:
  - of_clk_get_parent_count() was moved to <linux/of_clk.h>.
---
 drivers/soc/rockchip/pm_domains.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 53efc386b1ada8cf..13913d40c8213e36 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -14,6 +14,7 @@
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/of_address.h>
+#include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
@@ -400,8 +401,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->info = pd_info;
 	pd->pmu = pmu;
 
-	pd->num_clks = of_count_phandle_with_args(node, "clocks",
-						  "#clock-cells");
+	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
 		pd->clks = devm_kcalloc(pmu->dev, pd->num_clks,
 					sizeof(*pd->clks), GFP_KERNEL);
-- 
2.7.4
