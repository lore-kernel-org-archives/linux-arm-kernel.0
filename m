From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 19 Jan 2018 16:18:20 +0100
Subject: [PATCH 2/3] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
In-Reply-To: <1516375101-29836-1-git-send-email-geert+renesas@glider.be>
References: <1516375101-29836-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1516375101-29836-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of_clk_get_parent_count() returns zero on failure, while
of_count_phandle_with_args() might return a negative error code, this
also fixes the issue of possibly using a negative number in the
allocation below.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/rockchip/pm_domains.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 5c342167b9db7a16..9936038d38771784 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/power/rk3288-power.h>
@@ -391,7 +392,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		return -EINVAL;
 	}
 
-	clk_cnt = of_count_phandle_with_args(node, "clocks", "#clock-cells");
+	clk_cnt = of_clk_get_parent_count(node);
 	pd = devm_kzalloc(pmu->dev,
 			  sizeof(*pd) + clk_cnt * sizeof(pd->clks[0]),
 			  GFP_KERNEL);
-- 
2.7.4
