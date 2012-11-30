From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 16:40:37 -0500
Subject: [PATCH v4 13/14] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <20121119150737.GE3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154342.2836.9669.stgit@chazy-air>
 <20121119150737.GE3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98qLNMTw5DGBJLPhXrMs_p5mvphxiEisrz4pLnMFpmm_eCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 10:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Nov 10, 2012 at 03:43:42PM +0000, Christoffer Dall wrote:
>> Handles the guest faults in KVM by mapping in corresponding user pages
>> in the 2nd stage page tables.
>>
>> We invalidate the instruction cache by MVA whenever we map a page to the
>> guest (no, we cannot only do it when we have an iabt because the guest
>> may happily read/write a page before hitting the icache) if the hardware
>> uses VIPT or PIPT.  In the latter case, we can invalidate only that
>> physical page.  In the first case, all bets are off and we simply must
>> invalidate the whole affair.  Not that VIVT icaches are tagged with
>> vmids, and we are out of the woods on that one.  Alexander Graf was nice
>> enough to remind us of this massive pain.
>>
>> There is also  a subtle bug hidden somewhere, which we currently hide by
>> marking all pages dirty even when the pages are only mapped read-only.  The
>> current hypothesis is that marking pages dirty may exercise the IO system and
>> data cache more and therefore we don't see stale data in the guest, but it's
>> purely guesswork.  The bug is manifested by seemingly random kernel crashes in
>> guests when the host is under extreme memory pressure and swapping is enabled.
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> [...]
>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index f45be86..6c9ee3a 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -21,9 +21,11 @@
>>  #include <linux/io.h>
>>  #include <asm/idmap.h>
>>  #include <asm/pgalloc.h>
>> +#include <asm/cacheflush.h>
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_mmu.h>
>>  #include <asm/kvm_asm.h>
>> +#include <asm/kvm_emulate.h>
>>  #include <asm/mach/map.h>
>>  #include <trace/events/kvm.h>
>>
>> @@ -503,9 +505,150 @@ out:
>>         return ret;
>>  }
>>
>> +static void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>> +{
>> +       /*
>> +        * If we are going to insert an instruction page and the icache is
>> +        * either VIPT or PIPT, there is a potential problem where the host
>
> Why are PIPT caches affected by this? The virtual address is irrelevant.
>

The comment is slightly misleading, and I'll update it. Just so we're
clear, this is the culprit:

1. guest uses page X, containing instruction A
2. page X gets swapped out
3. host uses page X, containing instruction B
4. instruction B enters i-cache at page X's cache line
5. page X gets swapped out
6. guest swaps page X back in
7. guest executes instruction B from cache, should execute instruction A

The point is that with PIPT we can flush only that page from the
icache using the host virtual address, as the MMU will do the
translation on the fly. In the VIPT we have to nuke the whole thing
(unless we .

>> +        * (or another VM) may have used this page at the same virtual address
>> +        * as this guest, and we read incorrect data from the icache.  If
>> +        * we're using a PIPT cache, we can invalidate just that page, but if
>> +        * we are using a VIPT cache we need to invalidate the entire icache -
>> +        * damn shame - as written in the ARM ARM (DDI 0406C - Page B3-1384)
>> +        */
>> +       if (icache_is_pipt()) {
>> +               unsigned long hva = gfn_to_hva(kvm, gfn);
>> +               __cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
>> +       } else if (!icache_is_vivt_asid_tagged()) {
>> +               /* any kind of VIPT cache */
>> +               __flush_icache_all();
>> +       }
>
> so what if it *is* vivt_asid_tagged? Surely that necessitates nuking the
> thing, unless it's VMID tagged as well (does that even exist?).
>

see page B3-1392 in the ARM ARM, if it's vivt_asid_tagged it is also
vmid tagged.

>> +}
>> +
>> +static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>> +                         gfn_t gfn, struct kvm_memory_slot *memslot,
>> +                         bool is_iabt, unsigned long fault_status)
>> +{
>> +       pte_t new_pte;
>> +       pfn_t pfn;
>> +       int ret;
>> +       bool write_fault, writable;
>> +       unsigned long mmu_seq;
>> +       struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
>> +
>> +       if (is_iabt)
>> +               write_fault = false;
>> +       else if ((vcpu->arch.hsr & HSR_ISV) && !(vcpu->arch.hsr & HSR_WNR))
>
> Put this hsr parsing in a macro/function? Then you can just assign
> write_fault directly.
>

ok

>> +               write_fault = false;
>> +       else
>> +               write_fault = true;
>> +
>> +       if (fault_status == FSC_PERM && !write_fault) {
>> +               kvm_err("Unexpected L2 read permission error\n");
>> +               return -EFAULT;
>> +       }
>> +
>> +       /* We need minimum second+third level pages */
>> +       ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mmu_seq = vcpu->kvm->mmu_notifier_seq;
>> +       smp_rmb();
>
> What's this barrier for and why isn't there a write barrier paired with
> it?
>

The read barrier is to ensure that mmu_notifier_seq is read before we
call gfn_to_pfn_prot (which is essentially get_user_pages), so that we
don't get a page which is unmapped by an MMU notifier before we grab
the spinlock that we would never see. I also added a comment
explaining it in the patch below.

There is a write barrier paired with it, see virt/kvm/kvm_main.c,
specifically kvm_mmu_notifier_invalidate_page (the spin_unlock), and
kvm_mmu_notifier_invalidate_range_end.


See the following patch:

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
index 50deb74..503aa0f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -497,11 +497,14 @@ static void coherent_icache_guest_page(struct
kvm *kvm, gfn_t gfn)
 	/*
 	 * If we are going to insert an instruction page and the icache is
 	 * either VIPT or PIPT, there is a potential problem where the host
-	 * (or another VM) may have used this page at the same virtual address
-	 * as this guest, and we read incorrect data from the icache.  If
-	 * we're using a PIPT cache, we can invalidate just that page, but if
-	 * we are using a VIPT cache we need to invalidate the entire icache -
-	 * damn shame - as written in the ARM ARM (DDI 0406C - Page B3-1384)
+	 * (or another VM) may have used the same page as this guest, and we
+	 * read incorrect data from the icache.  If we're using a PIPT cache,
+	 * we can invalidate just that page, but if we are using a VIPT cache
+	 * we need to invalidate the entire icache - damn shame - as written
+	 * in the ARM ARM (DDI 0406C.b - Page B3-1393).
+	 *
+	 * VIVT caches are tagged using both the ASID and the VMID and doesn't
+	 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
 	 */
 	if (icache_is_pipt()) {
 		unsigned long hva = gfn_to_hva(kvm, gfn);
@@ -514,7 +517,7 @@ static void coherent_icache_guest_page(struct kvm
*kvm, gfn_t gfn)

 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  gfn_t gfn, struct kvm_memory_slot *memslot,
-			  bool is_iabt, unsigned long fault_status)
+			  unsigned long fault_status)
 {
 	pte_t new_pte;
 	pfn_t pfn;
@@ -523,13 +526,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu,
phys_addr_t fault_ipa,
 	unsigned long mmu_seq;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;

-	if (is_iabt)
-		write_fault = false;
-	else if ((vcpu->arch.hsr & HSR_ISV) && !(vcpu->arch.hsr & HSR_WNR))
-		write_fault = false;
-	else
-		write_fault = true;
-
+	write_fault = kvm_is_write_fault(vcpu->arch.hsr);
 	if (fault_status == FSC_PERM && !write_fault) {
 		kvm_err("Unexpected L2 read permission error\n");
 		return -EFAULT;
@@ -541,6 +538,15 @@ static int user_mem_abort(struct kvm_vcpu *vcpu,
phys_addr_t fault_ipa,
 		return ret;

 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
+	/*
+	 * Ensure the read of mmu_notifier_seq happens before we call
+	 * gfn_to_pfn_prot (which calls get_user_pages), so that we don't risk
+	 * the page we just got a reference to gets unmapped before we have a
+	 * chance to grab the mmu_lock, which ensure that if the page gets
+	 * unmapped afterwards, the call to kvm_unmap_hva will take it away
+	 * from us again properly. This smp_rmb() interacts with the smp_wmb()
+	 * in kvm_mmu_notifier_invalidate_<page|range_end>.
+	 */
 	smp_rmb();

 	pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
@@ -627,8 +633,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu,
struct kvm_run *run)
 		return -EINVAL;
 	}

-	ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot,
-			     is_iabt, fault_status);
+	ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot, fault_status);
 	return ret ? ret : 1;
 }

--

Thanks!
-Christoffer
