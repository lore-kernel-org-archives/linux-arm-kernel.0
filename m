From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Feb 2014 23:16:52 -0700
Subject: [PATCH 1/2] clk: fixed-rate: use full DT node name
Message-ID: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk-fixed-rate currently names clocks according to a node's name without
the unit address. When faced with the legal and technically correct DT
structure below, this causes rgistration attempts for 3 clocks with the
same name, 2 of which fail.

	clocks {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;

		clk_mmc: clock at 0 {
			compatible = "fixed-clock";
			reg = <0>;
...
		clk_i2c: clock at 1 {
			compatible = "fixed-clock";
			reg = <1>;
...
		clk_spi: clock at 2 {
			compatible = "fixed-clock";
			reg = <2>;
...

Solve this by naming the clocks after the full node name rather than the
short version (e.g. /clocks/clock at 0).

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
Note that if this is accepted, I intend to submit a patch for the RPi DTS
which uses the naming structure above, so it might be useful to place this
patch in its own branch. Or, I could submit the cleanup after 3.15-rc1.
---
 drivers/clk/clk-fixed-rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 0fc56ab..3335b3c 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -115,7 +115,7 @@ EXPORT_SYMBOL_GPL(clk_register_fixed_rate);
 void of_fixed_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
-	const char *clk_name = node->name;
+	const char *clk_name = node->full_name;
 	u32 rate;
 	u32 accuracy = 0;
 
-- 
1.8.3.2
