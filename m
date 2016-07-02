From: stefan@agner.ch (Stefan Agner)
Date: Sat,  2 Jul 2016 11:46:08 -0700
Subject: [PATCH] clk: imx7d: do not set parent of ethernet time clocks
Message-ID: <20160702184608.24462-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All device trees currently in mainline specify the time clock parent
using the assigned-clocks/assigned-clock-parents method, there is no
need to statically assign the parent in the core clock driver.

Furthermore, and the actual driver of this patch, specify parents at
that early point in boot leads to a warning:
bad: scheduling from the idle thread!

The reason for the warning is that setting the parent enables the ENET
PLL since we are using CLK_OPS_PARENT_ENABLE. Enabling the ENET PLL can
cause clk_pllv3_wait_lock to sleep. See also:
commit fc8726a2c021 ("clk: core: support clocks which requires parents
enable (part 2)").

Note that setting the ENET AXI root clock parent (two lines above
this change) also requires ENET PLL to be enabled. However, U-Boot
typically leaves the ENET PLL on, hence when the framework sets the
parent of the first clock, it does not need to wait for the PLL to
come up. But because there is currently no user of that clock, the
PLL gets disabled after setting the parent. Therefore, subsequent
reparenting calls of any clock which somehow rely on the ENET PLL,
need to reenable the ENET PLL which leads to a sleep. Removing those
subsequent reparenting calls works around this issue.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Dong,

What do you think about this change? I really think there is no need
to set the ethernet time roots here, and it would solve the problem
for now.

Also, we could move the other two parent assignments of ethernet
clocks to the device tree. I see it is a bit more problematic because
they are shared between the two instances. It begs the question: where
would we put them. I would just put them in both ethernet instances.
Of course, if they have conflicting settings, we end up in a race
condition which parent would actually be used in the end... But
IMHO, such a device tree would just be a buggy dt...

--
Stefan

 drivers/clk/imx/clk-imx7d.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 79293ed..9bf6282 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -864,12 +864,9 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	 * init enet clock source:
 	 * 	AXI clock source is 250MHz
 	 *	Phy refrence clock is 25MHz
-	 *	1588 time clock source is 100MHz
 	 */
 	clk_set_parent(clks[IMX7D_ENET_AXI_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_250M_CLK]);
 	clk_set_parent(clks[IMX7D_ENET_PHY_REF_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_25M_CLK]);
-	clk_set_parent(clks[IMX7D_ENET1_TIME_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_100M_CLK]);
-	clk_set_parent(clks[IMX7D_ENET2_TIME_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_100M_CLK]);
 
 	/* set uart module clock's parent clock source that must be great then 80MHz */
 	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
-- 
2.9.0
