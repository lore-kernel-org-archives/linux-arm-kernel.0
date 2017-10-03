From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:51:48 +0530
Subject: [PATCH 1/5] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush
 sequence
In-Reply-To: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
References: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008112-27117-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As-per suggestion from FlexRM HW folks, we have to first set
FlexRM ring flush state and then clear it for FlexRM ring flush
to work properly.

Currently, the FlexRM driver has incomplete FlexRM ring flush
sequence which causes repeated insmod+rmmod of mailbox client
drivers to fail.

This patch fixes FlexRM ring flush sequence in flexrm_shutdown()
as described above.

Fixes: dbc049eee730 ("mailbox: Add driver for Broadcom FlexRM
ring manager")

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Cc: stable at vger.kernel.org
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index ae61463..f052a3e 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1365,8 +1365,8 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 	/* Disable/inactivate ring */
 	writel_relaxed(0x0, ring->regs + RING_CONTROL);
 
-	/* Flush ring with timeout of 1s */
-	timeout = 1000;
+	/* Set ring flush state */
+	timeout = 1000; /* timeout of 1s */
 	writel_relaxed(BIT(CONTROL_FLUSH_SHIFT),
 			ring->regs + RING_CONTROL);
 	do {
@@ -1374,7 +1374,23 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 		    FLUSH_DONE_MASK)
 			break;
 		mdelay(1);
-	} while (timeout--);
+	} while (--timeout);
+	if (!timeout)
+		dev_err(ring->mbox->dev,
+			"setting ring%d flush state timedout\n", ring->num);
+
+	/* Clear ring flush state */
+	timeout = 1000; /* timeout of 1s */
+	writel_relaxed(0x0, ring + RING_CONTROL);
+	do {
+		if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
+		      FLUSH_DONE_MASK))
+			break;
+		mdelay(1);
+	} while (--timeout);
+	if (!timeout)
+		dev_err(ring->mbox->dev,
+			"clearing ring%d flush state timedout\n", ring->num);
 
 	/* Abort all in-flight requests */
 	for (reqid = 0; reqid < RING_MAX_REQ_COUNT; reqid++) {
-- 
2.7.4
