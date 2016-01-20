From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jan 2016 11:31:49 +0100
Subject: [PATCH] xen: allocate gntdev_copy_batch dynamically
Message-ID: <4664421.nvl14CijWp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct gntdev_copy_batch is arguably too large to fit on the kernel stack,
and we get a warning about the stack usage in gntdev_ioctl_grant_copy:

drivers/xen/gntdev.c:949:1: error: the frame size of 1240 bytes is larger than 1024 bytes

This changes the code to us a dynamic allocation instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a4cdb556cae0 ("xen/gntdev: add ioctl for grant copy")
---
This is a regression against v4.4, found with ARM randconfig testing.

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index dc495383ad73..cc753b3a7154 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -915,15 +915,16 @@ static int gntdev_grant_copy_seg(struct gntdev_copy_batch *batch,
 static long gntdev_ioctl_grant_copy(struct gntdev_priv *priv, void __user *u)
 {
 	struct ioctl_gntdev_grant_copy copy;
-	struct gntdev_copy_batch batch;
+	struct gntdev_copy_batch *batch;
 	unsigned int i;
 	int ret = 0;
 
 	if (copy_from_user(&copy, u, sizeof(copy)))
 		return -EFAULT;
 
-	batch.nr_ops = 0;
-	batch.nr_pages = 0;
+	batch = kzalloc(sizeof(*batch), GFP_KERNEL);
+	if (!batch)
+		return -ENOMEM;
 
 	for (i = 0; i < copy.count; i++) {
 		struct gntdev_grant_copy_segment seg;
@@ -933,18 +934,20 @@ static long gntdev_ioctl_grant_copy(struct gntdev_priv *priv, void __user *u)
 			goto out;
 		}
 
-		ret = gntdev_grant_copy_seg(&batch, &seg, &copy.segments[i].status);
+		ret = gntdev_grant_copy_seg(batch, &seg, &copy.segments[i].status);
 		if (ret < 0)
 			goto out;
 
 		cond_resched();
 	}
-	if (batch.nr_ops)
-		ret = gntdev_copy(&batch);
+	if (batch->nr_ops)
+		ret = gntdev_copy(batch);
+	kfree(batch);
 	return ret;
 
   out:
-	gntdev_put_pages(&batch);
+	gntdev_put_pages(batch);
+	kfree(batch);
 	return ret;
 }
 
