From: alex.elder@linaro.org (Alex Elder)
Date: Fri, 09 Aug 2013 08:16:16 -0500
Subject: [PATCH] clk: get matching entry under lock in of_clk_init()
Message-ID: <5204EBA0.1070803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently of_clk_init() finds a matching device node while holding
the device tree spinlock.  When a matching device node is found, the
lock is dropped and then re-acquired in order to get a reference
to the matching device id structure.

Acquiring the spinlock twice is unnecessary (and it opens a
vulnerable window that could conceivably lead to errors).

There already exists an interface for both finding and taking a
reference to a device id under lock, so use it.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Christian Daudt <csd@broadcom.com>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 drivers/clk/clk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 56a00db..760ab1d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2116,13 +2116,13 @@ EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
  */
 void __init of_clk_init(const struct of_device_id *matches)
 {
+	const struct of_device_id *match;
 	struct device_node *np;

 	if (!matches)
 		matches = __clk_of_table;

-	for_each_matching_node(np, matches) {
-		const struct of_device_id *match = of_match_node(matches, np);
+	for_each_matching_node_and_match(np, matches, &match) {
 		of_clk_init_cb_t clk_init_cb = match->data;
 		clk_init_cb(np);
 	}
-- 
1.7.9.5
