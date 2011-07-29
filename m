From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 29 Jul 2011 16:19:24 +0530
Subject: [PATCH 14/18] dmaengine/amba-pl08x: Choose peripheral bus as master
	bus
In-Reply-To: <cover.1311936523.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
Message-ID: <c1cb9cd2abc64b4efdc3648896324a1821fdba3e.1311936524.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we have DMA transfers between peripheral and memory, then we shouldn't
reduce width of peripheral at all, as that may be a strict requirement. But we
can always reduce width of memory access, with some compromise in performance.
Thus, we must select peripheral as master and not memory.

Also this rearranges code to make it shorter.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/amba-pl08x.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 44f317a..6b0ca26 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -492,34 +492,24 @@ struct pl08x_lli_build_data {
 /*
  * Autoselect a master bus to use for the transfer
  * - prefers the destination bus if both available
- * - if fixed address on one bus the other will be chosen
+ * - prefers bus with fixed address (i.e. peripheral)
  */
 static void pl08x_choose_master_bus(struct pl08x_lli_build_data *bd,
 	struct pl08x_bus_data **mbus, struct pl08x_bus_data **sbus, u32 cctl)
 {
 	if (!(cctl & PL080_CONTROL_DST_INCR)) {
-		*mbus = &bd->srcbus;
-		*sbus = &bd->dstbus;
-	} else if (!(cctl & PL080_CONTROL_SRC_INCR)) {
 		*mbus = &bd->dstbus;
 		*sbus = &bd->srcbus;
+	} else if (!(cctl & PL080_CONTROL_SRC_INCR)) {
+		*mbus = &bd->srcbus;
+		*sbus = &bd->dstbus;
 	} else {
-		if (bd->dstbus.buswidth == 4) {
-			*mbus = &bd->dstbus;
-			*sbus = &bd->srcbus;
-		} else if (bd->srcbus.buswidth == 4) {
-			*mbus = &bd->srcbus;
-			*sbus = &bd->dstbus;
-		} else if (bd->dstbus.buswidth == 2) {
+		if (bd->dstbus.buswidth >= bd->srcbus.buswidth) {
 			*mbus = &bd->dstbus;
 			*sbus = &bd->srcbus;
-		} else if (bd->srcbus.buswidth == 2) {
+		} else {
 			*mbus = &bd->srcbus;
 			*sbus = &bd->dstbus;
-		} else {
-			/* bd->srcbus.buswidth == 1 */
-			*mbus = &bd->dstbus;
-			*sbus = &bd->srcbus;
 		}
 	}
 }
-- 
1.7.2.2
