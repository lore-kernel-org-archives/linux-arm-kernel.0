From: florent.revest@arm.com (Florent Revest)
Date: Fri, 25 Aug 2017 09:31:41 +0100
Subject: [RFC 11/11] KVM, arm64: Don't trap internal VMs SMC calls
In-Reply-To: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
References: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
Message-ID: <1503649901-5834-12-git-send-email-florent.revest@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Internal virtual machines can be used to sandbox code such as EFI Runtime
Services. However, some implementations of those Runtime Services rely on
handlers placed in the Secure World (e.g: SoftIron Overdrive 1000) and need
access to SMC calls.

This patch modifies the Hypervisor Configuration Register to avoid trapping
SMC calls of internal virtual machines. Normal userspace VMs are not
affected by this patch.

Note: Letting Runtime Services VMs access EL3 without control can
potentially be a security threat on its own. An alternative would be to
forward SMC calls selectively from inside handle_smc. However, this would
require some level of knowledge of the SMC calls arguments and EFI
Runtime Services implementations.

Signed-off-by: Florent Revest <florent.revest@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index fe39e68..4b46cd0 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -49,6 +49,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
                vcpu->arch.hcr_el2 |= HCR_E2H;
        if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
                vcpu->arch.hcr_el2 &= ~HCR_RW;
+
+       if (!vcpu->kvm->mm)
+               vcpu->arch.hcr_el2 &= ~HCR_TSC;
 }

 static inline unsigned long vcpu_get_hcr(struct kvm_vcpu *vcpu)
--
1.9.1

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
