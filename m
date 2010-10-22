From: nikai@nikai.net (Nicolas Kaiser)
Date: Fri, 22 Oct 2010 19:29:53 +0200
Subject: [PATCH] dma/coh901318: fix copy_to_user error path
Message-ID: <20101022192953.1f67b10a@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If copy_to_user fails, the assigned error code instantly gets
overwritten, and the failure apparently ignored. Moreover,
shouldn't the error code be -EFAULT instead of -EINVAL?

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 drivers/dma/coh901318.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index ae2b871..eac8867 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -140,8 +140,10 @@ static int coh901318_debugfs_read(struct file *file, char __user *buf,
 	if (count > dev_size - *f_pos)
 		count = dev_size - *f_pos;
 
-	if (copy_to_user(buf, dev_buf + *f_pos, count))
-		ret = -EINVAL;
+	if (copy_to_user(buf, dev_buf + *f_pos, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
 	ret = count;
 	*f_pos += count;
 
-- 
1.7.2.2
