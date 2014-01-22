From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jan 2014 14:56:34 +0000
Subject: [PATCH v2 02/10] arm64: KVM: allows discrimination of AArch32 sysreg
 access
In-Reply-To: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
References: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1390402602-22777-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current handling of AArch32 trapping is slightly less than
perfect, as it is not possible (from a handler point of view)
to distinguish it from an AArch64 access, nor to tell a 32bit
from a 64bit access either.

Fix this by introducing two additional flags:
- is_aarch32: true if the access was made in AArch32 mode
- is_32bit: true if is_aarch32 == true and a MCR/MRC instruction
  was used to perform the access (as opposed to MCRR/MRRC).

This allows a handler to cover all the possible conditions in which
a system register gets trapped.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 5 +++++
 arch/arm64/kvm/sys_regs.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 02e9d09..f063750 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -437,6 +437,8 @@ int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	u32 hsr = kvm_vcpu_get_hsr(vcpu);
 	int Rt2 = (hsr >> 10) & 0xf;
 
+	params.is_aarch32 = true;
+	params.is_32bit = false;
 	params.CRm = (hsr >> 1) & 0xf;
 	params.Rt = (hsr >> 5) & 0xf;
 	params.is_write = ((hsr & 1) == 0);
@@ -480,6 +482,8 @@ int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	struct sys_reg_params params;
 	u32 hsr = kvm_vcpu_get_hsr(vcpu);
 
+	params.is_aarch32 = true;
+	params.is_32bit = true;
 	params.CRm = (hsr >> 1) & 0xf;
 	params.Rt  = (hsr >> 5) & 0xf;
 	params.is_write = ((hsr & 1) == 0);
@@ -549,6 +553,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	struct sys_reg_params params;
 	unsigned long esr = kvm_vcpu_get_hsr(vcpu);
 
+	params.is_aarch32 = false;
 	params.Op0 = (esr >> 20) & 3;
 	params.Op1 = (esr >> 14) & 0x7;
 	params.CRn = (esr >> 10) & 0xf;
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index d50d372..d411e25 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -30,6 +30,8 @@ struct sys_reg_params {
 	u8	Op2;
 	u8	Rt;
 	bool	is_write;
+	bool	is_aarch32;
+	bool	is_32bit;	/* Only valid if is_aarch32 is true */
 };
 
 struct sys_reg_desc {
-- 
1.8.3.4
