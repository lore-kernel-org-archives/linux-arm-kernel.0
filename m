From: jhbird.choi@gmail.com (Jonghwan Choi)
Date: Fri, 16 Sep 2011 23:14:12 +0900
Subject: [PATCH] CLKDEV: Reduce scaning time
Message-ID: <1316182452-14061-1-git-send-email-jhbird.choi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If ether dev_id or con_id is NULL. it is not necessary that match point should be 3.
it just takes a long time.

Signed-off-by: Jonghwan Choi <jhbird.choi@gmail.com>
---
 drivers/clk/clkdev.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6db161f..d1fcb67 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -35,7 +35,13 @@ static DEFINE_MUTEX(clocks_mutex);
 static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 {
 	struct clk_lookup *p, *cl = NULL;
-	int match, best = 0;
+	int match, best = 0, point = 0;
+
+	if (dev_id)
+		point += 2;
+
+	if (con_id)
+		point += 1;
 
 	list_for_each_entry(p, &clocks, node) {
 		match = 0;
@@ -52,10 +58,10 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 
 		if (match > best) {
 			cl = p;
-			if (match != 3)
-				best = match;
-			else
+			if (match == point)
 				break;
+			else
+				best = match;
 		}
 	}
 	return cl;
-- 
1.7.0.4
