From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 21 Jun 2018 15:57:34 +0100
Subject: [RFC PATCH 10/16] KVM: arm64: Add a vcpu flag to control SVE
 visibility for the guest
In-Reply-To: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1529593060-542-11-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since SVE will be enabled or disabled on a per-vcpu basis, a flag
is needed in order to track which vcpus have it enabled.

This patch adds a suitable flag and a helper for checking it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9671ddd..609d08b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -308,6 +308,14 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
 #define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
 #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
+#define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
+
+static inline bool vcpu_has_sve(struct kvm_vcpu_arch const *vcpu_arch)
+{
+	return system_supports_sve() &&
+		(vcpu_arch->flags & KVM_ARM64_GUEST_HAS_SVE);
+
+}
 
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
 
-- 
2.1.4
