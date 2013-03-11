From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 11 Mar 2013 14:13:37 -0700
Subject: [PATCH RFC] clk: divider: Tolerate 0 divider for one based dividers
Message-ID: <dbceb80f-0303-4ba0-acd8-336dd85444ae@DB8EHSMHS017.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle a zero divider value as one/bypass for dividers which have the
CLK_DIVIDER_ONE_BASED flag set.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
In Zynq we have a lot of dividers which are one based, but at the same time
zero is a valid value which is handled as one/bypass. Also, the reset value of
some of these registers is zero, resulting in warnings when the clock framework
encounters this.

So, my question here is: Are our dividers odd? Does it make sense to allow zero
for all one based dividers, as shown in this patch? Or does this behavior
qualify for another flag for the divider clocks (e.g. CLK_DIVIDER_ZERO_OKAY)?

	Thanks,
	S?ren

 drivers/clk/clk-divider.c    | 5 +++--
 include/linux/clk-provider.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 68b4021..6c2a431 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -109,8 +109,9 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 
 	div = _get_div(divider, val);
 	if (!div) {
-		WARN(1, "%s: Invalid divisor for clock %s\n", __func__,
-						__clk_get_name(hw->clk));
+		WARN(!(divider->flags & CLK_DIVIDER_ONE_BASED),
+				"%s: Invalid divisor for clock %s\n", __func__,
+				__clk_get_name(hw->clk));
 		return parent_rate;
 	}
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7f197d7..5b19b13 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -238,8 +238,8 @@ struct clk_div_table {
  * Flags:
  * CLK_DIVIDER_ONE_BASED - by default the divisor is the value read from the
  * 	register plus one.  If CLK_DIVIDER_ONE_BASED is set then the divider is
- * 	the raw value read from the register, with the value of zero considered
- * 	invalid
+ *	the raw value read from the register. A zero divider is considered to be
+ *	the same as the a value of one.
  * CLK_DIVIDER_POWER_OF_TWO - clock divisor is 2 raised to the value read from
  * 	the hardware register
  */
-- 
1.8.1.5
