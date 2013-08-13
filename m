From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 13 Aug 2013 18:19:36 +0900
Subject: [PATCH 2/2] [RFC PATCH v2] dma-buf: Add user interfaces for dmabuf
 sync support.
In-Reply-To: <1376385576-9039-1-git-send-email-inki.dae@samsung.com>
References: <1376385576-9039-1-git-send-email-inki.dae@samsung.com>
Message-ID: <1376385576-9039-3-git-send-email-inki.dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds lock and poll callbacks to dma buf file operations,
and these callbacks will be called by fcntl and select system calls.

fcntl and select system calls can be used to wait for the completion
of DMA or CPU access to a shared dmabuf. The difference of them is
fcntl system call takes a lock after the completion but select system
call doesn't. So in case of fcntl system call, it's useful when a task
wants to access a shared dmabuf without any broken. On the other hand,
it's useful when a task wants to just wait for the completion.

Changelog v2:
- Add select system call support.
  . The purpose of this feature is to wait for the completion of DMA or
    CPU access to a dmabuf without that caller locks the dmabuf again
    after the completion.
    That is useful when caller wants to be aware of the completion of
    DMA access to the dmabuf, and the caller doesn't use intefaces for
    the DMA device driver.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/base/dma-buf.c      |   81 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmabuf-sync.h |    1 +
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/base/dma-buf.c b/drivers/base/dma-buf.c
index 4aca57a..f16a396 100644
--- a/drivers/base/dma-buf.c
+++ b/drivers/base/dma-buf.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/poll.h>
 #include <linux/dmabuf-sync.h>
 
 static inline int is_dma_buf_file(struct file *);
@@ -80,9 +81,89 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 
+static unsigned int dma_buf_poll(struct file *filp,
+					struct poll_table_struct *poll)
+{
+	struct dma_buf *dmabuf;
+	struct dmabuf_sync_reservation *robj;
+	int ret = 0;
+
+	if (!is_dma_buf_file(filp))
+		return POLLERR;
+
+	dmabuf = filp->private_data;
+	if (!dmabuf || !dmabuf->sync)
+		return POLLERR;
+
+	robj = dmabuf->sync;
+
+	mutex_lock(&robj->lock);
+
+	robj->polled = true;
+
+	/*
+	 * CPU or DMA access to this buffer has been completed, and
+	 * the blocked task has been waked up. Return poll event
+	 * so that the task can get out of select().
+	 */
+	if (robj->poll_event) {
+		robj->poll_event = false;
+		mutex_unlock(&robj->lock);
+		return POLLIN | POLLOUT;
+	}
+
+	/*
+	 * There is no anyone accessing this buffer so just return.
+	 */
+	if (!robj->locked) {
+		mutex_unlock(&robj->lock);
+		return POLLIN | POLLOUT;
+	}
+
+	poll_wait(filp, &robj->poll_wait, poll);
+
+	mutex_unlock(&robj->lock);
+
+	return ret;
+}
+
+static int dma_buf_lock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct dma_buf *dmabuf;
+	unsigned int type;
+	bool wait = false;
+
+	if (!is_dma_buf_file(file))
+		return -EINVAL;
+
+	dmabuf = file->private_data;
+
+	if ((fl->fl_type & F_UNLCK) == F_UNLCK) {
+		dmabuf_sync_single_unlock(dmabuf);
+		return 0;
+	}
+
+	/* convert flock type to dmabuf sync type. */
+	if ((fl->fl_type & F_WRLCK) == F_WRLCK)
+		type = DMA_BUF_ACCESS_W;
+	else if ((fl->fl_type & F_RDLCK) == F_RDLCK)
+		type = DMA_BUF_ACCESS_R;
+	else
+		return -EINVAL;
+
+	if (fl->fl_flags & FL_SLEEP)
+		wait = true;
+
+	/* TODO. the locking to certain region should also be considered. */
+
+	return dmabuf_sync_single_lock(dmabuf, type, wait);
+}
+
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_release,
 	.mmap		= dma_buf_mmap_internal,
+	.poll		= dma_buf_poll,
+	.lock		= dma_buf_lock,
 };
 
 /*
diff --git a/include/linux/dmabuf-sync.h b/include/linux/dmabuf-sync.h
index 9a3afc4..0316f68 100644
--- a/include/linux/dmabuf-sync.h
+++ b/include/linux/dmabuf-sync.h
@@ -11,6 +11,7 @@
  */
 
 #include <linux/mutex.h>
+#include <linux/ww_mutex.h>
 #include <linux/sched.h>
 #include <linux/dma-buf.h>
 
-- 
1.7.5.4
