From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:59:11 -0500
Subject: [PATCH v6 13/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175911.29147.40578.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the guest accesses I/O memory this will create data abort
exceptions and they are handled by decoding the HSR information
(physical address, read/write, length, register) and forwarding reads
and writes to QEMU which performs the device emulation.

Certain classes of load/store operations do not support the syndrome
information provided in the HSR.  We don't support decoding these (patches
are available elsewhere), so we report an error to user space in this case.

This requires changing the general flow somewhat since new calls to run
the VCPU must check if there's a pending MMIO load and perform the write
after userspace has made the data available.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arm.h     |    3 +
 arch/arm/include/asm/kvm_asm.h     |    2 
 arch/arm/include/asm/kvm_emulate.h |    6 +
 arch/arm/include/asm/kvm_host.h    |    4 +
 arch/arm/include/asm/kvm_mmio.h    |   56 +++++++++++++
 arch/arm/kvm/Makefile              |    2 
 arch/arm/kvm/arm.c                 |    6 +
 arch/arm/kvm/interrupts.S          |   38 +++++++++
 arch/arm/kvm/mmio.c                |  153 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/mmu.c                 |    7 +-
 arch/arm/kvm/trace.h               |   21 +++++
 11 files changed, 295 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_mmio.h
 create mode 100644 arch/arm/kvm/mmio.c

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index 9a34c20..7c3d813 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -173,8 +173,11 @@
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
index 5e06e81..58d787b 100644
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
index 01a755b..4c1a073 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -21,6 +21,7 @@
 
 #include <linux/kvm_host.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_mmio.h>
 
 u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
 u32 *vcpu_spsr(struct kvm_vcpu *vcpu);
@@ -53,4 +54,9 @@ static inline bool vcpu_mode_priv(struct kvm_vcpu *vcpu)
 	return cpsr_mode > USR_MODE;;
 }
 
+static inline bool kvm_vcpu_reg_is_pc(struct kvm_vcpu *vcpu, int reg)
+{
+	return reg == 15;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ed79043..e65fc96 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -21,6 +21,7 @@
 
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_mmio.h>
 #include <asm/fpstate.h>
 
 #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
@@ -99,6 +100,9 @@ struct kvm_vcpu_arch {
 	int last_pcpu;
 	cpumask_t require_dcache_flush;
 
+	/* IO related fields */
+	struct kvm_decode mmio_decode;
+
 	/* Interrupt related fields */
 	u32 irq_lines;		/* IRQ and FIQ levels */
 
diff --git a/arch/arm/include/asm/kvm_mmio.h b/arch/arm/include/asm/kvm_mmio.h
new file mode 100644
index 0000000..adcc0d7
--- /dev/null
+++ b/arch/arm/include/asm/kvm_mmio.h
@@ -0,0 +1,56 @@
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
+struct kvm_decode {
+	unsigned long rt;
+	bool sign_extend;
+};
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
+		 phys_addr_t fault_ipa);
+
+#endif	/* __ARM_KVM_MMIO_H__ */
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 88edce6..1e45cd9 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -18,4 +18,4 @@ kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o guest.o mmu.o emulate.o reset.o
-obj-y += coproc.o coproc_a15.o
+obj-y += coproc.o coproc_a15.o mmio.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 875c63e..3168b9d 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -615,6 +615,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (ret)
 		return ret;
 
+	if (run->exit_reason == KVM_EXIT_MMIO) {
+		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
+		if (ret)
+			return ret;
+	}
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 04a9705..702743e 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -192,6 +192,44 @@ after_vfp_restore:
 	mov	r0, r1			@ Return the return code
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
+	read_cp15_state store_to_vcpu = 0
+	write_cp15_state read_from_vcpu = 1
+
+	ands	r2, r1, #1
+	bic	r1, r1, r2
+	mcrne	p15, 0, r1, c7, c8, 0	@ VA to PA, ATS1CPR
+	mcreq	p15, 0, r1, c7, c8, 2	@ VA to PA, ATS1CUR
+	isb
+
+	@ Restore host state.
+	read_cp15_state store_to_vcpu = 1
+	write_cp15_state read_from_vcpu = 0
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
index 0000000..0144baf
--- /dev/null
+++ b/arch/arm/kvm/mmio.c
@@ -0,0 +1,153 @@
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
+#include <linux/kvm_host.h>
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
+		dest = vcpu_reg(vcpu, vcpu->arch.mmio_decode.rt);
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
+		if (vcpu->arch.mmio_decode.sign_extend && len < 4) {
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
+	unsigned long rt, len;
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
+	rt = (vcpu->arch.hsr & HSR_SRT_MASK) >> HSR_SRT_SHIFT;
+
+	if (kvm_vcpu_reg_is_pc(vcpu, rt)) {
+		/* IO memory trying to read/write pc */
+		kvm_inject_pabt(vcpu, vcpu->arch.hxfar);
+		return 1;
+	}
+
+	mmio->is_write = is_write;
+	mmio->phys_addr = fault_ipa;
+	mmio->len = len;
+	vcpu->arch.mmio_decode.sign_extend = sign_extend;
+	vcpu->arch.mmio_decode.rt = rt;
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
+		 phys_addr_t fault_ipa)
+{
+	struct kvm_exit_mmio mmio;
+	unsigned long rt;
+	int ret;
+
+	/*
+	 * Prepare MMIO operation. First stash it in a private
+	 * structure that we can use for in-kernel emulation. If the
+	 * kernel can't handle it, copy it into run->mmio and let user
+	 * space do its magic.
+	 */
+
+	if (vcpu->arch.hsr & HSR_ISV) {
+		ret = decode_hsr(vcpu, fault_ipa, &mmio);
+		if (ret)
+			return ret;
+	} else {
+		kvm_err("load/store instruction decoding not implemented\n");
+		return -ENOSYS;
+	}
+
+	rt = vcpu->arch.mmio_decode.rt;
+	trace_kvm_mmio((mmio.is_write) ? KVM_TRACE_MMIO_WRITE :
+					 KVM_TRACE_MMIO_READ_UNSATISFIED,
+			mmio.len, fault_ipa,
+			(mmio.is_write) ? *vcpu_reg(vcpu, rt) : 0);
+
+	if (mmio.is_write)
+		memcpy(mmio.data, vcpu_reg(vcpu, rt), mmio.len);
+
+	kvm_prepare_mmio(run, &mmio);
+	return 0;
+}
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index a4b7b0f..f30e131 100644
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
@@ -624,8 +626,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			goto out_unlock;
 		}
 
-		kvm_pr_unimpl("I/O address abort...");
-		ret = 0;
+		/* Adjust page offset */
+		fault_ipa |= vcpu->arch.hxfar & ~PAGE_MASK;
+		ret = io_mem_abort(vcpu, run, fault_ipa);
 		goto out_unlock;
 	}
 
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index 624b5a4..a8e73ed 100644
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
