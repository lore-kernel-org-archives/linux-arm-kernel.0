From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:50 +0000
Subject: [PATCH 10/26] mfd: ab8500-debugfs: Wake-up device on debugfs IRQ
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure the device wakes up if the debugfs IRQ fires if we're
in suspend mode.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 71df8e4..b3ddc23 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -616,7 +616,8 @@ static ssize_t ab8500_subscribe_write(struct file *file,
 	}
 
 	err = request_threaded_irq(user_val, NULL, ab8500_debug_handler,
-				   0, "ab8500-debug", &dev->kobj);
+				   IRQF_SHARED | IRQF_NO_SUSPEND,
+				   "ab8500-debug", &dev->kobj);
 	if (err < 0) {
 		printk(KERN_ERR "request_threaded_irq failed %d, %lu\n",
                        err, user_val);
-- 
1.7.9.5
