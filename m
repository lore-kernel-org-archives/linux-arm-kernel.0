From: s-anna@ti.com (Suman Anna)
Date: Wed, 6 Apr 2016 18:37:19 -0500
Subject: [PATCH 3/4] mailbox/omap: check for any unread messages during suspend
In-Reply-To: <1459985840-1106-1-git-send-email-s-anna@ti.com>
References: <1459985840-1106-1-git-send-email-s-anna@ti.com>
Message-ID: <1459985840-1106-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP mailbox driver is used by clients to communicate with remote
processors in general. The mailbox clients are expected to have stopped
communicating with these remote processors during a system suspend. The
OMAP mailbox fifos are expected to not have any messages as such. Add a
check for any pending unprocessed messages in the suspend callback, to
detect any communication protocol issues of the mailbox clients. The
system suspend is aborted if any messages are found.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 1b90eb380d44..b61c6e8654b5 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -655,11 +655,19 @@ static const struct mbox_chan_ops omap_mbox_chan_ops = {
 static int omap_mbox_suspend(struct device *dev)
 {
 	struct omap_mbox_device *mdev = dev_get_drvdata(dev);
-	u32 usr, reg;
+	u32 usr, fifo, reg;
 
 	if (pm_runtime_status_suspended(dev))
 		return 0;
 
+	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
+		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
+			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
+				fifo);
+			return -EBUSY;
+		}
+	}
+
 	for (usr = 0; usr < mdev->num_users; usr++) {
 		reg = MAILBOX_IRQENABLE(mdev->intr_type, usr);
 		mdev->irq_ctx[usr] = mbox_read_reg(mdev, reg);
-- 
2.7.4
