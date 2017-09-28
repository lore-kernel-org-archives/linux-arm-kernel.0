From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:35 +0100
Subject: [PATCH v3 11/22] firmware: arm_scmi: add support for polling based
 SCMI transfers
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-12-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It would be useful to have options to perform some SCMI transfers
atomically by polling for the completion flag instead of interrupt
driven. The SCMI specification has option to disable the interrupt and
poll for the completion flag in the shared memory.

This patch adds support for polling based SCMI transfers using that
option. This might be used for uninterrupted/atomic DVFS operations
from the scheduler context.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 41 ++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a1abcf2049ca..e1abedf15cb0 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -369,6 +370,20 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	up(&minfo->sem_xfer_count);
 }
 
+static bool
+scmi_xfer_poll_done(const struct scmi_info *info, struct scmi_xfer *xfer)
+{
+	struct scmi_shared_mem *mem = info->tx_payload;
+	u16 xfer_id = MSG_XTRACT_TOKEN(le32_to_cpu(mem->msg_header));
+
+	if (xfer->hdr.seq != xfer_id)
+		return false;
+
+	return le32_to_cpu(mem->channel_status) &
+		(SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
+		SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
+}
+
 /**
  * scmi_do_xfer() - Do one transfer
  *
@@ -395,14 +410,24 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	/* mbox_send_message returns non-negative value on success, so reset */
 	ret = 0;
 
-	/* And we wait for the response. */
-	timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-	if (!wait_for_completion_timeout(&xfer->done, timeout)) {
-		dev_err(dev, "mbox timed out in resp(caller: %pF)\n",
-			(void *)_RET_IP_);
-		ret = -ETIMEDOUT;
-	} else if (xfer->hdr.status) {
-		ret = scmi_to_linux_errno(xfer->hdr.status);
+	if (xfer->hdr.poll_completion) {
+		timeout = info->desc->max_rx_timeout_ms * 100;
+		while (!scmi_xfer_poll_done(info, xfer) && timeout--)
+			udelay(10);
+		if (timeout)
+			scmi_fetch_response(xfer, info->tx_payload);
+		else
+			ret = -ETIMEDOUT;
+	} else {
+		/* And we wait for the response. */
+		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
+		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
+			dev_err(dev, "mbox timed out in resp(caller: %pF)\n",
+				(void *)_RET_IP_);
+			ret = -ETIMEDOUT;
+		} else if (xfer->hdr.status) {
+			ret = scmi_to_linux_errno(xfer->hdr.status);
+		}
 	}
 	/*
 	 * NOTE: we might prefer not to need the mailbox ticker to manage the
-- 
2.7.4
