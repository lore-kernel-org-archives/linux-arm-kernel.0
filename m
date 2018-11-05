From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  5 Nov 2018 14:36:15 +0000
Subject: [PATCH 3/4] arm64: KVM: Install stage-2 translation before enabling
 traps on VHE
In-Reply-To: <20181105143617.120602-1-marc.zyngier@arm.com>
References: <20181105143617.120602-1-marc.zyngier@arm.com>
Message-ID: <20181105143617.120602-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is a bit odd that we only install stage-2 translation after having
cleared HCR_EL2.TGE, which means that there is a window during which
AT requests could fail as stage-2 is not configured yet.

Let's move stage-2 configuration before we clear TGE, making the
guest entry sequence clearer: we first configure all the guest stuff,
then only switch to the guest translation regime.

Non-VHE doesn't have that kind of behaviour, and is left alone.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 7cc175c88a37..51d5d966d9e5 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -499,8 +499,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
-	__activate_traps(vcpu);
 	__activate_vm(vcpu->kvm);
+	__activate_traps(vcpu);
 
 	sysreg_restore_guest_state_vhe(guest_ctxt);
 	__debug_switch_to_guest(vcpu);
-- 
2.19.1
