From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed,  3 Mar 2010 12:18:27 +0530
Subject: [PATCH v2] CLKDEV: return from clk_find as soon as we get maching clk
Message-ID: <1267598907-7095-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_find function looks for clock with matching dev_id and con_id.
We should return from clk_find as soon as we get a clock with matching dev_id
and con_id. This can be done by comparing variable "match" with 3.

v2:
	- remove if (match == 0), check.
	- move match==3 in if (match > best) condition

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/common/clkdev.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
index aae5bc0..efd53f7 100644
--- a/arch/arm/common/clkdev.c
+++ b/arch/arm/common/clkdev.c
@@ -52,12 +52,13 @@ static struct clk *clk_find(const char *dev_id, const char *con_id)
 				continue;
 			match += 1;
 		}
-		if (match == 0)
-			continue;
 
 		if (match > best) {
 			clk = p->clk;
-			best = match;
+			if (match != 3)
+				best = match;
+			else
+				break;
 		}
 	}
 	return clk;
-- 
1.6.0.2
