From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 23 Sep 2014 20:44:15 +0200
Subject: [PATCH v13 7/9] clk: Take the prepare lock when updating the list of
 per-user clks
In-Reply-To: <1411497857-24726-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1411497613-24049-1-git-send-email-tomeu.vizoso@collabora.com>
 <1411497857-24726-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1411497857-24726-5-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bfb4672..3eb133c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -560,7 +560,9 @@ struct clk *__clk_create_clk(struct clk_core *clk_core, const char *dev,
 	clk->dev_id = dev;
 	clk->con_id = con;
 
+	clk_prepare_lock();
 	hlist_add_head(&clk->child_node, &clk_core->per_user_clks);
+	clk_prepare_unlock();
 
 	return clk;
 }
-- 
1.9.3
