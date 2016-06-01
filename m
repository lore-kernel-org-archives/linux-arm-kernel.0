From: eric@anholt.net (Eric Anholt)
Date: Wed,  1 Jun 2016 12:05:33 -0700
Subject: [PATCH v3 1/4] clk: bcm2835: Mark the VPU clock as critical
In-Reply-To: <1464807936-532-1-git-send-email-eric@anholt.net>
References: <1464807936-532-1-git-send-email-eric@anholt.net>
Message-ID: <1464807936-532-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VPU clock is also the clock for our AXI bus, so we really can't
disable it.  This might have happened during boot if, for example,
uart1 (aux_uart clock) probed and was then disabled before the other
consumers of the VPU clock had probed.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Rewrite to use a .flags in bcm2835_clock_data, since other clocks
    will need this too.

 drivers/clk/bcm/clk-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 7a7970865c2d..d9db03cb3fd8 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -443,6 +443,8 @@ struct bcm2835_clock_data {
 	/* Number of fractional bits in the divider */
 	u32 frac_bits;
 
+	u32 flags;
+
 	bool is_vpu_clock;
 	bool is_mash_clock;
 };
@@ -1230,7 +1232,7 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	init.parent_names = parents;
 	init.num_parents = data->num_mux_parents;
 	init.name = data->name;
-	init.flags = CLK_IGNORE_UNUSED;
+	init.flags = data->flags | CLK_IGNORE_UNUSED;
 
 	if (data->is_vpu_clock) {
 		init.ops = &bcm2835_vpu_clock_clk_ops;
@@ -1649,6 +1651,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_VPUDIV,
 		.int_bits = 12,
 		.frac_bits = 8,
+		.flags = CLK_IS_CRITICAL,
 		.is_vpu_clock = true),
 
 	/* clocks with per parent mux */
-- 
2.8.0.rc3
