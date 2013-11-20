From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Wed, 20 Nov 2013 15:09:01 +0100
Subject: [PATCH] clk: propagate parent change up one level
Message-ID: <528CC27D.2000100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for propagation of setup of clock's parent one level
up.

This feature is helpful when a driver changes topology of its clocks using
clk_set_parent().  The problem occurs when driver's clock is located at MUX
output on one platform/SoC but on the other platform/SoC there is a gated proxy
clock between the MUX and driver's clock.  In such a case, driver's code has to
be modified to use one clock for enabling and the other clock for setup of a
parent.

The code updates are avoided by propagating setup of a parent up one level.

Additionally, this patch adds CLK_SET_PARENT_PARENT (sorry for naming) flag to
inform clk-core that clk_set_parent() should be propagated.

Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
---
 drivers/clk/clk.c            |    6 ++++++
 include/linux/clk-provider.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a004769..14eda80 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1595,6 +1595,12 @@ int clk_set_parent(struct clk *clk, struct clk *parent)

 	/* try finding the new parent index */
 	if (parent) {
+		if ((clk->flags & CLK_SET_PARENT_PARENT)
+		    && clk->num_parents == 1) {
+			ret = clk_set_parent(clk->parent, parent);
+			goto out;
+		}
+
 		p_index = clk_fetch_parent_index(clk, parent);
 		p_rate = parent->rate;
 		if (p_index == clk->num_parents) {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 73bdb69..83c98d5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -29,6 +29,7 @@
 #define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
+#define CLK_SET_PARENT_PARENT	BIT(8) /* propagate parent change up one level */

 struct clk_hw;

-- 
1.7.9.5
