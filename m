From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Dec 2012 14:56:26 +0100
Subject: [PATCH 1/2] arm: cache-l2x0: aurora: Invalidate during clean
 operation with WT enable
In-Reply-To: <1355925387-9564-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355925387-9564-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1355925387-9564-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a bug for Aurora L2 cache controller when the
write-through mode is enable. For the clean operation even if we don't
have to flush the lines we still need to invalidate them.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/cache-l2x0.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 6911b8b..7ffe943 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -505,15 +505,21 @@ static void aurora_clean_range(unsigned long start, unsigned long end)
 
 static void aurora_flush_range(unsigned long start, unsigned long end)
 {
-	if (!l2_wt_override) {
-		start &= ~(CACHE_LINE_SIZE - 1);
-		end = ALIGN(end, CACHE_LINE_SIZE);
-		while (start != end) {
-			unsigned long range_end = calc_range_end(start, end);
+	start &= ~(CACHE_LINE_SIZE - 1);
+	end = ALIGN(end, CACHE_LINE_SIZE);
+	while (start != end) {
+		unsigned long range_end = calc_range_end(start, end);
+		/*
+		 * If L2 is forced to WT, the L2 will always be clean and we
+		 * just need to invalidate.
+		 */
+		if (l2_wt_override)
 			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
-					AURORA_FLUSH_RANGE_REG);
-			start = range_end;
-		}
+							AURORA_INVAL_RANGE_REG);
+		else
+			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
+							AURORA_FLUSH_RANGE_REG);
+		start = range_end;
 	}
 }
 
-- 
1.7.9.5
