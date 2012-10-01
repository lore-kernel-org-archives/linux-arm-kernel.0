From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:11:39 -0400
Subject: [PATCH v2 14/14] KVM: ARM: Handle I/O aborts
In-Reply-To: <20121001090945.49198.68950.stgit@ubuntu>
References: <20121001090945.49198.68950.stgit@ubuntu>
Message-ID: <20121001091139.49198.76744.stgit@ubuntu>
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

Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arm.h     |    3 
 arch/arm/include/asm/kvm_asm.h     |    2 
 arch/arm/include/asm/kvm_emulate.h |   22 ++
 arch/arm/include/asm/kvm_host.h    |    3 
 arch/arm/include/asm/kvm_mmu.h     |    1 
 arch/arm/kvm/arm.c                 |   14 +
 arch/arm/kvm/emulate.c             |  444 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/interrupts.S          |   41 +++
 arch/arm/kvm/mmu.c                 |  266 +++++++++++++++++++++-
 arch/arm/kvm/trace.h               |   21 ++
 10 files changed, 814 insertions(+), 3 deletions(-)

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
index 10e6bea..c954ff7 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -24,8 +24,30 @@
 
 u32 *vcpu_reg_mode(struct kvm_vcpu *vcpu, u8 reg_num, u32 cpsr);
 u32 *vcpu_spsr_mode(struct kvm_vcpu *vcpu, u32 cpsr);
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
 
 int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_emulate_mmio_ls(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			unsigned long instr, struct kvm_exit_mmio *mmio);
 void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr);
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 914f7eb..e4b5352 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -95,6 +95,9 @@ struct kvm_vcpu_arch {
 	int last_pcpu;
 	cpumask_t require_dcache_flush;
 
+	/* Don't run the guest: see copy_current_insn() */
+	bool pause;
+
 	/* IO related fields */
 	struct {
 		bool sign_extend;	/* for byte/halfword loads */
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 9bd0508..ecfaaf0 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -38,6 +38,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 			  phys_addr_t pa, unsigned long size);
 
+int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 07a47a5..50e9585 100644
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
 
-		ret = __kvm_vcpu_run(vcpu);
+		smp_mb(); /* set mode before reading vcpu->arch.pause */
+		if (unlikely(vcpu->arch.pause)) {
+			/* This means ignore, try again. */
+			ret = ARM_EXCEPTION_IRQ;
+		} else {
+			ret = __kvm_vcpu_run(vcpu);
+		}
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->arch.last_pcpu = smp_processor_id();
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index 8a0aa30..2a3c9798 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -206,6 +206,450 @@ int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+
+/******************************************************************************
+ * Load-Store instruction emulation
+ *****************************************************************************/
+
+/*
+ * This one accepts a matrix where the first element is the
+ * bits as they must be, and the second element is the bitmask.
+ */
+#define INSTR_NONE	-1
+static int kvm_instr_index(u32 instr, u32 table[][2], int table_entries)
+{
+	int i;
+	u32 mask;
+
+	for (i = 0; i < table_entries; i++) {
+		mask = table[i][1];
+		if ((table[i][0] & mask) == (instr & mask))
+			return i;
+	}
+	return INSTR_NONE;
+}
+
+/*
+ * Must be ordered with LOADS first and WRITES afterwards
+ * for easy distinction when doing MMIO.
+ */
+#define NUM_LD_INSTR  9
+enum INSTR_LS_INDEXES {
+	INSTR_LS_LDRBT, INSTR_LS_LDRT, INSTR_LS_LDR, INSTR_LS_LDRB,
+	INSTR_LS_LDRD, INSTR_LS_LDREX, INSTR_LS_LDRH, INSTR_LS_LDRSB,
+	INSTR_LS_LDRSH,
+	INSTR_LS_STRBT, INSTR_LS_STRT, INSTR_LS_STR, INSTR_LS_STRB,
+	INSTR_LS_STRD, INSTR_LS_STREX, INSTR_LS_STRH,
+	NUM_LS_INSTR
+};
+
+static u32 ls_instr[NUM_LS_INSTR][2] = {
+	{0x04700000, 0x0d700000}, /* LDRBT */
+	{0x04300000, 0x0d700000}, /* LDRT  */
+	{0x04100000, 0x0c500000}, /* LDR   */
+	{0x04500000, 0x0c500000}, /* LDRB  */
+	{0x000000d0, 0x0e1000f0}, /* LDRD  */
+	{0x01900090, 0x0ff000f0}, /* LDREX */
+	{0x001000b0, 0x0e1000f0}, /* LDRH  */
+	{0x001000d0, 0x0e1000f0}, /* LDRSB */
+	{0x001000f0, 0x0e1000f0}, /* LDRSH */
+	{0x04600000, 0x0d700000}, /* STRBT */
+	{0x04200000, 0x0d700000}, /* STRT  */
+	{0x04000000, 0x0c500000}, /* STR   */
+	{0x04400000, 0x0c500000}, /* STRB  */
+	{0x000000f0, 0x0e1000f0}, /* STRD  */
+	{0x01800090, 0x0ff000f0}, /* STREX */
+	{0x000000b0, 0x0e1000f0}  /* STRH  */
+};
+
+static inline int get_arm_ls_instr_index(u32 instr)
+{
+	return kvm_instr_index(instr, ls_instr, NUM_LS_INSTR);
+}
+
+/*
+ * Load-Store instruction decoding
+ */
+#define INSTR_LS_TYPE_BIT		26
+#define INSTR_LS_RD_MASK		0x0000f000
+#define INSTR_LS_RD_SHIFT		12
+#define INSTR_LS_RN_MASK		0x000f0000
+#define INSTR_LS_RN_SHIFT		16
+#define INSTR_LS_RM_MASK		0x0000000f
+#define INSTR_LS_OFFSET12_MASK		0x00000fff
+
+#define INSTR_LS_BIT_P			24
+#define INSTR_LS_BIT_U			23
+#define INSTR_LS_BIT_B			22
+#define INSTR_LS_BIT_W			21
+#define INSTR_LS_BIT_L			20
+#define INSTR_LS_BIT_S			 6
+#define INSTR_LS_BIT_H			 5
+
+/*
+ * ARM addressing mode defines
+ */
+#define OFFSET_IMM_MASK			0x0e000000
+#define OFFSET_IMM_VALUE		0x04000000
+#define OFFSET_REG_MASK			0x0e000ff0
+#define OFFSET_REG_VALUE		0x06000000
+#define OFFSET_SCALE_MASK		0x0e000010
+#define OFFSET_SCALE_VALUE		0x06000000
+
+#define SCALE_SHIFT_MASK		0x000000a0
+#define SCALE_SHIFT_SHIFT		5
+#define SCALE_SHIFT_LSL			0x0
+#define SCALE_SHIFT_LSR			0x1
+#define SCALE_SHIFT_ASR			0x2
+#define SCALE_SHIFT_ROR_RRX		0x3
+#define SCALE_SHIFT_IMM_MASK		0x00000f80
+#define SCALE_SHIFT_IMM_SHIFT		6
+
+#define PSR_BIT_C			29
+
+static unsigned long ls_word_calc_offset(struct kvm_vcpu *vcpu,
+					 unsigned long instr)
+{
+	int offset = 0;
+
+	if ((instr & OFFSET_IMM_MASK) == OFFSET_IMM_VALUE) {
+		/* Immediate offset/index */
+		offset = instr & INSTR_LS_OFFSET12_MASK;
+
+		if (!(instr & (1U << INSTR_LS_BIT_U)))
+			offset = -offset;
+	}
+
+	if ((instr & OFFSET_REG_MASK) == OFFSET_REG_VALUE) {
+		/* Register offset/index */
+		u8 rm = instr & INSTR_LS_RM_MASK;
+		offset = *vcpu_reg(vcpu, rm);
+
+		if (!(instr & (1U << INSTR_LS_BIT_P)))
+			offset = 0;
+	}
+
+	if ((instr & OFFSET_SCALE_MASK) == OFFSET_SCALE_VALUE) {
+		/* Scaled register offset */
+		u8 rm = instr & INSTR_LS_RM_MASK;
+		u8 shift = (instr & SCALE_SHIFT_MASK) >> SCALE_SHIFT_SHIFT;
+		u32 shift_imm = (instr & SCALE_SHIFT_IMM_MASK)
+				>> SCALE_SHIFT_IMM_SHIFT;
+		offset = *vcpu_reg(vcpu, rm);
+
+		switch (shift) {
+		case SCALE_SHIFT_LSL:
+			offset = offset << shift_imm;
+			break;
+		case SCALE_SHIFT_LSR:
+			if (shift_imm == 0)
+				offset = 0;
+			else
+				offset = ((u32)offset) >> shift_imm;
+			break;
+		case SCALE_SHIFT_ASR:
+			if (shift_imm == 0) {
+				if (offset & (1U << 31))
+					offset = 0xffffffff;
+				else
+					offset = 0;
+			} else {
+				/* Ensure arithmetic shift */
+				asm("mov %[r], %[op], ASR %[s]" :
+				    [r] "=r" (offset) :
+				    [op] "r" (offset), [s] "r" (shift_imm));
+			}
+			break;
+		case SCALE_SHIFT_ROR_RRX:
+			if (shift_imm == 0) {
+				u32 C = (vcpu->arch.regs.cpsr &
+						(1U << PSR_BIT_C));
+				offset = (C << 31) | offset >> 1;
+			} else {
+				/* Ensure arithmetic shift */
+				asm("mov %[r], %[op], ASR %[s]" :
+				    [r] "=r" (offset) :
+				    [op] "r" (offset), [s] "r" (shift_imm));
+			}
+			break;
+		}
+
+		if (instr & (1U << INSTR_LS_BIT_U))
+			return offset;
+		else
+			return -offset;
+	}
+
+	if (instr & (1U << INSTR_LS_BIT_U))
+		return offset;
+	else
+		return -offset;
+
+	BUG();
+}
+
+static int kvm_ls_length(struct kvm_vcpu *vcpu, u32 instr)
+{
+	int index;
+
+	index = get_arm_ls_instr_index(instr);
+
+	if (instr & (1U << INSTR_LS_TYPE_BIT)) {
+		/* LS word or unsigned byte */
+		if (instr & (1U << INSTR_LS_BIT_B))
+			return sizeof(unsigned char);
+		else
+			return sizeof(u32);
+	} else {
+		/* LS halfword, doubleword or signed byte */
+		u32 H = (instr & (1U << INSTR_LS_BIT_H));
+		u32 S = (instr & (1U << INSTR_LS_BIT_S));
+		u32 L = (instr & (1U << INSTR_LS_BIT_L));
+
+		if (!L && S) {
+			kvm_err("WARNING: d-word for MMIO\n");
+			return 2 * sizeof(u32);
+		} else if (L && S && !H)
+			return sizeof(char);
+		else
+			return sizeof(u16);
+	}
+
+	BUG();
+}
+
+static bool kvm_decode_arm_ls(struct kvm_vcpu *vcpu, unsigned long instr,
+			      struct kvm_exit_mmio *mmio)
+{
+	int index;
+	bool is_write;
+	unsigned long rd, rn, offset, len;
+
+	index = get_arm_ls_instr_index(instr);
+	if (index == INSTR_NONE)
+		return false;
+
+	is_write = (index < NUM_LD_INSTR) ? false : true;
+	rd = (instr & INSTR_LS_RD_MASK) >> INSTR_LS_RD_SHIFT;
+	len = kvm_ls_length(vcpu, instr);
+
+	mmio->is_write = is_write;
+	mmio->len = len;
+
+	vcpu->arch.mmio.sign_extend = false;
+	vcpu->arch.mmio.rd = rd;
+
+	/* Handle base register writeback */
+	if (!(instr & (1U << INSTR_LS_BIT_P)) ||
+	     (instr & (1U << INSTR_LS_BIT_W))) {
+		rn = (instr & INSTR_LS_RN_MASK) >> INSTR_LS_RN_SHIFT;
+		offset = ls_word_calc_offset(vcpu, instr);
+		*vcpu_reg(vcpu, rn) += offset;
+	}
+
+	return true;
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
+	u32 offset_addr = vcpu->arch.hdfar;
+	u8 Rn = (instr >> 16) & 0xf;
+
+	vcpu->arch.mmio.rd = (instr >> 12) & 0xf;
+
+	if (Rn == 15)
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
+ * @instr:	The instruction that caused the fault
+ *
+ * Handles emulation of load/store instructions which cannot be emulated through
+ * information found in the HSR on faults. It is necessary in this case to
+ * simply decode the offending instruction in software and determine the
+ * required operands.
+ */
+int kvm_emulate_mmio_ls(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			unsigned long instr, struct kvm_exit_mmio *mmio)
+{
+	bool is_thumb;
+
+	trace_kvm_mmio_emulate(vcpu->arch.regs.pc, instr, vcpu->arch.regs.cpsr);
+
+	mmio->phys_addr = fault_ipa;
+	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_T_BIT);
+	if (!is_thumb && !kvm_decode_arm_ls(vcpu, instr, mmio)) {
+		kvm_debug("Unable to decode inst: %#08lx (cpsr: %#08x (T=0)"
+			  "pc: %#08x)\n",
+			  instr, *vcpu_cpsr(vcpu), *vcpu_pc(vcpu));
+		kvm_inject_dabt(vcpu, vcpu->arch.hdfar);
+		return 1;
+	} else if (is_thumb && !kvm_decode_thumb_ls(vcpu, instr, mmio)) {
+		kvm_debug("Unable to decode inst: %#08lx (cpsr: %#08x (T=1)"
+			  "pc: %#08x)\n",
+			  instr, *vcpu_cpsr(vcpu), *vcpu_pc(vcpu));
+		kvm_inject_dabt(vcpu, vcpu->arch.hdfar);
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
index 8ee1cc6..90347d2 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -237,6 +237,47 @@ after_vfp_restore:
 	bx	lr			@ return to IOCTL
 
 /********************************************************************
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
+	hvc	#0			@ switch to hyp-mode
+
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
+	hvc	#0			@ Back to SVC
+	bx	lr
+
+
+/********************************************************************
  * Hypervisor exception vector and handlers
  *
  *
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 15ca732..0ab6ea3 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -19,6 +19,7 @@
 #include <linux/mman.h>
 #include <linux/kvm_host.h>
 #include <linux/io.h>
+#include <trace/events/kvm.h>
 #include <asm/idmap.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
@@ -574,6 +575,266 @@ out_unlock:
 }
 
 /**
+ * kvm_handle_mmio_return -- Handle MMIO loads after user space emulation
+ * @vcpu: The VCPU pointer
+ * @run:  The VCPU run struct containing the mmio data
+ *
+ * This should only be called after returning from userspace for MMIO load
+ * emulation.
+ */
+int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	int *dest;
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
+	par = __kvm_va_to_pa(vcpu, gva & PAGE_MASK, priv);
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
+	BUG_ON(!is_thumb && vcpu->arch.regs.pc & 0x3);
+
+	/* Now guest isn't running, we can va->pa map and copy atomically. */
+	ret = copy_from_guest_va(vcpu, instr, vcpu->arch.regs.pc, instr_len,
+				 vcpu_mode_priv(vcpu));
+	if (!ret)
+		goto out;
+
+	/* A 32-bit thumb2 instruction can actually go over a page boundary! */
+	if (is_thumb && is_wide_instruction(*instr)) {
+		*instr = *instr << 16;
+		ret = copy_from_guest_va(vcpu, instr, vcpu->arch.regs.pc + 2, 2,
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
+/**
+ * invalid_io_mem_abort -- Handle I/O aborts ISV bit is clear
+ *
+ * @vcpu:      The vcpu pointer
+ * @fault_ipa: The IPA that caused the 2nd stage fault
+ * @mmio:      Pointer to struct to hold decode information
+ *
+ * Some load/store instructions cannot be emulated using the information
+ * presented in the HSR, for instance, register write-back instructions are not
+ * supported. We therefore need to fetch the instruction, decode it, and then
+ * emulate its behavior.
+ */
+static int invalid_io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+				struct kvm_exit_mmio *mmio)
+{
+	unsigned long instr = 0;
+
+	/* If it fails (SMP race?), we reenter guest for it to retry. */
+	if (!copy_current_insn(vcpu, &instr))
+		return 1;
+
+	return kvm_emulate_mmio_ls(vcpu, fault_ipa, instr, mmio);
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
+		kvm_inject_dabt(vcpu, vcpu->arch.hdfar);
+		return 1;
+	}
+
+	if ((vcpu->arch.hsr >> 7) & 1) {
+		/* page table accesses IO mem: tell guest to fix its TTBR */
+		kvm_inject_dabt(vcpu, vcpu->arch.hdfar);
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
+	if (rd == 15) {
+		/* IO memory trying to read/write pc */
+		kvm_inject_pabt(vcpu, vcpu->arch.hdfar);
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
+static int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
+			phys_addr_t fault_ipa, struct kvm_memory_slot *memslot)
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
+		ret = invalid_io_mem_abort(vcpu, fault_ipa, &mmio);
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
+/**
  * kvm_handle_guest_abort - handles all 2nd stage aborts
  * @vcpu:	the VCPU pointer
  * @run:	the kvm_run structure
@@ -624,8 +885,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			return -EFAULT;
 		}
 
-		kvm_pr_unimpl("I/O address abort...");
-		return 0;
+		/* Adjust page offset */
+		fault_ipa |= vcpu->arch.hdfar & ~PAGE_MASK;
+		return io_mem_abort(vcpu, run, fault_ipa, memslot);
 	}
 
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index e088c78..67a2598 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -92,6 +92,27 @@ TRACE_EVENT(kvm_irq_line,
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
