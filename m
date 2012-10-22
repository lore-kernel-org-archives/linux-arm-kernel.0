From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:50:36 -0400
Subject: [PATCH v3 14/14] KVM: ARM: Handle I/O aborts
In-Reply-To: <20121022064831.18444.73273.stgit@ubuntu>
References: <20121022064831.18444.73273.stgit@ubuntu>
Message-ID: <20121022065036.18444.4942.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the guest accesses I/O memory this will create data abort
exceptions and they are handled by decoding the HSR information
(physical address, read/write, length, register) and forwarding reads
and writes to QEMU which performs the device emulation.

Certain classes of load/store operations do not support the syndrome
information provided in the HSR and we therefore must be able to fetch
the offending instruction from guest memory and decode it manually.

We only support instruction decoding for valid reasonable MMIO operations
where trapping them do not provide sufficient information in the HSR (no
16-bit Thumb instructions provide register writeback that we care about).

The following instruciton types are NOT supported for MMIO operations
despite the HSR not containing decode info:
 - any Load/Store multiple
 - any load/store exclusive
 - any load/store dual
 - anything with the PC as the dest register

This requires changing the general flow somewhat since new calls to run
the VCPU must check if there's a pending MMIO load and perform the write
after userspace has made the data available.

Rusty Russell fixed a horrible race pointed out by Ben Herrenschmidt:
(1) Guest complicated mmio instruction traps.
(2) The hardware doesn't tell us enough, so we need to read the actual
    instruction which was being exectuted.
(3) KVM maps the instruction virtual address to a physical address.
(4) The guest (SMP) swaps out that page, and fills it with something else.
(5) We read the physical address, but now that's the wrong thing.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arm.h     |    3 
 arch/arm/include/asm/kvm_asm.h     |    2 
 arch/arm/include/asm/kvm_emulate.h |    8 
 arch/arm/include/asm/kvm_host.h    |    3 
 arch/arm/include/asm/kvm_mmio.h    |   51 +++
 arch/arm/kvm/Makefile              |    2 
 arch/arm/kvm/arm.c                 |   14 +
 arch/arm/kvm/emulate.c             |  581 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/interrupts.S          |   38 ++
 arch/arm/kvm/mmio.c                |  152 +++++++++
 arch/arm/kvm/mmu.c                 |    7 
 arch/arm/kvm/trace.h               |   21 +
 12 files changed, 878 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_mmio.h
 create mode 100644 arch/arm/kvm/mmio.c

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index 61d8a26..4f1bb01 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -152,8 +152,11 @@
 #define HSR_ISS		(HSR_IL - 1)
 #define HSR_ISV_SHIFT	(24)
 #define HSR_ISV		(1U << HSR_ISV_SHIFT)
+#define HSR_SRT_SHIFT	(16)
+#define HSR_SRT_MASK	(0xf << HSR_SRT_SHIFT)
 #define HSR_FSC		(0x3f)
 #define HSR_FSC_TYPE	(0x3c)
+#define HSR_SSE		(1 << 21)
 #define HSR_WNR		(1 << 6)
 #define HSR_CV_SHIFT	(24)
 #define HSR_CV		(1U << HSR_CV_SHIFT)
diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 6fccdb3..99c0faf 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -77,6 +77,8 @@ extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
+
+extern u64 __kvm_va_to_pa(struct kvm_vcpu *vcpu, u32 va, bool priv);
 #endif
 
 #endif /* __ARM_KVM_ASM_H__ */
diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index ac48156..b94863a 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -21,11 +21,14 @@
 
 #include <linux/kvm_host.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_mmio.h>
 
 u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
 u32 *vcpu_spsr(struct kvm_vcpu *vcpu);
 
 int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_emulate_mmio_ls(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			struct kvm_exit_mmio *mmio);
 void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr);
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
@@ -53,4 +56,9 @@ static inline bool vcpu_mode_priv(struct kvm_vcpu *vcpu)
 	return cpsr_mode > USR_MODE;;
 }
 
+static inline bool kvm_vcpu_reg_is_pc(struct kvm_vcpu *vcpu, int reg)
+{
+	return reg == 15;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 606e21a..2eddd96 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -99,6 +99,9 @@ struct kvm_vcpu_arch {
 	int last_pcpu;
 	cpumask_t require_dcache_flush;
 
+	/* Don't run the guest: see copy_current_insn() */
+	bool pause;
+
 	/* IO related fields */
 	struct {
 		bool sign_extend;	/* for byte/halfword loads */
diff --git a/arch/arm/include/asm/kvm_mmio.h b/arch/arm/include/asm/kvm_mmio.h
new file mode 100644
index 0000000..31ab9f5
--- /dev/null
+++ b/arch/arm/include/asm/kvm_mmio.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_MMIO_H__
+#define __ARM_KVM_MMIO_H__
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_arm.h>
+
+/*
+ * The in-kernel MMIO emulation code wants to use a copy of run->mmio,
+ * which is an anonymous type. Use our own type instead.
+ */
+struct kvm_exit_mmio {
+	phys_addr_t	phys_addr;
+	u8		data[8];
+	u32		len;
+	bool		is_write;
+};
+
+static inline void kvm_prepare_mmio(struct kvm_run *run,
+				    struct kvm_exit_mmio *mmio)
+{
+	run->mmio.phys_addr	= mmio->phys_addr;
+	run->mmio.len		= mmio->len;
+	run->mmio.is_write	= mmio->is_write;
+	memcpy(run->mmio.data, mmio->data, mmio->len);
+	run->exit_reason	= KVM_EXIT_MMIO;
+}
+
+int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		 phys_addr_t fault_ipa, struct kvm_memory_slot *memslot);
+
+#endif	/* __ARM_KVM_MMIO_H__ */
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index ea5b282..574c67c 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -19,4 +19,4 @@ obj-$(CONFIG_KVM_ARM_HOST) += init.o interrupts.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 obj-$(CONFIG_KVM_ARM_HOST) += arm.o guest.o mmu.o emulate.o reset.o
-obj-$(CONFIG_KVM_ARM_HOST) += coproc.o coproc_a15.o
+obj-$(CONFIG_KVM_ARM_HOST) += coproc.o coproc_a15.o mmio.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c547797..acdfa63 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -580,6 +580,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(vcpu->arch.target < 0))
 		return -ENOEXEC;
 
+	if (run->exit_reason == KVM_EXIT_MMIO) {
+		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
+		if (ret)
+			return ret;
+	}
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -615,7 +621,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		kvm_guest_enter();
 		vcpu->mode = IN_GUEST_MODE;
 
-		ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
+		smp_mb(); /* set mode before reading vcpu->arch.pause */
+		if (unlikely(vcpu->arch.pause)) {
+			/* This means ignore, try again. */
+			ret = ARM_EXCEPTION_IRQ;
+		} else {
+			ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
+		}
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->arch.last_pcpu = smp_processor_id();
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index 546cdaf..30124cb 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -172,6 +172,587 @@ int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+static u64 kvm_va_to_pa(struct kvm_vcpu *vcpu, u32 va, bool priv)
+{
+	return kvm_call_hyp(__kvm_va_to_pa, vcpu, va, priv);
+}
+
+/**
+ * copy_from_guest_va - copy memory from guest (very slow!)
+ * @vcpu:	vcpu pointer
+ * @dest:	memory to copy into
+ * @gva:	virtual address in guest to copy from
+ * @len:	length to copy
+ * @priv:	use guest PL1 (ie. kernel) mappings
+ *              otherwise use guest PL0 mappings.
+ *
+ * Returns true on success, false on failure (unlikely, but retry).
+ */
+static bool copy_from_guest_va(struct kvm_vcpu *vcpu,
+			       void *dest, unsigned long gva, size_t len,
+			       bool priv)
+{
+	u64 par;
+	phys_addr_t pc_ipa;
+	int err;
+
+	BUG_ON((gva & PAGE_MASK) != ((gva + len) & PAGE_MASK));
+	par = kvm_va_to_pa(vcpu, gva & PAGE_MASK, priv);
+	if (par & 1) {
+		kvm_err("IO abort from invalid instruction address"
+			" %#lx!\n", gva);
+		return false;
+	}
+
+	BUG_ON(!(par & (1U << 11)));
+	pc_ipa = par & PAGE_MASK & ((1ULL << 32) - 1);
+	pc_ipa += gva & ~PAGE_MASK;
+
+
+	err = kvm_read_guest(vcpu->kvm, pc_ipa, dest, len);
+	if (unlikely(err))
+		return false;
+
+	return true;
+}
+
+/* Just ensure we're not running the guest. */
+static void do_nothing(void *info)
+{
+}
+
+/*
+ * We have to be very careful copying memory from a running (ie. SMP) guest.
+ * Another CPU may remap the page (eg. swap out a userspace text page) as we
+ * read the instruction.  Unlike normal hardware operation, to emulate an
+ * instruction we map the virtual to physical address then read that memory
+ * as separate steps, thus not atomic.
+ *
+ * Fortunately this is so rare (we don't usually need the instruction), we
+ * can go very slowly and noone will mind.
+ */
+static bool copy_current_insn(struct kvm_vcpu *vcpu, unsigned long *instr)
+{
+	int i;
+	bool ret;
+	struct kvm_vcpu *v;
+	bool is_thumb;
+	size_t instr_len;
+
+	/* Don't cross with IPIs in kvm_main.c */
+	spin_lock(&vcpu->kvm->mmu_lock);
+
+	/* Tell them all to pause, so no more will enter guest. */
+	kvm_for_each_vcpu(i, v, vcpu->kvm)
+		v->arch.pause = true;
+
+	/* Set ->pause before we read ->mode */
+	smp_mb();
+
+	/* Kick out any which are still running. */
+	kvm_for_each_vcpu(i, v, vcpu->kvm) {
+		/* Guest could exit now, making cpu wrong. That's OK. */
+		if (kvm_vcpu_exiting_guest_mode(v) == IN_GUEST_MODE)
+			smp_call_function_single(v->cpu, do_nothing, NULL, 1);
+	}
+
+
+	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_T_BIT);
+	instr_len = (is_thumb) ? 2 : 4;
+
+	BUG_ON(!is_thumb && *vcpu_pc(vcpu) & 0x3);
+
+	/* Now guest isn't running, we can va->pa map and copy atomically. */
+	ret = copy_from_guest_va(vcpu, instr, *vcpu_pc(vcpu), instr_len,
+				 vcpu_mode_priv(vcpu));
+	if (!ret)
+		goto out;
+
+	/* A 32-bit thumb2 instruction can actually go over a page boundary! */
+	if (is_thumb && is_wide_instruction(*instr)) {
+		*instr = *instr << 16;
+		ret = copy_from_guest_va(vcpu, instr, *vcpu_pc(vcpu) + 2, 2,
+					 vcpu_mode_priv(vcpu));
+	}
+
+out:
+	/* Release them all. */
+	kvm_for_each_vcpu(i, v, vcpu->kvm)
+		v->arch.pause = false;
+
+	spin_unlock(&vcpu->kvm->mmu_lock);
+
+	return ret;
+}
+
+/******************************************************************************
+ * Load-Store instruction emulation
+ *****************************************************************************/
+
+struct arm_instr {
+	/* Instruction decoding */
+	u32 opc;
+	u32 opc_mask;
+
+	/* Decoding for the register write back */
+	bool register_form;
+	u32 imm;
+	u8 Rm;
+	u8 type;
+	u8 shift_n;
+
+	/* Common decoding */
+	u8 len;
+	bool sign_extend;
+	bool w;
+
+	bool (*decode)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+		       unsigned long instr, struct arm_instr *ai);
+};
+
+enum SRType {
+	SRType_LSL,
+	SRType_LSR,
+	SRType_ASR,
+	SRType_ROR,
+	SRType_RRX
+};
+
+/* Modelled after DecodeImmShift() in the ARM ARM */
+enum SRType decode_imm_shift(u8 type, u8 imm5, u8 *amount)
+{
+	switch (type) {
+	case 0x0:
+		*amount = imm5;
+		return SRType_LSL;
+	case 0x1:
+		*amount = (imm5 == 0) ? 32 : imm5;
+		return SRType_LSR;
+	case 0x2:
+		*amount = (imm5 == 0) ? 32 : imm5;
+		return SRType_ASR; 
+	case 0x3:
+		if (imm5 == 0) {
+			*amount = 1;
+			return SRType_RRX;
+		} else {
+			*amount = imm5;
+			return SRType_ROR;
+		}
+	}
+
+	return SRType_LSL;
+}
+
+/* Modelled after Shift() in the ARM ARM */
+u32 shift(u32 value, u8 N, enum SRType type, u8 amount, bool carry_in)
+{
+	u32 mask = (1 << N) - 1;
+	s32 svalue = (s32)value;
+
+	BUG_ON(N > 32);
+	BUG_ON(type == SRType_RRX && amount != 1);
+	BUG_ON(amount > N);
+
+	if (amount == 0)
+		return value;
+
+	switch (type) {
+	case SRType_LSL:
+		value <<= amount;
+		break;
+	case SRType_LSR:
+		 value >>= amount;
+		break;
+	case SRType_ASR:
+		if (value & (1 << (N - 1)))
+			svalue |= ((-1UL) << N);
+		value = svalue >> amount;
+		break;
+	case SRType_ROR:
+		value = (value >> amount) | (value << (N - amount));
+		break;
+	case SRType_RRX: {
+		u32 C = (carry_in) ? 1 : 0;
+		value = (value >> 1) | (C << (N - 1));
+		break;
+	}
+	}
+
+	return value & mask;
+}
+
+static bool decode_arm_wb(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			  unsigned long instr, const struct arm_instr *ai)
+{
+	u8 Rt = (instr >> 12) & 0xf;
+	u8 Rn = (instr >> 16) & 0xf;
+	u8 W = (instr >> 21) & 1;
+	u8 U = (instr >> 23) & 1;
+	u8 P = (instr >> 24) & 1;
+	u32 base_addr = *vcpu_reg(vcpu, Rn);
+	u32 offset_addr, offset;
+
+	/*
+	 * Technically this is allowed in certain circumstances,
+	 * but we don't support it.
+	 */
+	if (Rt == 15 || Rn == 15)
+		return false;
+
+	if (P && !W) {
+		kvm_err("Decoding operation with valid ISV?\n");
+		return false;
+	}
+
+	vcpu->arch.mmio.rd = Rt;
+
+	if (ai->register_form) {
+		/* Register operation */
+		enum SRType s_type;
+		u8 shift_n;
+		bool c_bit = *vcpu_cpsr(vcpu) & PSR_C_BIT;
+		u32 s_reg = *vcpu_reg(vcpu, ai->Rm);
+
+		s_type = decode_imm_shift(ai->type, ai->shift_n, &shift_n);
+		offset = shift(s_reg, 5, s_type, shift_n, c_bit);
+	} else {
+		/* Immediate operation */
+		offset = ai->imm;
+	}
+
+	/* Handle Writeback */
+	if (U)
+		offset_addr = base_addr + offset;
+	else
+		offset_addr = base_addr - offset;
+	*vcpu_reg(vcpu, Rn) = offset_addr;
+	return true;
+}
+
+static bool decode_arm_ls(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			  unsigned long instr, struct arm_instr *ai)
+{
+	u8 A = (instr >> 25) & 1;
+
+	mmio->is_write = ai->w;
+	mmio->len = ai->len;
+	vcpu->arch.mmio.sign_extend = false;
+
+	ai->register_form = A;
+	ai->imm = instr & 0xfff;
+	ai->Rm = instr & 0xf;
+	ai->type = (instr >> 5) & 0x3;
+	ai->shift_n = (instr >> 7) & 0x1f;
+
+	return decode_arm_wb(vcpu, mmio, instr, ai);
+}
+
+static bool decode_arm_extra(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			     unsigned long instr, struct arm_instr *ai)
+{
+	mmio->is_write = ai->w;
+	mmio->len = ai->len;
+	vcpu->arch.mmio.sign_extend = ai->sign_extend;
+
+	ai->register_form = !((instr >> 22) & 1);
+	ai->imm = ((instr >> 4) & 0xf0) | (instr & 0xf);
+	ai->Rm = instr & 0xf;
+	ai->type = 0; /* SRType_LSL */
+	ai->shift_n = 0;
+
+	return decode_arm_wb(vcpu, mmio, instr, ai);
+}
+
+/*
+ * The encodings in this table assumes that a fault was generated where the
+ * ISV field in the HSR was clear, and the decoding information was invalid,
+ * which means that a register write-back occurred, the PC was used as the
+ * destination or a load/store multiple operation was used. Since the latter
+ * two cases are crazy for MMIO on the guest side, we simply inject a fault
+ * when this happens and support the common case.
+ *
+ * We treat unpriviledged loads and stores of words and bytes like all other
+ * loads and stores as their encodings mandate the W bit set and the P bit
+ * clear.
+ */
+static const struct arm_instr arm_instr[] = {
+	/**************** Load/Store Word and Byte **********************/
+	/* Store word with writeback */
+	{ .opc = 0x04000000, .opc_mask = 0x0c500000, .len = 4, .w = true,
+		.sign_extend = false, .decode = decode_arm_ls },
+	/* Store byte with writeback */
+	{ .opc = 0x04400000, .opc_mask = 0x0c500000, .len = 1, .w = true,
+		.sign_extend = false, .decode = decode_arm_ls },
+	/* Load word with writeback */
+	{ .opc = 0x04100000, .opc_mask = 0x0c500000, .len = 4, .w = false,
+		.sign_extend = false, .decode = decode_arm_ls },
+	/* Load byte with writeback */
+	{ .opc = 0x04500000, .opc_mask = 0x0c500000, .len = 1, .w = false,
+		.sign_extend = false, .decode = decode_arm_ls },
+
+	/*************** Extra load/store instructions ******************/
+
+	/* Store halfword with writeback */
+	{ .opc = 0x000000b0, .opc_mask = 0x0c1000f0, .len = 2, .w = true,
+		.sign_extend = false, .decode = decode_arm_extra },
+	/* Load halfword with writeback */
+	{ .opc = 0x001000b0, .opc_mask = 0x0c1000f0, .len = 2, .w = false,
+		.sign_extend = false, .decode = decode_arm_extra },
+
+	/* Load dual with writeback */
+	{ .opc = 0x000000d0, .opc_mask = 0x0c1000f0, .len = 8, .w = false,
+		.sign_extend = false, .decode = decode_arm_extra },
+	/* Load signed byte with writeback */
+	{ .opc = 0x001000d0, .opc_mask = 0x0c1000f0, .len = 1, .w = false,
+		.sign_extend = true,  .decode = decode_arm_extra },
+
+	/* Store dual with writeback */
+	{ .opc = 0x000000f0, .opc_mask = 0x0c1000f0, .len = 8, .w = true,
+		.sign_extend = false, .decode = decode_arm_extra },
+	/* Load signed halfword with writeback */
+	{ .opc = 0x001000f0, .opc_mask = 0x0c1000f0, .len = 2, .w = false,
+		.sign_extend = true,  .decode = decode_arm_extra },
+
+	/* Store halfword unprivileged */
+	{ .opc = 0x002000b0, .opc_mask = 0x0f3000f0, .len = 2, .w = true,
+		.sign_extend = false, .decode = decode_arm_extra },
+	/* Load halfword unprivileged */
+	{ .opc = 0x003000b0, .opc_mask = 0x0f3000f0, .len = 2, .w = false,
+		.sign_extend = false, .decode = decode_arm_extra },
+	/* Load signed byte unprivileged */
+	{ .opc = 0x003000d0, .opc_mask = 0x0f3000f0, .len = 1, .w = false,
+		.sign_extend = true , .decode = decode_arm_extra },
+	/* Load signed halfword unprivileged */
+	{ .opc = 0x003000d0, .opc_mask = 0x0f3000f0, .len = 2, .w = false,
+		.sign_extend = true , .decode = decode_arm_extra },
+};
+
+static bool kvm_decode_arm_ls(struct kvm_vcpu *vcpu, unsigned long instr,
+			      struct kvm_exit_mmio *mmio)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(arm_instr); i++) {
+		const struct arm_instr *ai = &arm_instr[i];
+		if ((instr & ai->opc_mask) == ai->opc) {
+			struct arm_instr ai_copy = *ai;
+			return ai->decode(vcpu, mmio, instr, &ai_copy);
+		}
+	}
+	return false;
+}
+
+struct thumb_instr {
+	bool is32;
+
+	union {
+		struct {
+			u8 opcode;
+			u8 mask;
+		} t16;
+
+		struct {
+			u8 op1;
+			u8 op2;
+			u8 op2_mask;
+		} t32;
+	};
+
+	bool (*decode)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+		       unsigned long instr, const struct thumb_instr *ti);
+};
+
+static bool decode_thumb_wb(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			    unsigned long instr)
+{
+	bool P = (instr >> 10) & 1;
+	bool U = (instr >> 9) & 1;
+	u8 imm8 = instr & 0xff;
+	u32 offset_addr = vcpu->arch.hxfar;
+	u8 Rn = (instr >> 16) & 0xf;
+
+	vcpu->arch.mmio.rd = (instr >> 12) & 0xf;
+
+	if (kvm_vcpu_reg_is_pc(vcpu, Rn))
+		return false;
+
+	/* Handle Writeback */
+	if (!P && U)
+		*vcpu_reg(vcpu, Rn) = offset_addr + imm8;
+	else if (!P && !U)
+		*vcpu_reg(vcpu, Rn) = offset_addr - imm8;
+	return true;
+}
+
+static bool decode_thumb_str(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			     unsigned long instr, const struct thumb_instr *ti)
+{
+	u8 op1 = (instr >> (16 + 5)) & 0x7;
+	u8 op2 = (instr >> 6) & 0x3f;
+
+	mmio->is_write = true;
+	vcpu->arch.mmio.sign_extend = false;
+
+	switch (op1) {
+	case 0x0: mmio->len = 1; break;
+	case 0x1: mmio->len = 2; break;
+	case 0x2: mmio->len = 4; break;
+	default:
+		  return false; /* Only register write-back versions! */
+	}
+
+	if ((op2 & 0x24) == 0x24) {
+		/* STRB (immediate, thumb, W=1) */
+		return decode_thumb_wb(vcpu, mmio, instr);
+	}
+
+	return false;
+}
+
+static bool decode_thumb_ldr(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			     unsigned long instr, const struct thumb_instr *ti)
+{
+	u8 op1 = (instr >> (16 + 7)) & 0x3;
+	u8 op2 = (instr >> 6) & 0x3f;
+
+	mmio->is_write = false;
+
+	switch (ti->t32.op2 & 0x7) {
+	case 0x1: mmio->len = 1; break;
+	case 0x3: mmio->len = 2; break;
+	case 0x5: mmio->len = 4; break;
+	}
+
+	if (op1 == 0x0)
+		vcpu->arch.mmio.sign_extend = false;
+	else if (op1 == 0x2 && (ti->t32.op2 & 0x7) != 0x5)
+		vcpu->arch.mmio.sign_extend = true;
+	else
+		return false; /* Only register write-back versions! */
+
+	if ((op2 & 0x24) == 0x24) {
+		/* LDR{S}X (immediate, thumb, W=1) */
+		return decode_thumb_wb(vcpu, mmio, instr);
+	}
+
+	return false;
+}
+
+/*
+ * We only support instruction decoding for valid reasonable MMIO operations
+ * where trapping them do not provide sufficient information in the HSR (no
+ * 16-bit Thumb instructions provide register writeback that we care about).
+ *
+ * The following instruciton types are NOT supported for MMIO operations
+ * despite the HSR not containing decode info:
+ *  - any Load/Store multiple
+ *  - any load/store exclusive
+ *  - any load/store dual
+ *  - anything with the PC as the dest register
+ */
+static const struct thumb_instr thumb_instr[] = {
+	/**************** 32-bit Thumb instructions **********************/
+	/* Store single data item:	Op1 == 11, Op2 == 000xxx0 */
+	{ .is32 = true,  .t32 = { 3, 0x00, 0x71}, decode_thumb_str	},
+	/* Load byte:			Op1 == 11, Op2 == 00xx001 */
+	{ .is32 = true,  .t32 = { 3, 0x01, 0x67}, decode_thumb_ldr	},
+	/* Load halfword:		Op1 == 11, Op2 == 00xx011 */
+	{ .is32 = true,  .t32 = { 3, 0x03, 0x67}, decode_thumb_ldr	},
+	/* Load word:			Op1 == 11, Op2 == 00xx101 */
+	{ .is32 = true,  .t32 = { 3, 0x05, 0x67}, decode_thumb_ldr	},
+};
+
+
+
+static bool kvm_decode_thumb_ls(struct kvm_vcpu *vcpu, unsigned long instr,
+				struct kvm_exit_mmio *mmio)
+{
+	bool is32 = is_wide_instruction(instr);
+	bool is16 = !is32;
+	struct thumb_instr tinstr; /* re-use to pass on already decoded info */
+	int i;
+
+	if (is16) {
+		tinstr.t16.opcode = (instr >> 10) & 0x3f;
+	} else {
+		tinstr.t32.op1 = (instr >> (16 + 11)) & 0x3;
+		tinstr.t32.op2 = (instr >> (16 + 4)) & 0x7f;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(thumb_instr); i++) {
+		const struct thumb_instr *ti = &thumb_instr[i];
+		if (ti->is32 != is32)
+			continue;
+
+		if (is16) {
+			if ((tinstr.t16.opcode & ti->t16.mask) != ti->t16.opcode)
+				continue;
+		} else {
+			if (ti->t32.op1 != tinstr.t32.op1)
+				continue;
+			if ((ti->t32.op2_mask & tinstr.t32.op2) != ti->t32.op2)
+				continue;
+		}
+
+		return ti->decode(vcpu, mmio, instr, &tinstr);
+	}
+
+	return false;
+}
+
+/**
+ * kvm_emulate_mmio_ls - emulates load/store instructions made to I/O memory
+ * @vcpu:	The vcpu pointer
+ * @fault_ipa:	The IPA that caused the 2nd stage fault
+ * @mmio:      Pointer to struct to hold decode information
+ *
+ * Some load/store instructions cannot be emulated using the information
+ * presented in the HSR, for instance, register write-back instructions are not
+ * supported. We therefore need to fetch the instruction, decode it, and then
+ * emulate its behavior.
+ *
+ * Handles emulation of load/store instructions which cannot be emulated through
+ * information found in the HSR on faults. It is necessary in this case to
+ * simply decode the offending instruction in software and determine the
+ * required operands.
+ */
+int kvm_emulate_mmio_ls(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			struct kvm_exit_mmio *mmio)
+{
+	bool is_thumb;
+	unsigned long instr = 0;
+
+	trace_kvm_mmio_emulate(*vcpu_pc(vcpu), instr, *vcpu_cpsr(vcpu));
+
+	/* If it fails (SMP race?), we reenter guest for it to retry. */
+	if (!copy_current_insn(vcpu, &instr))
+		return 1;
+
+	mmio->phys_addr = fault_ipa;
+	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_T_BIT);
+	if (!is_thumb && !kvm_decode_arm_ls(vcpu, instr, mmio)) {
+		kvm_debug("Unable to decode inst: %#08lx (cpsr: %#08x (T=0)"
+			  "pc: %#08x)\n",
+			  instr, *vcpu_cpsr(vcpu), *vcpu_pc(vcpu));
+		kvm_inject_dabt(vcpu, vcpu->arch.hxfar);
+		return 1;
+	} else if (is_thumb && !kvm_decode_thumb_ls(vcpu, instr, mmio)) {
+		kvm_debug("Unable to decode inst: %#08lx (cpsr: %#08x (T=1)"
+			  "pc: %#08x)\n",
+			  instr, *vcpu_cpsr(vcpu), *vcpu_pc(vcpu));
+		kvm_inject_dabt(vcpu, vcpu->arch.hxfar);
+		return 1;
+	}
+
+	/*
+	 * The MMIO instruction is emulated and should not be re-executed
+	 * in the guest.
+	 */
+	kvm_skip_instr(vcpu, is_wide_instruction(instr));
+	return 0;
+}
+
 /**
  * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
  * @vcpu:	The VCPU pointer
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index d79f1d4..7c89708 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -188,6 +188,44 @@ after_vfp_restore:
 	clrex				@ Clear exclusive monitor
 	bx	lr			@ return to IOCTL
 
+
+/********************************************************************
+ * Translate VA to PA
+ *
+ * u64 __kvm_va_to_pa(struct kvm_vcpu *vcpu, u32 va, bool priv)
+ *
+ * Arguments:
+ *  r0: pointer to vcpu struct
+ *  r1: virtual address to map (rounded to page)
+ *  r2: 1 = P1 (read) mapping, 0 = P0 (read) mapping.
+ * Returns 64 bit PAR value.
+ */
+ENTRY(__kvm_va_to_pa)
+	push	{r4-r12}
+
+	@ Fold flag into r1, easier than using stack.
+	cmp	r2, #0
+	movne	r2, #1
+	orr	r1, r1, r2
+
+	@ This swaps too many registers, but we're in the slow path anyway.
+	read_cp15_state
+	write_cp15_state 1, r0
+
+	ands	r2, r1, #1
+	bic	r1, r1, r2
+	mcrne	p15, 0, r1, c7, c8, 0	@ VA to PA, ATS1CPR
+	mcreq	p15, 0, r1, c7, c8, 2	@ VA to PA, ATS1CUR
+	isb
+
+	@ Restore host state.
+	read_cp15_state 1, r0
+	write_cp15_state
+
+	mrrc	p15, 0, r0, r1, c7	@ PAR
+	pop	{r4-r12}
+	bx	lr
+
 ENTRY(kvm_call_hyp)
 	hvc	#0
 	bx	lr
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
new file mode 100644
index 0000000..28bd5eb
--- /dev/null
+++ b/arch/arm/kvm/mmio.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <asm/kvm_mmio.h>
+#include <asm/kvm_emulate.h>
+#include <trace/events/kvm.h>
+
+#include "trace.h"
+
+/**
+ * kvm_handle_mmio_return -- Handle MMIO loads after user space emulation
+ * @vcpu: The VCPU pointer
+ * @run:  The VCPU run struct containing the mmio data
+ *
+ * This should only be called after returning from userspace for MMIO load
+ * emulation.
+ */
+int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	__u32 *dest;
+	unsigned int len;
+	int mask;
+
+	if (!run->mmio.is_write) {
+		dest = vcpu_reg(vcpu, vcpu->arch.mmio.rd);
+		memset(dest, 0, sizeof(int));
+
+		len = run->mmio.len;
+		if (len > 4)
+			return -EINVAL;
+
+		memcpy(dest, run->mmio.data, len);
+
+		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
+				*((u64 *)run->mmio.data));
+
+		if (vcpu->arch.mmio.sign_extend && len < 4) {
+			mask = 1U << ((len * 8) - 1);
+			*dest = (*dest ^ mask) - mask;
+		}
+	}
+
+	return 0;
+}
+
+static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+		      struct kvm_exit_mmio *mmio)
+{
+	unsigned long rd, len;
+	bool is_write, sign_extend;
+
+	if ((vcpu->arch.hsr >> 8) & 1) {
+		/* cache operation on I/O addr, tell guest unsupported */
+		kvm_inject_dabt(vcpu, vcpu->arch.hxfar);
+		return 1;
+	}
+
+	if ((vcpu->arch.hsr >> 7) & 1) {
+		/* page table accesses IO mem: tell guest to fix its TTBR */
+		kvm_inject_dabt(vcpu, vcpu->arch.hxfar);
+		return 1;
+	}
+
+	switch ((vcpu->arch.hsr >> 22) & 0x3) {
+	case 0:
+		len = 1;
+		break;
+	case 1:
+		len = 2;
+		break;
+	case 2:
+		len = 4;
+		break;
+	default:
+		kvm_err("Hardware is weird: SAS 0b11 is reserved\n");
+		return -EFAULT;
+	}
+
+	is_write = vcpu->arch.hsr & HSR_WNR;
+	sign_extend = vcpu->arch.hsr & HSR_SSE;
+	rd = (vcpu->arch.hsr & HSR_SRT_MASK) >> HSR_SRT_SHIFT;
+
+	if (kvm_vcpu_reg_is_pc(vcpu, rd)) {
+		/* IO memory trying to read/write pc */
+		kvm_inject_pabt(vcpu, vcpu->arch.hxfar);
+		return 1;
+	}
+
+	mmio->is_write = is_write;
+	mmio->phys_addr = fault_ipa;
+	mmio->len = len;
+	vcpu->arch.mmio.sign_extend = sign_extend;
+	vcpu->arch.mmio.rd = rd;
+
+	/*
+	 * The MMIO instruction is emulated and should not be re-executed
+	 * in the guest.
+	 */
+	kvm_skip_instr(vcpu, (vcpu->arch.hsr >> 25) & 1);
+	return 0;
+}
+
+int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		 phys_addr_t fault_ipa, struct kvm_memory_slot *memslot)
+{
+	struct kvm_exit_mmio mmio;
+	unsigned long rd;
+	int ret;
+
+	/*
+	 * Prepare MMIO operation. First stash it in a private
+	 * structure that we can use for in-kernel emulation. If the
+	 * kernel can't handle it, copy it into run->mmio and let user
+	 * space do its magic.
+	 */
+
+	if (vcpu->arch.hsr & HSR_ISV)
+		ret = decode_hsr(vcpu, fault_ipa, &mmio);
+	else
+		ret = kvm_emulate_mmio_ls(vcpu, fault_ipa, &mmio);
+
+	if (ret != 0)
+		return ret;
+
+	rd = vcpu->arch.mmio.rd;
+	trace_kvm_mmio((mmio.is_write) ? KVM_TRACE_MMIO_WRITE :
+					 KVM_TRACE_MMIO_READ_UNSATISFIED,
+			mmio.len, fault_ipa,
+			(mmio.is_write) ? *vcpu_reg(vcpu, rd) : 0);
+
+	if (mmio.is_write)
+		memcpy(mmio.data, vcpu_reg(vcpu, rd), mmio.len);
+
+	kvm_prepare_mmio(run, &mmio);
+	return 0;
+}
+
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 9e2230d..cb03d45 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -19,11 +19,13 @@
 #include <linux/mman.h>
 #include <linux/kvm_host.h>
 #include <linux/io.h>
+#include <trace/events/kvm.h>
 #include <asm/idmap.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_mmio.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/mach/map.h>
@@ -636,8 +638,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			return -EFAULT;
 		}
 
-		kvm_pr_unimpl("I/O address abort...");
-		return 0;
+		/* Adjust page offset */
+		fault_ipa |= vcpu->arch.hxfar & ~PAGE_MASK;
+		return io_mem_abort(vcpu, run, fault_ipa, memslot);
 	}
 
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index e2a9d2e..c3d05f4 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -90,6 +90,27 @@ TRACE_EVENT(kvm_irq_line,
 		  __entry->type, __entry->vcpu_idx, __entry->irq_num, __entry->level)
 );
 
+TRACE_EVENT(kvm_mmio_emulate,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long instr,
+		 unsigned long cpsr),
+	TP_ARGS(vcpu_pc, instr, cpsr),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+		__field(	unsigned long,	instr		)
+		__field(	unsigned long,	cpsr		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+		__entry->instr			= instr;
+		__entry->cpsr			= cpsr;
+	),
+
+	TP_printk("Emulate MMIO at: 0x%08lx (instr: %08lx, cpsr: %08lx)",
+		  __entry->vcpu_pc, __entry->instr, __entry->cpsr)
+);
+
 /* Architecturally implementation defined CP15 register access */
 TRACE_EVENT(kvm_emulate_cp15_imp,
 	TP_PROTO(unsigned long Op1, unsigned long Rt1, unsigned long CRn,
