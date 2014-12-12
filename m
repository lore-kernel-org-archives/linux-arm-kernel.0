From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Fri, 12 Dec 2014 15:54:26 +0100
Subject: [PATCH] clk: rockchip: add CLK_IGNORE_UNUSED flag to fix USB Host
Message-ID: <1418396066-31360-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CLK_IGNORE_UNUSED flag to hclk_usb_peri, hclk_usbotg0 and hclk_usbotg1
because these clocks must remain enabled to use the USB controllers in host mode.

This fixes a regression introduced by patch "clk: rockchip: disable unused clocks"
https://lkml.kernel.org/g/1415092270-24932-1-git-send-email-kever.yang at rock-chips.com

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 drivers/clk/rockchip/clk-rk3188.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index c540789..25ddb09 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -430,8 +430,10 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(0, "hclk_emem_peri", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 7, GFLAGS),
 	GATE(HCLK_EMAC, "hclk_emac", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 0, GFLAGS),
 	GATE(HCLK_NANDC0, "hclk_nandc0", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 9, GFLAGS),
-	GATE(0, "hclk_usb_peri", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 5, GFLAGS),
-	GATE(HCLK_OTG0, "hclk_usbotg0", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 13, GFLAGS),
+	GATE(0, "hclk_usb_peri", "hclk_peri", CLK_IGNORE_UNUSED,
+			RK2928_CLKGATE_CON(4), 5, GFLAGS),
+	GATE(HCLK_OTG0, "hclk_usbotg0", "hclk_peri", CLK_IGNORE_UNUSED,
+			RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(HCLK_HSADC, "hclk_hsadc", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 5, GFLAGS),
 	GATE(HCLK_PIDF, "hclk_pidfilter", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 6, GFLAGS),
 	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 10, GFLAGS),
@@ -592,7 +594,8 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 	GATE(0, "hclk_cif1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 6, GFLAGS),
 	GATE(0, "hclk_hdmi", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 
-	GATE(HCLK_OTG1, "hclk_usbotg1", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
+	GATE(HCLK_OTG1, "hclk_usbotg1", "hclk_peri", CLK_IGNORE_UNUSED,
+			RK2928_CLKGATE_CON(5), 14, GFLAGS),
 
 	GATE(0, "aclk_cif1", "aclk_vio1", 0, RK2928_CLKGATE_CON(6), 7, GFLAGS),
 
@@ -680,7 +683,8 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 	GATE(0, "hclk_imem0", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 	GATE(0, "hclk_imem1", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 15, GFLAGS),
 
-	GATE(HCLK_OTG1, "hclk_usbotg1", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
+	GATE(HCLK_OTG1, "hclk_usbotg1", "hclk_peri", CLK_IGNORE_UNUSED,
+			RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_HSIC, "hclk_hsic", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
 
 	GATE(PCLK_TIMER3, "pclk_timer3", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 9, GFLAGS),
-- 
2.1.0
