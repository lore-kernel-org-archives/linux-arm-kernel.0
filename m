From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 10 Feb 2014 15:26:50 -0500
Subject: [PATCH 1/2] clk: keystone: gate: fix clk_init_data initialization
In-Reply-To: <1392064011-11986-1-git-send-email-santosh.shilimkar@ti.com>
References: <1392064011-11986-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1392064011-11986-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

The clk_init_data struct is allocated in the stack. All members of
this struct should be initialized before using otherwise it will
lead to unpredictable situation as it can contain garbage.

Ultimately the clk->flag field contains garbage. In my case it leads
that flag CLK_IGNORE_UNUSED is set for most of clocks. As result a
bunch of unused clocks cannot be disabled.

So initialize flags in this structure too.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/clk/keystone/gate.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
index 17a5983..86f1e36 100644
--- a/drivers/clk/keystone/gate.c
+++ b/drivers/clk/keystone/gate.c
@@ -179,6 +179,7 @@ static struct clk *clk_register_psc(struct device *dev,
 
 	init.name = name;
 	init.ops = &clk_psc_ops;
+	init.flags = 0;
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
-- 
1.7.9.5
