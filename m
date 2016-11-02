From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed,  2 Nov 2016 08:57:05 +0100
Subject: [PATCH 2/3] ipmi/bt-bmc: maintain a request expiry list
In-Reply-To: <1478073426-3714-1-git-send-email-clg@kaod.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
Message-ID: <1478073426-3714-3-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regarding the response expiration handling, the IPMI spec says :

   The BMC must not return a given response once the corresponding
   Request-to-Response interval has passed. The BMC can ensure this
   by maintaining its own internal list of outstanding requests through
   the interface. The BMC could age and expire the entries in the list
   by expiring the entries at an interval that is somewhat shorter than
   the specified Request-to-Response interval....

To handle such case, we maintain list of received requests using the
seq number of the BT message to identify them. The list is updated
each time a request is received and a response is sent. The expiration
of the reponses is handled at each updates but also with a timer.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/char/ipmi/bt-bmc.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index fc9e8891eae3..e751e4a754b7 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 #include <linux/timer.h>
 
 /*
@@ -57,6 +58,15 @@
 
 #define BT_BMC_BUFFER_SIZE 256
 
+#define BT_BMC_RESPONSE_TIME	5 /* seconds */
+
+struct ipmi_request {
+	struct list_head list;
+
+	u8 seq;
+	unsigned long expires;
+};
+
 struct bt_bmc {
 	struct device		dev;
 	struct miscdevice	miscdev;
@@ -65,6 +75,11 @@ struct bt_bmc {
 	wait_queue_head_t	queue;
 	struct timer_list	poll_timer;
 	struct mutex		mutex;
+
+	unsigned int		response_time;
+	struct timer_list	requests_timer;
+	spinlock_t              requests_lock;
+	struct list_head        requests;
 };
 
 static atomic_t open_count = ATOMIC_INIT(0);
@@ -163,6 +178,94 @@ static int bt_bmc_open(struct inode *inode, struct file *file)
 }
 
 /*
+ * lock should be held
+ */
+static void drop_expired_requests(struct bt_bmc *bt_bmc)
+{
+	unsigned long flags = 0;
+	struct ipmi_request *req, *next;
+	unsigned long next_expires = 0;
+	int start_timer = 0;
+
+	spin_lock_irqsave(&bt_bmc->requests_lock, flags);
+	list_for_each_entry_safe(req, next, &bt_bmc->requests, list) {
+		if (time_after_eq(jiffies, req->expires)) {
+			pr_warn("BT: request seq:%d has expired. dropping\n",
+				req->seq);
+			list_del(&req->list);
+			kfree(req);
+			continue;
+		}
+		if (!start_timer) {
+			start_timer = 1;
+			next_expires = req->expires;
+		} else {
+			next_expires = min(next_expires, req->expires);
+		}
+	}
+	spin_unlock_irqrestore(&bt_bmc->requests_lock, flags);
+
+	/* and possibly restart */
+	if (start_timer)
+		mod_timer(&bt_bmc->requests_timer, next_expires);
+}
+
+static void requests_timer(unsigned long data)
+{
+	struct bt_bmc *bt_bmc = (void *)data;
+
+	drop_expired_requests(bt_bmc);
+}
+
+static int bt_bmc_add_request(struct bt_bmc *bt_bmc, u8 seq)
+{
+	struct ipmi_request *req;
+
+	req = kmalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->seq = seq;
+	req->expires = jiffies +
+		msecs_to_jiffies(bt_bmc->response_time * 1000);
+
+	spin_lock(&bt_bmc->requests_lock);
+	list_add(&req->list, &bt_bmc->requests);
+	spin_unlock(&bt_bmc->requests_lock);
+
+	drop_expired_requests(bt_bmc);
+	return 0;
+}
+
+static int bt_bmc_remove_request(struct bt_bmc *bt_bmc, u8 seq)
+{
+	struct ipmi_request *req, *next;
+	int ret = -EBADRQC; /* Invalid request code */
+
+	spin_lock(&bt_bmc->requests_lock);
+	list_for_each_entry_safe(req, next, &bt_bmc->requests, list) {
+		/*
+		 * The sequence number should be unique, so remove the
+		 * first matching request found. If there are others,
+		 * they should expire
+		 */
+		if (req->seq == seq) {
+			list_del(&req->list);
+			kfree(req);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&bt_bmc->requests_lock);
+
+	if (ret)
+		pr_warn("BT: request seq:%d is invalid\n", seq);
+
+	drop_expired_requests(bt_bmc);
+	return ret;
+}
+
+/*
  * The BT (Block Transfer) interface means that entire messages are
  * buffered by the host before a notification is sent to the BMC that
  * there is data to be read. The first byte is the length and the
@@ -231,6 +334,13 @@ static ssize_t bt_bmc_read(struct file *file, char __user *buf,
 		len_byte = 0;
 	}
 
+	if (ret > 0) {
+		int ret2 = bt_bmc_add_request(bt_bmc, kbuffer[2]);
+
+		if (ret2)
+			ret = ret2;
+	}
+
 	clr_b_busy(bt_bmc);
 
 out_unlock:
@@ -283,12 +393,20 @@ static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
 	clr_wr_ptr(bt_bmc);
 
 	while (count) {
+		int ret2;
+
 		nwritten = min_t(ssize_t, count, sizeof(kbuffer));
 		if (copy_from_user(&kbuffer, buf, nwritten)) {
 			ret = -EFAULT;
 			break;
 		}
 
+		ret2 = bt_bmc_remove_request(bt_bmc, kbuffer[2]);
+		if (ret2) {
+			ret = ret2;
+			break;
+		}
+
 		bt_writen(bt_bmc, kbuffer, nwritten);
 
 		count -= nwritten;
@@ -438,6 +556,8 @@ static int bt_bmc_probe(struct platform_device *pdev)
 
 	mutex_init(&bt_bmc->mutex);
 	init_waitqueue_head(&bt_bmc->queue);
+	INIT_LIST_HEAD(&bt_bmc->requests);
+	spin_lock_init(&bt_bmc->requests_lock);
 
 	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR,
 		bt_bmc->miscdev.name	= DEVICE_NAME,
@@ -451,6 +571,8 @@ static int bt_bmc_probe(struct platform_device *pdev)
 
 	bt_bmc_config_irq(bt_bmc, pdev);
 
+	bt_bmc->response_time = BT_BMC_RESPONSE_TIME;
+
 	if (bt_bmc->irq) {
 		dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
 	} else {
@@ -468,6 +590,9 @@ static int bt_bmc_probe(struct platform_device *pdev)
 		  BT_CR0_ENABLE_IBT,
 		  bt_bmc->base + BT_CR0);
 
+	setup_timer(&bt_bmc->requests_timer, requests_timer,
+		    (unsigned long)bt_bmc);
+
 	clr_b_busy(bt_bmc);
 
 	return 0;
@@ -476,10 +601,17 @@ static int bt_bmc_probe(struct platform_device *pdev)
 static int bt_bmc_remove(struct platform_device *pdev)
 {
 	struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
+	struct ipmi_request *req, *next;
 
 	misc_deregister(&bt_bmc->miscdev);
 	if (!bt_bmc->irq)
 		del_timer_sync(&bt_bmc->poll_timer);
+
+	del_timer_sync(&bt_bmc->requests_timer);
+	list_for_each_entry_safe(req, next, &bt_bmc->requests, list) {
+		list_del(&req->list);
+		kfree(req);
+	}
 	return 0;
 }
 
-- 
2.7.4
