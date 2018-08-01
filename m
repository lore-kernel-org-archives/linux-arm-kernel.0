From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 1 Aug 2018 12:16:24 +0000
Subject: [PATCH] clk: meson-axg: pcie: drop the mpll3 clock parent
Message-ID: <20180801121625.9488-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We found the PCIe driver doesn't really work with
the mpll3 clock which is actually reserved for debug,
So drop it from the mux list.

Fixes: 33b89db68236 ("clk: meson-axg: add clocks required by pcie driver")
Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
hi Jerome:
  I'm sorry we found this during latest PCIe driver test.

  I'm fine with either pull this as a fixup for 4.18 or
queued for next 4.19, since the PCIe driver is not merged yet,
just do as you feel what's fit best, thanks.

Yixun
---
 drivers/clk/meson/axg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 2d458092884a..246c23df64a8 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -700,12 +700,14 @@ static struct clk_regmap axg_pcie_mux = {
 		.offset = HHI_PCIE_PLL_CNTL6,
 		.mask = 0x1,
 		.shift = 2,
+		/* skip the parent mpll3, reserved for debug */
+		.table = (u32[]){ 1 },
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_mux",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "mpll3", "pcie_pll" },
-		.num_parents = 2,
+		.parent_names = (const char *[]){ "pcie_pll" },
+		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.18.0
