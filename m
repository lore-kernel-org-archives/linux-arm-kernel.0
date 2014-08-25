From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 25 Aug 2014 15:27:43 +0200
Subject: [RFC 8/9] KVM: KVM-VFIO: add kvm_vfio_arch_data and accessors
In-Reply-To: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
References: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1408973264-30384-9-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a pointer to architecture specific data in kvm_vfio struct
add accessors to keep kvm_vfio private

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 arch/arm/include/asm/kvm_host.h |  8 ++++++++
 virt/kvm/vfio.c                 | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 62cbf5b..4f1edbf 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -177,6 +177,14 @@ void kvm_vfio_device_put_external_user(struct vfio_device *vdev);
 int kvm_vfio_external_get_type(struct vfio_device *vdev);
 struct device *kvm_vfio_external_get_base_device(struct vfio_device *vdev);
 
+struct kvm_vfio;
+struct kvm_vfio_arch_data;
+void kvm_vfio_device_set_arch_data(struct kvm_vfio *kv,
+				   struct kvm_vfio_arch_data *ptr);
+struct kvm_vfio_arch_data *kvm_vfio_device_get_arch_data(struct kvm_vfio *kv);
+void kvm_vfio_lock(struct kvm_vfio *kv);
+void kvm_vfio_unlock(struct kvm_vfio *kv);
+
 /* We do not have shadow page tables, hence the empty hooks */
 static inline int kvm_age_hva(struct kvm *kvm, unsigned long hva)
 {
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index f1c4e35..177b71e 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -28,6 +28,7 @@ struct kvm_vfio {
 	struct list_head group_list;
 	struct mutex lock;
 	bool noncoherent;
+	struct kvm_vfio_arch_data *arch_data;
 };
 
 static struct vfio_group *kvm_vfio_group_get_external_user(struct file *filep)
@@ -338,6 +339,26 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 type)
 	return 0;
 }
 
+void kvm_vfio_device_set_arch_data(struct kvm_vfio *kv,
+				   struct kvm_vfio_arch_data *ptr)
+{
+	kv->arch_data = ptr;
+}
+
+struct kvm_vfio_arch_data *kvm_vfio_device_get_arch_data(struct kvm_vfio *kv)
+{
+	return kv->arch_data;
+}
+
+void kvm_vfio_lock(struct kvm_vfio *kv)
+{
+	mutex_lock(&kv->lock);
+}
+
+void kvm_vfio_unlock(struct kvm_vfio *kv)
+{
+	mutex_unlock(&kv->lock);
+}
 
 struct kvm_device_ops kvm_vfio_ops = {
 	.name = "kvm-vfio",
-- 
1.9.1
