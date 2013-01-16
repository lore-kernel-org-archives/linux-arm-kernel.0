From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:59:05 -0500
Subject: [PATCH v6 12/15] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175905.29147.17824.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handles the guest faults in KVM by mapping in corresponding user pages
in the 2nd stage page tables.

We invalidate the instruction cache by MVA whenever we map a page to the
guest (no, we cannot only do it when we have an iabt because the guest
may happily read/write a page before hitting the icache) if the hardware
uses VIPT or PIPT.  In the latter case, we can invalidate only that
physical page.  In the first case, all bets are off and we simply must
invalidate the whole affair.  Not that VIVT icaches are tagged with
vmids, and we are out of the woods on that one.  Alexander Graf was nice
enough to remind us of this massive pain.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_asm.h |    2 +
 arch/arm/include/asm/kvm_mmu.h |   12 +++
 arch/arm/kvm/mmu.c             |  153 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/trace.h           |   26 +++++++
 4 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index f6652f6..5e06e81 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -71,6 +71,8 @@ extern char __kvm_hyp_vector[];
 extern char __kvm_hyp_code_start[];
 extern char __kvm_hyp_code_end[];
 
+extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
+
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 499e7b0..421a20b 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -35,4 +35,16 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
+
+static inline bool kvm_is_write_fault(unsigned long hsr)
+{
+	unsigned long hsr_ec = hsr >> HSR_EC_SHIFT;
+	if (hsr_ec == HSR_EC_IABT)
+		return false;
+	else if ((hsr & HSR_ISV) && !(hsr & HSR_WNR))
+		return false;
+	else
+		return true;
+}
+
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 4347d68..a4b7b0f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -21,9 +21,11 @@
 #include <linux/io.h>
 #include <asm/idmap.h>
 #include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_emulate.h>
 #include <asm/mach/map.h>
 #include <trace/events/kvm.h>
 
@@ -488,9 +490,158 @@ out:
 	return ret;
 }
 
+static void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+{
+	/*
+	 * If we are going to insert an instruction page and the icache is
+	 * either VIPT or PIPT, there is a potential problem where the host
+	 * (or another VM) may have used the same page as this guest, and we
+	 * read incorrect data from the icache.  If we're using a PIPT cache,
+	 * we can invalidate just that page, but if we are using a VIPT cache
+	 * we need to invalidate the entire icache - damn shame - as written
+	 * in the ARM ARM (DDI 0406C.b - Page B3-1393).
+	 *
+	 * VIVT caches are tagged using both the ASID and the VMID and doesn't
+	 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
+	 */
+	if (icache_is_pipt()) {
+		unsigned long hva = gfn_to_hva(kvm, gfn);
+		__cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
+	} else if (!icache_is_vivt_asid_tagged()) {
+		/* any kind of VIPT cache */
+		__flush_icache_all();
+	}
+}
+
+static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			  gfn_t gfn, struct kvm_memory_slot *memslot,
+			  unsigned long fault_status)
+{
+	pte_t new_pte;
+	pfn_t pfn;
+	int ret;
+	bool write_fault, writable;
+	unsigned long mmu_seq;
+	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
+
+	write_fault = kvm_is_write_fault(vcpu->arch.hsr);
+	if (fault_status == FSC_PERM && !write_fault) {
+		kvm_err("Unexpected L2 read permission error\n");
+		return -EFAULT;
+	}
+
+	/* We need minimum second+third level pages */
+	ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
+	if (ret)
+		return ret;
+
+	mmu_seq = vcpu->kvm->mmu_notifier_seq;
+	/*
+	 * Ensure the read of mmu_notifier_seq happens before we call
+	 * gfn_to_pfn_prot (which calls get_user_pages), so that we don't risk
+	 * the page we just got a reference to gets unmapped before we have a
+	 * chance to grab the mmu_lock, which ensure that if the page gets
+	 * unmapped afterwards, the call to kvm_unmap_hva will take it away
+	 * from us again properly. This smp_rmb() interacts with the smp_wmb()
+	 * in kvm_mmu_notifier_invalidate_<page|range_end>.
+	 */
+	smp_rmb();
+
+	pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
+	if (is_error_pfn(pfn))
+		return -EFAULT;
+
+	new_pte = pfn_pte(pfn, PAGE_S2);
+	coherent_icache_guest_page(vcpu->kvm, gfn);
+
+	spin_lock(&vcpu->kvm->mmu_lock);
+	if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
+		goto out_unlock;
+	if (writable) {
+		pte_val(new_pte) |= L_PTE_S2_RDWR;
+		kvm_set_pfn_dirty(pfn);
+	}
+	stage2_set_pte(vcpu->kvm, memcache, fault_ipa, &new_pte, false);
+
+out_unlock:
+	spin_unlock(&vcpu->kvm->mmu_lock);
+	kvm_release_pfn_clean(pfn);
+	return 0;
+}
+
+/**
+ * kvm_handle_guest_abort - handles all 2nd stage aborts
+ * @vcpu:	the VCPU pointer
+ * @run:	the kvm_run structure
+ *
+ * Any abort that gets to the host is almost guaranteed to be caused by a
+ * missing second stage translation table entry, which can mean that either the
+ * guest simply needs more memory and we must allocate an appropriate page or it
+ * can mean that the guest tried to access I/O memory, which is emulated by user
+ * space. The distinction is based on the IPA causing the fault and whether this
+ * memory region has been registered as standard RAM by user space.
+ */
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	return -EINVAL;
+	unsigned long hsr_ec;
+	unsigned long fault_status;
+	phys_addr_t fault_ipa;
+	struct kvm_memory_slot *memslot;
+	bool is_iabt;
+	gfn_t gfn;
+	int ret, idx;
+
+	hsr_ec = vcpu->arch.hsr >> HSR_EC_SHIFT;
+	is_iabt = (hsr_ec == HSR_EC_IABT);
+	fault_ipa = ((phys_addr_t)vcpu->arch.hpfar & HPFAR_MASK) << 8;
+
+	trace_kvm_guest_fault(*vcpu_pc(vcpu), vcpu->arch.hsr,
+			      vcpu->arch.hxfar, fault_ipa);
+
+	/* Check the stage-2 fault is trans. fault or write fault */
+	fault_status = (vcpu->arch.hsr & HSR_FSC_TYPE);
+	if (fault_status != FSC_FAULT && fault_status != FSC_PERM) {
+		kvm_err("Unsupported fault status: EC=%#lx DFCS=%#lx\n",
+			hsr_ec, fault_status);
+		return -EFAULT;
+	}
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	gfn = fault_ipa >> PAGE_SHIFT;
+	if (!kvm_is_visible_gfn(vcpu->kvm, gfn)) {
+		if (is_iabt) {
+			/* Prefetch Abort on I/O address */
+			kvm_inject_pabt(vcpu, vcpu->arch.hxfar);
+			ret = 1;
+			goto out_unlock;
+		}
+
+		if (fault_status != FSC_FAULT) {
+			kvm_err("Unsupported fault status on io memory: %#lx\n",
+				fault_status);
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+
+		kvm_pr_unimpl("I/O address abort...");
+		ret = 0;
+		goto out_unlock;
+	}
+
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!memslot->user_alloc) {
+		kvm_err("non user-alloc memslots not supported\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot, fault_status);
+	if (ret == 0)
+		ret = 1;
+out_unlock:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	return ret;
 }
 
 static void handle_hva_to_gpa(struct kvm *kvm,
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index 022305b..624b5a4 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -39,6 +39,32 @@ TRACE_EVENT(kvm_exit,
 	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_guest_fault,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long hsr,
+		 unsigned long hxfar,
+		 unsigned long long ipa),
+	TP_ARGS(vcpu_pc, hsr, hxfar, ipa),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+		__field(	unsigned long,	hsr		)
+		__field(	unsigned long,	hxfar		)
+		__field(   unsigned long long,	ipa		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+		__entry->hsr			= hsr;
+		__entry->hxfar			= hxfar;
+		__entry->ipa			= ipa;
+	),
+
+	TP_printk("guest fault at PC %#08lx (hxfar %#08lx, "
+		  "ipa %#16llx, hsr %#08lx",
+		  __entry->vcpu_pc, __entry->hxfar,
+		  __entry->ipa, __entry->hsr)
+);
+
 TRACE_EVENT(kvm_irq_line,
 	TP_PROTO(unsigned int type, int vcpu_idx, int irq_num, int level),
 	TP_ARGS(type, vcpu_idx, irq_num, level),
