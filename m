From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 27 Nov 2012 14:51:50 +0100
Subject: [PATCH] clk: ux500: assume PRCC clocks are off by default
Message-ID: <1354024310-22021-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The code for the PRCC clock assumed that on boot all the PRCC
clocks were on, defining them as enabled. However some such
clocks like the clock for the GPIO block 6 in the PER2
peripheral group are not on at all.

This would manifest itself as a GPIO block seeming to be
clocked and working from the debugfs point of view when
actually it was not clocked at all.

So instead assume that the PRCC clocks are *not* on, and
everything starts working. This may cause a few extra writes
to the enable registers but it's worth it. We cannot read
the status registers to find out if the clock is on at
this point as that means we first have to turn on the
clock to the peripheral cluster.

Reported-by: Lee Jones <lee.jones@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Philippe Begnic <philippe.begnic@st.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mike: this needs to go into v3.7. (Yes, sorry for not seeing
this earlier, but the problem did manifest itself in very
strange ways.) If v3.7 is not possible, make sure to add the
Cc: stable at kernel.org tag to it.
---
 drivers/clk/ux500/clk-prcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index 7eee7f7..0a20a06 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -120,7 +120,7 @@ static struct clk *clk_reg_prcc(const char *name,
 		goto free_clk;
 
 	clk->cg_sel = cg_sel;
-	clk->is_enabled = 1;
+	clk->is_enabled = 0;
 
 	clk_prcc_init.name = name;
 	clk_prcc_init.ops = clk_prcc_ops;
-- 
1.7.11.3
