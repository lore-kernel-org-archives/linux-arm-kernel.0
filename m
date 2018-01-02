From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  2 Jan 2018 14:42:33 +0000
Subject: [PATCH v5 11/20] firmware: arm_scmi: add support for polling based
 SCMI transfers
In-Reply-To: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1514904162-11201-12-git-send-email-sudeep.holla@arm.com>
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
 drivers/firmware/arm_scmi/driver.c | 49 +++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 11c18ac9816f..0c9dda72f10c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -26,9 +26,11 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -363,6 +365,21 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
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
+#define SCMI_MAX_POLLING_TIMEOUT_NS	(100 * NSEC_PER_USEC)
 /**
  * scmi_do_xfer() - Do one transfer
  *
@@ -389,14 +406,30 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
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
+		ktime_t stop, cur;
+
+		stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLLING_TIMEOUT_NS);
+		do {
+			udelay(5);
+			cur = ktime_get();
+		} while (!scmi_xfer_poll_done(info, xfer) &&
+			 ktime_before(cur, stop));
+
+		if (ktime_before(cur, stop))
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
