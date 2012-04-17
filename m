From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 10:59:49 +0530
Subject: [PATCH] CLKDEV: Optimize clk_find()
Message-ID: <f142251c5cc09681c3644519d1d5c13e0cfdd951.1334640503.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_find must return as soon as it gets the correct clock. Currently it check
all clocks until it found a lookup with both dev_id and con_id matching.

If only one of them is passed, then we don't actually need to wait for both of
them to match. We can quit as soon as the requested id (dev_id or con_id)
matches.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clkdev.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9d93d27..3a72022 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -35,7 +35,12 @@ static DEFINE_MUTEX(clocks_mutex);
 static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 {
 	struct clk_lookup *p, *cl = NULL;
-	int match, best = 0;
+	int match, best_found = 0, best_possible = 0;
+
+	if (dev_id)
+		best_possible += 2;
+	if (con_id)
+		best_possible += 1;
 
 	list_for_each_entry(p, &clocks, node) {
 		match = 0;
@@ -50,10 +55,10 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 			match += 1;
 		}
 
-		if (match > best) {
+		if (match > best_found) {
 			cl = p;
-			if (match != 3)
-				best = match;
+			if (match != best_possible)
+				best_found = match;
 			else
 				break;
 		}
-- 
1.7.9
