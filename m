From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Aug 2015 23:43:19 -0300
Subject: [PATCH] ARM: rockchip: pm: Fix PTR_ERR() argument
Message-ID: <1439520199-16076-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

PTR_ERR should access the value just tested by IS_ERR.

The semantic patch that makes this change is available
in scripts/coccinelle/tests/odd_ptr_err.cocci.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-rockchip/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index 892bace..01123dd 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -224,14 +224,14 @@ static int rk3288_suspend_init(struct device_node *np)
 				"rockchip,rk3288-sgrf");
 	if (IS_ERR(sgrf_regmap)) {
 		pr_err("%s: could not find sgrf regmap\n", __func__);
-		return PTR_ERR(pmu_regmap);
+		return PTR_ERR(sgrf_regmap);
 	}
 
 	grf_regmap = syscon_regmap_lookup_by_compatible(
 				"rockchip,rk3288-grf");
 	if (IS_ERR(grf_regmap)) {
 		pr_err("%s: could not find grf regmap\n", __func__);
-		return PTR_ERR(pmu_regmap);
+		return PTR_ERR(grf_regmap);
 	}
 
 	sram_np = of_find_compatible_node(NULL, NULL,
-- 
1.9.1
