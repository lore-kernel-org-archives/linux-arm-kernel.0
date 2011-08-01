From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 1 Aug 2011 15:07:26 +0530
Subject: [PATCH V2 16/20] dmaengine/amba-pl08x: Choose peripheral bus as
	master bus
In-Reply-To: <cover.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
Message-ID: <f7c6713e493ea64cbb9a659753f3ba508f033a86.1312190881.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we have DMA transfers between peripheral and memory, then we shouldn't
reduce width of peripheral at all, as that may be a strict requirement. But we
can always reduce width of memory access, with some compromise in performance.
Thus, we must select peripheral as master and not memory.

Also this rearranges code to make it shorter.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index ef02fb9..c969309 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -496,34 +496,24 @@ struct pl08x_lli_build_data {
  * byte data), slave is still not aligned, then its width will be reduced to
  * BYTE.
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
