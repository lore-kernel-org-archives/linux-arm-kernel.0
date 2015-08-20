From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Aug 2015 17:28:47 +0100
Subject: [PATCH 09/25] KVM: arm64: guest debug, HW assisted debug support
In-Reply-To: <1440088143-4722-1-git-send-email-marc.zyngier@arm.com>
References: <1440088143-4722-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1440088143-4722-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Benn?e <alex.bennee@linaro.org>

This adds support for userspace to control the HW debug registers for
guest debug. In the debug ioctl we copy an IMPDEF registers into a new
register set called host_debug_state.

We use the recently introduced vcpu parameter debug_ptr to select which
register set is copied into the real registers when world switch occurs.

I've made some helper functions from hw_breakpoint.c more widely
available for re-use.

As with single step we need to tweak the guest registers to enable the
exceptions so we need to save and restore those bits.

Two new capabilities have been added to the KVM_EXTENSION ioctl to allow
userspace to query the number of hardware break and watch points
available on the host hardware.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/uapi/linux/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4ab3c6a..a1e08e7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -820,6 +820,8 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_DISABLE_QUIRKS 116
 #define KVM_CAP_X86_SMM 117
 #define KVM_CAP_MULTI_ADDRESS_SPACE 118
+#define KVM_CAP_GUEST_DEBUG_HW_BPS 119
+#define KVM_CAP_GUEST_DEBUG_HW_WPS 120
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.1.4
