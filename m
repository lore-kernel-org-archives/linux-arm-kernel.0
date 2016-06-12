From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sun, 12 Jun 2016 17:48:33 +0800
Subject: [PATCH] clk: rockchip: add pclk_vio_grf to critical clock on the
 RK3399
Message-ID: <1465724913-14553-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pclk_vio_grf supply power for GRF IOs, if it is disabled, will
cause abnormal operation of the GRF.

The clock tree of the pclk_vio like this:
             | --> pclk_vio_grf
... pclk_vio | --> pclk_mipi_dsi1
             | --> pclk_mipi_dsi0

and the pclk_mipi_dsi0 and pclk_mipi_dsi1 don't have the flag
CLK_IGNORE_UNUSED, and they will be disabled by clk_disable_unused
when startup:
clk_disable_unused
  --> clk_disable_unprepare
    --> clk_disable
      --> clk_core_disable(core->parent)

then, the pclk_vio_grf also is disabled. Therefore, we need to add
pclk_vio_grf to critical clock and avoid to disable pclk_vio and
pclk_vio_grf.

Tested-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index b6742fa..7ecb12c3 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1485,6 +1485,7 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"gpll_hclk_perilp1_src",
 	"gpll_aclk_perilp0_src",
 	"gpll_aclk_perihp_src",
+	"pclk_vio_grf",
 };
 
 static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
-- 
1.7.9.5
