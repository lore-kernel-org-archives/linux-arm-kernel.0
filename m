From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  3 Sep 2014 18:01:05 -0700
Subject: [PATCH v2 3/4] clk: Use lockless functions for debug printing
In-Reply-To: <1409792466-5092-1-git-send-email-sboyd@codeaurora.org>
References: <1409792466-5092-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1409792466-5092-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the near future we're going to move the prepare lock to a
per-clock ww_mutex. Use the lockless functions here for printing
the rate and accuracy so that we don't run into AA deadlocks in
the future.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 248a8612a12d..d2da11674f0b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -122,8 +122,8 @@ static void clk_summary_show_one(struct seq_file *s, struct clk *c, int level)
 	seq_printf(s, "%*s%-*s %11d %12d %11lu %10lu\n",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
-		   c->enable_count, c->prepare_count, clk_get_rate(c),
-		   clk_get_accuracy(c));
+		   c->enable_count, c->prepare_count, __clk_get_rate(c),
+		   __clk_get_accuracy(c));
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk *c,
@@ -180,8 +180,8 @@ static void clk_dump_one(struct seq_file *s, struct clk *c, int level)
 	seq_printf(s, "\"%s\": { ", c->name);
 	seq_printf(s, "\"enable_count\": %d,", c->enable_count);
 	seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
-	seq_printf(s, "\"rate\": %lu", clk_get_rate(c));
-	seq_printf(s, "\"accuracy\": %lu", clk_get_accuracy(c));
+	seq_printf(s, "\"rate\": %lu", __clk_get_rate(c));
+	seq_printf(s, "\"accuracy\": %lu", __clk_get_accuracy(c));
 }
 
 static void clk_dump_subtree(struct seq_file *s, struct clk *c, int level)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
