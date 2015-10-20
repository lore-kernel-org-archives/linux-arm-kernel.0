From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Oct 2015 17:11:27 +0100
Subject: [PATCH] mailbox: mailbox-test: Correctly repair Sparse warnings
Message-ID: <1445357487-13961-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kbuild test robot reported some Sparse warnings to the tune of:

  sparse: incorrect type in argument 6 (different address spaces)
    expected void const *buf
    got void [noderef] <asn:2>*mmio

This was due to passing variables tagged with the Sparse cookie
'__iomem' through into memcpy() and print_hex_dump() without
adequate protection or casting.  These issues were fixed in a
previous patch suppressing the warnings, but the issue is indeed
still present.

This patch fixes the warnings in the correct way, i.e. by using
the purposely authored memcpy_{from,to}io() derivatives in the
memcpy() case and casting the memory address to (void *) and
forcing Sparse to ignore to ignore it in the print_hex_dump()
case [NB: This is also what the memcpy() derivatives do].

Reported-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox-test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 22f2e40..a4f10cc 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -11,6 +11,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
@@ -30,7 +31,7 @@ static struct dentry *root_debugfs_dir;
 
 struct mbox_test_device {
 	struct device		*dev;
-	void			*mmio;
+	void __iomem		*mmio;
 	struct mbox_chan	*tx_channel;
 	struct mbox_chan	*rx_channel;
 	char			*rx_buffer;
@@ -222,8 +223,8 @@ static void mbox_test_receive_message(struct mbox_client *client, void *message)
 	if (tdev->mmio) {
 		print_hex_dump(KERN_INFO, "Client: Received [MMIO]: ",
 			       DUMP_PREFIX_ADDRESS, MBOX_BYTES_PER_LINE, 1,
-			       tdev->mmio, MBOX_MAX_MSG_LEN, true);
-		memcpy(tdev->rx_buffer, tdev->mmio, MBOX_MAX_MSG_LEN);
+			       __io_virt(tdev->mmio), MBOX_MAX_MSG_LEN, true);
+		memcpy_fromio(tdev->rx_buffer, tdev->mmio, MBOX_MAX_MSG_LEN);
 
 	} else if (message) {
 		print_hex_dump(KERN_INFO, "Client: Received [API]: ",
@@ -240,9 +241,9 @@ static void mbox_test_prepare_message(struct mbox_client *client, void *message)
 
 	if (tdev->mmio) {
 		if (tdev->signal)
-			memcpy(tdev->mmio, tdev->message, MBOX_MAX_MSG_LEN);
+			memcpy_toio(tdev->mmio, tdev->message, MBOX_MAX_MSG_LEN);
 		else
-			memcpy(tdev->mmio, message, MBOX_MAX_MSG_LEN);
+			memcpy_toio(tdev->mmio, message, MBOX_MAX_MSG_LEN);
 	}
 }
 
-- 
1.9.1
