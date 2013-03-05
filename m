From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:04 +0000
Subject: [PATCH 10/29] ARM: KVM: abstract IL decoding away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 6 ++++++
 arch/arm/kvm/arm.c                 | 3 +--
 arch/arm/kvm/coproc.c              | 2 +-
 arch/arm/kvm/mmio.c                | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 2cbb694..bb1a25c 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -135,4 +135,10 @@ static inline int kvm_vcpu_dabt_get_as(struct kvm_vcpu *vcpu)
 	}
 }
 
+/* This one is not specific to Data Abort */
+static inline bool kvm_vcpu_trap_il_is32bit(struct kvm_vcpu *vcpu)
+{
+	return !!((kvm_vcpu_get_hsr(vcpu) >> 25) & 1);
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 6ba934b..e49a687 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -624,8 +624,7 @@ static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		 * that fail their condition code check"
 		 */
 		if (!kvm_condition_valid(vcpu)) {
-			bool is_wide = kvm_vcpu_get_hsr(vcpu) & HSR_IL;
-			kvm_skip_instr(vcpu, is_wide);
+			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 			return 1;
 		}
 
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index b305916..94eee8b 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -293,7 +293,7 @@ static int emulate_cp15(struct kvm_vcpu *vcpu,
 
 		if (likely(r->access(vcpu, params, r))) {
 			/* Skip instruction, since it was emulated */
-			kvm_skip_instr(vcpu, (kvm_vcpu_get_hsr(vcpu) >> 25) & 1);
+			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 			return 1;
 		}
 		/* If access function fails, it should complain. */
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index cd33a7e..9bd471a 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -101,7 +101,7 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * The MMIO instruction is emulated and should not be re-executed
 	 * in the guest.
 	 */
-	kvm_skip_instr(vcpu, (kvm_vcpu_get_hsr(vcpu) >> 25) & 1);
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 0;
 }
 
-- 
1.7.12.4
