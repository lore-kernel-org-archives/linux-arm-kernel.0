From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 30 Sep 2012 13:47:39 -0400
Subject: [PATCH 10/15] KVM: ARM: World-switch implementation
In-Reply-To: <20120925170031.GF28728@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153533.21241.82489.stgit@ubuntu>
 <20120925170031.GF28728@mudshark.cambridge.arm.com>
Message-ID: <CANM98qL=s0jDWhcH9ktaFnc5fEEZfX+Ujx9-HqXDhQkRt+onLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 1:00 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Sep 15, 2012 at 04:35:33PM +0100, Christoffer Dall wrote:
>> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
>> index 1429d89..cd8fc86 100644
>> --- a/arch/arm/kernel/asm-offsets.c
>> +++ b/arch/arm/kernel/asm-offsets.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/mm.h>
>>  #include <linux/dma-mapping.h>
>> +#include <linux/kvm_host.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm/glue-df.h>
>>  #include <asm/glue-pf.h>
>> @@ -144,5 +145,48 @@ int main(void)
>>    DEFINE(DMA_BIDIRECTIONAL,    DMA_BIDIRECTIONAL);
>>    DEFINE(DMA_TO_DEVICE,                DMA_TO_DEVICE);
>>    DEFINE(DMA_FROM_DEVICE,      DMA_FROM_DEVICE);
>> +#ifdef CONFIG_KVM_ARM_HOST
>> +  DEFINE(VCPU_KVM,             offsetof(struct kvm_vcpu, kvm));
>> +  DEFINE(VCPU_MIDR,            offsetof(struct kvm_vcpu, arch.midr));
>> +  DEFINE(VCPU_MPIDR,           offsetof(struct kvm_vcpu, arch.cp15[c0_MPIDR]));
>> +  DEFINE(VCPU_CSSELR,          offsetof(struct kvm_vcpu, arch.cp15[c0_CSSELR]));
>> +  DEFINE(VCPU_SCTLR,           offsetof(struct kvm_vcpu, arch.cp15[c1_SCTLR]));
>> +  DEFINE(VCPU_CPACR,           offsetof(struct kvm_vcpu, arch.cp15[c1_CPACR]));
>> +  DEFINE(VCPU_TTBR0,           offsetof(struct kvm_vcpu, arch.cp15[c2_TTBR0]));
>> +  DEFINE(VCPU_TTBR1,           offsetof(struct kvm_vcpu, arch.cp15[c2_TTBR1]));
>> +  DEFINE(VCPU_TTBCR,           offsetof(struct kvm_vcpu, arch.cp15[c2_TTBCR]));
>> +  DEFINE(VCPU_DACR,            offsetof(struct kvm_vcpu, arch.cp15[c3_DACR]));
>> +  DEFINE(VCPU_DFSR,            offsetof(struct kvm_vcpu, arch.cp15[c5_DFSR]));
>> +  DEFINE(VCPU_IFSR,            offsetof(struct kvm_vcpu, arch.cp15[c5_IFSR]));
>> +  DEFINE(VCPU_ADFSR,           offsetof(struct kvm_vcpu, arch.cp15[c5_ADFSR]));
>> +  DEFINE(VCPU_AIFSR,           offsetof(struct kvm_vcpu, arch.cp15[c5_AIFSR]));
>> +  DEFINE(VCPU_DFAR,            offsetof(struct kvm_vcpu, arch.cp15[c6_DFAR]));
>> +  DEFINE(VCPU_IFAR,            offsetof(struct kvm_vcpu, arch.cp15[c6_IFAR]));
>> +  DEFINE(VCPU_PRRR,            offsetof(struct kvm_vcpu, arch.cp15[c10_PRRR]));
>> +  DEFINE(VCPU_NMRR,            offsetof(struct kvm_vcpu, arch.cp15[c10_NMRR]));
>> +  DEFINE(VCPU_VBAR,            offsetof(struct kvm_vcpu, arch.cp15[c12_VBAR]));
>> +  DEFINE(VCPU_CID,             offsetof(struct kvm_vcpu, arch.cp15[c13_CID]));
>> +  DEFINE(VCPU_TID_URW,         offsetof(struct kvm_vcpu, arch.cp15[c13_TID_URW]));
>> +  DEFINE(VCPU_TID_URO,         offsetof(struct kvm_vcpu, arch.cp15[c13_TID_URO]));
>> +  DEFINE(VCPU_TID_PRIV,                offsetof(struct kvm_vcpu, arch.cp15[c13_TID_PRIV]));
>
> Could you instead define an offset for arch.cp15, then use scaled offsets
> from that in the assembly code?
>

that would require changing the enum in kvm_host.h to defines and
either wrap that whole file in #ifndef __ASSEMBLY__ or move those
defines to kvm_asm.h, not sure which I think is the most pretty:

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 5315c69..99c0faf 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -19,6 +19,34 @@
 #ifndef __ARM_KVM_ASM_H__
 #define __ARM_KVM_ASM_H__

+/* 0 is reserved as an invalid value. */
+#define c0_MPIDR	1	/* MultiProcessor ID Register */
+#define c0_CSSELR	2	/* Cache Size Selection Register */
+#define c1_SCTLR	3	/* System Control Register */
+#define c1_ACTLR	4	/* Auxilliary Control Register */
+#define c1_CPACR	5	/* Coprocessor Access Control */
+#define c2_TTBR0	6	/* Translation Table Base Register 0 */
+#define c2_TTBR0_high	7	/* TTBR0 top 32 bits */
+#define c2_TTBR1	8	/* Translation Table Base Register 1 */
+#define c2_TTBR1_high	9	/* TTBR1 top 32 bits */
+#define c2_TTBCR	10	/* Translation Table Base Control R. */
+#define c3_DACR		11	/* Domain Access Control Register */
+#define c5_DFSR		12	/* Data Fault Status Register */
+#define c5_IFSR		13	/* Instruction Fault Status Register */
+#define c5_ADFSR	14	/* Auxilary Data Fault Status R */
+#define c5_AIFSR	15	/* Auxilary Instrunction Fault Status R */
+#define c6_DFAR		16	/* Data Fault Address Register */
+#define c6_IFAR		17	/* Instruction Fault Address Register */
+#define c9_L2CTLR	18	/* Cortex A15 L2 Control Register */
+#define c10_PRRR	19	/* Primary Region Remap Register */
+#define c10_NMRR	20	/* Normal Memory Remap Register */
+#define c12_VBAR	21	/* Vector Base Address Register */
+#define c13_CID		22	/* Context ID Register */
+#define c13_TID_URW	23	/* Thread ID, User R/W */
+#define c13_TID_URO	24	/* Thread ID, User R/O */
+#define c13_TID_PRIV	25	/* Thread ID, Priveleged */
+#define NR_CP15_REGS	26	/* Number of regs (incl. invalid) */
+
 #define ARM_EXCEPTION_RESET	  0
 #define ARM_EXCEPTION_UNDEFINED   1
 #define ARM_EXCEPTION_SOFTWARE    2
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 9c4fbd4..f9b2ca6 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -21,6 +21,7 @@

 #include <asm/kvm.h>
 #include <asm/fpstate.h>
+#include <asm/kvm_asm.h>

 #define KVM_MAX_VCPUS NR_CPUS
 #define KVM_MEMORY_SLOTS 32
@@ -73,37 +74,6 @@ struct kvm_mmu_memory_cache {
 	void *objects[KVM_NR_MEM_OBJS];
 };

-/* 0 is reserved as an invalid value. */
-enum cp15_regs {
-	c0_MPIDR=1,		/* MultiProcessor ID Register */
-	c0_CSSELR,		/* Cache Size Selection Register */
-	c1_SCTLR,		/* System Control Register */
-	c1_ACTLR,		/* Auxilliary Control Register */
-	c1_CPACR,		/* Coprocessor Access Control */
-	c2_TTBR0,		/* Translation Table Base Register 0 */
-	c2_TTBR0_high,		/* TTBR0 top 32 bits */
-	c2_TTBR1,		/* Translation Table Base Register 1 */
-	c2_TTBR1_high,		/* TTBR1 top 32 bits */
-	c2_TTBCR,		/* Translation Table Base Control R. */
-	c3_DACR,		/* Domain Access Control Register */
-	c5_DFSR,		/* Data Fault Status Register */
-	c5_IFSR,		/* Instruction Fault Status Register */
-	c5_ADFSR,		/* Auxilary Data Fault Status Register */
-	c5_AIFSR,		/* Auxilary Instruction Fault Status Register */
-	c6_DFAR,		/* Data Fault Address Register */
-	c6_IFAR,		/* Instruction Fault Address Register */
-	c9_L2CTLR,		/* Cortex A15 L2 Control Register */
-	c10_PRRR,		/* Primary Region Remap Register */
-	c10_NMRR,		/* Normal Memory Remap Register */
-	c12_VBAR,		/* Vector Base Address Register */
-	c13_CID,		/* Context ID Register */
-	c13_TID_URW,		/* Thread ID, User R/W */
-	c13_TID_URO,		/* Thread ID, User R/O */
-	c13_TID_PRIV,		/* Thread ID, Priveleged */
-
-	nr_cp15_regs
-};
-
 struct kvm_vcpu_arch {
 	struct kvm_regs regs;

@@ -111,7 +81,7 @@ struct kvm_vcpu_arch {
 	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);

 	/* System control coprocessor (cp15) */
-	u32 cp15[nr_cp15_regs];
+	u32 cp15[NR_CP15_REGS];

 	/* The CPU type we expose to the VM */
 	u32 midr;
@@ -203,4 +173,5 @@ unsigned long kvm_arm_num_coproc_regs(struct
kvm_vcpu *vcpu);
 struct kvm_one_reg;
 int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index cf0b50e..1c4181e 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -148,27 +148,7 @@ int main(void)
 #ifdef CONFIG_KVM_ARM_HOST
   DEFINE(VCPU_KVM,		offsetof(struct kvm_vcpu, kvm));
   DEFINE(VCPU_MIDR,		offsetof(struct kvm_vcpu, arch.midr));
-  DEFINE(VCPU_MPIDR,		offsetof(struct kvm_vcpu, arch.cp15[c0_MPIDR]));
-  DEFINE(VCPU_CSSELR,		offsetof(struct kvm_vcpu, arch.cp15[c0_CSSELR]));
-  DEFINE(VCPU_SCTLR,		offsetof(struct kvm_vcpu, arch.cp15[c1_SCTLR]));
-  DEFINE(VCPU_CPACR,		offsetof(struct kvm_vcpu, arch.cp15[c1_CPACR]));
-  DEFINE(VCPU_TTBR0,		offsetof(struct kvm_vcpu, arch.cp15[c2_TTBR0]));
-  DEFINE(VCPU_TTBR1,		offsetof(struct kvm_vcpu, arch.cp15[c2_TTBR1]));
-  DEFINE(VCPU_TTBCR,		offsetof(struct kvm_vcpu, arch.cp15[c2_TTBCR]));
-  DEFINE(VCPU_DACR,		offsetof(struct kvm_vcpu, arch.cp15[c3_DACR]));
-  DEFINE(VCPU_DFSR,		offsetof(struct kvm_vcpu, arch.cp15[c5_DFSR]));
-  DEFINE(VCPU_IFSR,		offsetof(struct kvm_vcpu, arch.cp15[c5_IFSR]));
-  DEFINE(VCPU_ADFSR,		offsetof(struct kvm_vcpu, arch.cp15[c5_ADFSR]));
-  DEFINE(VCPU_AIFSR,		offsetof(struct kvm_vcpu, arch.cp15[c5_AIFSR]));
-  DEFINE(VCPU_DFAR,		offsetof(struct kvm_vcpu, arch.cp15[c6_DFAR]));
-  DEFINE(VCPU_IFAR,		offsetof(struct kvm_vcpu, arch.cp15[c6_IFAR]));
-  DEFINE(VCPU_PRRR,		offsetof(struct kvm_vcpu, arch.cp15[c10_PRRR]));
-  DEFINE(VCPU_NMRR,		offsetof(struct kvm_vcpu, arch.cp15[c10_NMRR]));
-  DEFINE(VCPU_VBAR,		offsetof(struct kvm_vcpu, arch.cp15[c12_VBAR]));
-  DEFINE(VCPU_CID,		offsetof(struct kvm_vcpu, arch.cp15[c13_CID]));
-  DEFINE(VCPU_TID_URW,		offsetof(struct kvm_vcpu, arch.cp15[c13_TID_URW]));
-  DEFINE(VCPU_TID_URO,		offsetof(struct kvm_vcpu, arch.cp15[c13_TID_URO]));
-  DEFINE(VCPU_TID_PRIV,		offsetof(struct kvm_vcpu, arch.cp15[c13_TID_PRIV]));
+  DEFINE(VCPU_CP15,		offsetof(struct kvm_vcpu, arch.cp15));
   DEFINE(VCPU_VFP_GUEST,	offsetof(struct kvm_vcpu, arch.vfp_guest));
   DEFINE(VCPU_VFP_HOST,		offsetof(struct kvm_vcpu, arch.vfp_host));
   DEFINE(VCPU_REGS,		offsetof(struct kvm_vcpu, arch.regs));
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 15977a6..759396a 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -61,7 +61,7 @@ struct coproc_reg {
 	void (*reset)(struct kvm_vcpu *, const struct coproc_reg *);

 	/* Index into vcpu->arch.cp15[], or 0 if we don't need to save it. */
-	enum cp15_regs reg;
+	unsigned long reg;

 	/* Value (usually reset value) */
 	u64 val;
@@ -1097,7 +1097,7 @@ void kvm_reset_coprocs(struct kvm_vcpu *vcpu)
 	table = get_target_table(vcpu->arch.target, &num);
 	reset_coproc_regs(vcpu, table, num);

-	for (num = 1; num < nr_cp15_regs; num++)
+	for (num = 1; num < NR_CP15_REGS; num++)
 		if (vcpu->arch.cp15[num] == 0x42424242)
 			panic("Didn't reset vcpu->arch.cp15[%zi]", num);
 }
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index f32e2f7..2839afa 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -29,6 +29,7 @@
 #define VCPU_USR_SP		(VCPU_USR_REG(13))
 #define VCPU_FIQ_REG(_reg_nr)	(VCPU_FIQ_REGS + (_reg_nr * 4))
 #define VCPU_FIQ_SPSR		(VCPU_FIQ_REG(7))
+#define CP15_OFFSET(_cp15_reg_idx) (VCPU_CP15 + (_cp15_reg_idx * 4))

 	.text
 	.align	PAGE_SHIFT
@@ -202,18 +203,18 @@ ENDPROC(__kvm_flush_vm_context)
 	.if \vcpu == 0
 	push	{r2-r12}		@ Push CP15 registers
 	.else
-	str	r2, [\vcpup, #VCPU_SCTLR]
-	str	r3, [\vcpup, #VCPU_CPACR]
-	str	r4, [\vcpup, #VCPU_TTBCR]
-	str	r5, [\vcpup, #VCPU_DACR]
-	add	\vcpup, \vcpup, #VCPU_TTBR0
+	str	r2, [\vcpup, #CP15_OFFSET(c1_SCTLR)]
+	str	r3, [\vcpup, #CP15_OFFSET(c1_CPACR)]
+	str	r4, [\vcpup, #CP15_OFFSET(c2_TTBCR)]
+	str	r5, [\vcpup, #CP15_OFFSET(c3_DACR)]
+	add	\vcpup, \vcpup, #CP15_OFFSET(c2_TTBR0)
 	strd	r6, r7, [\vcpup]
-	add	\vcpup, \vcpup, #(VCPU_TTBR1 - VCPU_TTBR0)
+	add	\vcpup, \vcpup, #CP15_OFFSET(c2_TTBR1) - CP15_OFFSET(c2_TTBR0)
 	strd	r8, r9, [\vcpup]
-	sub	\vcpup, \vcpup, #(VCPU_TTBR1)
-	str	r10, [\vcpup, #VCPU_PRRR]
-	str	r11, [\vcpup, #VCPU_NMRR]
-	str	r12, [\vcpup, #VCPU_CSSELR]
+	sub	\vcpup, \vcpup, #CP15_OFFSET(c2_TTBR1)
+	str	r10, [\vcpup, #CP15_OFFSET(c10_PRRR)]
+	str	r11, [\vcpup, #CP15_OFFSET(c10_NMRR)]
+	str	r12, [\vcpup, #CP15_OFFSET(c0_CSSELR)]
 	.endif

 	mrc	p15, 0, r2, c13, c0, 1	@ CID
@@ -231,17 +232,17 @@ ENDPROC(__kvm_flush_vm_context)
 	.if \vcpu == 0
 	push	{r2-r12}		@ Push CP15 registers
 	.else
-	str	r2, [\vcpup, #VCPU_CID]
-	str	r3, [\vcpup, #VCPU_TID_URW]
-	str	r4, [\vcpup, #VCPU_TID_URO]
-	str	r5, [\vcpup, #VCPU_TID_PRIV]
-	str	r6, [\vcpup, #VCPU_DFSR]
-	str	r7, [\vcpup, #VCPU_IFSR]
-	str	r8, [\vcpup, #VCPU_ADFSR]
-	str	r9, [\vcpup, #VCPU_AIFSR]
-	str	r10, [\vcpup, #VCPU_DFAR]
-	str	r11, [\vcpup, #VCPU_IFAR]
-	str	r12, [\vcpup, #VCPU_VBAR]
+	str	r2, [\vcpup, #CP15_OFFSET(c13_CID)]
+	str	r3, [\vcpup, #CP15_OFFSET(c13_TID_URW)]
+	str	r4, [\vcpup, #CP15_OFFSET(c13_TID_URO)]
+	str	r5, [\vcpup, #CP15_OFFSET(c13_TID_PRIV)]
+	str	r6, [\vcpup, #CP15_OFFSET(c5_DFSR)]
+	str	r7, [\vcpup, #CP15_OFFSET(c5_IFSR)]
+	str	r8, [\vcpup, #CP15_OFFSET(c5_ADFSR)]
+	str	r9, [\vcpup, #CP15_OFFSET(c5_AIFSR)]
+	str	r10, [\vcpup, #CP15_OFFSET(c6_DFAR)]
+	str	r11, [\vcpup, #CP15_OFFSET(c6_IFAR)]
+	str	r12, [\vcpup, #CP15_OFFSET(c12_VBAR)]
 	.endif
 .endm

@@ -254,17 +255,17 @@ ENDPROC(__kvm_flush_vm_context)
 	.if \vcpu == 0
 	pop	{r2-r12}
 	.else
-	ldr	r2, [\vcpup, #VCPU_CID]
-	ldr	r3, [\vcpup, #VCPU_TID_URW]
-	ldr	r4, [\vcpup, #VCPU_TID_URO]
-	ldr	r5, [\vcpup, #VCPU_TID_PRIV]
-	ldr	r6, [\vcpup, #VCPU_DFSR]
-	ldr	r7, [\vcpup, #VCPU_IFSR]
-	ldr	r8, [\vcpup, #VCPU_ADFSR]
-	ldr	r9, [\vcpup, #VCPU_AIFSR]
-	ldr	r10, [\vcpup, #VCPU_DFAR]
-	ldr	r11, [\vcpup, #VCPU_IFAR]
-	ldr	r12, [\vcpup, #VCPU_VBAR]
+	ldr	r2, [\vcpup, #CP15_OFFSET(c13_CID)]
+	ldr	r3, [\vcpup, #CP15_OFFSET(c13_TID_URW)]
+	ldr	r4, [\vcpup, #CP15_OFFSET(c13_TID_URO)]
+	ldr	r5, [\vcpup, #CP15_OFFSET(c13_TID_PRIV)]
+	ldr	r6, [\vcpup, #CP15_OFFSET(c5_DFSR)]
+	ldr	r7, [\vcpup, #CP15_OFFSET(c5_IFSR)]
+	ldr	r8, [\vcpup, #CP15_OFFSET(c5_ADFSR)]
+	ldr	r9, [\vcpup, #CP15_OFFSET(c5_AIFSR)]
+	ldr	r10, [\vcpup, #CP15_OFFSET(c6_DFAR)]
+	ldr	r11, [\vcpup, #CP15_OFFSET(c6_IFAR)]
+	ldr	r12, [\vcpup, #CP15_OFFSET(c12_VBAR)]
 	.endif

 	mcr	p15, 0, r2, c13, c0, 1	@ CID
@@ -282,18 +283,18 @@ ENDPROC(__kvm_flush_vm_context)
 	.if \vcpu == 0
 	pop	{r2-r12}
 	.else
-	ldr	r2, [\vcpup, #VCPU_SCTLR]
-	ldr	r3, [\vcpup, #VCPU_CPACR]
-	ldr	r4, [\vcpup, #VCPU_TTBCR]
-	ldr	r5, [\vcpup, #VCPU_DACR]
-	add	\vcpup, \vcpup, #VCPU_TTBR0
+	ldr	r2, [\vcpup, #CP15_OFFSET(c1_SCTLR)]
+	ldr	r3, [\vcpup, #CP15_OFFSET(c1_CPACR)]
+	ldr	r4, [\vcpup, #CP15_OFFSET(c2_TTBCR)]
+	ldr	r5, [\vcpup, #CP15_OFFSET(c3_DACR)]
+	add	\vcpup, \vcpup, #CP15_OFFSET(c2_TTBR0)
 	ldrd	r6, r7, [\vcpup]
-	add	\vcpup, \vcpup, #(VCPU_TTBR1 - VCPU_TTBR0)
+	add	\vcpup, \vcpup, #CP15_OFFSET(c2_TTBR1) - CP15_OFFSET(c2_TTBR0)
 	ldrd	r8, r9, [\vcpup]
-	sub	\vcpup, \vcpup, #(VCPU_TTBR1)
-	ldr	r10, [\vcpup, #VCPU_PRRR]
-	ldr	r11, [\vcpup, #VCPU_NMRR]
-	ldr	r12, [\vcpup, #VCPU_CSSELR]
+	sub	\vcpup, \vcpup, #CP15_OFFSET(c2_TTBR1)
+	ldr	r10, [\vcpup, #CP15_OFFSET(c10_PRRR)]
+	ldr	r11, [\vcpup, #CP15_OFFSET(c10_NMRR)]
+	ldr	r12, [\vcpup, #CP15_OFFSET(c0_CSSELR)]
 	.endif

 	mcr	p15, 0, r2, c1, c0, 0	@ SCTLR
@@ -556,7 +557,7 @@ ENTRY(__kvm_vcpu_run)
 	mcr	p15, 4, r1, c0, c0, 0

 	@ Write guest view of MPIDR into VMPIDR
-	ldr	r1, [r0, #VCPU_MPIDR]
+	ldr	r1, [r0, #CP15_OFFSET(c0_MPIDR)]
 	mcr	p15, 4, r1, c0, c0, 5

 	@ Load guest registers


>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 8a87fc7..087f9d1 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -41,6 +41,7 @@
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_asm.h>
>>  #include <asm/kvm_mmu.h>
>> +#include <asm/kvm_emulate.h>
>>
>>  #ifdef REQUIRES_VIRT
>>  __asm__(".arch_extension       virt");
>> @@ -50,6 +51,10 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>>  static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
>>  static unsigned long hyp_default_vectors;
>>
>> +/* The VMID used in the VTTBR */
>> +static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
>> +static u8 kvm_next_vmid;
>> +static DEFINE_SPINLOCK(kvm_vmid_lock);
>>
>>  int kvm_arch_hardware_enable(void *garbage)
>>  {
>> @@ -273,6 +278,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
>>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>>  {
>>         vcpu->cpu = cpu;
>> +       vcpu->arch.vfp_host = this_cpu_ptr(kvm_host_vfp_state);
>>  }
>>
>>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>> @@ -305,12 +311,169 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>>
>>  int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
>>  {
>> +       return v->mode == IN_GUEST_MODE;
>> +}
>> +
>> +static void reset_vm_context(void *info)
>> +{
>> +       __kvm_flush_vm_context();
>> +}
>> +
>> +/**
>> + * need_new_vmid_gen - check that the VMID is still valid
>> + * @kvm: The VM's VMID to checkt
>> + *
>> + * return true if there is a new generation of VMIDs being used
>> + *
>> + * The hardware supports only 256 values with the value zero reserved for the
>> + * host, so we check if an assigned value belongs to a previous generation,
>> + * which which requires us to assign a new value. If we're the first to use a
>> + * VMID for the new generation, we must flush necessary caches and TLBs on all
>> + * CPUs.
>> + */
>> +static bool need_new_vmid_gen(struct kvm *kvm)
>> +{
>> +       return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
>> +}
>> +
>> +/**
>> + * update_vttbr - Update the VTTBR with a valid VMID before the guest runs
>> + * @kvm        The guest that we are about to run
>> + *
>> + * Called from kvm_arch_vcpu_ioctl_run before entering the guest to ensure the
>> + * VM has a valid VMID, otherwise assigns a new one and flushes corresponding
>> + * caches and TLBs.
>> + */
>> +static void update_vttbr(struct kvm *kvm)
>> +{
>> +       phys_addr_t pgd_phys;
>> +
>> +       if (!need_new_vmid_gen(kvm))
>> +               return;
>> +
>> +       spin_lock(&kvm_vmid_lock);
>> +
>> +       /* First user of a new VMID generation? */
>> +       if (unlikely(kvm_next_vmid == 0)) {
>> +               atomic64_inc(&kvm_vmid_gen);
>> +               kvm_next_vmid = 1;
>> +
>> +               /*
>> +                * On SMP we know no other CPUs can use this CPU's or
>> +                * each other's VMID since the kvm_vmid_lock blocks
>> +                * them from reentry to the guest.
>> +                */
>> +               on_each_cpu(reset_vm_context, NULL, 1);
>
> Why on_each_cpu? The maintenance operations should be broadcast, right?
>

we need each cpu (that runs guests) to exit guests and pick up the new
vmid in their vttbr.

>> +       }
>> +
>> +       kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
>> +       kvm->arch.vmid = kvm_next_vmid;
>> +       kvm_next_vmid++;
>> +
>> +       /* update vttbr to be used with the new vmid */
>> +       pgd_phys = virt_to_phys(kvm->arch.pgd);
>> +       kvm->arch.vttbr = pgd_phys & ((1LLU << 40) - 1)
>> +                         & ~((2 << VTTBR_X) - 1);
>> +       kvm->arch.vttbr |= (u64)(kvm->arch.vmid) << 48;
>> +
>> +       spin_unlock(&kvm_vmid_lock);
>> +}
>
> This smells like a watered-down version of the ASID allocator. Now, I can't
> really see much code sharing going on here, but perhaps your case is
> simpler... do you anticipate running more than 255 VMs in parallel? If not,
> then you could just invalidate the relevant TLB entries on VM shutdown and
> avoid the rollover case.
>

I want to support running more than 255 VMs in parallel. I think
trying to share code with the ASID allocator complicates things
without any real benefit.

>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index edf9ed5..cc9448b 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -23,6 +23,12 @@
>>  #include <asm/asm-offsets.h>
>>  #include <asm/kvm_asm.h>
>>  #include <asm/kvm_arm.h>
>> +#include <asm/vfpmacros.h>
>> +
>> +#define VCPU_USR_REG(_reg_nr)  (VCPU_USR_REGS + (_reg_nr * 4))
>> +#define VCPU_USR_SP            (VCPU_USR_REG(13))
>> +#define VCPU_FIQ_REG(_reg_nr)  (VCPU_FIQ_REGS + (_reg_nr * 4))
>> +#define VCPU_FIQ_SPSR          (VCPU_FIQ_REG(7))
>>
>>         .text
>>         .align  PAGE_SHIFT
>> @@ -34,7 +40,33 @@ __kvm_hyp_code_start:
>>  @  Flush per-VMID TLBs
>>  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>
> This comment syntax crops up a few times in your .S files but doesn't match
> anything currently under arch/arm/. Please can you follow what we do there
> and use /* */ ?
>

sure

>>  ENTRY(__kvm_tlb_flush_vmid)
>> +       hvc     #0                      @ Switch to Hyp mode
>> +       push    {r2, r3}
>> +
>> +       add     r0, r0, #KVM_VTTBR
>> +       ldrd    r2, r3, [r0]
>> +       mcrr    p15, 6, r2, r3, c2      @ Write VTTBR
>> +       isb
>> +       mcr     p15, 0, r0, c8, c3, 0   @ TLBIALLIS (rt ignored)
>> +       dsb
>> +       isb
>> +       mov     r2, #0
>> +       mov     r3, #0
>> +       mcrr    p15, 6, r2, r3, c2      @ Back to VMID #0
>> +       isb
>
> Do you need this isb, given that you're about to do an hvc?
>

they're gone

>> +       pop     {r2, r3}
>> +       hvc     #0                      @ Back to SVC
>>         bx      lr
>>  ENDPROC(__kvm_tlb_flush_vmid)
>>
>> @@ -42,26 +74,702 @@ ENDPROC(__kvm_tlb_flush_vmid)
>>  @  Flush TLBs and instruction caches of current CPU for all VMIDs
>>  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>
>> +/*
>> + * void __kvm_flush_vm_context(void);
>> + */
>>  ENTRY(__kvm_flush_vm_context)
>> +       hvc     #0                      @ switch to hyp-mode
>> +
>> +       mov     r0, #0                  @ rn parameter for c15 flushes is SBZ
>> +       mcr     p15, 4, r0, c8, c7, 4   @ Invalidate Non-secure Non-Hyp TLB
>> +       mcr     p15, 0, r0, c7, c5, 0   @ Invalidate instruction caches
>> +       dsb
>> +       isb
>
> Likewise.
>

ditto

>> +       hvc     #0                      @ switch back to svc-mode, see hyp_svc
>>         bx      lr
>>  ENDPROC(__kvm_flush_vm_context)
>>
>> +/* These are simply for the macros to work - value don't have meaning */
>> +.equ usr, 0
>> +.equ svc, 1
>> +.equ abt, 2
>> +.equ und, 3
>> +.equ irq, 4
>> +.equ fiq, 5
>> +
>> +.macro store_mode_state base_reg, mode
>> +       .if \mode == usr
>> +       mrs     r2, SP_usr
>> +       mov     r3, lr
>> +       stmdb   \base_reg!, {r2, r3}
>> +       .elseif \mode != fiq
>> +       mrs     r2, SP_\mode
>> +       mrs     r3, LR_\mode
>> +       mrs     r4, SPSR_\mode
>> +       stmdb   \base_reg!, {r2, r3, r4}
>> +       .else
>> +       mrs     r2, r8_fiq
>> +       mrs     r3, r9_fiq
>> +       mrs     r4, r10_fiq
>> +       mrs     r5, r11_fiq
>> +       mrs     r6, r12_fiq
>> +       mrs     r7, SP_fiq
>> +       mrs     r8, LR_fiq
>> +       mrs     r9, SPSR_fiq
>> +       stmdb   \base_reg!, {r2-r9}
>> +       .endif
>> +.endm
>
> Perhaps you could stick the assembly macros into a separate file, like we do
> in assembler.h, so the code is more readable and they can be reused if
> need-be?
>
This is a lot of code to stick in a header file (hard to read within C
constructs, no assembly syntax highlighting, cannot use @ for
end-of-line comments), but I factored it out to interrupts_header.S,
which makes it nicer to read interrupts.S and it should be easy to
factor out pieces if ever needed anywhere else.

-Christoffer
