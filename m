From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed,  5 Nov 2014 16:47:41 +0800
Subject: [PATCH v2] clk: rockchip: change hierarchy for some clocks
Message-ID: <1415177261-6942-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some bus clock for multiple controllers with the same
function in rk3288: four usb controllers on hclk_usb_peri,
two nandc on hclk_emem and four dw_emmc controller on hclk_mem.
These bus clock has the same parent with the controllers,
they should be enabled if at least one of controllers
on that bus is enabled, and should be disabled if all the
controllers are disabled.

There is no existern way to describ this kind of dependency,
so maybe we can make the bus clock as a pseudo parent.

This patch change the hierarchy for these bus clocks, to met
the following bus hierarchy:
hclk_usb_peri is bus clock for
|- hclk_otg0,
|- hclk_host0,
|- hclk_host1,
|- hclk_hsic

hclk_emem is bus clock for
|- hclk_nandc0
|- hclk_nandc1

hclk_mem is bus clock for
|- hclk_sdmmc
|- hclk_sdio0
|- hclk_sdio1
|- hclk_emmc

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- update the commit message

 drivers/clk/rockchip/clk-rk3288.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index baf8a89..d31bc45 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -652,21 +652,21 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 
 	/* hclk_peri gates */
 	GATE(0, "hclk_peri_matrix", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(6), 0, GFLAGS),
-	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 4, GFLAGS),
-	GATE(HCLK_USBHOST0, "hclk_host0", "hclk_peri", 0, RK3288_CLKGATE_CON(7), 6, GFLAGS),
-	GATE(HCLK_USBHOST1, "hclk_host1", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 7, GFLAGS),
-	GATE(HCLK_HSIC, "hclk_hsic", "hclk_peri", 0, RK3288_CLKGATE_CON(7), 8, GFLAGS),
+	GATE(HCLK_OTG0, "hclk_otg0", "hclk_usb_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 4, GFLAGS),
+	GATE(HCLK_USBHOST0, "hclk_host0", "hclk_usb_peri", 0, RK3288_CLKGATE_CON(7), 6, GFLAGS),
+	GATE(HCLK_USBHOST1, "hclk_host1", "hclk_usb_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 7, GFLAGS),
+	GATE(HCLK_HSIC, "hclk_hsic", "hclk_usb_peri", 0, RK3288_CLKGATE_CON(7), 8, GFLAGS),
 	GATE(0, "hclk_usb_peri", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 9, GFLAGS),
 	GATE(0, "hclk_peri_ahb_arbi", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 10, GFLAGS),
 	GATE(0, "hclk_emem", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 12, GFLAGS),
 	GATE(0, "hclk_mem", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 13, GFLAGS),
-	GATE(HCLK_NANDC0, "hclk_nandc0", "hclk_peri", 0, RK3288_CLKGATE_CON(7), 14, GFLAGS),
-	GATE(HCLK_NANDC1, "hclk_nandc1", "hclk_peri", 0, RK3288_CLKGATE_CON(7), 15, GFLAGS),
+	GATE(HCLK_NANDC0, "hclk_nandc0", "hclk_emem", 0, RK3288_CLKGATE_CON(7), 14, GFLAGS),
+	GATE(HCLK_NANDC1, "hclk_nandc1", "hclk_emem", 0, RK3288_CLKGATE_CON(7), 15, GFLAGS),
 	GATE(HCLK_TSP, "hclk_tsp", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 8, GFLAGS),
-	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 3, GFLAGS),
-	GATE(HCLK_SDIO0, "hclk_sdio0", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 4, GFLAGS),
-	GATE(HCLK_SDIO1, "hclk_sdio1", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 5, GFLAGS),
-	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 6, GFLAGS),
+	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_mem", 0, RK3288_CLKGATE_CON(8), 3, GFLAGS),
+	GATE(HCLK_SDIO0, "hclk_sdio0", "hclk_mem", 0, RK3288_CLKGATE_CON(8), 4, GFLAGS),
+	GATE(HCLK_SDIO1, "hclk_sdio1", "hclk_mem", 0, RK3288_CLKGATE_CON(8), 5, GFLAGS),
+	GATE(HCLK_EMMC, "hclk_emmc", "hclk_mem", 0, RK3288_CLKGATE_CON(8), 6, GFLAGS),
 	GATE(HCLK_HSADC, "hclk_hsadc", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 7, GFLAGS),
 	GATE(0, "pmu_hclk_otg0", "hclk_peri", 0, RK3288_CLKGATE_CON(7), 5, GFLAGS),
 
-- 
1.9.1
