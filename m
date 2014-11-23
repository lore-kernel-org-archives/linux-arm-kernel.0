From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 19:35:58 +0100
Subject: [PATCH v3 6/8] KVM: kvm-vfio: wrapper to VFIO external API device
 helpers
In-Reply-To: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
References: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1416767760-14487-7-git-send-email-eric.auger@linaro.org>
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

The KVM-VFIO device uses the VFIO external API device functions.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2 -> v3:
reword the commit message and title

v1 -> v2:
- kvm_vfio_external_get_base_device renamed into
  kvm_vfio_external_base_device
- kvm_vfio_external_get_type removed
---
 arch/arm/include/asm/kvm_host.h |  5 +++++
 virt/kvm/vfio.c                 | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 53036e2..bca5b79 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -169,6 +169,11 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 
+struct vfio_device;
+struct vfio_device *kvm_vfio_device_get_external_user(struct file *filep);
+void kvm_vfio_device_put_external_user(struct vfio_device *vdev);
+struct device *kvm_vfio_external_base_device(struct vfio_device *vdev);
+
 /* We do not have shadow page tables, hence the empty hooks */
 static inline int kvm_age_hva(struct kvm *kvm, unsigned long start,
 			      unsigned long end)
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 620e37f..6f0cc34 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -60,6 +60,51 @@ static void kvm_vfio_group_put_external_user(struct vfio_group *vfio_group)
 	symbol_put(vfio_group_put_external_user);
 }
 
+struct vfio_device *kvm_vfio_device_get_external_user(struct file *filep)
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
+void kvm_vfio_device_put_external_user(struct vfio_device *vdev)
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
+struct device *kvm_vfio_external_base_device(struct vfio_device *vdev)
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
 static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
 {
 	long (*fn)(struct vfio_group *, unsigned long);
-- 
1.9.1
