From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue,  2 Aug 2016 15:19:57 +0800
Subject: [PATCH v3 3/7] clk: rockchip: rk3399: fix incorrect GATE bits for {c,
 g}pll_aclk_perihp_src
In-Reply-To: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
References: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1470122401-31934-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry to refer incorrect clock diagram, we double check it that the bits
configuration of the Xpll_aclk_perihp_src need to be fixed:
bit 1 - shows aclk_perihp_cpll_src_en
bit 0 - shows aclk_perihp_gpll_src_en

Through the testing that plug/unplug the USB ethernet cable on the RK3399 kevin board.

1. the hclk_host0 and hclk_host1 are endpoint clocks:
cpll --> G5[1] --> aclk_perihp_cpll_src --\              |--> hclk_host0
                                          | --> ... ---> |
gpll --> G5[0] --> aclk_perihp_gpll_src --/              |--> hclk_host1

2. there is no clock below the cpll_aclk_perihp_src,
   and the hclk_hostX are below the gpll_aclk_perihp_src:
    pll_cpll                              1            1   800000000          0 0
       cpll                               7           19   800000000          0 0
          cpll_aclk_perihp_src            0            0   800000000          0 0
...
    pll_gpll                              1            1   594000000          0 0
       gpll                              10           10   594000000          0 0
          gpll_aclk_perihp_src            2            2   594000000          0 0
                hclk_perihp               5            5    74250000          0 0
                   hclk_host1_arb         2            2    74250000          0 0
                   hclk_host1             2            2    74250000          0 0
                   hclk_host0_arb         2            2    74250000          0 0
                   hclk_host0             2            2    74250000          0 0

3. by default, G5[0] and G5[1] are enabled:
localhost ~ # mem r 0xff760314
0x000003e0

4. close the G5[1] (aclk_perihp_cpll_src), and plug/unplug USB ethernet cable,
   the DUT still works well:
localhost ~ # mem w 0xff760314 0xffff03e2
localhost ~ # mem r 0xff760314
0x000003e2
plug/unplug, the work statue is ok

5. close the G5[0] (aclk_perihp_gpll_src), , and plug/unplug USB ethernet cable,
   the DUT will be crashed:
localhost ~ # mem w 0xff760314 0xffff03e1
localhost ~ # mem r 0xff760314
0x000003e1
plug/unplug, the DUT is crashed

Summary:
bit 1 - shows aclk_perihp_cpll_src_en
bit 0 - shows aclk_perihp_gpll_src_en

Fixes: 3bd14ae9da91 ("clk: rockchip: fix incorrect parent for rk3399's {c,g}pll_aclk_perihp_src")
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

---

Changes in v3:
- list more details of the testing steps
- add the regresson message "Fixes: 3bd14ae9da91 ..." to track the previous commit
- remove the patch "clk: rockchip: rk3399: fix incorrect parent for rk3399's {c, g}pll_aclk_perihp_src"

Changes in v2:
- add this patch " clk: rockchip: rk3399: fix incorrect GATE bits for {c, g}pll_aclk_perihp_src" into the patchset

 drivers/clk/rockchip/clk-rk3399.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 316f5f4..f511de6 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -833,9 +833,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 
 	/* perihp */
 	GATE(0, "cpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
-			RK3399_CLKGATE_CON(5), 0, GFLAGS),
-	GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(5), 1, GFLAGS),
+	GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
+			RK3399_CLKGATE_CON(5), 0, GFLAGS),
 	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(14), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(5), 2, GFLAGS),
-- 
1.7.9.5
