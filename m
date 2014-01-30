From: adrienverge@gmail.com (=?UTF-8?q?Adrien=20Verg=C3=A9?=)
Date: Thu, 30 Jan 2014 11:11:06 -0500
Subject: [PATCH V3 1/5] ARM CoreSight: ETM: Fix a memory allocation failure
In-Reply-To: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
References: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
Message-ID: <1391098270-8867-2-git-send-email-adrienverge@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an application reads the ETB buffer too often, it can be empty.
In this case, it results in a "vmalloc: allocation failure: 0 bytes",
a backtrace in dmesg and a vfree on an incorrect address.

This patch allocates and frees the trace buffer only when necessary.

Signed-off-by: Adrien Verg? <adrienverge@gmail.com>
---
 arch/arm/kernel/etm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 8ff0ecd..5192693 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -275,7 +275,7 @@ static ssize_t etb_read(struct file *file, char __user *data,
 	long length;
 	struct tracectx *t = file->private_data;
 	u32 first = 0;
-	u32 *buf;
+	u32 *buf = NULL;
 
 	mutex_lock(&t->mutex);
 
@@ -293,12 +293,14 @@ static ssize_t etb_read(struct file *file, char __user *data,
 	etb_writel(t, first, ETBR_READADDR);
 
 	length = min(total * 4, (int)len);
-	buf = vmalloc(length);
+	if (length != 0)
+		buf = vmalloc(length);
 
 	dev_dbg(t->dev, "ETB buffer length: %d\n", total);
 	dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ETBR_STATUS));
-	for (i = 0; i < length / 4; i++)
-		buf[i] = etb_readl(t, ETBR_READMEM);
+	if (buf)
+		for (i = 0; i < length / 4; i++)
+			buf[i] = etb_readl(t, ETBR_READMEM);
 
 	/* the only way to deassert overflow bit in ETB status is this */
 	etb_writel(t, 1, ETBR_CTRL);
@@ -311,7 +313,8 @@ static ssize_t etb_read(struct file *file, char __user *data,
 	etb_lock(t);
 
 	length -= copy_to_user(data, buf, length);
-	vfree(buf);
+	if (buf)
+		vfree(buf);
 
 out:
 	mutex_unlock(&t->mutex);
-- 
1.8.5.3
