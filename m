From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 11 Sep 2014 16:26:21 +0200
Subject: [PATCH v11 7/9] clk: Take the prepare lock when updating the list of
 per-user clks
In-Reply-To: <1410445583-18626-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1410445421-18362-1-git-send-email-tomeu.vizoso@collabora.com>
 <1410445583-18626-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1410445583-18626-5-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3018f37..f283dcc 100644
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
