From: dhobsong@igel.co.jp (Damian Hobson-Garcia)
Date: Fri, 18 Jan 2013 15:35:10 +0900
Subject: [PATCH] ARM: shmobile: ipmmu: Add basic PMB support
Message-ID: <1358490910-30716-1-git-send-email-dhobsong@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMB can be used to remap 16, 64, 128 or 512 MiB pages from
the 0x80000000-0xffffffff address range to anywhere in the
0x00000000-0x7fffffff range.
It also has the ability to perform tiled-linear address translation,
which can be used to access a memory buffer as a series of n x m tiles,
useful for image encoding/decoding.
Currently only the userspace API via character device is supported.
All register access and hardware dependent functionality is
provided by the IPMMU driver, which is shared with the IOMMU/TLB module.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
This patch must be applied on top of the IPMMU patch series by
Hideki EIRAKU. The code has been placed in the drivers/iommu directory for
two reasons:
	1) The PMB also performs hardware address translation
	2) Since the PMB shares the same register address range as the
	   shmobile IOMMU, the two functions are accessed through the same
	   platform device, the driver for which is in drivers/iommu

 drivers/iommu/Kconfig          |   14 ++
 drivers/iommu/Makefile         |    1 +
 drivers/iommu/shmobile-ipmmu.c |  117 ++++++++++++-
 drivers/iommu/shmobile-ipmmu.h |   28 +++-
 drivers/iommu/shmobile-pmb.c   |  362 ++++++++++++++++++++++++++++++++++++++++
 include/linux/ipmmu.h          |   29 ++++
 6 files changed, 544 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iommu/shmobile-pmb.c
 create mode 100644 include/linux/ipmmu.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d364494..44af0cb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -261,4 +261,18 @@ config SHMOBILE_IOMMU_L1SIZE
 	default 256 if SHMOBILE_IOMMU_ADDRSIZE_64MB
 	default 128 if SHMOBILE_IOMMU_ADDRSIZE_32MB
 
+config SHMOBILE_PMB
+	bool "IPMMU PMB driver"
+	default n
+	select SHMOBILE_IPMMU
+	help
+	  This enables the PMB interface of the IPMMU hardware module.
+	  The PMB can be used to remap 16, 64, 128 or 512 MiB pages from
+	  the 0x80000000-0xffffffff address range to anywhere in the
+	  0x00000000-0x7fffffff range.
+	  PMB support can be used either with or without SHMOBILE IOMMU
+	  support.
+
+	  If unsure, say N.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ef0e520..618238b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
+obj-$(CONFIG_SHMOBILE_PMB) += shmobile-pmb.o
diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index 8321f89..db2ae78 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -14,15 +14,34 @@
 #include <linux/slab.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include "shmobile-ipmmu.h"
+#include <linux/ipmmu.h>
 
-#define IMCTR1 0x000
-#define IMCTR2 0x004
-#define IMASID 0x010
-#define IMTTBR 0x014
-#define IMTTBCR 0x018
-
+#define IMCTR1		0x00
 #define IMCTR1_TLBEN (1 << 0)
 #define IMCTR1_FLUSH (1 << 1)
+#define IMCTR2		0x04
+#define IMCTR2_PMBEN	0x01
+#define IMASID		0x010
+#define IMTTBR		0x014
+#define IMTTBCR		0x018
+#define IMPMBA_BASE	0x80
+#define IMPBMA_V	(1 << 8)
+#define IMPMBD_BASE	0xC0
+#define IMPBMD_V	(1 << 8)
+#define IMPBMD_SZ_16M	0x00
+#define IMPBMD_SZ_64M	0x10
+#define IMPBMD_SZ_128M	0x80
+#define IMPBMD_SZ_512M	0x90
+#define IMPBMD_BV	(1 << 9)
+#define IMPBMD_TBM_MASK	(7 << 12)
+#define IMPBMD_TBM_POS	12
+#define IMPBMD_HBM_MASK	(7 << 16)
+#define IMPBMD_HBM_POS	16
+#define IMPBMD_VBM_MASK	(7 << 20)
+#define IMPBMD_VBM_POS	20
+
+#define IMPBMA(x) (IMPMBA_BASE + 0x4*x)
+#define IMPBMD(x) (IMPMBD_BASE + 0x4*x)
 
 static void ipmmu_reg_write(struct shmobile_ipmmu *ipmmu, unsigned long reg_off,
 			    unsigned long data)
@@ -88,6 +107,91 @@ void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
 	mutex_unlock(&ipmmu->flush_lock);
 }
 
+int ipmmu_pmb_enable(struct shmobile_ipmmu *ipmmu,
+		      int enable)
+{
+	ipmmu_reg_write(ipmmu, IMCTR2, enable ? IMCTR2_PMBEN : 0);
+	return 0;
+
+}
+int ipmmu_pmb_set_addr(struct shmobile_ipmmu *ipmmu,
+		 int index,
+		 unsigned long addr,
+		 int enabled)
+{
+
+	if (!enabled) {
+		ipmmu_reg_write(ipmmu, IMPBMA(index), 0);
+		return 0;
+	}
+
+	ipmmu_reg_write(ipmmu, IMPBMA(index), addr |
+		IMPBMD_V);
+	return 0;
+
+}
+
+int ipmmu_pmb_set_data(struct shmobile_ipmmu *ipmmu,
+		 int index,
+		 struct ipmmu_pmb_info *info,
+		 struct pmb_tile_info *tile)
+{
+	int vbm, hbm, tbm;
+	int w, h;
+	unsigned long temp;
+
+	if (!info || !info->enabled) {
+		ipmmu_reg_write(ipmmu, IMPBMD(index), 0);
+		return 0;
+	}
+
+	temp = info->paddr;
+
+	switch (info->size_mb) {
+	case 16:
+		temp |= IMPBMD_SZ_16M;
+		break;
+	case 64:
+		temp |= IMPBMD_SZ_64M;
+		break;
+	case 128:
+		temp |= IMPBMD_SZ_128M;
+		break;
+	case 512:
+		temp |= IMPBMD_SZ_512M;
+		break;
+	default:
+		break;
+	}
+
+	temp |= IMPBMD_V;
+
+	if (!tile || !tile->enabled) {
+		ipmmu_reg_write(ipmmu, IMPBMD(index), temp);
+		return 0;
+	}
+
+	w = tile->tile_width;
+	h = tile->tile_height;
+
+	if (w & (w - 1) || h & (h - 1))
+		return -EINVAL;
+
+	tbm = ilog2(tile->tile_width);
+	vbm = ilog2(tile->tile_height) - 1;
+	hbm = ilog2(tile->buffer_pitch) - tbm - 1;
+	tbm -= 4;
+
+	temp |= (tbm << IMPBMD_TBM_POS) & IMPBMD_TBM_MASK;
+	temp |= (vbm << IMPBMD_VBM_POS) & IMPBMD_VBM_MASK;
+	temp |= (hbm << IMPBMD_HBM_POS) & IMPBMD_HBM_MASK;
+	temp |= IMPBMD_BV;
+	ipmmu_reg_write(ipmmu, IMPBMD(index),
+			temp);
+	ipmmu_tlb_flush(ipmmu);
+	return 0;
+}
+
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct shmobile_ipmmu *ipmmu;
@@ -118,6 +222,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	ipmmu_reg_write(ipmmu, IMCTR1, 0x0); /* disable TLB */
 	ipmmu_reg_write(ipmmu, IMCTR2, 0x0); /* disable PMB */
 	ipmmu_iommu_init(ipmmu);
+	ipmmu->pmb_priv = ipmmu_pmb_init(ipmmu);
 	return 0;
 }
 
diff --git a/drivers/iommu/shmobile-ipmmu.h b/drivers/iommu/shmobile-ipmmu.h
index 6270e7c..ecc4211 100644
--- a/drivers/iommu/shmobile-ipmmu.h
+++ b/drivers/iommu/shmobile-ipmmu.h
@@ -11,6 +11,8 @@
 #define __SHMOBILE_IPMMU_H__
 
 struct dma_iommu_mapping;
+struct pmb_tile_info;
+struct ipmmu_pmb_info;
 
 struct shmobile_ipmmu {
 	struct device *dev;
@@ -20,10 +22,12 @@ struct shmobile_ipmmu {
 	struct dma_iommu_mapping *iommu_mapping;
 	const char * const *dev_names;
 	unsigned int num_dev_names;
+	void *pmb_priv;
 };
 
-#ifdef CONFIG_SHMOBILE_IPMMU_TLB
 void ipmmu_tlb_flush(struct shmobile_ipmmu *ipmmu);
+
+#ifdef CONFIG_SHMOBILE_IPMMU_TLB
 void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
 		   int asid);
 int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu);
@@ -34,4 +38,26 @@ static int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
 }
 #endif
 
+#ifdef CONFIG_SHMOBILE_PMB
+/* Access functions used by PMB device */
+/*void handle_free(struct device *dev, unsigned long handle, int size_mb);
+unsigned long handle_alloc(struct device *dev, int size_mb);*/
+int ipmmu_pmb_set_addr(struct shmobile_ipmmu *ipmmu,
+		int index, unsigned long addr,
+		int enabled);
+int ipmmu_pmb_set_data(struct shmobile_ipmmu *ipmmu, int index,
+		struct ipmmu_pmb_info *info,
+		struct pmb_tile_info *tile);
+int ipmmu_pmb_enable(struct shmobile_ipmmu *ipmmu, int index);
+/* PMB initialization */
+void *ipmmu_pmb_init(struct shmobile_ipmmu *ipmmu);
+void ipmmu_pmb_deinit(void *pmb_priv);
+#else
+static inline void *ipmmu_pmb_init(struct device *dev)
+{
+	return NULL;
+}
+static inline void ipmmu_pmb_deinit(void *pmb_priv) { }
+#endif
+
 #endif /* __SHMOBILE_IPMMU_H__ */
diff --git a/drivers/iommu/shmobile-pmb.c b/drivers/iommu/shmobile-pmb.c
new file mode 100644
index 0000000..464af0b
--- /dev/null
+++ b/drivers/iommu/shmobile-pmb.c
@@ -0,0 +1,362 @@
+/*
+ * IPMMU-PMB driver
+ * Copyright (C) 2012 Damian Hobson-Garcia
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/ipmmu.h>
+#include "shmobile-ipmmu.h"
+#include <linux/uaccess.h>
+
+#define PMB_DEVICE_NAME "pmb"
+
+#define PMB_NR 16
+/* the smallest size that can be reserverd in the pmb */
+#define PMB_GRANULARITY (16 << 20)
+#define PMB_START_ADDR	0x80000000
+#define PMB_SIZE	0x40000000
+#define NUM_BITS(x)	((x) / PMB_GRANULARITY)
+#define NR_BITMAPS	((NUM_BITS(PMB_SIZE) + BITS_PER_LONG - 1) \
+				>> ilog2(BITS_PER_LONG))
+
+struct ipmmu_pmb_data {
+	struct ipmmu_pmb_priv	*priv;
+	struct ipmmu_pmb_info	info;
+	struct pmb_tile_info	tile;
+	unsigned long		handle;
+	int			index;
+};
+
+struct ipmmu_pmb_priv {
+	struct shmobile_ipmmu	*ipmmu;
+	struct device		*ipmmu_dev;
+	struct cdev		cdev;
+	struct class		*pmb_class;
+	dev_t			pmb_dev;
+	unsigned long		busy_pmbs;
+	struct mutex		pmb_lock;
+	struct ipmmu_pmb_data	pmbs[PMB_NR];
+	struct mutex		alloc_lock;
+	unsigned long		alloc_bitmaps[NR_BITMAPS];
+	int			pmb_enabled;
+};
+
+static int valid_size(int size_mb)
+{
+	switch (size_mb) {
+	case 16:
+	case 64:
+	case 128:
+	case 512:
+		return 1;
+	}
+	return 0;
+
+}
+
+static unsigned long alloc_handle(struct ipmmu_pmb_priv *priv,
+				     int size_mb)
+{
+	int i;
+	int idx;
+	unsigned long tmp_bitmap;
+	unsigned long alloc_mask;
+	unsigned long align_mask;
+	int alloc_bits;
+
+	if (!valid_size(size_mb))
+		return -1;
+
+	alloc_bits = NUM_BITS(size_mb << 20);
+	alloc_mask = alloc_bits < BITS_PER_LONG ?
+				(1 << alloc_bits) - 1 : -1;
+
+
+	align_mask = alloc_mask - 1;
+	for (i = BITS_PER_LONG >> 1; i >= alloc_bits; i = i >> 1)
+		align_mask = align_mask | (align_mask << i);
+
+	mutex_lock(&priv->alloc_lock);
+	for (i = 0; i < NR_BITMAPS; i++) {
+		tmp_bitmap = priv->alloc_bitmaps[i];
+		tmp_bitmap |= align_mask;
+		idx = 0;
+		while (idx < BITS_PER_LONG) {
+			idx = find_next_zero_bit(&tmp_bitmap, BITS_PER_LONG,
+					idx);
+			if (!((alloc_mask << idx) & priv->alloc_bitmaps[i]) ||
+					(idx == BITS_PER_LONG))
+				break;
+			idx++;
+		}
+		if (idx < BITS_PER_LONG)
+			break;
+	}
+	if (i == NR_BITMAPS) {
+		mutex_unlock(&priv->alloc_lock);
+		return 0;
+	}
+
+	priv->alloc_bitmaps[i] |= (alloc_mask << idx);
+	mutex_unlock(&priv->alloc_lock);
+
+	return PMB_START_ADDR + (i * BITS_PER_LONG + idx) * PMB_GRANULARITY;
+}
+
+void free_handle(struct ipmmu_pmb_priv *priv,
+			unsigned long handle,
+			int size_mb)
+{
+	int idx;
+	unsigned long offset;
+	unsigned long alloc_bits;
+	unsigned long alloc_mask;
+
+	alloc_bits = NUM_BITS(size_mb << 20);
+	alloc_mask = alloc_bits < BITS_PER_LONG ?
+				(1 << alloc_bits) - 1 : -1;
+	offset = handle - PMB_START_ADDR;
+	offset /= PMB_GRANULARITY;
+	idx = offset & (BITS_PER_LONG - 1);
+	offset = offset / BITS_PER_LONG;
+	mutex_lock(&priv->alloc_lock);
+	priv->alloc_bitmaps[offset] &= ~(alloc_mask << idx);
+	mutex_unlock(&priv->alloc_lock);
+}
+
+static int set_pmb(struct ipmmu_pmb_data *data,
+	    struct ipmmu_pmb_info *info)
+{
+	struct ipmmu_pmb_priv *priv = data->priv;
+	unsigned long data_mask;
+	int err;
+
+	if (!info->enabled) {
+		if (data->handle) {
+			free_handle(priv, data->handle,
+				data->info.size_mb);
+			data->handle = 0;
+		}
+		data->info = *info;
+		ipmmu_pmb_set_data(priv->ipmmu, data->index, NULL, NULL);
+		ipmmu_pmb_set_addr(priv->ipmmu, data->index, 0, 0);
+		ipmmu_tlb_flush(priv->ipmmu);
+		return 0;
+	}
+
+	if (data->info.enabled) {
+		err = -EBUSY;
+		goto err_out;
+	}
+
+	data_mask = ~((info->size_mb) - 1);
+
+	if (info->paddr & ~(data_mask)) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	data->handle = alloc_handle(priv, info->size_mb);
+
+	if (!data->handle) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	data->info = *info;
+
+	ipmmu_pmb_set_addr(priv->ipmmu, data->index, data->handle, 1);
+	ipmmu_pmb_set_data(priv->ipmmu, data->index, &data->info,
+		&data->tile);
+
+	if (!data->priv->pmb_enabled) {
+		ipmmu_pmb_enable(priv->ipmmu, 1);
+		data->priv->pmb_enabled = 1;
+	}
+
+	ipmmu_tlb_flush(priv->ipmmu);
+
+	return 0;
+
+err_out:
+	info->enabled = 0;
+	return err;
+}
+
+static int set_tile(struct ipmmu_pmb_data *data,
+	    struct pmb_tile_info *tile)
+{
+	struct ipmmu_pmb_priv *priv = data->priv;
+	data->tile = *tile;
+	return ipmmu_pmb_set_data(priv->ipmmu, data->index, &data->info,
+		&data->tile);
+}
+
+static int ipmmu_pmb_open(struct inode *inode, struct file *filp)
+{
+	struct ipmmu_pmb_priv *priv;
+	int idx;
+	priv = container_of(inode->i_cdev, struct ipmmu_pmb_priv,
+		cdev);
+
+	mutex_lock(&priv->pmb_lock);
+	idx = find_first_zero_bit(&priv->busy_pmbs, PMB_NR);
+	if (idx == PMB_NR)
+		return -EBUSY;
+
+	__set_bit(idx, &priv->busy_pmbs);
+	mutex_unlock(&priv->pmb_lock);
+	priv->pmbs[idx].index = idx;
+	priv->pmbs[idx].priv = priv;
+	filp->private_data = &priv->pmbs[idx];
+	return 0;
+}
+
+static int ipmmu_pmb_release(struct inode *inode, struct file *filp)
+{
+	struct ipmmu_pmb_data *pmb;
+	pmb = filp->private_data;
+	if (pmb->info.enabled) {
+		pmb->info.enabled = 0;
+		set_pmb(pmb, &pmb->info);
+	}
+
+	mutex_lock(&pmb->priv->pmb_lock);
+	__clear_bit(pmb->index, &pmb->priv->busy_pmbs);
+	mutex_unlock(&pmb->priv->pmb_lock);
+	return 0;
+}
+
+static long ipmmu_pmb_ioctl(struct file *filp, unsigned int cmd_in,
+		       unsigned long arg)
+{
+	struct ipmmu_pmb_data *pmb;
+	struct ipmmu_pmb_info user_set;
+	struct pmb_tile_info user_tile;
+	long ret = -EINVAL;
+	pmb = filp->private_data;
+	switch (cmd_in) {
+	case IPMMU_GET_PMB:
+		ret = copy_to_user((char *)arg, &pmb->info, sizeof(pmb->info));
+		break;
+	case IPMMU_SET_PMB:
+		ret = copy_from_user(&user_set, (char *)arg, sizeof(user_set));
+		if (ret)
+			break;
+		ret = set_pmb(pmb, &user_set);
+		if (!ret)
+			pmb->info = user_set;
+		break;
+	case IPMMU_GET_PMB_HANDLE:
+		ret = copy_to_user((char *)arg, &pmb->handle,
+			sizeof(pmb->handle));
+		break;
+	case IPMMU_GET_PMB_TL:
+		ret = copy_to_user((char *)arg, &pmb->tile, sizeof(pmb->tile));
+		break;
+	case IPMMU_SET_PMB_TL:
+		ret = copy_from_user(&user_tile, (char *)arg,
+			sizeof(user_tile));
+		if (ret)
+			break;
+		ret = set_tile(pmb, &user_tile);
+		if (!ret)
+			pmb->tile = user_tile;
+		break;
+	}
+	return ret;
+}
+
+static const struct file_operations ipmmu_pmb_fops = {
+	.owner = THIS_MODULE,
+	.open = ipmmu_pmb_open,
+	.release = ipmmu_pmb_release,
+	.unlocked_ioctl = ipmmu_pmb_ioctl,
+};
+
+void ipmmu_pmb_deinit(void *arg)
+{
+	struct ipmmu_pmb_priv *priv = arg;
+
+	if (!priv || IS_ERR(priv))
+		return;
+
+	cdev_del(&priv->cdev);
+	device_destroy(priv->pmb_class, priv->pmb_dev);
+	unregister_chrdev_region(priv->pmb_dev, 1);
+	class_destroy(priv->pmb_class);
+	kfree(priv);
+}
+
+void *ipmmu_pmb_init(struct shmobile_ipmmu *ipmmu)
+{
+	int err = -ENOENT;
+	struct ipmmu_pmb_priv *priv;
+
+	priv = kzalloc(sizeof(struct ipmmu_pmb_priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(ipmmu->dev, "cannot allocate device data\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	priv->ipmmu = ipmmu;
+	priv->ipmmu_dev = ipmmu->dev;
+
+	mutex_init(&priv->pmb_lock);
+	mutex_init(&priv->alloc_lock);
+
+	priv->pmb_class = class_create(THIS_MODULE, "ipmmu-pmb");
+	if (!priv->pmb_class)
+		goto free_priv;
+
+	err = alloc_chrdev_region(&priv->pmb_dev, 0, 1, PMB_DEVICE_NAME);
+	if (err) {
+		dev_err(ipmmu->dev, "cannot allocate device num\n");
+		goto destroy_class;
+	}
+
+	if (!device_create(priv->pmb_class, ipmmu->dev, priv->pmb_dev, priv,
+			"pmb"))
+		goto unregister_region;
+
+	cdev_init(&priv->cdev, &ipmmu_pmb_fops);
+	priv->cdev.owner = THIS_MODULE;
+	priv->cdev.ops = &ipmmu_pmb_fops;
+	err = cdev_add(&priv->cdev, priv->pmb_dev, 1);
+	if (err) {
+		dev_err(ipmmu->dev, "cannot add ipmmu_pmb device\n");
+		goto destroy_device;
+	}
+
+	return priv;
+
+destroy_device:
+	device_destroy(priv->pmb_class, priv->pmb_dev);
+unregister_region:
+	unregister_chrdev_region(priv->pmb_dev, 1);
+destroy_class:
+	class_destroy(priv->pmb_class);
+free_priv:
+	kfree(priv);
+	return ERR_PTR(err);
+}
diff --git a/include/linux/ipmmu.h b/include/linux/ipmmu.h
new file mode 100644
index 0000000..4d31122
--- /dev/null
+++ b/include/linux/ipmmu.h
@@ -0,0 +1,29 @@
+#ifndef __LINUX_IPMMU_PMB_H__
+#define __LINUX_IPMMU_PMB_H__
+
+struct ipmmu_pmb_info {
+	int		enabled;
+	unsigned long	paddr;
+	int             size_mb;
+};
+
+struct pmb_tile_info {
+	int             tile_width;
+	int             tile_height;
+	int             buffer_pitch;
+	int             enabled;
+};
+
+/* IOCTL commands. */
+
+#define IPMMU_SET_PMB		_IOW('S', 37, struct ipmmu_pmb_phys *)
+#define IPMMU_GET_PMB		_IOR('S', 38, struct ipmmu_pmb_phys *)
+#define IPMMU_GET_PMB_HANDLE	_IOR('S', 39, unsigned long *)
+#define IPMMU_SET_PMB_TL	_IOW('S', 41, struct ipmmu_pmb_tile_info *)
+#define IPMMU_GET_PMB_TL	_IOR('S', 42, struct ipmmu_pmb_tile_info *)
+
+#ifdef __kernel
+
+#endif /* __kernel */
+
+#endif /* __LINUX_IPMMU_PMB_H__ */
-- 
1.7.5.4
