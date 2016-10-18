From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Oct 2016 13:42:09 +0800
Subject: [PATCH] clk: sunxi-ng: sun6i-a31: Force AHB1 clock to use PLL6 as
 parent
Message-ID: <20161018054209.24546-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A31, the DMA engine only works if AHB1 is clocked from PLL6.
In addition, the hstimer is clocked from AHB1, and if AHB1 is clocked
from the CPU clock, and cpufreq is working, we get an unstable timer.

Force the AHB1 clock to use PLL6 as its parent. Previously this was done
in the device tree with the assigned-clocks and assigned-clocks-parent
bindings. However with this new monolithic driver, the system critical
clocks aren't exported through the device tree. The alternative is to
force this setting in the driver before the clocks are registered.

This is also done in newer versions of mainline U-boot. But people still
using an older version, or even the vendor version, can still hit this
issue. Hence the need to do it in the kernel as well.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Hi,

This fix is for 4.9. This should fix issues with hstimer and DMA when
booting with an old bootloader.

ChenYu
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 79596463e0d9..4a82a49cff5e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -191,6 +191,8 @@ static struct clk_div_table axi_div_table[] = {
 static SUNXI_CCU_DIV_TABLE(axi_clk, "axi", "cpu",
 			   0x050, 0, 3, axi_div_table, 0);
 
+#define SUN6I_A31_AHB1_REG  0x054
+
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
 					     "axi", "pll-periph" };
 
@@ -1230,6 +1232,16 @@ static void __init sun6i_a31_ccu_setup(struct device_node *node)
 	val &= BIT(16);
 	writel(val, reg + SUN6I_A31_PLL_MIPI_REG);
 
+	/* Force AHB1 to PLL6 / 3 */
+	val = readl(reg + SUN6I_A31_AHB1_REG);
+	/* set PLL6 pre-div = 3 */
+	val &= ~GENMASK(7, 6);
+	val |= 0x2 << 6;
+	/* select PLL6 / pre-div */
+	val &= ~GENMASK(13, 12);
+	val |= 0x3 << 12;
+	writel(val, reg + SUN6I_A31_AHB1_REG);
+
 	sunxi_ccu_probe(node, reg, &sun6i_a31_ccu_desc);
 
 	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
-- 
2.9.3
