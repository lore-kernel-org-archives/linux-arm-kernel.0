From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 15:07:37 +0000
Subject: [PATCH v4 13/14] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <20121110154342.2836.9669.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154342.2836.9669.stgit@chazy-air>
Message-ID: <20121119150737.GE3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:43:42PM +0000, Christoffer Dall wrote:
> Handles the guest faults in KVM by mapping in corresponding user pages
> in the 2nd stage page tables.
> 
> We invalidate the instruction cache by MVA whenever we map a page to the
> guest (no, we cannot only do it when we have an iabt because the guest
> may happily read/write a page before hitting the icache) if the hardware
> uses VIPT or PIPT.  In the latter case, we can invalidate only that
> physical page.  In the first case, all bets are off and we simply must
> invalidate the whole affair.  Not that VIVT icaches are tagged with
> vmids, and we are out of the woods on that one.  Alexander Graf was nice
> enough to remind us of this massive pain.
> 
> There is also  a subtle bug hidden somewhere, which we currently hide by
> marking all pages dirty even when the pages are only mapped read-only.  The
> current hypothesis is that marking pages dirty may exercise the IO system and
> data cache more and therefore we don't see stale data in the guest, but it's
> purely guesswork.  The bug is manifested by seemingly random kernel crashes in
> guests when the host is under extreme memory pressure and swapping is enabled.
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

[...]

> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index f45be86..6c9ee3a 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -21,9 +21,11 @@
>  #include <linux/io.h>
>  #include <asm/idmap.h>
>  #include <asm/pgalloc.h>
> +#include <asm/cacheflush.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_asm.h>
> +#include <asm/kvm_emulate.h>
>  #include <asm/mach/map.h>
>  #include <trace/events/kvm.h>
> 
> @@ -503,9 +505,150 @@ out:
>         return ret;
>  }
> 
> +static void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
> +{
> +       /*
> +        * If we are going to insert an instruction page and the icache is
> +        * either VIPT or PIPT, there is a potential problem where the host

Why are PIPT caches affected by this? The virtual address is irrelevant.

> +        * (or another VM) may have used this page at the same virtual address
> +        * as this guest, and we read incorrect data from the icache.  If
> +        * we're using a PIPT cache, we can invalidate just that page, but if
> +        * we are using a VIPT cache we need to invalidate the entire icache -
> +        * damn shame - as written in the ARM ARM (DDI 0406C - Page B3-1384)
> +        */
> +       if (icache_is_pipt()) {
> +               unsigned long hva = gfn_to_hva(kvm, gfn);
> +               __cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
> +       } else if (!icache_is_vivt_asid_tagged()) {
> +               /* any kind of VIPT cache */
> +               __flush_icache_all();
> +       }

so what if it *is* vivt_asid_tagged? Surely that necessitates nuking the
thing, unless it's VMID tagged as well (does that even exist?).

> +}
> +
> +static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> +                         gfn_t gfn, struct kvm_memory_slot *memslot,
> +                         bool is_iabt, unsigned long fault_status)
> +{
> +       pte_t new_pte;
> +       pfn_t pfn;
> +       int ret;
> +       bool write_fault, writable;
> +       unsigned long mmu_seq;
> +       struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> +
> +       if (is_iabt)
> +               write_fault = false;
> +       else if ((vcpu->arch.hsr & HSR_ISV) && !(vcpu->arch.hsr & HSR_WNR))

Put this hsr parsing in a macro/function? Then you can just assign
write_fault directly.

> +               write_fault = false;
> +       else
> +               write_fault = true;
> +
> +       if (fault_status == FSC_PERM && !write_fault) {
> +               kvm_err("Unexpected L2 read permission error\n");
> +               return -EFAULT;
> +       }
> +
> +       /* We need minimum second+third level pages */
> +       ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
> +       if (ret)
> +               return ret;
> +
> +       mmu_seq = vcpu->kvm->mmu_notifier_seq;
> +       smp_rmb();

What's this barrier for and why isn't there a write barrier paired with
it?

> +
> +       pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
> +       if (is_error_pfn(pfn))
> +               return -EFAULT;
> +
> +       new_pte = pfn_pte(pfn, PAGE_S2);
> +       coherent_icache_guest_page(vcpu->kvm, gfn);
> +
> +       spin_lock(&vcpu->kvm->mmu_lock);
> +       if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
> +               goto out_unlock;
> +       if (writable) {
> +               pte_val(new_pte) |= L_PTE_S2_RDWR;
> +               kvm_set_pfn_dirty(pfn);
> +       }
> +       stage2_set_pte(vcpu->kvm, memcache, fault_ipa, &new_pte, false);
> +
> +out_unlock:
> +       spin_unlock(&vcpu->kvm->mmu_lock);
> +       /*
> +        * XXX TODO FIXME:
> +-        * This is _really_ *weird* !!!
> +-        * We should be calling the _clean version, because we set the pfn dirty
> +        * if we map the page writable, but this causes memory failures in
> +        * guests under heavy memory pressure on the host and heavy swapping.
> +        */

We need to get to the bottom of this, or expand this comment and make it
more widely known that there is something not understood in KVM VM code
for ARM, otherwise we'll be shipping code that we know contains a serious
flaw and I worry that, being the first release, it will end up getting
deployed fairly widely (although the bug reports might be useful...).

Will
