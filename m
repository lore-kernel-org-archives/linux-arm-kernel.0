From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 14 Oct 2013 18:51:35 +1030
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <87d2n88dps.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:
> This small patch series adds just enough kernel infrastructure and
> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
> that the host actually supports such madness.
>
> This has been tested on arm64, with some fixes to KVM and a set of
> changes to kvmtool, both which I am posting separately.

OK, so I already have a patch which supports config space accessors.
I've posted the series below, and since you want it, I'll put it in
virtio-next after more testing and rebasing...

But we won't be using feature bits for endianness, since we're defining
endian in the 1.0 spec (whether LE-everywhere or LE-for-mmio-and-PCI is
still debated).  Since we need to guess for backwards compat anyway,
let's keep doing this until v1.0?

(Yeah, I made this mess with "native endian".  I promise I have learnt
my lesson).

Thanks,
Rusty.

Subject: virtio_config: introduce size-based accessors.

This lets the us do endian conversion if necessary, and insulates the
drivers from that change.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 29b9104..e62acdd 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -162,5 +135,139 @@ int virtqueue_set_affinity(struct virtqueue *vq, int cpu)
 	return 0;
 }
 
+/* Config space accessors. */
+#define virtio_cread(vdev, structname, member, ptr)			\
+	do {								\
+		/* Must match the member's type, and be integer */	\
+		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+			(*ptr) = 1;					\
+									\
+		switch (sizeof(*ptr)) {					\
+		case 1:							\
+			*(ptr) = virtio_cread8(vdev,			\
+					       offsetof(structname, member)); \
+			break;						\
+		case 2:							\
+			*(ptr) = virtio_cread16(vdev,			\
+						offsetof(structname, member)); \
+			break;						\
+		case 4:							\
+			*(ptr) = virtio_cread32(vdev,			\
+						offsetof(structname, member)); \
+			break;						\
+		case 8:							\
+			*(ptr) = virtio_cread64(vdev,			\
+						offsetof(structname, member)); \
+			break;						\
+		default:						\
+			BUG();						\
+		}							\
+	} while(0)
+
+/* Config space accessors. */
+#define virtio_cwrite(vdev, structname, member, ptr)			\
+	do {								\
+		/* Must match the member's type, and be integer */	\
+		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+			BUG_ON((*ptr) == 1);				\
+									\
+		switch (sizeof(*ptr)) {					\
+		case 1:							\
+			virtio_cwrite8(vdev,				\
+				       offsetof(structname, member),	\
+				       *(ptr));				\
+			break;						\
+		case 2:							\
+			virtio_cwrite16(vdev,				\
+					offsetof(structname, member),	\
+					*(ptr));			\
+			break;						\
+		case 4:							\
+			virtio_cwrite32(vdev,				\
+					offsetof(structname, member),	\
+					*(ptr));			\
+			break;						\
+		case 8:							\
+			virtio_cwrite64(vdev,				\
+					offsetof(structname, member),	\
+					*(ptr));			\
+			break;						\
+		default:						\
+			BUG();						\
+		}							\
+	} while(0)
+
+static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
+{
+	u8 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cread_bytes(struct virtio_device *vdev,
+				      unsigned int offset,
+				      void *buf, size_t len)
+{
+	vdev->config->get(vdev, offset, buf, len);
+}
+
+static inline void virtio_cwrite8(struct virtio_device *vdev,
+				  unsigned int offset, u8 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline u16 virtio_cread16(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	u16 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite16(struct virtio_device *vdev,
+				   unsigned int offset, u16 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline u32 virtio_cread32(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	u32 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite32(struct virtio_device *vdev,
+				   unsigned int offset, u32 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+static inline u64 virtio_cread64(struct virtio_device *vdev,
+				 unsigned int offset)
+{
+	u64 ret;
+	vdev->config->get(vdev, offset, &ret, sizeof(ret));
+	return ret;
+}
+
+static inline void virtio_cwrite64(struct virtio_device *vdev,
+				   unsigned int offset, u64 val)
+{
+	vdev->config->set(vdev, offset, &val, sizeof(val));
+}
+
+/* Conditional config space accessors. */
+#define virtio_cread_feature(vdev, fbit, structname, member, ptr)	\
+	({								\
+		int _r = 0;						\
+		if (!virtio_has_feature(vdev, fbit))			\
+			_r = -ENOENT;					\
+		else							\
+			virtio_cread((vdev), structname, member, ptr);	\
+		_r;							\
+	})
 
 #endif /* _LINUX_VIRTIO_CONFIG_H */

Subject: virtio: use size-based config accessors.

This lets the transport do endian conversion if necessary, and insulates
the drivers from the difference.

Most drivers can use the simple helpers virtio_cread() and virtio_cwrite().

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6472395..1b1bbd3 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -456,18 +456,15 @@ static int virtblk_ioctl(struct block_device *bdev, fmode_t mode,
 static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 {
 	struct virtio_blk *vblk = bd->bd_disk->private_data;
-	struct virtio_blk_geometry vgeo;
-	int err;
 
 	/* see if the host passed in geometry config */
-	err = virtio_config_val(vblk->vdev, VIRTIO_BLK_F_GEOMETRY,
-				offsetof(struct virtio_blk_config, geometry),
-				&vgeo);
-
-	if (!err) {
-		geo->heads = vgeo.heads;
-		geo->sectors = vgeo.sectors;
-		geo->cylinders = vgeo.cylinders;
+	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
+		virtio_cread(vblk->vdev, struct virtio_blk_config,
+			     geometry.cylinders, &geo->cylinders);
+		virtio_cread(vblk->vdev, struct virtio_blk_config,
+			     geometry.heads, &geo->heads);
+		virtio_cread(vblk->vdev, struct virtio_blk_config,
+			     geometry.sectors, &geo->sectors);
 	} else {
 		/* some standard values, similar to sd */
 		geo->heads = 1 << 6;
@@ -529,8 +526,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
 		goto done;
 
 	/* Host must always specify the capacity. */
-	vdev->config->get(vdev, offsetof(struct virtio_blk_config, capacity),
-			  &capacity, sizeof(capacity));
+	virtio_cread(vdev, struct virtio_blk_config, capacity, &capacity);
 
 	/* If capacity is too big, truncate with warning. */
 	if ((sector_t)capacity != capacity) {
@@ -608,9 +604,9 @@ static int virtblk_get_cache_mode(struct virtio_device *vdev)
 	u8 writeback;
 	int err;
 
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_CONFIG_WCE,
-				offsetof(struct virtio_blk_config, wce),
-				&writeback);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_CONFIG_WCE,
+				   struct virtio_blk_config, wce,
+				   &writeback);
 	if (err)
 		writeback = virtio_has_feature(vdev, VIRTIO_BLK_F_WCE);
 
@@ -642,7 +638,6 @@ virtblk_cache_type_store(struct device *dev, struct device_attribute *attr,
 	struct virtio_blk *vblk = disk->private_data;
 	struct virtio_device *vdev = vblk->vdev;
 	int i;
-	u8 writeback;
 
 	BUG_ON(!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_CONFIG_WCE));
 	for (i = ARRAY_SIZE(virtblk_cache_types); --i >= 0; )
@@ -652,11 +647,7 @@ virtblk_cache_type_store(struct device *dev, struct device_attribute *attr,
 	if (i < 0)
 		return -EINVAL;
 
-	writeback = i;
-	vdev->config->set(vdev,
-			  offsetof(struct virtio_blk_config, wce),
-			  &writeback, sizeof(writeback));
-
+	virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
 	virtblk_update_cache_mode(vdev);
 	return count;
 }
@@ -699,9 +690,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 	index = err;
 
 	/* We need to know how many segments before we allocate. */
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_SEG_MAX,
-				offsetof(struct virtio_blk_config, seg_max),
-				&sg_elems);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
+				   struct virtio_blk_config, seg_max,
+				   &sg_elems);
 
 	/* We need at least one SG element, whatever they say. */
 	if (err || !sg_elems)
@@ -772,8 +763,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		set_disk_ro(vblk->disk, 1);
 
 	/* Host must always specify the capacity. */
-	vdev->config->get(vdev, offsetof(struct virtio_blk_config, capacity),
-			  &cap, sizeof(cap));
+	virtio_cread(vdev, struct virtio_blk_config, capacity, &cap);
 
 	/* If capacity is too big, truncate with warning. */
 	if ((sector_t)cap != cap) {
@@ -794,46 +784,45 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_SIZE_MAX,
-				offsetof(struct virtio_blk_config, size_max),
-				&v);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
+				   struct virtio_blk_config, size_max, &v);
 	if (!err)
 		blk_queue_max_segment_size(q, v);
 	else
 		blk_queue_max_segment_size(q, -1U);
 
 	/* Host can optionally specify the block size of the device */
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_BLK_SIZE,
-				offsetof(struct virtio_blk_config, blk_size),
-				&blk_size);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
+				   struct virtio_blk_config, blk_size,
+				   &blk_size);
 	if (!err)
 		blk_queue_logical_block_size(q, blk_size);
 	else
 		blk_size = queue_logical_block_size(q);
 
 	/* Use topology information if available */
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_TOPOLOGY,
-			offsetof(struct virtio_blk_config, physical_block_exp),
-			&physical_block_exp);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
+				   struct virtio_blk_config, physical_block_exp,
+				   &physical_block_exp);
 	if (!err && physical_block_exp)
 		blk_queue_physical_block_size(q,
 				blk_size * (1 << physical_block_exp));
 
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_TOPOLOGY,
-			offsetof(struct virtio_blk_config, alignment_offset),
-			&alignment_offset);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
+				   struct virtio_blk_config, alignment_offset,
+				   &alignment_offset);
 	if (!err && alignment_offset)
 		blk_queue_alignment_offset(q, blk_size * alignment_offset);
 
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_TOPOLOGY,
-			offsetof(struct virtio_blk_config, min_io_size),
-			&min_io_size);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
+				   struct virtio_blk_config, min_io_size,
+				   &min_io_size);
 	if (!err && min_io_size)
 		blk_queue_io_min(q, blk_size * min_io_size);
 
-	err = virtio_config_val(vdev, VIRTIO_BLK_F_TOPOLOGY,
-			offsetof(struct virtio_blk_config, opt_io_size),
-			&opt_io_size);
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
+				   struct virtio_blk_config, opt_io_size,
+				   &opt_io_size);
 	if (!err && opt_io_size)
 		blk_queue_io_opt(q, blk_size * opt_io_size);
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e6ba6b7..1735c38 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1800,12 +1800,8 @@ static void config_intr(struct virtio_device *vdev)
 		struct port *port;
 		u16 rows, cols;
 
-		vdev->config->get(vdev,
-				  offsetof(struct virtio_console_config, cols),
-				  &cols, sizeof(u16));
-		vdev->config->get(vdev,
-				  offsetof(struct virtio_console_config, rows),
-				  &rows, sizeof(u16));
+		virtio_cread(vdev, struct virtio_console_config, cols, &cols);
+		virtio_cread(vdev, struct virtio_console_config, rows, &rows);
 
 		port = find_port_by_id(portdev, 0);
 		set_console_size(port, rows, cols);
@@ -1977,10 +1973,9 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
 	if (!is_rproc_serial(vdev) &&
-	    virtio_config_val(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
-				  offsetof(struct virtio_console_config,
-					   max_nr_ports),
-				  &portdev->config.max_nr_ports) == 0) {
+	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
+				 struct virtio_console_config, max_nr_ports,
+				 &portdev->config.max_nr_ports) == 0) {
 		multiport = true;
 	}
 
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 8308dee..ef602e3 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -682,18 +682,19 @@ static int cfv_probe(struct virtio_device *vdev)
 		goto err;
 
 	/* Get the CAIF configuration from virtio config space, if available */
-#define GET_VIRTIO_CONFIG_OPS(_v, _var, _f) \
-	((_v)->config->get(_v, offsetof(struct virtio_caif_transf_config, _f), \
-			   &_var, \
-			   FIELD_SIZEOF(struct virtio_caif_transf_config, _f)))
-
 	if (vdev->config->get) {
-		GET_VIRTIO_CONFIG_OPS(vdev, cfv->tx_hr, headroom);
-		GET_VIRTIO_CONFIG_OPS(vdev, cfv->rx_hr, headroom);
-		GET_VIRTIO_CONFIG_OPS(vdev, cfv->tx_tr, tailroom);
-		GET_VIRTIO_CONFIG_OPS(vdev, cfv->rx_tr, tailroom);
-		GET_VIRTIO_CONFIG_OPS(vdev, cfv->mtu, mtu);
-		GET_VIRTIO_CONFIG_OPS(vdev, cfv->mru, mtu);
+		virtio_cread(vdev, struct virtio_caif_transf_config, headroom,
+			     &cfv->tx_hr);
+		virtio_cread(vdev, struct virtio_caif_transf_config, headroom,
+			     &cfv->rx_hr);
+		virtio_cread(vdev, struct virtio_caif_transf_config, tailroom,
+			     &cfv->tx_tr);
+		virtio_cread(vdev, struct virtio_caif_transf_config, tailroom,
+			     &cfv->rx_tr);
+		virtio_cread(vdev, struct virtio_caif_transf_config, mtu,
+			     &cfv->mtu);
+		virtio_cread(vdev, struct virtio_caif_transf_config, mtu,
+			     &cfv->mru);
 	} else {
 		cfv->tx_hr = CFV_DEF_HEADROOM;
 		cfv->rx_hr = CFV_DEF_HEADROOM;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index be70487..61c1592 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -829,8 +829,13 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 			return -EINVAL;
 		}
 	} else if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
-		vdev->config->set(vdev, offsetof(struct virtio_net_config, mac),
-				  addr->sa_data, dev->addr_len);
+		unsigned int i;
+
+		/* Naturally, this has an atomicity problem. */
+		for (i = 0; i < dev->addr_len; i++)
+			virtio_cwrite8(vdev,
+				       offsetof(struct virtio_net_config, mac) +
+				       i, addr->sa_data[i]);
 	}
 
 	eth_commit_mac_addr_change(dev, p);
@@ -1239,9 +1244,8 @@ static void virtnet_config_changed_work(struct work_struct *work)
 	if (!vi->config_enable)
 		goto done;
 
-	if (virtio_config_val(vi->vdev, VIRTIO_NET_F_STATUS,
-			      offsetof(struct virtio_net_config, status),
-			      &v) < 0)
+	if (virtio_cread_feature(vi->vdev, VIRTIO_NET_F_STATUS,
+				 struct virtio_net_config, status, &v) < 0)
 		goto done;
 
 	if (v & VIRTIO_NET_S_ANNOUNCE) {
@@ -1463,9 +1467,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	u16 max_queue_pairs;
 
 	/* Find if host supports multiqueue virtio_net device */
-	err = virtio_config_val(vdev, VIRTIO_NET_F_MQ,
-				offsetof(struct virtio_net_config,
-				max_virtqueue_pairs), &max_queue_pairs);
+	err = virtio_cread_feature(vdev, VIRTIO_NET_F_MQ,
+				   struct virtio_net_config,
+				   max_virtqueue_pairs, &max_queue_pairs);
 
 	/* We need@least 2 queue's */
 	if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
@@ -1513,9 +1517,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 
 	/* Configuration may specify what MAC to use.  Otherwise random. */
-	if (virtio_config_val_len(vdev, VIRTIO_NET_F_MAC,
-				  offsetof(struct virtio_net_config, mac),
-				  dev->dev_addr, dev->addr_len) < 0)
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
+		virtio_cread_bytes(vdev,
+				   offsetof(struct virtio_net_config, mac),
+				   dev->dev_addr, dev->addr_len);
+	else
 		eth_hw_addr_random(dev);
 
 	/* Set up our device-specific information */
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index f679b8c..a20418f 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -547,19 +547,15 @@ static struct scsi_host_template virtscsi_host_template = {
 #define virtscsi_config_get(vdev, fld) \
 	({ \
 		typeof(((struct virtio_scsi_config *)0)->fld) __val; \
-		vdev->config->get(vdev, \
-				  offsetof(struct virtio_scsi_config, fld), \
-				  &__val, sizeof(__val)); \
+		virtio_cread(vdev, struct virtio_scsi_config, fld, &__val); \
 		__val; \
 	})
 
 #define virtscsi_config_set(vdev, fld, val) \
-	(void)({ \
+	do { \
 		typeof(((struct virtio_scsi_config *)0)->fld) __val = (val); \
-		vdev->config->set(vdev, \
-				  offsetof(struct virtio_scsi_config, fld), \
-				  &__val, sizeof(__val)); \
-	})
+		virtio_cwrite(vdev, struct virtio_scsi_config, fld, &__val); \
+	} while(0)
 
 static void virtscsi_init_vq(struct virtio_scsi_vq *virtscsi_vq,
 			     struct virtqueue *vq)
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8dab163..bbab952 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -273,9 +273,8 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	__le32 v;
 	s64 target;
 
-	vb->vdev->config->get(vb->vdev,
-			      offsetof(struct virtio_balloon_config, num_pages),
-			      &v, sizeof(v));
+	virtio_cread(vb->vdev, struct virtio_balloon_config, num_pages, &v);
+
 	target = le32_to_cpu(v);
 	return target - vb->num_pages;
 }
@@ -284,9 +283,8 @@ static void update_balloon_size(struct virtio_balloon *vb)
 {
 	__le32 actual = cpu_to_le32(vb->num_pages);
 
-	vb->vdev->config->set(vb->vdev,
-			      offsetof(struct virtio_balloon_config, actual),
-			      &actual, sizeof(actual));
+	virtio_cwrite(vb->vdev, struct virtio_balloon_config, num_pages,
+		      &actual);
 }
 
 static int balloon(void *_vballoon)
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index de2e950..d843d5d 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -514,9 +514,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 
 	chan->inuse = false;
 	if (virtio_has_feature(vdev, VIRTIO_9P_MOUNT_TAG)) {
-		vdev->config->get(vdev,
-				offsetof(struct virtio_9p_config, tag_len),
-				&tag_len, sizeof(tag_len));
+		virtio_cread(vdev, struct virtio_9p_config, tag_len, &tag_len);
 	} else {
 		err = -EINVAL;
 		goto out_free_vq;
@@ -526,8 +524,9 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 		err = -ENOMEM;
 		goto out_free_vq;
 	}
-	vdev->config->get(vdev, offsetof(struct virtio_9p_config, tag),
-			tag, tag_len);
+
+	virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
+			   tag, tag_len);
 	chan->tag = tag;
 	chan->tag_len = tag_len;
 	err = sysfs_create_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);


Subject: virtio_config: remove virtio_config_val

The virtio_cread() functions should now be used.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 29b9104..e62acdd 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -96,33 +96,6 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	return test_bit(fbit, vdev->features);
 }
 
-/**
- * virtio_config_val - look for a feature and get a virtio config entry.
- * @vdev: the virtio device
- * @fbit: the feature bit
- * @offset: the type to search for.
- * @v: a pointer to the value to fill in.
- *
- * The return value is -ENOENT if the feature doesn't exist.  Otherwise
- * the config value is copied into whatever is pointed to by v. */
-#define virtio_config_val(vdev, fbit, offset, v) \
-	virtio_config_buf((vdev), (fbit), (offset), (v), sizeof(*v))
-
-#define virtio_config_val_len(vdev, fbit, offset, v, len) \
-	virtio_config_buf((vdev), (fbit), (offset), (v), (len))
-
-static inline int virtio_config_buf(struct virtio_device *vdev,
-				    unsigned int fbit,
-				    unsigned int offset,
-				    void *buf, unsigned len)
-{
-	if (!virtio_has_feature(vdev, fbit))
-		return -ENOENT;
-
-	vdev->config->get(vdev, offset, buf, len);
-	return 0;
-}
-
 static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
