From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Mar 2015 18:16:52 +0000
Subject: [PATCH v2 3/3] arm/arm64: KVM: Optimize handling of Access Flag faults
In-Reply-To: <1426184212-29333-1-git-send-email-marc.zyngier@arm.com>
References: <1426184212-29333-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426184212-29333-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have page aging in Stage-2, it becomes obvious that
we're doing way too much work handling the fault.

The page is not going anywhere (it is still mapped), the page
tables are already allocated, and all we want is to flip a bit
in the PMD or PTE. Also, we can avoid any form of TLB invalidation,
since a page with the AF bit off is not allowed to be cached.

An obvious solution is to have a separate handler for FSC_ACCESS,
where we pride ourselves to only do the very minimum amount of
work.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/trace.h | 15 +++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1831aa2..56c8b03 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1304,6 +1304,46 @@ out_unlock:
 	return ret;
 }
 
+/*
+ * Resolve the access fault by making the page young again.
+ * Note that because the faulting entry is guaranteed not to be
+ * cached in the TLB, we don't need to invalidate anything.
+ */
+static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
+{
+	pmd_t *pmd;
+	pte_t *pte;
+	pfn_t pfn;
+	bool pfn_valid = false;
+
+	trace_kvm_access_fault(fault_ipa);
+
+	spin_lock(&vcpu->kvm->mmu_lock);
+
+	pmd = stage2_get_pmd(vcpu->kvm, NULL, fault_ipa);
+	if (!pmd || pmd_none(*pmd))	/* Nothing there */
+		goto out;
+
+	if (kvm_pmd_huge(*pmd)) {	/* THP, HugeTLB */
+		*pmd = pmd_mkyoung(*pmd);
+		pfn = pmd_pfn(*pmd);
+		pfn_valid = true;
+		goto out;
+	}
+
+	pte = pte_offset_kernel(pmd, fault_ipa);
+	if (pte_none(*pte))		/* Nothing there either */
+		goto out;
+
+	*pte = pte_mkyoung(*pte);	/* Just a page... */
+	pfn = pte_pfn(*pte);
+	pfn_valid = true;
+out:
+	spin_unlock(&vcpu->kvm->mmu_lock);
+	if (pfn_valid)
+		kvm_set_pfn_accessed(pfn);
+}
+
 /**
  * kvm_handle_guest_abort - handles all 2nd stage aborts
  * @vcpu:	the VCPU pointer
@@ -1371,6 +1411,12 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	/* Userspace should not be able to register out-of-bounds IPAs */
 	VM_BUG_ON(fault_ipa >= KVM_PHYS_SIZE);
 
+	if (fault_status == FSC_ACCESS) {
+		handle_access_fault(vcpu, fault_ipa);
+		ret = 1;
+		goto out_unlock;
+	}
+
 	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
 	if (ret == 0)
 		ret = 1;
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index c09f37f..0ec3539 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -68,6 +68,21 @@ TRACE_EVENT(kvm_guest_fault,
 		  __entry->hxfar, __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_access_fault,
+	TP_PROTO(unsigned long ipa),
+	TP_ARGS(ipa),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	ipa		)
+	),
+
+	TP_fast_assign(
+		__entry->ipa		= ipa;
+	),
+
+	TP_printk("IPA: %lx", __entry->ipa)
+);
+
 TRACE_EVENT(kvm_irq_line,
 	TP_PROTO(unsigned int type, int vcpu_idx, int irq_num, int level),
 	TP_ARGS(type, vcpu_idx, irq_num, level),
-- 
2.1.4
