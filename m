From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jan 2016 07:11:28 +0000
Subject: [PATCH 3/4] mailbox: mailbox-test: Prevent memory leak
In-Reply-To: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
References: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1452755489-18736-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we set the Signal twice or more, without using it as part of a message,
memory will be re-allocated and the pointer over-written.  Prevent this
potential leak by only allocating memory when there isn't any already.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index e370aa6..539d475 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -58,9 +58,12 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 		return -EINVAL;
 	}
 
-	tdev->signal = kzalloc(MBOX_MAX_SIG_LEN, GFP_KERNEL);
-	if (!tdev->signal)
-		return -ENOMEM;
+	/* Only allocate memory if we need to */
+	if (!tdev->signal) {
+		tdev->signal = kzalloc(MBOX_MAX_SIG_LEN, GFP_KERNEL);
+		if (!tdev->signal)
+			return -ENOMEM;
+	}
 
 	if (copy_from_user(tdev->signal, userbuf, count)) {
 		kfree(tdev->signal);
-- 
1.9.1
