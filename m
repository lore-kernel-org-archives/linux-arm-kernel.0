From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 12 Dec 2014 17:50:39 +0000
Subject: [PATCH] clk: rockchip: Fix clock gate for rk3188 hclk_emem_peri
Message-ID: <1418406639-13668-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not disable clock gate "hclk_emem_peri", otherwise EMAC clocks no longer work
and it breaks ethernet on RK3066 and RK3188. It fixes a regression introduced by
commit 78eaf6095cc763c1a228ebac5682852f04e85205 ("clk: rockchip: disable unused clocks").

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index c540789..dcf63a6 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -427,8 +427,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	/* hclk_peri gates */
 	GATE(0, "hclk_peri_axi_matrix", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 0, GFLAGS),
 	GATE(0, "hclk_peri_ahb_arbi", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 6, GFLAGS),
-	GATE(0, "hclk_emem_peri", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 7, GFLAGS),
+	GATE(0, "hclk_emem_peri", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 7, GFLAGS),
 	GATE(HCLK_EMAC, "hclk_emac", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 0, GFLAGS),
 	GATE(HCLK_NANDC0, "hclk_nandc0", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 9, GFLAGS),
 	GATE(0, "hclk_usb_peri", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 5, GFLAGS),
--
1.9.1
