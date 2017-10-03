From: jintack.lim@linaro.org (Jintack Lim)
Date: Mon,  2 Oct 2017 22:10:49 -0500
Subject: [RFC PATCH v2 07/31] KVM: arm64: Setup vttbr_el2 on each VM entry
In-Reply-To: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
References: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1507000273-3735-5-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Now that the vttbr value will be different depending on the VM's
exception level, we set it on each VM entry.

We only have one mmu instance at this point, but there will be
multiple of them if we come to run nested VMs.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/context.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
index a7811e1..afd1702 100644
--- a/arch/arm64/kvm/context.c
+++ b/arch/arm64/kvm/context.c
@@ -18,6 +18,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
 #include <asm/esr.h>
+#include <asm/kvm_mmu.h>
 
 struct el1_el2_map {
 	enum vcpu_sysreg	el1;
@@ -174,6 +175,15 @@ static void flush_shadow_el1_sysregs(struct kvm_vcpu *vcpu)
 		flush_shadow_el1_sysregs_nvhe(vcpu);
 }
 
+static void setup_s2_mmu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s2_mmu *mmu = &vcpu->kvm->arch.mmu;
+	struct kvm_s2_vmid *vmid = vcpu_get_active_vmid(vcpu);
+
+	vcpu->arch.hw_vttbr = kvm_get_vttbr(vmid, mmu);
+	vcpu->arch.hw_mmu = mmu;
+}
+
 /*
  * List of EL0 and EL1 registers which we allow the virtual EL2 mode to access
  * directly without trapping. This is possible because the impact of
@@ -323,6 +333,8 @@ void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
 		setup_mpidr_el1(vcpu);
 		ctxt->hw_sys_regs = ctxt->sys_regs;
 	}
+
+	setup_s2_mmu(vcpu);
 }
 
 /**
-- 
1.9.1
