From: j.fanguede@virtualopensystems.com (=?UTF-8?q?J=C3=A9r=C3=A9my=20Fangu=C3=A8de?=)
Date: Tue,  5 May 2015 11:13:11 +0200
Subject: [RFC] ARM/ARM64: KVM: Implement KVM_FLUSH_DCACHE_GPA ioctl
Message-ID: <1430817191-6231-1-git-send-email-j.fanguede@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To maintain cache coherency on ARM, we may need a mechanism to flush
the data cache.

This patch implements KVM_FLUSH_DCACHE_GPA vm ioctl which flushes the
data cache at a specified address range. The input argument is a
struct kvm_mem_addr containing the guest physical address and the
length.

Signed-off-by: J?r?my Fangu?de <j.fanguede@virtualopensystems.com>
---
 arch/arm/kvm/arm.c       | 13 +++++++++++++
 include/uapi/linux/kvm.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d9631ec..8638fd2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -886,6 +886,19 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		return 0;
 	}
+	case KVM_FLUSH_DCACHE_GPA: {
+		struct kvm_mem_addr mem_addr;
+		hva_t hva;
+		gpa_t gpa;
+
+		if (copy_from_user(&mem_addr, argp, sizeof(mem_addr)))
+			return -EFAULT;
+
+		gpa = mem_addr.addr;
+		hva = gfn_to_hva(kvm, gpa_to_gfn(gpa)) | (gpa & ~PAGE_MASK);
+		kvm_flush_dcache_to_poc((void *)hva, mem_addr.len);
+		return 0;
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4b60056..3bc599e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -978,6 +978,11 @@ struct kvm_arm_device_addr {
 	__u64 addr;
 };
 
+struct kvm_mem_addr {
+	__u64 addr;
+	__u32 len;
+};
+
 /*
  * Device control API, available with KVM_CAP_DEVICE_CTRL
  */
@@ -1199,6 +1204,7 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_S390_IRQ_STATE */
 #define KVM_S390_SET_IRQ_STATE	  _IOW(KVMIO, 0xb5, struct kvm_s390_irq_state)
 #define KVM_S390_GET_IRQ_STATE	  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
+#define KVM_FLUSH_DCACHE_GPA     _IOW(KVMIO,  0xb7, struct kvm_mem_addr)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-- 
1.9.1
