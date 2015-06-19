From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jun 2015 13:53:08 +0100
Subject: [PATCH 04/12] kvm: remove one useless check extension
In-Reply-To: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
References: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1434718396-13110-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tiejun Chen <tiejun.chen@intel.com>

We already check KVM_CAP_IRQFD in generic once enable CONFIG_HAVE_KVM_IRQFD,

kvm_vm_ioctl_check_extension_generic()
    |
    + switch (arg) {
    +   ...
    +   #ifdef CONFIG_HAVE_KVM_IRQFD
    +       case KVM_CAP_IRQFD:
    +   #endif
    +   ...
    +   return 1;
    +   ...
    + }
    |
    + kvm_vm_ioctl_check_extension()

So its not necessary to check this in arch again, and also fix one typo,
s/emlation/emulation.

Signed-off-by: Tiejun Chen <tiejun.chen@intel.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c       | 1 -
 include/uapi/linux/kvm.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e41cb11..7e82330 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -171,7 +171,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	int r;
 	switch (ext) {
 	case KVM_CAP_IRQCHIP:
-	case KVM_CAP_IRQFD:
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
 	case KVM_CAP_USER_MEMORY:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 75bd9f7..cbfd1ac 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -895,7 +895,7 @@ struct kvm_xen_hvm_config {
  *
  * KVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
  * the irqfd to operate in resampling mode for level triggered interrupt
- * emlation.  See Documentation/virtual/kvm/api.txt.
+ * emulation.  See Documentation/virtual/kvm/api.txt.
  */
 #define KVM_IRQFD_FLAG_RESAMPLE (1 << 1)
 
-- 
2.1.4
