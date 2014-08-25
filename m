From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 25 Aug 2014 15:27:41 +0200
Subject: [RFC 6/9] KVM: KVM-VFIO: allow arch specific implementation
In-Reply-To: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
References: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1408973264-30384-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

introduce a new option __KVM_HAVE_ARCH_KVM_VFIO option.
When set the generic KVM-VFIO code calls architecture dependent
code.

the architecture dependent hooks are
- kvm_arch_vfio_has_attr
- kvm_arch_vfio_set_attr
- kvm_arch_vfio_init
- kvm_arch_vfio_destroy

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 include/linux/kvm_host.h | 30 ++++++++++++++++++++++++++++++
 virt/kvm/vfio.c          |  9 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a4c33b3..c4ce4af 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1075,6 +1075,36 @@ extern struct kvm_device_ops kvm_vfio_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 extern struct kvm_device_ops kvm_flic_ops;
 
+#ifdef __KVM_HAVE_ARCH_KVM_VFIO
+
+int kvm_arch_vfio_has_attr(struct kvm_device *dev,
+			   struct kvm_device_attr *attr);
+int kvm_arch_vfio_set_attr(struct kvm_device *dev,
+			   struct kvm_device_attr *attr);
+int kvm_arch_vfio_init(struct kvm_device *dev);
+
+void kvm_arch_vfio_destroy(struct kvm_device *dev);
+
+#else
+static inline int kvm_arch_vfio_has_attr(struct kvm_device *dev,
+				  struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+static inline int kvm_arch_vfio_set_attr(struct kvm_device *dev,
+				  struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+static inline int kvm_arch_vfio_init(struct kvm_device *dev)
+{
+	return 0;
+}
+static inline void kvm_arch_vfio_destroy(struct kvm_device *dev)
+{
+}
+#endif
+
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
 static inline void kvm_vcpu_set_in_spin_loop(struct kvm_vcpu *vcpu, bool val)
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index ba1a93f..89d3b75 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -207,6 +207,8 @@ static int kvm_vfio_set_attr(struct kvm_device *dev,
 	switch (attr->group) {
 	case KVM_DEV_VFIO_GROUP:
 		return kvm_vfio_set_group(dev, attr->attr, attr->addr);
+	default:
+		return kvm_arch_vfio_set_attr(dev, attr);
 	}
 
 	return -ENXIO;
@@ -224,6 +226,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 		}
 
 		break;
+
+	default:
+		kvm_arch_vfio_has_attr(dev, attr);
 	}
 
 	return -ENXIO;
@@ -234,6 +239,8 @@ static void kvm_vfio_destroy(struct kvm_device *dev)
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_group *kvg, *tmp;
 
+	kvm_arch_vfio_destroy(dev);
+
 	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
 		kvm_vfio_group_put_external_user(kvg->vfio_group);
 		list_del(&kvg->node);
@@ -265,6 +272,8 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 type)
 
 	dev->private = kv;
 
+	kvm_arch_vfio_init(dev);
+
 	return 0;
 }
 
-- 
1.9.1
