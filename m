From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 20 Jan 2016 15:42:54 +0100
Subject: [PATCH] clk-divider: make sure read-only dividers do not write to
 their register
Message-ID: <8710207.gKyLbM2bKY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1") removed
the special ops struct for read-only clocks and instead opted to handle
them regularly.

On the rk3368 this results in breakage as aclkm now gets set a value.
While it is the same divider, the A53 core still doesn't like it.
The reason being that "ACLKENMasserts one clock cycle before the rising
edge of ACLKM" and the clock should only be touched when STANDBYWFIL2
is asserted.

So make sure, read-only clocks don't touch the clock-register at all
even if only writing the same value.

Fixes: e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
Reported-by: Zhang Qing <zhangqing@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-divider.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index ded3ff4..6dfe261 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -391,6 +391,10 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags = 0;
 	u32 val;
 
+	/* don't do writes in read-only case */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY)
+		return 0;
+
 	value = divider_get_val(rate, parent_rate, divider->table,
 				divider->width, divider->flags);
 
-- 
2.6.4
