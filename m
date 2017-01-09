From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:33 -0500
Subject: [RFC 37/55] KVM: arm64: Setup vttbr_el2 on each VM entry
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-38-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Now that the vttbr value will be different depending on the VM's
exception level, we set it on each VM entry.

We only have one mmu instance at this point, but there will be
multiple of them when we run nested VMs.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/context.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
index a93ffe4..b2c0220 100644
--- a/arch/arm64/kvm/context.c
+++ b/arch/arm64/kvm/context.c
@@ -18,6 +18,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
 #include <asm/esr.h>
+#include <asm/kvm_mmu.h>
 
 struct el1_el2_map {
 	enum vcpu_sysreg	el1;
@@ -88,6 +89,15 @@ static void create_shadow_el1_sysregs(struct kvm_vcpu *vcpu)
 	s_sys_regs[CPACR_EL1] = cptr_el2_to_cpacr_el1(el2_regs[CPTR_EL2]);
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
  * List of EL1 registers which we allow the virtual EL2 mode to access
  * directly without trapping and which haven't been paravirtualized.
@@ -166,6 +176,8 @@ void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
 	}
 
 	vgic_v2_setup_shadow_state(vcpu);
+
+	setup_s2_mmu(vcpu);
 }
 
 /**
-- 
1.9.1
