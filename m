From: jim2101024@gmail.com (Jim Quinlan)
Date: Thu, 18 Dec 2014 17:18:26 -0500
Subject: [PATCH] clk: invoke clk_disable_unused() after resume
Message-ID: <1418941106-5930-1-git-send-email-jim2101024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a discussion[1], mturquette made the suggestion that

    "It might be a good idea to call clk_disable_unused()
     from the clk core after resuming from suspend."

This commit does exactly that.  For Broadcom STB chips, clocks
may come up after resume in an "on" state, so calling
clk_disable_unused() again will turn off clocks that should
be off.

[1] https://lkml.org/lkml/2014/11/17/666

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/clk/clk.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4896ae9..d54d414 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -21,6 +21,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/syscore_ops.h>
 
 #include "clk.h"
 
@@ -500,13 +501,13 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
-static int clk_disable_unused(void)
+static void clk_disable_unused(void)
 {
 	struct clk *clk;
 
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
-		return 0;
+		return;
 	}
 
 	clk_prepare_lock();
@@ -524,10 +525,19 @@ static int clk_disable_unused(void)
 		clk_unprepare_unused_subtree(clk);
 
 	clk_prepare_unlock();
+}
 
+static struct syscore_ops disable_unused_ops = {
+	.resume = clk_disable_unused,
+};
+
+static int clk_init_disable_unused(void)
+{
+	clk_disable_unused();
+	register_syscore_ops(&disable_unused_ops);
 	return 0;
 }
-late_initcall_sync(clk_disable_unused);
+late_initcall_sync(clk_init_disable_unused);
 
 /***    helper functions   ***/
 
-- 
1.9.0.138.g2de3478
