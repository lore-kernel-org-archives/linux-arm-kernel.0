From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Mar 2016 14:43:41 +0000
Subject: [PATCH v2 3/5] mailbox: mailbox-test: Use more consistent format for
 calling copy_from_user()
In-Reply-To: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
References: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1458744223-12164-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we're at it, ensure copy-to location is NULL'ed in the error path.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox-test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index dc11bbf..5f4b439 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -46,7 +46,6 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 				       size_t count, loff_t *ppos)
 {
 	struct mbox_test_device *tdev = filp->private_data;
-	int ret;
 
 	if (!tdev->tx_channel) {
 		dev_err(tdev->dev, "Channel cannot do Tx\n");
@@ -64,13 +63,13 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 	if (!tdev->signal)
 		return -ENOMEM;
 
-	ret = copy_from_user(tdev->signal, userbuf, count);
-	if (ret) {
+	if (copy_from_user(tdev->signal, userbuf, count)) {
 		kfree(tdev->signal);
+		tdev->signal = NULL;
 		return -EFAULT;
 	}
 
-	return ret < 0 ? ret : count;
+	return count;
 }
 
 static const struct file_operations mbox_test_signal_ops = {
-- 
1.9.1
