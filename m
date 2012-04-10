From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:14 +0200
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the generic clock framework we do not necessarily have
a pointer to the struct clk we want to register a lookup
for, so add a const char *clkname field to struct clk_lookup
so that a lookup can be registered with a clock name.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/clkdev.c   |    8 ++++++++
 include/linux/clkdev.h |    3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index a9a1137..535d3d7 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
@@ -67,6 +68,13 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 
 	mutex_lock(&clocks_mutex);
 	cl = clk_find(dev_id, con_id);
+#ifdef CONFIG_COMMON_CLK
+	if (cl && cl->clkname && !cl->clk) {
+		cl->clk = __clk_lookup(cl->clkname);
+		if (!cl->clk)
+			return ERR_PTR(-ENOENT);
+	}
+#endif
 	if (cl && !__clk_get(cl->clk))
 		cl = NULL;
 	mutex_unlock(&clocks_mutex);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index d9a4fd0..2f589ff 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -21,6 +21,9 @@ struct clk_lookup {
 	struct list_head	node;
 	const char		*dev_id;
 	const char		*con_id;
+#ifdef CONFIG_COMMON_CLK
+	const char		*clkname;
+#endif
 	struct clk		*clk;
 };
 
-- 
1.7.9.5
