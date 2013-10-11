From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:11 +0100
Subject: [PATCH 3/3] virtio: mmio: access configuration space as little-endian
In-Reply-To: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502171-8187-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virtio_mmio defines the config space to be little-endian. This means
that a big-endian guest has to perform the access with byte-swapping
accessors.

The config space accessors are changed to take an "access_size"
parameter, allowing the low-level code to use the correct primitives.
Drivers and transports are updated to use the modified API. Only
virtio_mmio is actually changed to do something different.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/block/virtio_blk.c             |  6 +--
 drivers/char/virtio_console.c          |  4 +-
 drivers/lguest/lguest_device.c         |  8 +++-
 drivers/net/caif/caif_virtio.c         |  2 +-
 drivers/net/virtio_net.c               |  2 +-
 drivers/remoteproc/remoteproc_virtio.c |  8 +++-
 drivers/s390/kvm/kvm_virtio.c          |  8 +++-
 drivers/s390/kvm/virtio_ccw.c          |  9 +++-
 drivers/scsi/virtio_scsi.c             |  4 +-
 drivers/virtio/virtio_balloon.c        |  8 ++--
 drivers/virtio/virtio_mmio.c           | 86 ++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_pci.c            |  8 +++-
 include/linux/virtio_config.h          | 19 ++++----
 net/9p/trans_virtio.c                  |  4 +-
 14 files changed, 133 insertions(+), 43 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5cdf88b..9eadf52 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -530,7 +530,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
 
 	/* Host must always specify the capacity. */
 	vdev->config->get(vdev, offsetof(struct virtio_blk_config, capacity),
-			  &capacity, sizeof(capacity));
+			  &capacity, 1, sizeof(capacity));
 
 	/* If capacity is too big, truncate with warning. */
 	if ((sector_t)capacity != capacity) {
@@ -655,7 +655,7 @@ virtblk_cache_type_store(struct device *dev, struct device_attribute *attr,
 	writeback = i;
 	vdev->config->set(vdev,
 			  offsetof(struct virtio_blk_config, wce),
-			  &writeback, sizeof(writeback));
+			  &writeback, 1, sizeof(writeback));
 
 	virtblk_update_cache_mode(vdev);
 	return count;
@@ -773,7 +773,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	/* Host must always specify the capacity. */
 	vdev->config->get(vdev, offsetof(struct virtio_blk_config, capacity),
-			  &cap, sizeof(cap));
+			  &cap, 1, sizeof(cap));
 
 	/* If capacity is too big, truncate with warning. */
 	if ((sector_t)cap != cap) {
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b79cf3e..5ca3eb1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1839,10 +1839,10 @@ static void config_intr(struct virtio_device *vdev)
 
 		vdev->config->get(vdev,
 				  offsetof(struct virtio_console_config, cols),
-				  &cols, sizeof(u16));
+				  &cols, 1, sizeof(u16));
 		vdev->config->get(vdev,
 				  offsetof(struct virtio_console_config, rows),
-				  &rows, sizeof(u16));
+				  &rows, 1, sizeof(u16));
 
 		port = find_port_by_id(portdev, 0);
 		set_console_size(port, rows, cols);
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index b3256ff..5858a9b 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -154,10 +154,12 @@ static void lg_finalize_features(struct virtio_device *vdev)
 
 /* Once they've found a field, getting a copy of it is easy. */
 static void lg_get(struct virtio_device *vdev, unsigned int offset,
-		   void *buf, unsigned len)
+		   void *buf, unsigned len, unsigned access_size)
 {
 	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
 
+	len *= access_size;
+
 	/* Check they didn't ask for more than the length of the config! */
 	BUG_ON(offset + len > desc->config_len);
 	memcpy(buf, lg_config(desc) + offset, len);
@@ -165,10 +167,12 @@ static void lg_get(struct virtio_device *vdev, unsigned int offset,
 
 /* Setting the contents is also trivial. */
 static void lg_set(struct virtio_device *vdev, unsigned int offset,
-		   const void *buf, unsigned len)
+		   const void *buf, unsigned len, unsigned access_size)
 {
 	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
 
+	len *= access_size;
+
 	/* Check they didn't ask for more than the length of the config! */
 	BUG_ON(offset + len > desc->config_len);
 	memcpy(lg_config(desc) + offset, buf, len);
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index b9ed128..5ace13d 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -689,7 +689,7 @@ static int cfv_probe(struct virtio_device *vdev)
 #define GET_VIRTIO_CONFIG_OPS(_v, _var, _f) \
 	((_v)->config->get(_v, offsetof(struct virtio_caif_transf_config, _f), \
 			   &_var, \
-			   FIELD_SIZEOF(struct virtio_caif_transf_config, _f)))
+			   1, FIELD_SIZEOF(struct virtio_caif_transf_config, _f)))
 
 	if (vdev->config->get) {
 		GET_VIRTIO_CONFIG_OPS(vdev, cfv->tx_hr, headroom);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index defec2b..54e9a22 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -853,7 +853,7 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 		}
 	} else if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
 		vdev->config->set(vdev, offsetof(struct virtio_net_config, mac),
-				  addr->sa_data, dev->addr_len);
+				  addr->sa_data, dev->addr_len, 1);
 	}
 
 	eth_commit_mac_addr_change(dev, p);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index b09c75c..40af32f 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -234,12 +234,14 @@ static void rproc_virtio_finalize_features(struct virtio_device *vdev)
 }
 
 static void rproc_virtio_get(struct virtio_device *vdev, unsigned offset,
-							void *buf, unsigned len)
+			     void *buf, unsigned len, unsigned access_size)
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct fw_rsc_vdev *rsc;
 	void *cfg;
 
+	len *= access_size;
+
 	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
 	cfg = &rsc->vring[rsc->num_of_vrings];
 
@@ -252,12 +254,14 @@ static void rproc_virtio_get(struct virtio_device *vdev, unsigned offset,
 }
 
 static void rproc_virtio_set(struct virtio_device *vdev, unsigned offset,
-		      const void *buf, unsigned len)
+			     const void *buf, unsigned len, unsigned access_size)
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct fw_rsc_vdev *rsc;
 	void *cfg;
 
+	len *= access_size;
+
 	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
 	cfg = &rsc->vring[rsc->num_of_vrings];
 
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index af2166f..119b106 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -115,19 +115,23 @@ static void kvm_finalize_features(struct virtio_device *vdev)
  * Reading and writing elements in config space
  */
 static void kvm_get(struct virtio_device *vdev, unsigned int offset,
-		   void *buf, unsigned len)
+		    void *buf, unsigned len, unsigned access_size)
 {
 	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
 
+	len *= access_size;
+
 	BUG_ON(offset + len > desc->config_len);
 	memcpy(buf, kvm_vq_configspace(desc) + offset, len);
 }
 
 static void kvm_set(struct virtio_device *vdev, unsigned int offset,
-		   const void *buf, unsigned len)
+		    const void *buf, unsigned len, unsigned access_size)
 {
 	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
 
+	len *= access_size;
+
 	BUG_ON(offset + len > desc->config_len);
 	memcpy(kvm_vq_configspace(desc) + offset, buf, len);
 }
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 779dc51..2c36788 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -477,13 +477,16 @@ out_free:
 }
 
 static void virtio_ccw_get_config(struct virtio_device *vdev,
-				  unsigned int offset, void *buf, unsigned len)
+				  unsigned int offset, void *buf,
+				  unsigned len, unsigned access_size)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	int ret;
 	struct ccw1 *ccw;
 	void *config_area;
 
+	len *= access_size;
+
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
 		return;
@@ -511,12 +514,14 @@ out_free:
 
 static void virtio_ccw_set_config(struct virtio_device *vdev,
 				  unsigned int offset, const void *buf,
-				  unsigned len)
+				  unsigned len, unsigned access_size)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct ccw1 *ccw;
 	void *config_area;
 
+	len *= access_size;
+
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
 		return;
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 74b88ef..652d64e 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -712,7 +712,7 @@ static struct scsi_host_template virtscsi_host_template_multi = {
 		typeof(((struct virtio_scsi_config *)0)->fld) __val; \
 		vdev->config->get(vdev, \
 				  offsetof(struct virtio_scsi_config, fld), \
-				  &__val, sizeof(__val)); \
+				  &__val, 1, sizeof(__val));		\
 		__val; \
 	})
 
@@ -721,7 +721,7 @@ static struct scsi_host_template virtscsi_host_template_multi = {
 		typeof(((struct virtio_scsi_config *)0)->fld) __val = (val); \
 		vdev->config->set(vdev, \
 				  offsetof(struct virtio_scsi_config, fld), \
-				  &__val, sizeof(__val)); \
+				  &__val, 1, sizeof(__val));		\
 	})
 
 static void __virtscsi_set_affinity(struct virtio_scsi *vscsi, bool affinity)
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f572c0..ccac818 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -272,23 +272,21 @@ static void virtballoon_changed(struct virtio_device *vdev)
 
 static inline s64 towards_target(struct virtio_balloon *vb)
 {
-	__le32 v;
 	s64 target;
 
 	vb->vdev->config->get(vb->vdev,
 			      offsetof(struct virtio_balloon_config, num_pages),
-			      &v, sizeof(v));
-	target = le32_to_cpu(v);
+			      &target, 1, sizeof(target));
 	return target - vb->num_pages;
 }
 
 static void update_balloon_size(struct virtio_balloon *vb)
 {
-	__le32 actual = cpu_to_le32(vb->num_pages);
+	u32 actual = vb->num_pages;
 
 	vb->vdev->config->set(vb->vdev,
 			      offsetof(struct virtio_balloon_config, actual),
-			      &actual, sizeof(actual));
+			      &actual, 1, sizeof(actual));
 }
 
 static int balloon(void *_vballoon)
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 57f24fd..bbc4410 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -101,7 +101,7 @@
 #include <linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
 
-
+#include <asm-generic/io-64-nonatomic-lo-hi.h>
 
 /* The alignment to use between consumer and producer parts of vring.
  * Currently hardcoded to the page size. */
@@ -168,25 +168,93 @@ static void vm_finalize_features(struct virtio_device *vdev)
 }
 
 static void vm_get(struct virtio_device *vdev, unsigned offset,
-		   void *buf, unsigned len)
+		   void *buf, unsigned len, unsigned access_size)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	u8 *ptr = buf;
 	int i;
 
-	for (i = 0; i < len; i++)
-		ptr[i] = readb(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+	switch (access_size) {
+	case 1: {
+		u8 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			ptr[i] = readb(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	case 2: {
+		u16 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			ptr[i] = readw(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	case 4: {
+		u32 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			ptr[i] = readl(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	case 8: {
+		u64 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			ptr[i] = readq(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	default:
+		pr_err("virtio: illegal access size %d\n", access_size);
+		BUG();
+	}
 }
 
 static void vm_set(struct virtio_device *vdev, unsigned offset,
-		   const void *buf, unsigned len)
+		   const void *buf, unsigned len, unsigned access_size)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	const u8 *ptr = buf;
 	int i;
 
-	for (i = 0; i < len; i++)
-		writeb(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+	switch (access_size) {
+	case 1: {
+		const u8 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			writeb(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	case 2: {
+		const u16 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			writew(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	case 4: {
+		const u32 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			writel(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	case 8: {
+		const u64 *ptr = buf;
+
+		for (i = 0; i < len; i++)
+			writeq(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+
+		break;
+	}
+	default:
+		pr_err("virtio: illegal access size %d\n", access_size);
+		BUG();
+	}
 }
 
 static u8 vm_get_status(struct virtio_device *vdev)
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 98917fc..f06671c 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -129,7 +129,7 @@ static void vp_finalize_features(struct virtio_device *vdev)
 
 /* virtio config->get() implementation */
 static void vp_get(struct virtio_device *vdev, unsigned offset,
-		   void *buf, unsigned len)
+		   void *buf, unsigned len, unsigned access_size)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
@@ -137,6 +137,8 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 	u8 *ptr = buf;
 	int i;
 
+	len *= access_size;
+
 	for (i = 0; i < len; i++)
 		ptr[i] = ioread8(ioaddr + i);
 }
@@ -144,7 +146,7 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 /* the config->set() implementation.  it's symmetric to the config->get()
  * implementation */
 static void vp_set(struct virtio_device *vdev, unsigned offset,
-		   const void *buf, unsigned len)
+		   const void *buf, unsigned len, unsigned access_size)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
@@ -152,6 +154,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	const u8 *ptr = buf;
 	int i;
 
+	len *= access_size;
+
 	for (i = 0; i < len; i++)
 		iowrite8(ptr[i], ioaddr + i);
 }
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 29b9104..69d1884 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -12,12 +12,14 @@
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
  *	buf: the buffer to write the field value into.
- *	len: the length of the buffer
+ *	len: the length of the buffer in access_size unit
+ *	access_size: access length
  * @set: write the value of a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
  *	buf: the buffer to read the field value from.
- *	len: the length of the buffer
+ *	len: the length of the buffer in access_size unit
+ *	access_size: access length
  * @get_status: read the status byte
  *	vdev: the virtio_device
  *	Returns the status byte
@@ -55,9 +57,9 @@
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
-		    void *buf, unsigned len);
+		    void *buf, unsigned len, unsigned access_size);
 	void (*set)(struct virtio_device *vdev, unsigned offset,
-		    const void *buf, unsigned len);
+		    const void *buf, unsigned len, unsigned access_size);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
@@ -106,20 +108,21 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
  * The return value is -ENOENT if the feature doesn't exist.  Otherwise
  * the config value is copied into whatever is pointed to by v. */
 #define virtio_config_val(vdev, fbit, offset, v) \
-	virtio_config_buf((vdev), (fbit), (offset), (v), sizeof(*v))
+	virtio_config_buf((vdev), (fbit), (offset), (v), 1, sizeof(*v))
 
 #define virtio_config_val_len(vdev, fbit, offset, v, len) \
-	virtio_config_buf((vdev), (fbit), (offset), (v), (len))
+	virtio_config_buf((vdev), (fbit), (offset), (v), (len), 1)
 
 static inline int virtio_config_buf(struct virtio_device *vdev,
 				    unsigned int fbit,
 				    unsigned int offset,
-				    void *buf, unsigned len)
+				    void *buf, unsigned len,
+				    unsigned access_size)
 {
 	if (!virtio_has_feature(vdev, fbit))
 		return -ENOENT;
 
-	vdev->config->get(vdev, offset, buf, len);
+	vdev->config->get(vdev, offset, buf, len, access_size);
 	return 0;
 }
 
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 990afab..d12a2aa 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -546,7 +546,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_9P_MOUNT_TAG)) {
 		vdev->config->get(vdev,
 				offsetof(struct virtio_9p_config, tag_len),
-				&tag_len, sizeof(tag_len));
+				  &tag_len, 1, sizeof(tag_len));
 	} else {
 		err = -EINVAL;
 		goto out_free_vq;
@@ -557,7 +557,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 		goto out_free_vq;
 	}
 	vdev->config->get(vdev, offsetof(struct virtio_9p_config, tag),
-			tag, tag_len);
+			  tag, tag_len, 1);
 	chan->tag = tag;
 	chan->tag_len = tag_len;
 	err = sysfs_create_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
-- 
1.8.2.3
