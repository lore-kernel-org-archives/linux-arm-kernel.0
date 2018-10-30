From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 30 Oct 2018 19:08:41 +0100
Subject: [PATCH] firmware: raspberrypi: Define timeout for transactions
Message-ID: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should never assume to get a reply from the firmware otherwise
the call could block forever and the user don't get informed. So
define a timeout of 1 sec and print a stacktrace once in the unlikely
case the timeout expired.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/firmware/raspberrypi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index a200a21..bf45ac4 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -56,8 +56,12 @@ rpi_firmware_transaction(struct rpi_firmware *fw, u32 chan, u32 data)
 	reinit_completion(&fw->c);
 	ret = mbox_send_message(fw->chan, &message);
 	if (ret >= 0) {
-		wait_for_completion(&fw->c);
-		ret = 0;
+		if (wait_for_completion_timeout(&fw->c, HZ)) {
+			ret = 0;
+		} else {
+			ret = -ETIMEDOUT;
+			WARN_ONCE(1, "Firmware transaction timeout");
+		}
 	} else {
 		dev_err(fw->cl.dev, "mbox_send_message returned %d\n", ret);
 	}
-- 
2.7.4
