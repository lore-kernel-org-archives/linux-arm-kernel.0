From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 15 Jan 2013 10:28:05 +0000
Subject: [PATCH 1/1] clk-divider: fix is_power_of_two()
Message-ID: <1358245685-4392-1-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macro is_power_of_two() in clk-divider.c was defined as !(i & ~i)
which is always true. Correct it to !(i & (i - 1)).

Also add brackets around the macro arguments in div_mask and
is_power_of_two, as well as around the is_power_of_two expression as a
whole to avoid any future operator precedence problems.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
I haven't tested this other than with a couple of compile time asserts.

 drivers/clk/clk-divider.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a9204c6..13bca0c 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -29,8 +29,8 @@
 
 #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
 
-#define div_mask(d)	((1 << (d->width)) - 1)
-#define is_power_of_two(i)	!(i & ~i)
+#define div_mask(d)	((1 << ((d)->width)) - 1)
+#define is_power_of_two(i)	(!((i) & ((i) - 1)))
 
 static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
 {
-- 
1.7.7.6
