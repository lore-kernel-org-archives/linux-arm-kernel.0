From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:18 +0100
Subject: [PATCH 02/58] KVM: arm64: Restore host physical timer access on
 hyp_panic()
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

When KVM panics, it hurridly restores the host context and parachutes
into the host's panic() code. At some point panic() touches the physical
timer/counter. Unless we are an arm64 system with VHE, this traps back
to EL2. If we're lucky, we panic again.

Add a __timer_save_state() call to KVMs hyp_panic() path, this saves the
guest registers and disables the traps for the host.

Fixes: 53fd5b6487e4 ("arm64: KVM: Add panic handling")
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index aede1658aeda..e5f089de6526 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -422,6 +422,7 @@ void __hyp_text __noreturn __hyp_panic(void)
 
 		vcpu = (struct kvm_vcpu *)read_sysreg(tpidr_el2);
 		host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+		__timer_save_state(vcpu);
 		__deactivate_traps(vcpu);
 		__deactivate_vm(vcpu);
 		__sysreg_restore_host_state(host_ctxt);
-- 
2.11.0
