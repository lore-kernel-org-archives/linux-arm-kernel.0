From: nikai@nikai.net (Nicolas Kaiser)
Date: Fri, 22 Oct 2010 20:30:39 +0200
Subject: [PATCH] dma/coh901318: use simple_read_from_buffer
In-Reply-To: <201010221938.12591.arnd@arndb.de>
References: <20101022192953.1f67b10a@absol.kitzblitz>
	<201010221938.12591.arnd@arndb.de>
Message-ID: <20101022203039.7b353056@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de>:
> On Friday 22 October 2010 19:29:53 Nicolas Kaiser wrote:
> > If copy_to_user fails, the assigned error code instantly gets
> > overwritten, and the failure apparently ignored. Moreover,
> > shouldn't the error code be -EFAULT instead of -EINVAL?
> 
> Looks good, but it would be even better to just use
> simple_read_from_buffer in this function, which takes care of
> a lot the other complexities as well.

Like this? (Sorry, untested.)

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
obsoletes patch "dma/coh901318: fix copy_to_user error path"

 drivers/dma/coh901318.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index ae2b871..e7d0f06 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -133,17 +133,7 @@ static int coh901318_debugfs_read(struct file *file, char __user *buf,
 	tmp += sprintf(tmp, "Pool alloc nbr %d\n", pool_count);
 	dev_size = tmp  - dev_buf;
 
-	/* No more to read if offset != 0 */
-	if (*f_pos > dev_size)
-		goto out;
-
-	if (count > dev_size - *f_pos)
-		count = dev_size - *f_pos;
-
-	if (copy_to_user(buf, dev_buf + *f_pos, count))
-		ret = -EINVAL;
-	ret = count;
-	*f_pos += count;
+	ret = simple_read_from_buffer(buf, count, f_pos, dev_buf, dev_size);
 
  out:
 	kfree(dev_buf);
-- 
1.7.2.2
