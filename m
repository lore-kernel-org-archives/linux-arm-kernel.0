From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:51 -0500
Subject: [RFC 55/55] KVM: arm64: Enable nested virtualization
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-56-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that everything is ready, we enable nested virtualization by setting
the HCR NV and NV1 bit.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/include/asm/kvm_arm.h | 1 +
 arch/arm64/kvm/hyp/switch.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index f9addf3..ab8b93b 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -24,6 +24,7 @@
 
 /* Hyp Configuration Register (HCR) bits */
 #define HCR_NV1		(UL(1) << 43)
+#define HCR_NV		(UL(1) << 42)
 #define HCR_E2H		(UL(1) << 34)
 #define HCR_ID		(UL(1) << 33)
 #define HCR_CD		(UL(1) << 32)
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index c80b2ae..df7b88d 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -87,7 +87,7 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 		isb();
 	}
 	if (vcpu_mode_el2(vcpu))
-		val |= HCR_TVM | HCR_TRVM;
+		val |= HCR_TVM | HCR_TRVM | HCR_NV | HCR_NV1;
 	write_sysreg(val, hcr_el2);
 	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
 	write_sysreg(1 << 15, hstr_el2);
-- 
1.9.1
