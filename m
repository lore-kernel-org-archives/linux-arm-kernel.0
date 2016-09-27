From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:41 +0200
Subject: [PULL 33/50] arm/arm64: KVM: Inject virtual abort when guest exits on
 external abort
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-34-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

If we spot a data abort bearing the ESR_EL2.EA bit set, we know that
this is an external abort, and that should be punished by the injection
of an abort.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 344755d..60e0c1a 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1432,6 +1432,11 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int ret, idx;
 
 	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
+	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu))) {
+		kvm_inject_vabt(vcpu);
+		return 1;
+	}
+
 	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
-- 
2.9.0
