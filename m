From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 12 Dec 2013 14:30:42 -0600
Subject: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
In-Reply-To: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
Message-ID: <1386880245-10192-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add a "altr,socfpga-sdmmc-sdr-clk" clock type in the SOCFPGA clock driver. This
clock type is not really a "clock" for say, but a mechanism to set the phase
shift of the clock that is used to feed the SD/MMC CIU's clock. This clock does
not have parent so it is designated as a CLK_IS_ROOT.

This clock implements the set_clk_rate method that is meant to receive the SDR
settings that is designated by the "samsung,dw-mshc-sdr-timing" binding. The
SD/MMC driver passes this clock phase information into the clock driver to use.

This enables the SD/MMC driver to touch registers that are located outside of
the SD/MMC IP, which helps make the core SD/MMC driver generic.

Signed-off-by: Dinh Nguyen <dinguyen@alter.com>
---
v6: Add a new clock type "altr,socfpga-sdmmc-sdr-clk" that will be used to
set the phase shift settings.
v5: Use the "snps,dw-mshc" binding
v4: Use the sdmmc_clk prepare function to set the phase shift settings
v3: Not use the syscon driver because as of 3.13-rc1, the syscon driver is
loaded after the clock driver.
v2: Use the syscon driver
---
 drivers/clk/socfpga/clk.c |   86 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 280c983..f4c983e 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -21,8 +21,10 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 
 /* Clock Manager offsets */
 #define CLKMGR_CTRL	0x0
@@ -69,6 +71,84 @@ struct socfpga_clk {
 };
 #define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw.hw)
 
+/* SDMMC Group for System Manager defines */
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+struct sdmmc_sdr_clk {
+	struct clk_hw	hw;
+	u32	reg;
+};
+#define to_sdmmc_sdr_clk(p) container_of(p, struct sdmmc_sdr_clk, hw)
+
+static int sdr_clk_set_rate(struct clk_hw *hwclk, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct sdmmc_sdr_clk *sdmmc_sdr_clk = to_sdmmc_sdr_clk(hwclk);
+	struct regmap *sys_mgr_base_addr;
+	u32 hs_timing;
+
+	sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
+	if (IS_ERR(sys_mgr_base_addr)) {
+		pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
+		return -EINVAL;
+	}
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(((rate > 4) & 0xf), (rate & 0xf));
+	regmap_write(sys_mgr_base_addr, sdmmc_sdr_clk->reg, hs_timing);
+	return 0;
+}
+
+static unsigned long sdr_clk_recalc_rate(struct clk_hw *hwclk,
+						unsigned long parent_rate)
+{
+	return parent_rate;
+}
+
+static long sdr_clk_round_rate(struct clk_hw *hwclk, unsigned long rate,
+						unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static const struct clk_ops sdmmc_sdr_clk_ops = {
+	.recalc_rate = sdr_clk_recalc_rate,
+	.round_rate = sdr_clk_round_rate,
+	.set_rate = sdr_clk_set_rate,
+};
+
+static __init struct clk *socfpga_sdmmc_sdr_clk_init(struct device_node *node,
+						const struct clk_ops *ops)
+{
+	u32 reg;
+	struct clk *clk;
+	struct sdmmc_sdr_clk *sdmmc_sdr_clk;
+	const char *clk_name = node->name;
+	struct clk_init_data init;
+	int rc;
+
+	rc = of_property_read_u32(node, "reg", &reg);
+
+	sdmmc_sdr_clk = kzalloc(sizeof(*sdmmc_sdr_clk), GFP_KERNEL);
+	if (WARN_ON(!sdmmc_sdr_clk))
+		return NULL;
+
+	sdmmc_sdr_clk->reg = reg;
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	init.name = clk_name;
+	init.ops = ops;
+	init.flags = CLK_IS_ROOT;
+	init.num_parents = 0;
+	sdmmc_sdr_clk->hw.init = &init;
+
+	clk = clk_register(NULL, &sdmmc_sdr_clk->hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(sdmmc_sdr_clk);
+		return NULL;
+	}
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return clk;
+}
+
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
@@ -332,10 +412,16 @@ static void __init socfpga_gate_init(struct device_node *node)
 	socfpga_gate_clk_init(node, &gateclk_ops);
 }
 
+static void __init socfpga_sdmmc_init(struct device_node *node)
+{
+	socfpga_sdmmc_sdr_clk_init(node, &sdmmc_sdr_clk_ops);
+}
+
 static struct of_device_id socfpga_child_clocks[] = {
 	{ .compatible = "altr,socfpga-pll-clock", socfpga_pll_init, },
 	{ .compatible = "altr,socfpga-perip-clk", socfpga_periph_init, },
 	{ .compatible = "altr,socfpga-gate-clk", socfpga_gate_init, },
+	{ .compatible = "altr,socfpga-sdmmc-sdr-clk", socfpga_sdmmc_init, },
 	{},
 };
 
-- 
1.7.9.5
