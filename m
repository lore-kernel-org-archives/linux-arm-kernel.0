From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:47:08 +0200
Subject: [GIT PULL 51/51] arm64: KVM: fix 64bit CP15 VM access for 32bit guests
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-52-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Commit f0a3eaff71b8 (ARM64: KVM: fix big endian issue in
access_vm_reg for 32bit guest) changed the way we handle CP15
VM accesses, so that all 64bit accesses are done via vcpu_sys_reg.

This looks like a good idea as it solves indianness issues in an
elegant way, except for one small detail: the register index is
doesn't refer to the same array! We end up corrupting some random
data structure instead.

Fix this by reverting to the original code, except for the introduction
of a vcpu_cp15_64_high macro that deals with the endianness thing.

Tested on Juno with 32bit SMP guests.

Cc: Victor Kamensky <victor.kamensky@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h | 6 ++++--
 arch/arm64/kvm/sys_regs.c         | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 79812be..e10c45a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -149,9 +149,11 @@ struct kvm_vcpu_arch {
 #define vcpu_cp15(v,r)		((v)->arch.ctxt.copro[(r)])
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
-#define vcpu_cp15_64_low(v,r) ((v)->arch.ctxt.copro[((r) + 1)])
+#define vcpu_cp15_64_high(v,r)	vcpu_cp15((v),(r))
+#define vcpu_cp15_64_low(v,r)	vcpu_cp15((v),(r) + 1)
 #else
-#define vcpu_cp15_64_low(v,r) ((v)->arch.ctxt.copro[((r) + 0)])
+#define vcpu_cp15_64_high(v,r)	vcpu_cp15((v),(r) + 1)
+#define vcpu_cp15_64_low(v,r)	vcpu_cp15((v),(r))
 #endif
 
 struct kvm_vm_stat {
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a4fd526..5805e7c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -135,10 +135,13 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 	BUG_ON(!p->is_write);
 
 	val = *vcpu_reg(vcpu, p->Rt);
-	if (!p->is_aarch32 || !p->is_32bit)
+	if (!p->is_aarch32) {
 		vcpu_sys_reg(vcpu, r->reg) = val;
-	else
+	} else {
+		if (!p->is_32bit)
+			vcpu_cp15_64_high(vcpu, r->reg) = val >> 32;
 		vcpu_cp15_64_low(vcpu, r->reg) = val & 0xffffffffUL;
+	}
 
 	return true;
 }
-- 
2.0.0
