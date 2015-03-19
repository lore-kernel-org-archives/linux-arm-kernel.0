From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Mar 2015 15:55:46 +0100
Subject: [RFC v5 08/13] KVM: kvm-vfio: wrappers for
 vfio_external_{mask|is_active|set_automasked}
In-Reply-To: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
References: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1426776951-24901-9-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those 3 new wrapper functions call the respective VFIO external
functions.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v4: creation
---
 include/linux/vfio.h |  8 +++-----
 virt/kvm/vfio.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 7aa6330..78c1202 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -108,14 +108,12 @@ extern struct device *vfio_external_base_device(struct vfio_device *vdev);
 struct vfio_platform_device;
 extern void vfio_external_mask(struct vfio_platform_device *vdev, int index);
 /*
- * returns whether the VFIO IRQ is active:
- * true if not yet deactivated at interrupt controller level or if
- * automasked (level sensitive IRQ). Unfortunately there is no way to
- * discriminate between handler auto-masking and user-space masking
+ * returns whether the VFIO IRQ is active at interrupt controller level
+ * or VFIO-masked. Note that if the use-space masked the IRQ index it
+ * cannot be discriminated from automasked handler situation.
  */
 extern bool vfio_external_is_active(struct vfio_platform_device *vdev,
 				    int index);
-
 extern void vfio_external_set_automasked(struct vfio_platform_device *vdev,
 					 int index, bool automasked);
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 80a45e4..c995e51 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -134,6 +134,50 @@ static void kvm_vfio_put_vfio_device(struct vfio_device *vdev)
 	kvm_vfio_device_put_external_user(vdev);
 }
 
+bool kvm_vfio_external_is_active(struct vfio_platform_device *vpdev,
+				 int index)
+{
+	bool (*fn)(struct vfio_platform_device *, int index);
+	bool active;
+
+	fn = symbol_get(vfio_external_is_active);
+	if (!fn)
+		return -1;
+
+	active = fn(vpdev, index);
+
+	symbol_put(vfio_external_is_active);
+	return active;
+}
+
+void kvm_vfio_external_mask(struct vfio_platform_device *vpdev,
+			    int index)
+{
+	void (*fn)(struct vfio_platform_device *, int index);
+
+	fn = symbol_get(vfio_external_mask);
+	if (!fn)
+		return;
+
+	fn(vpdev, index);
+
+	symbol_put(vfio_external_mask);
+}
+
+void kvm_vfio_external_set_automasked(struct vfio_platform_device *vpdev,
+				      int index, bool automasked)
+{
+	void (*fn)(struct vfio_platform_device *, int index, bool automasked);
+
+	fn = symbol_get(vfio_external_set_automasked);
+	if (!fn)
+		return;
+
+	fn(vpdev, index, automasked);
+
+	symbol_put(vfio_external_set_automasked);
+}
+
 static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
 {
 	long (*fn)(struct vfio_group *, unsigned long);
-- 
1.9.1
