From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 16 Dec 2013 10:41:38 +0000
Subject: [PATCH] clk: clk-divider: fix divisor > 255 bug
Message-ID: <1387190498-15392-1-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6d9252bd9a4bb (clk: Add support for power of two type dividers)
merged in v3.6 added the _get_val function to convert a divisor value to
a register field value depending on the flags. However it used the type
u8 for the div field, causing divisors larger than 255 to be masked
and the resultant clock rate to be too high.

E.g. in my case an 11bit divider was supposed to divide 24.576 MHz down
to 32.768KHz. The divisor was correctly calculated as 750 (0x2ee). This
was masked to 238 (0xee) resulting in a frequency of 103.26KHz.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: stable at vger.kernel.org
---
Since this bug was introduced in 3.6, it probably should by applied to
stable 3.10 and 3.12.
---
 drivers/clk/clk-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8d3009e44fba..5543b7df8e16 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -87,7 +87,7 @@ static unsigned int _get_table_val(const struct clk_div_table *table,
 	return 0;
 }
 
-static unsigned int _get_val(struct clk_divider *divider, u8 div)
+static unsigned int _get_val(struct clk_divider *divider, unsigned int div)
 {
 	if (divider->flags & CLK_DIVIDER_ONE_BASED)
 		return div;
-- 
1.8.1.2
