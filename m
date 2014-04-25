From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 25 Apr 2014 15:44:47 -0700
Subject: [RFC/PATCH 3/4] clk: Use lockless functions for debug printing
In-Reply-To: <1398465888-12610-1-git-send-email-sboyd@codeaurora.org>
References: <1398465888-12610-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1398465888-12610-4-git-send-email-sboyd@codeaurora.org>
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
index fd22a4583013..48b3a5594839 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -111,8 +111,8 @@ static void clk_summary_show_one(struct seq_file *s, struct clk *c, int level)
 	seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
-		   c->enable_count, c->prepare_count, clk_get_rate(c),
-		   clk_get_accuracy(c));
+		   c->enable_count, c->prepare_count, __clk_get_rate(c),
+		   __clk_get_accuracy(c));
 	seq_printf(s, "\n");
 }
 
@@ -171,8 +171,8 @@ static void clk_dump_one(struct seq_file *s, struct clk *c, int level)
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
