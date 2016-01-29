From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Jan 2016 18:19:36 +0000
Subject: [PATCH 2/2] firmware: arm_scpi: decrease Tx timeout to 20ms
In-Reply-To: <1454091576-27816-1-git-send-email-sudeep.holla@arm.com>
References: <1454091576-27816-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1454091576-27816-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have Tx timeout of 50ms while Rx timeout of 20 ms. Tx state
machine is maintained by the mailbox framework and Rx by SCPI driver.

It is possible that before msg_submit call tx_prepare(because of other
message in the queue and the channel being active), wait for completion
in scpi_send_message times out and the buffers are freed. In that case
when Tx state machine timer goes off later, poll_txdone calls
scpi_tx_prepare on that message, which adds it to the rx_pending list,
corrupting link pointers.

This patch reduces the Tx timeout to 20ms and increases Rx timeout to
30ms to avoid the above mentioned issue.

Reported-by: Jon Medhurst (Tixy) <tixy@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 3cb591eca951..c32ac6e61ba2 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -80,7 +80,7 @@
 #define FW_REV_MINOR(x)		(((x) & FW_REV_MINOR_MASK) >> FW_REV_MINOR_BITS)
 #define FW_REV_PATCH(x)		((x) & FW_REV_PATCH_MASK)
 
-#define MAX_RX_TIMEOUT		(msecs_to_jiffies(20))
+#define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
 
 enum scpi_error_codes {
 	SCPI_SUCCESS = 0, /* Success */
@@ -700,7 +700,7 @@ static int scpi_probe(struct platform_device *pdev)
 		cl->rx_callback = scpi_handle_remote_msg;
 		cl->tx_prepare = scpi_tx_prepare;
 		cl->tx_block = true;
-		cl->tx_tout = 50;
+		cl->tx_tout = 20;
 		cl->knows_txdone = false; /* controller can't ack */
 
 		INIT_LIST_HEAD(&pchan->rx_pending);
-- 
1.9.1
