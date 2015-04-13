From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 13 Apr 2015 14:29:26 +0200
Subject: [RFC v6 11/16] KVM: kvm-vfio: wrappers for
 vfio_external_{mask|is_active|set_automasked}
In-Reply-To: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
References: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1428928171-18884-12-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those 3 new wrapper functions call the respective VFIO external
functions.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

- v4: creation
- v5 -> v6:
  x vfio.h modifications duly moved in "VFIO: platform: add
    vfio_external_{mask|is_active|set_automasked}"
  x all external functions use vfio_device handle
  x change proto of above function (unsigned index, unsigned start,
    unsigned count); also return int.
---
 virt/kvm/vfio.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 80a45e4..f4e86d3 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -134,6 +134,58 @@ static void kvm_vfio_put_vfio_device(struct vfio_device *vdev)
 	kvm_vfio_device_put_external_user(vdev);
 }
 
+int kvm_vfio_external_is_active(struct vfio_device *vdev,
+				unsigned index, unsigned start, unsigned count)
+{
+	int (*fn)(struct vfio_device *, unsigned index, unsigned start,
+			   unsigned count);
+	bool active;
+
+	fn = symbol_get(vfio_external_is_active);
+	if (!fn)
+		return -ENXIO;
+
+	active = fn(vdev, index, start, count);
+
+	symbol_put(vfio_external_is_active);
+	return active;
+}
+
+int kvm_vfio_external_mask(struct vfio_device *vdev, unsigned index,
+			   unsigned start, unsigned count)
+{
+	int ret;
+	int (*fn)(struct vfio_device *, unsigned index, unsigned start,
+		  unsigned count);
+
+	fn = symbol_get(vfio_external_mask);
+	if (!fn)
+		return -ENXIO;
+
+	ret = fn(vdev, index, start, count);
+
+	symbol_put(vfio_external_mask);
+	return ret;
+}
+
+int kvm_vfio_external_set_automasked(struct vfio_device *vdev,
+				      unsigned index, unsigned start,
+				      unsigned count, bool automasked)
+{
+	int ret;
+	int (*fn)(struct vfio_device *, unsigned index, unsigned start,
+		  unsigned count, bool automasked);
+
+	fn = symbol_get(vfio_external_set_automasked);
+	if (!fn)
+		return -ENXIO;
+
+	ret = fn(vdev, index, start, count, automasked);
+
+	symbol_put(vfio_external_set_automasked);
+	return ret;
+}
+
 static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
 {
 	long (*fn)(struct vfio_group *, unsigned long);
-- 
1.9.1
