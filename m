From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 26 Jan 2016 15:44:10 +0300
Subject: [PATCH] clk: rockchip: Reparent hclk_rom,
 hclk_i2s0 and hclk_spdif to hclk_cpubus on RK3066/RK3188
Message-ID: <1453812250-11819-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make peripherals (rom, i2s0 or spdif) accessible via cpu,
hclk_cpubus gate must be opened. Without that all accesses (readl/writel)
return wrong data.

The patch fixes regression introduced by recent clock code.

Fixes: 78eaf6095cc763c ("clk: rockchip: disable unused clocks")

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

CC: linux-clk at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-rockchip at lists.infradead.org
CC: linux-kernel at vger.kernel.org
CC: stable at vger.kernel.org # 4.1.x-
---
 drivers/clk/rockchip/clk-rk3188.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index abb4760..54b88a6 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -429,10 +429,10 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(0, "aclk_strc_sys", "aclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 10, GFLAGS),
 
 	/* hclk_cpu gates */
-	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(5), 6, GFLAGS),
-	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
-	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
 	GATE(0, "hclk_cpubus", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 8, GFLAGS),
+	GATE(HCLK_ROM, "hclk_rom", "hclk_cpubus", 0, RK2928_CLKGATE_CON(5), 6, GFLAGS),
+	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpubus", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
+	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_cpubus", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
 	/* hclk_ahb2apb is part of a clk branch */
 	GATE(0, "hclk_vio_bus", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 12, GFLAGS),
 	GATE(HCLK_LCDC0, "hclk_lcdc0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 1, GFLAGS),
-- 
1.7.9.5
