From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sun, 11 Feb 2018 11:42:01 +0800
Subject: [PATCH] irqchip/gic-v3-its: handle rd_idx wrapping in
 its_wait_for_range_completion()
Message-ID: <1518320521-12536-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In direct case, rd_idx will wrap if other cpus post commands
that make rd_idx increase. When rd_idx wrapped, the driver prints
timeout messages but in fact the command is finished. To handle
this case by adding last_rd_id to check rd_idx whether wrapped.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 84 ++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025f..d7176d1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -713,7 +713,8 @@ static void its_flush_cmd(struct its_node *its, struct its_cmd_block *cmd)
 
 static int its_wait_for_range_completion(struct its_node *its,
 					 struct its_cmd_block *from,
-					 struct its_cmd_block *to)
+					 struct its_cmd_block *to,
+					 u64 last_rd_idx)
 {
 	u64 rd_idx, from_idx, to_idx;
 	u32 count = 1000000;	/* 1s! */
@@ -724,9 +725,14 @@ static int its_wait_for_range_completion(struct its_node *its,
 	while (1) {
 		rd_idx = readl_relaxed(its->base + GITS_CREADR);
 
-		/* Direct case */
-		if (from_idx < to_idx && rd_idx >= to_idx)
-			break;
+
+		/*
+		 * Direct case. In this case, rd_idx may wrapped,
+		 * because other cpus may post commands that make
+		 * rd_idx increase.
+		 */
+		if (from_idx < to_idx && (rd_idx >= to_idx || rd_idx < last_rd_idx))
+				break;
 
 		/* Wrapped case */
 		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
@@ -746,40 +752,42 @@ static int its_wait_for_range_completion(struct its_node *its,
 }
 
 /* Warning, macro hell follows */
-#define BUILD_SINGLE_CMD_FUNC(name, buildtype, synctype, buildfn)	\
-void name(struct its_node *its,						\
-	  buildtype builder,						\
-	  struct its_cmd_desc *desc)					\
-{									\
-	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;		\
-	synctype *sync_obj;						\
-	unsigned long flags;						\
-									\
-	raw_spin_lock_irqsave(&its->lock, flags);			\
-									\
-	cmd = its_allocate_entry(its);					\
-	if (!cmd) {		/* We're soooooo screewed... */		\
-		raw_spin_unlock_irqrestore(&its->lock, flags);		\
-		return;							\
-	}								\
-	sync_obj = builder(its, cmd, desc);				\
-	its_flush_cmd(its, cmd);					\
-									\
-	if (sync_obj) {							\
-		sync_cmd = its_allocate_entry(its);			\
-		if (!sync_cmd)						\
-			goto post;					\
-									\
-		buildfn(its, sync_cmd, sync_obj);			\
-		its_flush_cmd(its, sync_cmd);				\
-	}								\
-									\
-post:									\
-	next_cmd = its_post_commands(its);				\
-	raw_spin_unlock_irqrestore(&its->lock, flags);			\
-									\
-	if (its_wait_for_range_completion(its, cmd, next_cmd))		\
-		pr_err_ratelimited("ITS cmd %ps failed\n", builder);	\
+#define BUILD_SINGLE_CMD_FUNC(name, buildtype, synctype, buildfn)		\
+void name(struct its_node *its,							\
+	  buildtype builder,							\
+	  struct its_cmd_desc *desc)						\
+{										\
+	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;			\
+	synctype *sync_obj;							\
+	unsigned long flags;							\
+	u64 last_rd_idx;							\
+										\
+	raw_spin_lock_irqsave(&its->lock, flags);				\
+										\
+	cmd = its_allocate_entry(its);						\
+	if (!cmd) {		/* We're soooooo screewed... */			\
+		raw_spin_unlock_irqrestore(&its->lock, flags);			\
+		return;								\
+	}									\
+	sync_obj = builder(its, cmd, desc);					\
+	its_flush_cmd(its, cmd);						\
+										\
+	if (sync_obj) {								\
+		sync_cmd = its_allocate_entry(its);				\
+		if (!sync_cmd)							\
+			goto post;						\
+										\
+		buildfn(its, sync_cmd, sync_obj);				\
+		its_flush_cmd(its, sync_cmd);					\
+	}									\
+										\
+post:										\
+	next_cmd = its_post_commands(its);					\
+	last_rd_idx = readl_relaxed(its->base + GITS_CREADR);			\
+	raw_spin_unlock_irqrestore(&its->lock, flags);				\
+										\
+	if (its_wait_for_range_completion(its, cmd, next_cmd, last_rd_idx))	\
+		pr_err_ratelimited("ITS cmd %ps failed\n", builder);		\
 }
 
 static void its_build_sync_cmd(struct its_node *its,
-- 
1.8.3
