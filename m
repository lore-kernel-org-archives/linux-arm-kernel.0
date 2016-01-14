From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jan 2016 07:11:26 +0000
Subject: [PATCH 1/4] mailbox: mailbox-test: Use more consistent format for
 calling copy_from_user()
In-Reply-To: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
References: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1452755489-18736-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we're at it, ensure copy-to location is NULL'ed in the error path.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 684ae17..7d9b915 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -63,9 +63,9 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 	if (!tdev->signal)
 		return -ENOMEM;
 
-	ret = copy_from_user(tdev->signal, userbuf, count);
-	if (ret) {
+	if (copy_from_user(tdev->signal, userbuf, count)) {
 		kfree(tdev->signal);
+		tdev->signal = NULL;
 		return -EFAULT;
 	}
 
-- 
1.9.1
