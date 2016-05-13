From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 11:42:16 -0700
Subject: [PATCH 1/2] clk: rockchip: mark rk3399 GIC clocks as critical
Message-ID: <1463164937-91089-1-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We never want to kill the GIC.

Noticed when making other clock fixups, and seeing the newly-constructed
clock tree try to disable cpll, where we had this parent structure:

  aclk_gic <------\
                  |--- aclk_gic_pre <-- cpll <-- pll_cpll
  aclk_gic_noc <--/

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/clk/rockchip/clk-rk3399.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 291543f52caa..145756c4f3c8 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1466,6 +1466,8 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 
 static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"aclk_cci_pre",
+	"aclk_gic",
+	"aclk_gic_noc",
 	"pclk_perilp0",
 	"pclk_perilp0",
 	"hclk_perilp0",
-- 
2.8.0.rc3.226.g39d4020
