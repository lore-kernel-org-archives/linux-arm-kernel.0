From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 31 Mar 2015 15:02:00 +0200
Subject: [PATCH v2 2/8] net/macb: add comment in macb_probe_queues
In-Reply-To: <1427806926-18887-1-git-send-email-nicolas.ferre@atmel.com>
References: <1427806926-18887-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1427806926-18887-3-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we access the MID register directly, we need to tell why
we don't use the macb_is_gem() dedicated function.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---

Changes in v2: None

 drivers/net/ethernet/cadence/macb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index ac1f18142f7e..68d59b3900b1 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -2161,9 +2161,13 @@ static void macb_probe_queues(void __iomem *mem,
 	*queue_mask = 0x1;
 	*num_queues = 1;
 
-	/* is it macb or gem ? */
+	/* is it macb or gem ?
+	 *
+	 * We need to read directly from the hardware here because
+	 * we are early in the probe process and don't have the
+	 * MACB_CAPS_MACB_IS_GEM flag positioned
+	 */
 	mid = readl_relaxed(mem + MACB_MID);
-
 	if (MACB_BFEXT(IDNUM, mid) < 0x2)
 		return;
 
-- 
2.1.3
