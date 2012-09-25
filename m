From: mingyu84.kim@samsung.com (Min-gyu Kim)
Date: Tue, 25 Sep 2012 20:11:11 +0900
Subject: [PATCH 13/15] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <20120915153552.21241.8656.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153552.21241.8656.stgit@ubuntu>
Message-ID: <000101cd9b0e$78934fe0$69b9efa0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On
> Behalf Of Christoffer Dall
> Sent: Sunday, September 16, 2012 12:36 AM
> To: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> kvmarm at lists.cs.columbia.edu
> Subject: [PATCH 13/15] KVM: ARM: Handle guest faults in KVM
> 
> From: Christoffer Dall <cdall@cs.columbia.edu>
> 
> Handles the guest faults in KVM by mapping in corresponding user pages in
> the 2nd stage page tables.
> 
> We invalidate the instruction cache by MVA whenever we map a page to the
> guest (no, we cannot only do it when we have an iabt because the guest may
> happily read/write a page before hitting the icache) if the hardware uses
> VIPT or PIPT.  In the latter case, we can invalidate only that physical
> page.  In the first case, all bets are off and we simply must invalidate
> the whole affair.  Not that VIVT icaches are tagged with vmids, and we are
> out of the woods on that one.  Alexander Graf was nice enough to remind us
> of this massive pain.
> 
> There may be a subtle bug hidden in, which we currently hide by marking
> all pages dirty even when the pages are only mapped read-only.  The
> current hypothesis is that marking pages dirty may exercise the IO system
> and data cache more and therefore we don't see stale data in the guest,
> but it's purely guesswork.  The bug is manifested by seemingly random
> kernel crashes in guests when the host is under extreme memory pressure
> and swapping is enabled.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/kvm_arm.h |    9 ++
>  arch/arm/include/asm/kvm_asm.h |    2 +
>  arch/arm/kvm/mmu.c             |  155
> ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kvm/trace.h           |   28 +++++++
>  4 files changed, 193 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_arm.h
> b/arch/arm/include/asm/kvm_arm.h index ae586c1..4cff3b7 100644
> --- a/arch/arm/include/asm/kvm_arm.h
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -158,11 +158,20 @@
>  #define HSR_ISS		(HSR_IL - 1)
>  #define HSR_ISV_SHIFT	(24)
>  #define HSR_ISV		(1U << HSR_ISV_SHIFT)
> +#define HSR_FSC		(0x3f)
> +#define HSR_FSC_TYPE	(0x3c)
> +#define HSR_WNR		(1 << 6)
>  #define HSR_CV_SHIFT	(24)
>  #define HSR_CV		(1U << HSR_CV_SHIFT)
>  #define HSR_COND_SHIFT	(20)
>  #define HSR_COND	(0xfU << HSR_COND_SHIFT)
> 
> +#define FSC_FAULT	(0x04)
> +#define FSC_PERM	(0x0c)
> +
> +/* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
> +#define HPFAR_MASK	(~0xf)
> +
>  #define HSR_EC_UNKNOWN	(0x00)
>  #define HSR_EC_WFI	(0x01)
>  #define HSR_EC_CP15_32	(0x03)
> diff --git a/arch/arm/include/asm/kvm_asm.h
> b/arch/arm/include/asm/kvm_asm.h index 201ec1f..40ee099 100644
> --- a/arch/arm/include/asm/kvm_asm.h
> +++ b/arch/arm/include/asm/kvm_asm.h
> @@ -43,6 +43,8 @@ extern char __kvm_hyp_vector[];  extern char
> __kvm_hyp_code_start[];  extern char __kvm_hyp_code_end[];
> 
> +extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
> +
>  extern void __kvm_flush_vm_context(void);  extern void
> __kvm_tlb_flush_vmid(struct kvm *kvm);
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c index
> ea17a97..52cc280 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -21,10 +21,16 @@
>  #include <linux/io.h>
>  #include <asm/idmap.h>
>  #include <asm/pgalloc.h>
> +#include <asm/cacheflush.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_asm.h>
> +#include <asm/kvm_emulate.h>
>  #include <asm/mach/map.h>
> +#include <asm/kvm_asm.h>
> +#include <trace/events/kvm.h>
> +
> +#include "trace.h"
> 
>  static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
> 
> @@ -490,9 +496,156 @@ out:
>  	return ret;
>  }
> 
> +static void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn) {
> +	/*
> +	 * If we are going to insert an instruction page and the icache is
> +	 * either VIPT or PIPT, there is a potential problem where the host
> +	 * (or another VM) may have used this page at the same virtual
> address
> +	 * as this guest, and we read incorrect data from the icache.  If
> +	 * we're using a PIPT cache, we can invalidate just that page, but
> if
> +	 * we are using a VIPT cache we need to invalidate the entire
> icache -
> +	 * damn shame - as written in the ARM ARM (DDI 0406C - Page B3-1384)
> +	 */
> +	if (icache_is_pipt()) {
> +		unsigned long hva = gfn_to_hva(kvm, gfn);
> +		__cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
> +	} else if (!icache_is_vivt_asid_tagged()) {
> +		/* any kind of VIPT cache */
> +		__flush_icache_all();
> +	}
> +}
> +
> +static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> +			  gfn_t gfn, struct kvm_memory_slot *memslot,
> +			  bool is_iabt, unsigned long fault_status) {
> +	pte_t new_pte;
> +	pfn_t pfn, pfn_existing = KVM_PFN_ERR_BAD;
> +	int ret;
> +	bool write_fault, writable;
> +	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> +
> +	if (is_iabt)
> +		write_fault = false;
> +	else if ((vcpu->arch.hsr & HSR_ISV) && !(vcpu->arch.hsr & HSR_WNR))
> +		write_fault = false;
> +	else
> +		write_fault = true;
> +
> +	if (fault_status == FSC_PERM && !write_fault) {
> +		kvm_err("Unexpected L2 read permission error\n");
> +		return -EFAULT;
> +	}
> +
> +	/*
> +	 * If this is a write fault (think COW) we need to make sure the
> +	 * existing page, which other CPUs might still read, doesn't go
> away
> +	 * from under us, by calling gfn_to_pfn_prot(write_fault=true).
> +	 * Therefore, we call gfn_to_pfn_prot(write_fault=false), which
> will
> +	 * pin the existing page, then we get a new page for the user space
> +	 * pte and map this in the stage-2 table where we also make sure to
> +	 * flush the TLB for the VM, if there was an existing entry (the
> entry
> +	 * was updated setting the write flag to the potentially new page).
> +	 */
> +	if (fault_status == FSC_PERM) {
> +		pfn_existing = gfn_to_pfn_prot(vcpu->kvm, gfn, false, NULL);
> +		if (is_error_pfn(pfn_existing))
> +			return -EFAULT;
> +	}
> +
> +	pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
> +	if (is_error_pfn(pfn)) {
> +		ret = -EFAULT;
> +		goto out_put_existing;
> +	}
> +
> +	/* We need minimum second+third level pages */
> +	ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
> +	if (ret)
> +		goto out;
> +	new_pte = pfn_pte(pfn, PAGE_KVM_GUEST);
> +	if (writable)
> +		pte_val(new_pte) |= L_PTE2_WRITE;
> +	coherent_icache_guest_page(vcpu->kvm, gfn);

why don't you flush icache only when guest has mapped executable page
as __sync_icache_dcache function does currently?


> +
> +	spin_lock(&vcpu->kvm->arch.pgd_lock);
> +	stage2_set_pte(vcpu->kvm, memcache, fault_ipa, &new_pte);
> +	spin_unlock(&vcpu->kvm->arch.pgd_lock);
> +
> +out:
> +	/*
> +	 * XXX TODO FIXME:
> +	 * This is _really_ *weird* !!!
> +	 * We should only be calling the _dirty verison when we map
> something
> +	 * writable, but this causes memory failures in guests under heavy
> +	 * memory pressure on the host and heavy swapping.
> +	 */
> +	kvm_release_pfn_dirty(pfn);
> +out_put_existing:
> +	if (!is_error_pfn(pfn_existing))
> +		kvm_release_pfn_clean(pfn_existing);
> +	return ret;
> +}
> +
> +/**
> + * kvm_handle_guest_abort - handles all 2nd stage aborts
> + * @vcpu:	the VCPU pointer
> + * @run:	the kvm_run structure
> + *
> + * Any abort that gets to the host is almost guaranteed to be caused by
> +a
> + * missing second stage translation table entry, which can mean that
> +either the
> + * guest simply needs more memory and we must allocate an appropriate
> +page or it
> + * can mean that the guest tried to access I/O memory, which is
> +emulated by user
> + * space. The distinction is based on the IPA causing the fault and
> +whether this
> + * memory region has been registered as standard RAM by user space.
> + */
>  int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)  {
> -	return -EINVAL;
> +	unsigned long hsr_ec;
> +	unsigned long fault_status;
> +	phys_addr_t fault_ipa;
> +	struct kvm_memory_slot *memslot = NULL;
> +	bool is_iabt;
> +	gfn_t gfn;
> +	int ret;
> +
> +	hsr_ec = vcpu->arch.hsr >> HSR_EC_SHIFT;
> +	is_iabt = (hsr_ec == HSR_EC_IABT);
> +	fault_ipa = ((phys_addr_t)vcpu->arch.hpfar & HPFAR_MASK) << 8;
> +
> +	trace_kvm_guest_fault(*vcpu_pc(vcpu), vcpu->arch.hsr,
> +			      vcpu->arch.hdfar, vcpu->arch.hifar, fault_ipa);
> +
> +	/* Check the stage-2 fault is trans. fault or write fault */
> +	fault_status = (vcpu->arch.hsr & HSR_FSC_TYPE);
> +	if (fault_status != FSC_FAULT && fault_status != FSC_PERM) {
> +		kvm_err("Unsupported fault status: EC=%#lx DFCS=%#lx\n",
> +			hsr_ec, fault_status);
> +		return -EFAULT;
> +	}
> +
> +	gfn = fault_ipa >> PAGE_SHIFT;
> +	if (!kvm_is_visible_gfn(vcpu->kvm, gfn)) {
> +		if (is_iabt) {
> +			/* Prefetch Abort on I/O address */
> +			kvm_inject_pabt(vcpu, vcpu->arch.hifar);
> +			return 1;
> +		}
> +
> +		kvm_pr_unimpl("I/O address abort...");
> +		return 0;
> +	}
> +
> +	memslot = gfn_to_memslot(vcpu->kvm, gfn);
> +	if (!memslot->user_alloc) {
> +		kvm_err("non user-alloc memslots not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot,
> +			     is_iabt, fault_status);
> +	return ret ? ret : 1;
>  }
> 
>  static void handle_hva_to_gpa(struct kvm *kvm, unsigned long hva, diff --
> git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h index 772e045..40606c9
> 100644
> --- a/arch/arm/kvm/trace.h
> +++ b/arch/arm/kvm/trace.h
> @@ -39,6 +39,34 @@ TRACE_EVENT(kvm_exit,
>  	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)  );
> 
> +TRACE_EVENT(kvm_guest_fault,
> +	TP_PROTO(unsigned long vcpu_pc, unsigned long hsr,
> +		 unsigned long hdfar, unsigned long hifar,
> +		 unsigned long ipa),
> +	TP_ARGS(vcpu_pc, hsr, hdfar, hifar, ipa),
> +
> +	TP_STRUCT__entry(
> +		__field(	unsigned long,	vcpu_pc		)
> +		__field(	unsigned long,	hsr		)
> +		__field(	unsigned long,	hdfar		)
> +		__field(	unsigned long,	hifar		)
> +		__field(	unsigned long,	ipa		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->vcpu_pc		= vcpu_pc;
> +		__entry->hsr			= hsr;
> +		__entry->hdfar			= hdfar;
> +		__entry->hifar			= hifar;
> +		__entry->ipa			= ipa;
> +	),
> +
> +	TP_printk("guest fault at PC %#08lx (hdfar %#08lx, hifar %#08lx, "
> +		  "ipa %#08lx, hsr %#08lx",
> +		  __entry->vcpu_pc, __entry->hdfar, __entry->hifar,
> +		  __entry->hsr, __entry->ipa)
> +);
> +
>  TRACE_EVENT(kvm_irq_line,
>  	TP_PROTO(unsigned int type, int vcpu_idx, int irq_num, int level),
>  	TP_ARGS(type, vcpu_idx, irq_num, level),
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
