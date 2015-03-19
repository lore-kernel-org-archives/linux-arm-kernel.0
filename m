From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Mar 2015 15:55:45 +0100
Subject: [RFC v5 07/13] KVM: kvm-vfio: wrappers to VFIO external API device
 helpers
In-Reply-To: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
References: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1426776951-24901-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide wrapper functions that allow KVM-VFIO device code to
interact with a vfio device:
- kvm_vfio_device_get_external_user gets a handle to a struct
  vfio_device from the vfio device file descriptor and increments
  its reference counter,
- kvm_vfio_device_put_external_user decrements the reference counter
  to a vfio device,
- kvm_vfio_external_base_device returns a handle to the struct device
  of the vfio device.

Also kvm_vfio_get_vfio_device and kvm_vfio_put_vfio_device helpers
are introduced.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v3 -> v4:
- wrappers are no more exposed in kvm_host and become kvm/vfio.c static
  functions
- added kvm_vfio_get_vfio_device/kvm_vfio_put_vfio_device in that
  patch file

v2 -> v3:
- reword the commit message and title

v1 -> v2:
- kvm_vfio_external_get_base_device renamed into
  kvm_vfio_external_base_device
- kvm_vfio_external_get_type removed
---
 virt/kvm/vfio.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 620e37f..80a45e4 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -60,6 +60,80 @@ static void kvm_vfio_group_put_external_user(struct vfio_group *vfio_group)
 	symbol_put(vfio_group_put_external_user);
 }
 
+static struct vfio_device *kvm_vfio_device_get_external_user(struct file *filep)
+{
+	struct vfio_device *vdev;
+	struct vfio_device *(*fn)(struct file *);
+
+	fn = symbol_get(vfio_device_get_external_user);
+	if (!fn)
+		return ERR_PTR(-EINVAL);
+
+	vdev = fn(filep);
+
+	symbol_put(vfio_device_get_external_user);
+
+	return vdev;
+}
+
+static void kvm_vfio_device_put_external_user(struct vfio_device *vdev)
+{
+	void (*fn)(struct vfio_device *);
+
+	fn = symbol_get(vfio_device_put_external_user);
+	if (!fn)
+		return;
+
+	fn(vdev);
+
+	symbol_put(vfio_device_put_external_user);
+}
+
+static struct device *kvm_vfio_external_base_device(struct vfio_device *vdev)
+{
+	struct device *(*fn)(struct vfio_device *);
+	struct device *dev;
+
+	fn = symbol_get(vfio_external_base_device);
+	if (!fn)
+		return NULL;
+
+	dev = fn(vdev);
+
+	symbol_put(vfio_external_base_device);
+
+	return dev;
+}
+
+/**
+ * kvm_vfio_get_vfio_device - Returns a handle to a vfio-device
+ *
+ * Checks it is a valid vfio device and increments its reference counter
+ * @fd: file descriptor of the vfio platform device
+ */
+static struct vfio_device *kvm_vfio_get_vfio_device(int fd)
+{
+	struct fd f = fdget(fd);
+	struct vfio_device *vdev;
+
+	if (!f.file)
+		return ERR_PTR(-EINVAL);
+	vdev = kvm_vfio_device_get_external_user(f.file);
+	fdput(f);
+	return vdev;
+}
+
+/**
+ * kvm_vfio_put_vfio_device: decrements the reference counter of the
+ * vfio platform * device
+ *
+ * @vdev: vfio_device handle to release
+ */
+static void kvm_vfio_put_vfio_device(struct vfio_device *vdev)
+{
+	kvm_vfio_device_put_external_user(vdev);
+}
+
 static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
 {
 	long (*fn)(struct vfio_group *, unsigned long);
-- 
1.9.1
