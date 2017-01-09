From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:44 -0500
Subject: [RFC 48/55] KVM: arm64: Emulate TLBI instruction
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-49-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Currently, we flush ALL shadow stage-2 page tables on the tlbi
instruction execution. We may be able to do this more efficiently by
considering the vttbr_el2 value of the guest hypervisor, but leave it
for now.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/sys_regs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ddb641c..b0a057d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2013,8 +2013,14 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 static int emulate_tlbi(struct kvm_vcpu *vcpu,
 			     struct sys_reg_params *params)
 {
-	/* TODO: support tlbi instruction emulation*/
-	kvm_inject_undefined(vcpu);
+	/*
+	 * We unmap ALL stage-2 page tables on tlbi instruction.
+	 * We may make it more efficient by looking at the exact tlbi
+	 * instruction.
+	 */
+	stage2_unmap_vm(vcpu->kvm);
+	kvm_nested_s2_unmap(vcpu);
+
 	return 1;
 }
 
-- 
1.9.1
