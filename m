From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:17 +0100
Subject: [PATCH 01/58] KVM: arm: Restore banked registers and physical timer
 access on hyp_panic()
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

When KVM panics, it hurridly restores the host context and parachutes
into the host's panic() code. This looks like it was copied from arm64,
the 32bit KVM panic code needs to restore the host's banked registers
too.

At some point panic() touches the physical timer/counter, this will
trap back to HYP. If we're lucky, we panic again.

Add a __timer_save_state() call to KVMs hyp_panic() path, this saves the
guest registers and disables the traps for the host.

Fixes: c36b6db5f3e4 ("ARM: KVM: Add panic handling code")
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/kvm/hyp/switch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index 92678b7bd046..c8f15bb5c8b3 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -235,8 +235,10 @@ void __hyp_text __noreturn __hyp_panic(int cause)
 
 		vcpu = (struct kvm_vcpu *)read_sysreg(HTPIDR);
 		host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+		__timer_save_state(vcpu);
 		__deactivate_traps(vcpu);
 		__deactivate_vm(vcpu);
+		__banked_restore_state(host_ctxt);
 		__sysreg_restore_state(host_ctxt);
 	}
 
-- 
2.11.0
