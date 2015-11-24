From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 18:35:30 +0100
Subject: [PULL 2/8] arm64: KVM: Fix AArch32 to AArch64 register mapping
In-Reply-To: <1448386536-30118-1-git-send-email-christoffer.dall@linaro.org>
References: <1448386536-30118-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1448386536-30118-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When running a 32bit guest under a 64bit hypervisor, the ARMv8
architecture defines a mapping of the 32bit registers in the 64bit
space. This includes banked registers that are being demultiplexed
over the 64bit ones.

On exceptions caused by an operation involving a 32bit register, the
HW exposes the register number in the ESR_EL2 register. It was so
far understood that SW had to distinguish between AArch32 and AArch64
accesses (based on the current AArch32 mode and register number).

It turns out that I misinterpreted the ARM ARM, and the clue is in
D1.20.1: "For some exceptions, the exception syndrome given in the
ESR_ELx identifies one or more register numbers from the issued
instruction that generated the exception. Where the exception is
taken from an Exception level using AArch32 these register numbers
give the AArch64 view of the register."

Which means that the HW is already giving us the translated version,
and that we shouldn't try to interpret it at all (for example, doing
an MMIO operation from the IRQ mode using the LR register leads to
very unexpected behaviours).

The fix is thus not to perform a call to vcpu_reg32() at all from
vcpu_reg(), and use whatever register number is supplied directly.
The only case we need to find out about the mapping is when we
actively generate a register access, which only occurs when injecting
a fault in a guest.

Cc: stable at vger.kernel.org
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 8 +++++---
 arch/arm64/kvm/inject_fault.c        | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 17e92f0..3ca894e 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -99,11 +99,13 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) |= COMPAT_PSR_T_BIT;
 }
 
+/*
+ * vcpu_reg should always be passed a register number coming from a
+ * read of ESR_EL2. Otherwise, it may give the wrong result on AArch32
+ * with banked registers.
+ */
 static inline unsigned long *vcpu_reg(const struct kvm_vcpu *vcpu, u8 reg_num)
 {
-	if (vcpu_mode_is_32bit(vcpu))
-		return vcpu_reg32(vcpu, reg_num);
-
 	return (unsigned long *)&vcpu_gp_regs(vcpu)->regs.regs[reg_num];
 }
 
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 85c5715..648112e 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -48,7 +48,7 @@ static void prepare_fault32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
 
 	/* Note: These now point to the banked copies */
 	*vcpu_spsr(vcpu) = new_spsr_value;
-	*vcpu_reg(vcpu, 14) = *vcpu_pc(vcpu) + return_offset;
+	*vcpu_reg32(vcpu, 14) = *vcpu_pc(vcpu) + return_offset;
 
 	/* Branch to exception vector */
 	if (sctlr & (1 << 13))
-- 
2.1.2.330.g565301e.dirty
