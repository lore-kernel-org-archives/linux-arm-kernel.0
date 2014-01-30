From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 30 Jan 2014 20:03:11 +0200
Subject: [PATCH v2] clk: keystone: gate: fix clk_init_data initialization
Message-ID: <1391104991-15000-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_init_data struct is allocated in the stack. All members of
this struct should be initialized before using otherwise it will
lead to unpredictable situation as it can contain garbage.

Ultimately the clk->flag field contains garbage. In my case it leads
that flag CLK_IGNORE_UNUSED is set for most of clocks. As result a
bunch of unused clocks cannot be disabled.

So initialize flags in this structure too.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
Based on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

v1..v2:
- updated commit description only

 drivers/clk/keystone/gate.c | 1 +
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
1.8.3.2
