From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Fri, 17 Apr 2015 09:50:56 +0200
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial patch for generic TEE subsystem.
This subsystem provides:
* Registration/un-registration of TEE drivers.
* Shared memory between normal world and secure world.
* Ioctl interface for interaction with user space.

A TEE (Trusted Execution Environment) driver is a driver that interfaces
with a trusted OS running in some secure environment, for example,
TrustZone on ARM cpus, or a separate secure co-processor etc.

To avoid putting unnecessary restrictions on the TEE driver and the
trusted OS the TEE_IOC_CMD passes an opaque buffer to the TEE driver to
facilitate a communication channel between user space and the trusted
OS.

The TEE subsystem can serve a TEE driver for a Global Platform compliant
TEE, but it's not limited to only Global Platform TEEs.

This patch builds on other similar implementations trying to solve
the same problem:
* "optee_linuxdriver" by among others
  Jean-michel DELORME<jean-michel.delorme@st.com> and
  Emmanuel MICHEL <emmanuel.michel@st.com>
* "Generic TrustZone Driver" by Javier Gonz?lez <javier@javigon.com>

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 Documentation/ioctl/ioctl-number.txt |   1 +
 drivers/Kconfig                      |   2 +
 drivers/Makefile                     |   1 +
 drivers/tee/Kconfig                  |   8 +
 drivers/tee/Makefile                 |   3 +
 drivers/tee/tee.c                    | 253 +++++++++++++++++++++++++++
 drivers/tee/tee_private.h            |  64 +++++++
 drivers/tee/tee_shm.c                | 330 +++++++++++++++++++++++++++++++++++
 drivers/tee/tee_shm_pool.c           | 246 ++++++++++++++++++++++++++
 include/linux/tee/tee.h              | 180 +++++++++++++++++++
 include/linux/tee/tee_drv.h          | 271 ++++++++++++++++++++++++++++
 11 files changed, 1359 insertions(+)
 create mode 100644 drivers/tee/Kconfig
 create mode 100644 drivers/tee/Makefile
 create mode 100644 drivers/tee/tee.c
 create mode 100644 drivers/tee/tee_private.h
 create mode 100644 drivers/tee/tee_shm.c
 create mode 100644 drivers/tee/tee_shm_pool.c
 create mode 100644 include/linux/tee/tee.h
 create mode 100644 include/linux/tee/tee_drv.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 8136e1f..6e9bd04 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -301,6 +301,7 @@ Code  Seq#(hex)	Include File		Comments
 0xA3	80-8F	Port ACL		in development:
 					<mailto:tlewis@mindspring.com>
 0xA3	90-9F	linux/dtlk.h
+0xA4	00-1F	linux/sec-hw/tee.h	Generic TEE subsystem
 0xAB	00-1F	linux/nbd.h
 0xAC	00-1F	linux/raw.h
 0xAD	00	Netfilter device	in development:
diff --git a/drivers/Kconfig b/drivers/Kconfig
index c0cc96b..7510f69 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -182,4 +182,6 @@ source "drivers/thunderbolt/Kconfig"
 
 source "drivers/android/Kconfig"
 
+source "drivers/tee/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 527a6da..0d24e70 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -165,3 +165,4 @@ obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= coresight/
 obj-$(CONFIG_ANDROID)		+= android/
+obj-$(CONFIG_TEE)		+= tee/
diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
new file mode 100644
index 0000000..64a8cd7
--- /dev/null
+++ b/drivers/tee/Kconfig
@@ -0,0 +1,8 @@
+# Generic Trusted Execution Environment Configuration
+config TEE
+	bool "Trusted Execution Environment support"
+	default n
+	select DMA_SHARED_BUFFER
+	help
+	  This implements a generic interface towards a Trusted Execution
+	  Environment (TEE).
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
new file mode 100644
index 0000000..60d2dab
--- /dev/null
+++ b/drivers/tee/Makefile
@@ -0,0 +1,3 @@
+obj-y += tee.o
+obj-y += tee_shm.o
+obj-y += tee_shm_pool.o
diff --git a/drivers/tee/tee.c b/drivers/tee/tee.c
new file mode 100644
index 0000000..23a6e75
--- /dev/null
+++ b/drivers/tee/tee.c
@@ -0,0 +1,253 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/tee/tee_drv.h>
+#include "tee_private.h"
+
+static int tee_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+	struct tee_device *teedev;
+	struct tee_context *ctx;
+
+	teedev = container_of(filp->private_data, struct tee_device, miscdev);
+	if (!try_module_get(teedev->desc->owner))
+		return -EINVAL;
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->teedev = teedev;
+	filp->private_data = ctx;
+	ret = teedev->desc->ops->open(ctx);
+	if (ret) {
+		kfree(ctx);
+		module_put(teedev->desc->owner);
+	}
+	return ret;
+}
+
+static int tee_release(struct inode *inode, struct file *filp)
+{
+	struct tee_context *ctx = filp->private_data;
+	struct tee_device *teedev = ctx->teedev;
+
+	ctx->teedev->desc->ops->release(ctx);
+	kfree(ctx);
+	module_put(teedev->desc->owner);
+	return 0;
+}
+
+static long tee_ioctl_version(struct tee_context *ctx,
+		struct tee_ioctl_version __user *uvers)
+{
+	struct tee_ioctl_version vers;
+
+	memset(&vers, 0, sizeof(vers));
+	vers.gen_version = TEE_SUBSYS_VERSION;
+	ctx->teedev->desc->ops->get_version(ctx, &vers.spec_version,
+					    vers.uuid);
+
+	return copy_to_user(uvers, &vers, sizeof(vers));
+}
+
+static long tee_ioctl_cmd(struct tee_context *ctx,
+		struct tee_ioctl_cmd_data __user *ucmd)
+{
+	long ret;
+	struct tee_ioctl_cmd_data cmd;
+	void __user *buf_ptr;
+
+	ret = copy_from_user(&cmd, ucmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	buf_ptr = (void __user *)(uintptr_t)cmd.buf_ptr;
+	return ctx->teedev->desc->ops->cmd(ctx, buf_ptr, cmd.buf_len);
+}
+
+static long tee_ioctl_shm_alloc(struct tee_context *ctx,
+		struct tee_ioctl_shm_alloc_data __user *udata)
+{
+	long ret;
+	struct tee_ioctl_shm_alloc_data data;
+	struct tee_shm *shm;
+
+	if (copy_from_user(&data, udata, sizeof(data)))
+		return -EFAULT;
+
+	/* Currently no input flags are supported */
+	if (data.flags)
+		return -EINVAL;
+
+	data.fd = -1;
+
+	shm = tee_shm_alloc(ctx->teedev, data.size,
+			    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	if (IS_ERR(shm))
+		return PTR_ERR(shm);
+
+	ret = ctx->teedev->desc->ops->shm_share(shm);
+	if (ret)
+		goto err;
+
+	data.flags = shm->flags;
+	data.size = shm->size;
+	data.fd = tee_shm_get_fd(shm);
+	if (data.fd < 0) {
+		ret = data.fd;
+		goto err;
+	}
+
+	if (copy_to_user(udata, &data, sizeof(data))) {
+		ret = -EFAULT;
+		goto err;
+	}
+	/*
+	 * When user space closes the file descriptor the shared memory
+	 * should be freed
+	 */
+	tee_shm_put(shm);
+	return 0;
+err:
+	if (data.fd >= 0)
+		tee_shm_put_fd(data.fd);
+	tee_shm_free(shm);
+	return ret;
+}
+
+static long tee_ioctl_mem_share(struct tee_context *ctx,
+		struct tee_ioctl_mem_share_data __user *udata)
+{
+	/* Not supported yet */
+	return -ENOSYS;
+}
+
+static long tee_ioctl_mem_unshare(struct tee_context *ctx,
+		struct tee_ioctl_mem_share_data __user *udata)
+{
+	/* Not supported yet */
+	return -ENOSYS;
+}
+
+static long tee_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct tee_context *ctx = filp->private_data;
+	void __user *uarg = (void __user *)arg;
+
+	switch (cmd) {
+	case TEE_IOC_VERSION:
+		return tee_ioctl_version(ctx, uarg);
+	case TEE_IOC_CMD:
+		return tee_ioctl_cmd(ctx, uarg);
+	case TEE_IOC_SHM_ALLOC:
+		return tee_ioctl_shm_alloc(ctx, uarg);
+	case TEE_IOC_MEM_SHARE:
+		return tee_ioctl_mem_share(ctx, uarg);
+	case TEE_IOC_MEM_UNSHARE:
+		return tee_ioctl_mem_unshare(ctx, uarg);
+	default:
+		return -EINVAL;
+	}
+}
+
+
+static const struct file_operations tee_fops = {
+	.owner = THIS_MODULE,
+	.open = tee_open,
+	.release = tee_release,
+	.unlocked_ioctl = tee_ioctl
+};
+
+struct tee_device *tee_register(const struct tee_desc *teedesc,
+			struct device *dev, struct tee_shm_pool *pool,
+			void *driver_data)
+{
+	static atomic_t device_no = ATOMIC_INIT(-1);
+	static atomic_t priv_device_no = ATOMIC_INIT(-1);
+	struct tee_device *teedev;
+	void *ret;
+	int rc;
+
+	if (!teedesc || !teedesc->name || !dev || !pool) {
+		ret = ERR_PTR(-EINVAL);
+		goto err;
+	}
+
+	teedev = devm_kzalloc(dev, sizeof(*teedev), GFP_KERNEL);
+	if (!teedev) {
+		ret = ERR_PTR(-ENOMEM);
+		goto err;
+	}
+
+	teedev->dev = dev;
+	teedev->desc = teedesc;
+	teedev->pool = pool;
+	teedev->driver_data = driver_data;
+
+	if (teedesc->flags & TEE_DESC_PRIVILEGED)
+		snprintf(teedev->name, sizeof(teedev->name),
+			 "teepriv%d", atomic_inc_return(&priv_device_no));
+	else
+		snprintf(teedev->name, sizeof(teedev->name),
+			 "tee%d", atomic_inc_return(&device_no));
+
+	teedev->miscdev.parent = dev;
+	teedev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	teedev->miscdev.name = teedev->name;
+	teedev->miscdev.fops = &tee_fops;
+
+	rc = misc_register(&teedev->miscdev);
+	if (rc) {
+		dev_err(dev, "misc_register() failed name=\"%s\"\n",
+			teedev->name);
+		ret = ERR_PTR(rc);
+		goto err;
+	}
+
+	INIT_LIST_HEAD(&teedev->list_shm);
+
+	dev_set_drvdata(teedev->miscdev.this_device, teedev);
+
+	dev_dbg(dev, "register misc device \"%s\" (minor=%d)\n",
+		 dev_name(teedev->miscdev.this_device), teedev->miscdev.minor);
+
+	return teedev;
+err:
+	dev_err(dev, "could not register %s driver\n",
+		teedesc->flags & TEE_DESC_PRIVILEGED ? "privileged" : "client");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tee_register);
+
+void tee_unregister(struct tee_device *teedev)
+{
+	if (!teedev)
+		return;
+
+	dev_dbg(teedev->dev, "unregister misc device \"%s\" (minor=%d)\n",
+		 dev_name(teedev->miscdev.this_device), teedev->miscdev.minor);
+	misc_deregister(&teedev->miscdev);
+}
+EXPORT_SYMBOL_GPL(tee_unregister);
+
+void *tee_get_drvdata(struct tee_device *teedev)
+{
+	return teedev->driver_data;
+}
+EXPORT_SYMBOL_GPL(tee_get_drvdata);
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
new file mode 100644
index 0000000..2199634
--- /dev/null
+++ b/drivers/tee/tee_private.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef TEE_PRIVATE_H
+#define TEE_PRIVATE_H
+
+struct tee_device;
+
+struct tee_shm {
+	struct list_head list_node;
+	struct tee_device *teedev;
+	phys_addr_t paddr;
+	void *kaddr;
+	size_t size;
+	struct dma_buf *dmabuf;
+	struct page *pages;
+	u32 flags;
+};
+
+struct tee_shm_pool_mgr;
+struct tee_shm_pool_mgr_ops {
+	int (*alloc)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *shm,
+		     size_t size);
+	void (*free)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *shm);
+};
+
+struct tee_shm_pool_mgr {
+	const struct tee_shm_pool_mgr_ops *ops;
+	void *private_data;
+};
+
+struct tee_shm_pool {
+	struct tee_shm_pool_mgr private_mgr;
+	struct tee_shm_pool_mgr dma_buf_mgr;
+	void (*destroy)(struct tee_shm_pool *pool);
+	void *private_data;
+};
+
+#define TEE_MAX_DEV_NAME_LEN 32
+struct tee_device {
+	char name[TEE_MAX_DEV_NAME_LEN];
+	const struct tee_desc *desc;
+	struct device *dev;
+	struct miscdevice miscdev;
+
+	void *driver_data;
+
+	struct list_head list_shm;
+	struct tee_shm_pool *pool;
+};
+
+int tee_shm_init(void);
+
+#endif /*TEE_PRIVATE_H*/
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
new file mode 100644
index 0000000..38359ad
--- /dev/null
+++ b/drivers/tee/tee_shm.c
@@ -0,0 +1,330 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/fdtable.h>
+#include <linux/sched.h>
+#include <linux/dma-buf.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/tee/tee_drv.h>
+#include "tee_private.h"
+
+/* Mutex for all shm objects and lists */
+static DEFINE_MUTEX(teeshm_mutex);
+
+static void tee_shm_release(struct tee_shm *shm);
+
+static struct sg_table *tee_shm_op_map_dma_buf(struct dma_buf_attachment
+			*attach, enum dma_data_direction dir)
+{
+	return NULL;
+}
+
+static void tee_shm_op_unmap_dma_buf(struct dma_buf_attachment *attach,
+			struct sg_table *table, enum dma_data_direction dir)
+{
+}
+
+static void tee_shm_op_release(struct dma_buf *dmabuf)
+{
+	struct tee_shm *shm = dmabuf->priv;
+
+	tee_shm_release(shm);
+}
+
+static void *tee_shm_op_kmap_atomic(struct dma_buf *dmabuf,
+			unsigned long pgnum)
+{
+	return NULL;
+}
+
+static void *tee_shm_op_kmap(struct dma_buf *dmabuf, unsigned long pgnum)
+{
+	return NULL;
+}
+
+static int tee_shm_op_mmap(struct dma_buf *dmabuf,
+			struct vm_area_struct *vma)
+{
+	struct tee_shm *shm = dmabuf->priv;
+	size_t size = vma->vm_end - vma->vm_start;
+
+	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
+			       size, vma->vm_page_prot);
+}
+
+static struct dma_buf_ops tee_shm_dma_buf_ops = {
+	.map_dma_buf = tee_shm_op_map_dma_buf,
+	.unmap_dma_buf = tee_shm_op_unmap_dma_buf,
+	.release = tee_shm_op_release,
+	.kmap_atomic = tee_shm_op_kmap_atomic,
+	.kmap = tee_shm_op_kmap,
+	.mmap = tee_shm_op_mmap,
+};
+
+struct tee_shm *tee_shm_alloc(struct tee_device *teedev, size_t size,
+			u32 flags)
+{
+	struct tee_shm_pool_mgr *poolm = NULL;
+	struct tee_shm *shm;
+	void *ret;
+	int rc;
+
+	if (!(flags & TEE_SHM_MAPPED)) {
+		dev_err(teedev->dev, "only mapped allocations supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if ((flags & ~(TEE_SHM_MAPPED|TEE_SHM_DMA_BUF))) {
+		dev_err(teedev->dev, "invalid shm flags 0x%x", flags);
+		return ERR_PTR(-EINVAL);
+	}
+
+	shm = kzalloc(sizeof(struct tee_shm), GFP_KERNEL);
+	if (!shm)
+		return ERR_PTR(-ENOMEM);
+
+	if (!try_module_get(teedev->desc->owner)) {
+		ret = ERR_PTR(-EINVAL);
+		goto err;
+	}
+
+	shm->flags = flags;
+	shm->teedev = teedev;
+	if (flags & TEE_SHM_DMA_BUF)
+		poolm = &teedev->pool->dma_buf_mgr;
+	else
+		poolm = &teedev->pool->private_mgr;
+
+	rc = poolm->ops->alloc(poolm, shm, size);
+	if (rc) {
+		ret = ERR_PTR(rc);
+		goto err;
+	}
+
+	mutex_lock(&teeshm_mutex);
+	list_add_tail(&shm->list_node, &teedev->list_shm);
+	mutex_unlock(&teeshm_mutex);
+
+	if (flags & TEE_SHM_DMA_BUF) {
+		shm->dmabuf = dma_buf_export(shm, &tee_shm_dma_buf_ops,
+					     shm->size, O_RDWR, NULL);
+		if (IS_ERR(shm->dmabuf)) {
+			ret = ERR_CAST(shm->dmabuf);
+			goto err;
+		}
+
+		/*
+		 * Only call share on dma_buf shm:s, as the driver private
+		 * shm:s always originates from the driver itself.
+		 */
+		rc = teedev->desc->ops->shm_share(shm);
+		if (rc) {
+			dma_buf_put(shm->dmabuf);
+			return ERR_PTR(rc);
+		}
+		shm->flags |= __TEE_SHM_SHARED;
+	}
+
+	return shm;
+err:
+	if (poolm && shm->kaddr)
+		poolm->ops->free(poolm, shm);
+	kfree(shm);
+	module_put(teedev->desc->owner);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc);
+
+int tee_shm_get_fd(struct tee_shm *shm)
+{
+	u32 req_flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF;
+	int fd;
+
+	if ((shm->flags & req_flags) != req_flags)
+		return -EINVAL;
+
+	fd = dma_buf_fd(shm->dmabuf, O_CLOEXEC);
+	if (fd >= 0)
+		get_dma_buf(shm->dmabuf);
+	return fd;
+}
+EXPORT_SYMBOL_GPL(tee_shm_get_fd);
+
+int tee_shm_put_fd(int fd)
+{
+	return __close_fd(current->files, fd);
+}
+EXPORT_SYMBOL_GPL(tee_shm_put_fd);
+
+
+static void tee_shm_release(struct tee_shm *shm)
+{
+	struct tee_device *teedev = shm->teedev;
+	struct tee_shm_pool_mgr *poolm;
+
+	mutex_lock(&teeshm_mutex);
+	list_del(&shm->list_node);
+	mutex_unlock(&teeshm_mutex);
+
+	if (shm->flags & TEE_SHM_DMA_BUF)
+		poolm = &teedev->pool->dma_buf_mgr;
+	else
+		poolm = &teedev->pool->private_mgr;
+
+	if (shm->flags & __TEE_SHM_SHARED)
+		teedev->desc->ops->shm_unshare(shm);
+	poolm->ops->free(poolm, shm);
+	kfree(shm);
+
+	module_put(teedev->desc->owner);
+}
+
+void tee_shm_free(struct tee_shm *shm)
+{
+
+	/*
+	 * dma_buf_put() decreases the dmabuf reference counter and will
+	 * call tee_shm_release() when the last reference is gone.
+	 *
+	 * In the case of anonymous memory we call tee_shm_release directly
+	 * instead at it doesn't have a reference counter.
+	 */
+	if (shm->flags & TEE_SHM_DMA_BUF)
+		dma_buf_put(shm->dmabuf);
+	else
+		tee_shm_release(shm);
+}
+EXPORT_SYMBOL_GPL(tee_shm_free);
+
+static bool cmp_key_va(struct tee_shm *shm, uintptr_t va)
+{
+	uintptr_t shm_va = (uintptr_t)shm->kaddr;
+
+	return (va >= shm_va) && (va < (shm_va + shm->size));
+}
+
+static bool cmp_key_pa(struct tee_shm *shm, uintptr_t pa)
+{
+	return (pa >= shm->paddr) && (pa < (shm->paddr + shm->size));
+}
+
+static struct tee_shm *tee_shm_find_by_key(struct tee_device *teedev, u32 flags,
+			bool (*cmp)(struct tee_shm *shm, uintptr_t key),
+			uintptr_t key)
+{
+	struct tee_shm *ret = NULL;
+	struct tee_shm *shm;
+
+	mutex_lock(&teeshm_mutex);
+	list_for_each_entry(shm, &teedev->list_shm, list_node) {
+		if (cmp(shm, key)) {
+			ret = shm;
+			break;
+		}
+	}
+	mutex_unlock(&teeshm_mutex);
+
+	return ret;
+}
+
+struct tee_shm *tee_shm_find_by_va(struct tee_device *teedev, u32 flags,
+			void *va)
+{
+	return tee_shm_find_by_key(teedev, flags, cmp_key_va, (uintptr_t)va);
+}
+EXPORT_SYMBOL_GPL(tee_shm_find_by_va);
+
+struct tee_shm *tee_shm_find_by_pa(struct tee_device *teedev, u32 flags,
+			phys_addr_t pa)
+{
+	return tee_shm_find_by_key(teedev, flags, cmp_key_pa, pa);
+}
+EXPORT_SYMBOL_GPL(tee_shm_find_by_pa);
+
+int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
+{
+	/* Check that we're in the range of the shm */
+	if ((char *)va < (char *)shm->kaddr)
+		return -EINVAL;
+	if ((char *)va >= ((char *)shm->kaddr + shm->size))
+		return -EINVAL;
+
+	return tee_shm_get_pa(shm, (u_long)va - (u_long)shm->kaddr, pa);
+}
+EXPORT_SYMBOL_GPL(tee_shm_va2pa);
+
+int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
+{
+	/* Check that we're in the range of the shm */
+	if (pa < shm->paddr)
+		return -EINVAL;
+	if (pa >= (shm->paddr + shm->size))
+		return -EINVAL;
+
+	if (va) {
+		void *v = tee_shm_get_va(shm, pa - shm->paddr);
+
+		if (IS_ERR(v))
+			return PTR_ERR(v);
+		*va = v;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tee_shm_pa2va);
+
+void *tee_shm_get_va(struct tee_shm *shm, size_t offs)
+{
+	if (offs >= shm->size)
+		return ERR_PTR(-EINVAL);
+	return (char *)shm->kaddr + offs;
+}
+EXPORT_SYMBOL_GPL(tee_shm_get_va);
+
+int tee_shm_get_pa(struct tee_shm *shm, size_t offs, phys_addr_t *pa)
+{
+	if (offs >= shm->size)
+		return -EINVAL;
+	if (pa)
+		*pa = shm->paddr + offs;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tee_shm_get_pa);
+
+static bool is_shm_dma_buf(struct dma_buf *dmabuf)
+{
+	return dmabuf->ops == &tee_shm_dma_buf_ops;
+}
+
+struct tee_shm *tee_shm_get_from_fd(int fd)
+{
+	struct dma_buf *dmabuf = dma_buf_get(fd);
+
+	if (IS_ERR(dmabuf))
+		return ERR_CAST(dmabuf);
+
+	if (!is_shm_dma_buf(dmabuf)) {
+		dma_buf_put(dmabuf);
+		return ERR_PTR(-EINVAL);
+	}
+	return dmabuf->priv;
+}
+EXPORT_SYMBOL_GPL(tee_shm_get_from_fd);
+
+void tee_shm_put(struct tee_shm *shm)
+{
+	if (shm->flags & TEE_SHM_DMA_BUF)
+		dma_buf_put(shm->dmabuf);
+}
+EXPORT_SYMBOL_GPL(tee_shm_put);
diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
new file mode 100644
index 0000000..c1d2092
--- /dev/null
+++ b/drivers/tee/tee_shm_pool.c
@@ -0,0 +1,246 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/slab.h>
+#include <linux/genalloc.h>
+#ifdef CONFIG_CMA
+#include <linux/cma.h>
+#include <linux/dma-contiguous.h>
+#endif
+#include <linux/tee/tee_drv.h>
+#include "tee_private.h"
+
+#define SHM_POOL_NUM_PRIV_PAGES 1
+
+static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
+			struct tee_shm *shm, size_t size)
+{
+	unsigned long va;
+	struct gen_pool *genpool = poolm->private_data;
+	size_t s = roundup(size, 1 << genpool->min_alloc_order);
+
+	va = gen_pool_alloc(genpool, s);
+	if (!va)
+		return -ENOMEM;
+	shm->kaddr = (void *)va;
+	shm->paddr = gen_pool_virt_to_phys(genpool, va);
+	shm->size = s;
+	return 0;
+}
+
+static void pool_op_gen_free(struct tee_shm_pool_mgr *poolm,
+			struct tee_shm *shm)
+{
+	gen_pool_free(poolm->private_data, (unsigned long)shm->kaddr,
+		      shm->size);
+	shm->kaddr = NULL;
+}
+
+static const struct tee_shm_pool_mgr_ops pool_ops_generic = {
+	.alloc = pool_op_gen_alloc,
+	.free = pool_op_gen_free,
+};
+
+#ifdef CONFIG_CMA
+static int pool_op_cma_alloc(struct tee_shm_pool_mgr *poolm,
+			struct tee_shm *shm, size_t size)
+{
+	unsigned long order = get_order(PAGE_SIZE);
+	size_t count;
+	struct page *pages;
+
+	/*
+	 * It's not valid to call this function with size = 0, but if size
+	 * is 0 we'll get a very large number and the allocation will fail.
+	 */
+	count = ((size - 1) >> PAGE_SHIFT) + 1;
+	pages = cma_alloc(poolm->private_data, count, order);
+	if (!pages)
+		return -ENOMEM;
+	shm->kaddr = page_address(pages);
+	shm->pages = pages;
+	shm->paddr = virt_to_phys(shm->kaddr);
+	shm->size = count << PAGE_SHIFT;
+	return 0;
+}
+
+static void pool_op_cma_free(struct tee_shm_pool_mgr *poolm,
+			struct tee_shm *shm)
+{
+	size_t count;
+
+	count = shm->size >> PAGE_SHIFT;
+	cma_release(poolm->private_data, shm->pages, count);
+	shm->kaddr = NULL;
+}
+
+static const struct tee_shm_pool_mgr_ops pool_ops_cma = {
+	.alloc = pool_op_cma_alloc,
+	.free = pool_op_cma_free,
+};
+
+static void pool_cma_destroy(struct tee_shm_pool *pool)
+{
+	gen_pool_destroy(pool->private_mgr.private_data);
+	cma_release(pool->dma_buf_mgr.private_data, pool->private_data,
+		    SHM_POOL_NUM_PRIV_PAGES);
+}
+
+struct tee_shm_pool *tee_shm_pool_alloc_cma(struct device *dev, u_long *vaddr,
+			phys_addr_t *paddr, size_t *size)
+{
+	struct cma *cma = dev_get_cma_area(dev);
+	struct tee_shm_pool *pool;
+	struct page *page = NULL;
+	size_t order = get_order(PAGE_SIZE);
+	struct gen_pool *genpool = NULL;
+	void *va;
+	int ret;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	page = cma_alloc(cma, SHM_POOL_NUM_PRIV_PAGES, order);
+	if (!page) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	genpool = gen_pool_create(get_order(8), -1);
+	if (!genpool) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	gen_pool_set_algo(genpool, gen_pool_best_fit, NULL);
+
+	va = page_address(page);
+	ret = gen_pool_add_virt(genpool, (u_long)va, virt_to_phys(va),
+				SHM_POOL_NUM_PRIV_PAGES * PAGE_SIZE, -1);
+	if (ret)
+		goto err;
+
+	pool->private_data = page;
+	pool->private_mgr.private_data = genpool;
+	pool->private_mgr.ops = &pool_ops_generic;
+	pool->dma_buf_mgr.private_data = cma;
+	pool->dma_buf_mgr.ops = &pool_ops_cma;
+	pool->destroy = pool_cma_destroy;
+
+	*paddr = cma_get_base(cma);
+	*vaddr = (u_long)phys_to_virt(*paddr);
+	*size = cma_get_size(cma);
+	return pool;
+err:
+	dev_err(dev, "can't allocate memory for CMA shared memory pool\n");
+	if (genpool)
+		gen_pool_destroy(genpool);
+	if (page)
+		cma_release(cma, page, SHM_POOL_NUM_PRIV_PAGES);
+	kfree(pool);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_cma);
+#endif
+
+static void pool_res_mem_destroy(struct tee_shm_pool *pool)
+{
+	gen_pool_destroy(pool->private_mgr.private_data);
+	gen_pool_destroy(pool->dma_buf_mgr.private_data);
+}
+
+struct tee_shm_pool *tee_shm_pool_alloc_res_mem(struct device *dev,
+			u_long vaddr, phys_addr_t paddr, size_t size)
+{
+	size_t page_mask = PAGE_SIZE - 1;
+	size_t priv_size = PAGE_SIZE * SHM_POOL_NUM_PRIV_PAGES;
+	struct tee_shm_pool *pool = NULL;
+	struct gen_pool *genpool = NULL;
+	int ret;
+
+	/*
+	 * Start and end must be page aligned
+	 */
+	if ((vaddr & page_mask) || (paddr & page_mask) || (size & page_mask)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * Wouldn't make sense to have less than twice the number of
+	 * private pages, in practice the size has to be much larger, but
+	 * this is the absolute minimum.
+	 */
+	if (size < priv_size * 2) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * Create the pool for driver private shared memory
+	 */
+	genpool = gen_pool_create(3 /* 8 byte aligned */, -1);
+	if (!genpool) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	gen_pool_set_algo(genpool, gen_pool_best_fit, NULL);
+	ret = gen_pool_add_virt(genpool, vaddr, paddr, priv_size, -1);
+	if (ret)
+		goto err;
+	pool->private_mgr.private_data = genpool;
+	pool->private_mgr.ops = &pool_ops_generic;
+
+	/*
+	 * Create the pool for dma_buf shared memory
+	 */
+	genpool = gen_pool_create(PAGE_SHIFT, -1);
+	gen_pool_set_algo(genpool, gen_pool_best_fit, NULL);
+	if (!genpool) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	ret = gen_pool_add_virt(genpool, vaddr + priv_size, paddr + priv_size,
+				size - priv_size, -1);
+	if (ret)
+		goto err;
+	pool->dma_buf_mgr.private_data = genpool;
+	pool->dma_buf_mgr.ops = &pool_ops_generic;
+	pool->destroy = pool_res_mem_destroy;
+	return pool;
+err:
+	dev_err(dev, "can't allocate memory for res_mem shared memory pool\n");
+	if (pool && pool->private_mgr.private_data)
+		gen_pool_destroy(pool->private_mgr.private_data);
+	if (genpool)
+		gen_pool_destroy(genpool);
+	kfree(pool);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
+
+void tee_shm_pool_free(struct tee_shm_pool *pool)
+{
+	pool->destroy(pool);
+	kfree(pool);
+}
+EXPORT_SYMBOL_GPL(tee_shm_pool_free);
diff --git a/include/linux/tee/tee.h b/include/linux/tee/tee.h
new file mode 100644
index 0000000..f1af46b
--- /dev/null
+++ b/include/linux/tee/tee.h
@@ -0,0 +1,180 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __TEE_H
+#define __TEE_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * This file describes the API provided by the generic TEE driver to user
+ * space
+ */
+
+
+/* Helpers to make the ioctl defines */
+#define TEE_IOC_MAGIC	0xa4
+#define TEE_IOC_BASE	0
+#define _TEE_IOR(nr, size)	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
+#define _TEE_IOWR(nr, size)	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
+#define _TEE_IOW(nr, size)	_IOW(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
+
+/*
+ * Version of the generic TEE subsystem, if it doesn't match what's
+ * returned by TEE_IOC_VERSION this header is not in sync with the kernel.
+ */
+#define TEE_SUBSYS_VERSION	1
+
+
+/* Flags relating to shared memory */
+#define TEE_IOCTL_SHM_MAPPED	0x1	/* memory mapped in normal world */
+#define TEE_IOCTL_SHM_DMA_BUF	0x2	/* dma-buf handle on shared memory */
+
+/**
+ * struct tee_version - TEE versions
+ * @gen_version:	[out] Generic TEE driver version
+ * @spec_version:	[out] Specific TEE driver version
+ * @uuid:		[out] Specific TEE driver uuid, zero if not used
+ *
+ * Identifies the generic TEE driver, and the specific TEE driver.
+ * Used as argument for TEE_IOC_VERSION below.
+ */
+struct tee_ioctl_version {
+	uint32_t gen_version;
+	uint32_t spec_version;
+	uint8_t uuid[16];
+};
+/**
+ * TEE_IOC_VERSION - query version of drivers
+ *
+ * Takes a tee_version struct and returns with the version numbers filled in.
+ */
+#define TEE_IOC_VERSION		_TEE_IOR(0, struct tee_ioctl_version)
+
+/**
+ * struct tee_cmd_data - Opaque command argument
+ * @buf_ptr:	[in] A __user pointer to a command buffer
+ * @buf_len:	[in] Length of the buffer above
+ *
+ * Opaque command data which is passed on to the specific driver. The command
+ * buffer doesn't have to reside in shared memory.
+ * Used as argument for TEE_IOC_CMD below.
+ */
+struct tee_ioctl_cmd_data {
+	uint64_t buf_ptr;
+	uint64_t buf_len;
+};
+/**
+ * TEE_IOC_CMD - pass a command to the specific TEE driver
+ *
+ * Takes tee_cmd_data struct which is passed to the specific TEE driver.
+ */
+#define TEE_IOC_CMD		_TEE_IOR(1, struct tee_ioctl_cmd_data)
+
+/**
+ * struct tee_shm_alloc_data - Shared memory allocate argument
+ * @size:	[in/out] Size of shared memory to allocate
+ * @flags:	[in/out] Flags to/from allocation.
+ * @fd:		[out] dma_buf file descriptor of the shared memory
+ *
+ * The flags field should currently be zero as input. Updated by the call
+ * with actual flags as defined by TEE_IOCTL_SHM_* above.
+ * This structure is used as argument for TEE_IOC_SHM_ALLOC below.
+ */
+struct tee_ioctl_shm_alloc_data {
+	uint64_t size;
+	uint32_t flags;
+	int32_t fd;
+};
+/**
+ * TEE_IOC_SHM_ALLOC - allocate shared memory
+ *
+ * Allocates shared memory between the user space process and secure OS.
+ * The returned file descriptor is used to map the shared memory into user
+ * space. The shared memory is freed when the descriptor is closed and the
+ * memory is unmapped.
+ */
+#define TEE_IOC_SHM_ALLOC	_TEE_IOWR(2, struct tee_ioctl_shm_alloc_data)
+
+/**
+ * struct tee_mem_buf - share user space memory with Secure OS
+ * @ptr:	A __user pointer to memory to share
+ * @size:	Size of the memory to share
+ * Used in 'struct tee_mem_share_data' below.
+ */
+struct tee_ioctl_mem_buf {
+	uint64_t ptr;
+	uint64_t size;
+};
+
+/**
+ * struct tee_mem_dma_buf - share foreign dma_buf memory
+ * @fd:		dma_buf file descriptor
+ * @pad:	padding, set to zero by caller
+ * Used in 'struct tee_mem_share_data' below.
+ */
+struct tee_ioctl_mem_dma_buf {
+	int32_t fd;
+	uint32_t pad;
+};
+
+/**
+ * struct tee_mem_share_data - share memory with Secure OS
+ * @buf:	[in] share user space memory
+ * @dma_buf:	[in] share foreign dma_buf memory
+ * @flags:	[in/out] Flags to/from sharing.
+ * @pad:	[in/out] Padding, set to zero by caller
+ *
+ * The bits in @flags are defined by TEE_IOCTL_SHM_* above, undefined bits
+ * should be seto to zero as input. If TEE_IOCTL_SHM_DMA_BUF is set in the
+ * flags field use the dma_buf field, else the buf field in the union.
+ *
+ * Used as argument for TEE_IOC_MEM_SHARE and TEE_IOC_MEM_UNSHARE below.
+ */
+struct tee_ioctl_mem_share_data {
+	union {
+		struct tee_ioctl_mem_buf buf;
+		struct tee_ioctl_mem_dma_buf dma_buf;
+	};
+	uint32_t flags;
+	uint32_t pad;
+};
+
+/**
+ * TEE_IOC_MEM_SHARE - share a portion of user space memory with secure OS
+ *
+ * Shares a portion of user space memory with secure OS.
+ */
+#define TEE_IOC_MEM_SHARE	_TEE_IOWR(3, struct tee_ioctl_mem_share_data)
+
+/**
+ * TEE_IOC_MEM_UNSHARE - unshares a portion shared user space memory
+ *
+ * Unshares a portion of previously shared user space memory.
+ */
+#define TEE_IOC_MEM_UNSHARE	_TEE_IOW(4, struct tee_ioctl_mem_share_data)
+
+/*
+ * Five syscalls are used when communicating with the generic TEE driver.
+ * open(): opens the device associated with the driver
+ * ioctl(): as described above operating on the file descripto from open()
+ * close(): two cases
+ *   - closes the device file descriptor
+ *   - closes a file descriptor connected to allocated shared memory
+ * mmap(): maps shared memory into user space
+ * munmap(): unmaps previously shared memory
+ */
+
+#endif /*__TEE_H*/
diff --git a/include/linux/tee/tee_drv.h b/include/linux/tee/tee_drv.h
new file mode 100644
index 0000000..8309fb4
--- /dev/null
+++ b/include/linux/tee/tee_drv.h
@@ -0,0 +1,271 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __TEE_DRV_H
+#define __TEE_DRV_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/tee/tee.h>
+
+/*
+ * The file describes the API provided by the generic TEE driver to the
+ * specific TEE driver.
+ */
+
+#define TEE_SHM_MAPPED		0x1	/* Memory mapped by the kernel */
+#define TEE_SHM_DMA_BUF		0x2	/* Memory with dma-buf handle */
+#define __TEE_SHM_SHARED	0x4	/* Has been shared with secure world */
+
+#define TEE_UUID_SIZE		16
+
+struct tee_device;
+struct tee_shm;
+struct tee_shm_pool;
+
+/**
+ * struct tee_context - driver specific context on file pointer data
+ * @teedev:	pointer to this drivers struct tee_device
+ * @data:	driver specific context data, managed by the driver
+ */
+struct tee_context {
+	struct tee_device *teedev;
+	void *data;
+};
+
+/**
+ * struct tee_driver_ops - driver operations vtable
+ * @get_version:	returns version of driver
+ * @open:		called when the device file is opened
+ * @release:		release this open file
+ * @cmd:		process a command from user space
+ * @shm_share:		share some memory with Secure OS
+ * @shm_unshare:	unshare some memory with Secure OS
+ */
+struct tee_driver_ops {
+	void (*get_version)(struct tee_context *ctx, u32 *version, u8 *uuid);
+	int (*open)(struct tee_context *ctx);
+	void (*release)(struct tee_context *ctx);
+	int (*cmd)(struct tee_context *ctx, void __user *buf, size_t len);
+	int (*shm_share)(struct tee_shm *shm);
+	void (*shm_unshare)(struct tee_shm *shm);
+};
+
+/**
+ * struct tee_desc - Describes the TEE driver to the subsystem
+ * @name:	name of driver
+ * @ops:	driver operations vtable
+ * @owner:	module providing the driver
+ * @flags:	Extra properties of driver, defined by TEE_DESC_* below
+ */
+#define TEE_DESC_PRIVILEGED	0x1
+struct tee_desc {
+	const char *name;
+	const struct tee_driver_ops *ops;
+	struct module *owner;
+	u32 flags;
+};
+
+
+/**
+ * tee_register() - Register a specific TEE driver
+ * @teedesc:		Descriptor for this driver
+ * @dev:		Parent device for this driver
+ * @driver_data:	Private driver data for this driver
+ *
+ * Once the specific driver has been probed it registers in the generic
+ * driver with this function.
+ *
+ * @returns a pointer to a 'struct tee_device' or an ERR_PTR on failure
+ */
+struct tee_device *tee_register(const struct tee_desc *teedesc,
+			struct device *dev, struct tee_shm_pool *pool,
+			void *driver_data);
+
+/**
+ * tee_unregister() - Unregister a specific TEE driver
+ * @teedev:	Driver to unregister
+ */
+void tee_unregister(struct tee_device *teedev);
+
+/**
+ * tee_shm_pool_alloc_cma() - Create a shared memory pool based on device default CMA area
+ * @dev:	Device to get default CMA area from
+ * @vaddr:	Returned virtual address of start of CMA area
+ * @paddr:	Returned physical address of start of CMA area
+ * @size:	Returned size of CMA area
+ * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
+ */
+#ifdef CONFIG_CMA
+struct tee_shm_pool *tee_shm_pool_alloc_cma(struct device *dev, u_long *vaddr,
+			phys_addr_t *paddr, size_t *size);
+#else
+struct tee_shm_pool *tee_shm_pool_alloc_cma(struct device *dev, u_long *vaddr,
+			phys_addr_t *paddr, size_t *size)
+{
+	return ERR_PTR(-ENOENT);
+}
+#endif
+
+/**
+ * tee_shm_pool_alloc_res_mem() - Create a shared memory pool a reserved memory range
+ * @dev:	Device allocating the pool
+ * @vaddr:	Virtual address of start of pool
+ * @paddr:	Physical address of start of pool
+ * @size:	Size in bytes of the pool
+ *
+ * Start of pool will be rounded up to the nearest page, end of pool will
+ * be rounded down to the nearest page.
+ *
+ * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
+ */
+struct tee_shm_pool *tee_shm_pool_alloc_res_mem(struct device *dev,
+			u_long vaddr, phys_addr_t paddr, size_t size);
+
+/**
+ * tee_shm_pool_free() - Free a shared memory pool
+ * @pool:	The shared memory pool to free
+ *
+ * The must be no remaining shared memory allocated from this pool when
+ * this function is called.
+ */
+void tee_shm_pool_free(struct tee_shm_pool *pool);
+
+/**
+ * tee_get_drvdata() - Return driver_data pointer
+ * @returns the driver_data pointer supplied to tee_register().
+ */
+void *tee_get_drvdata(struct tee_device *teedev);
+
+/**
+ * tee_shm_alloc() - Allocate shared memory
+ * @teedev:	Driver that allocates the shared memory
+ * @size:	Requested size of shared memory
+ * @flags:	Flags setting properties for the requested shared memory.
+ *
+ * Memory allocated as global shared memory is automatically freed when the
+ * TEE file pointer is closed. The @flags field uses the bits defined by
+ * TEE_SHM_* above. TEE_SHM_MAPPED must currently always be set. If
+ * TEE_SHM_DMA_BUF global shared memory will be allocated and associated
+ * with a dma-buf handle, else driver private memory.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc(struct tee_device *teedev, size_t size,
+			u32 flags);
+
+/**
+ * tee_shm_free() - Free shared memory
+ * @shm:	Handle to shared memory to free
+ */
+void tee_shm_free(struct tee_shm *shm);
+
+/**
+ * tee_shm_find_by_va() - Find a shared memory handle by a virtual address
+ * @teedev:	The device that owns the shared memory
+ * @flags:	Select which type of shared memory to locate, if
+ *		TEE_SHM_DMA_BUF global shared memory else driver private
+ *		shared memory.
+ * @va:		Virtual address covered by the shared memory
+ * @returns a Handle to shared memory
+ */
+struct tee_shm *tee_shm_find_by_va(struct tee_device *teedev, u32 flags,
+			void *va);
+/**
+ * tee_shm_find_by_pa() - Find a shared memory handle by a physical address
+ * @teedev:	The device that owns the shared memory
+ * @flags:	Select which type of shared memory to locate, if
+ *		TEE_SHM_DMA_BUF global shared memory else driver private
+ *		shared memory.
+ * @pa:		Physical address covered by the shared memory
+ * @returns a Handle to shared memory
+ */
+struct tee_shm *tee_shm_find_by_pa(struct tee_device *teedev, u32 flags,
+			phys_addr_t pa);
+
+/**
+ * tee_shm_va2pa() - Get physical address of a virtual address
+ * @shm:	Shared memory handle
+ * @va:		Virtual address to tranlsate
+ * @pa:		Returned physical address
+ * @returns 0 on success and < 0 on failure
+ */
+int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa);
+
+/**
+ * tee_shm_pa2va() - Get virtual address of a physical address
+ * @shm:	Shared memory handle
+ * @pa:		Physical address to tranlsate
+ * @va:		Returned virtual address
+ * @returns 0 on success and < 0 on failure
+ */
+int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va);
+
+/**
+ * tee_shm_get_size() - Get size of a shared memory
+ * @returns the size of the shared memory
+ */
+size_t tee_shm_get_size(struct tee_shm *shm);
+
+/**
+ * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
+ * @shm:	Shared memory handle
+ * @offs:	Offset from start of this shared memory
+ * @returns virtual address of the shared memory + offs if offs is within
+ *	the bounds of this shared memory, else an ERR_PTR
+ */
+void *tee_shm_get_va(struct tee_shm *shm, size_t offs);
+
+/**
+ * tee_shm_get_pa() - Get physical address of a shared memory plus an offset
+ * @shm:	Shared memory handle
+ * @offs:	Offset from start of this shared memory
+ * @pa:		Physical address to return
+ * @returns 0 if offs is within the bounds of this shared memory, else an
+ *	error code.
+ */
+int tee_shm_get_pa(struct tee_shm *shm, size_t offs, phys_addr_t *pa);
+
+/**
+ * tee_shm_get_from_fd() - Get a shared memory handle from a file descriptor
+ * @fd:		A user space file descriptor
+ *
+ * This function increases the reference counter on the shared memory and
+ * returns a handle.
+ * @returns handle to shared memory
+ */
+struct tee_shm *tee_shm_get_from_fd(int fd);
+
+/**
+ * tee_shm_put() - Decrease reference count on a shared memory handle
+ * @shm:	Shared memory handle
+ */
+void tee_shm_put(struct tee_shm *shm);
+
+/**
+ * tee_shm_get_fd() - Increase reference count and return file descriptor
+ * @shm:	Shared memory handle
+ * @returns user space file descriptor to shared memory
+ */
+int tee_shm_get_fd(struct tee_shm *shm);
+
+/**
+ * tee_shm_put_fd() - Decrease reference count and close file descriptor
+ * @fd:		File descriptor to close
+ * @returns < 0 on failure
+ */
+int tee_shm_put_fd(int fd);
+
+#endif /*__TEE_DRV_H*/
-- 
1.9.1
