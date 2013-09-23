From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Sep 2013 15:46:27 +0100
Subject: [PATCH 3/3] KVM: ARM: Transparent huge pages and hugetlbfs support
In-Reply-To: <524013BB.4090303@arm.com>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
 <1376021239-10532-4-git-send-email-christoffer.dall@linaro.org>
 <524013BB.4090303@arm.com>
Message-ID: <52405443.7000709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/13 11:11, Marc Zyngier wrote:
> Hi Christoffer,
> 
> Finally taking some time to review this patch. Sorry for the delay...
> 
> On 09/08/13 05:07, Christoffer Dall wrote:
>> From: Christoffer Dall <cdall@cs.columbia.edu>
>>
>> Support transparent huge pages in KVM/ARM 32-bit and 64-bit.  The whole
>> transparent_hugepage_adjust stuff is far from pretty, but this is how
>> it's solved on x86 so we duplicate their logic.  This should be shared
>> across architectures if possible (like many other things), but can
>> always be changed down the road.
>>
>> The pud_huge checking on the unmap path may feel a bit silly as the
>> pud_huge check is always defined to false, but the compiler should be
>> smart about this.
>>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> ---
>>  arch/arm/include/asm/kvm_mmu.h   |   17 +++-
>>  arch/arm/kvm/mmu.c               |  200 ++++++++++++++++++++++++++++++++------
>>  arch/arm64/include/asm/kvm_mmu.h |   12 ++-
>>  3 files changed, 194 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 472ac70..ff3ff67 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -62,6 +62,12 @@ phys_addr_t kvm_get_idmap_vector(void);
>>  int kvm_mmu_init(void);
>>  void kvm_clear_hyp_idmap(void);
>>
>> +static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
>> +{
>> +       *pmd = new_pmd;
>> +       flush_pmd_entry(pmd);
>> +}
>> +
>>  static inline void kvm_set_pte(pte_t *pte, pte_t new_pte)
>>  {
>>         pte_val(*pte) = new_pte;
>> @@ -103,9 +109,15 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
>>         pte_val(*pte) |= L_PTE_S2_RDWR;
>>  }
>>
>> +static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
>> +{
>> +       pmd_val(*pmd) |= L_PTE_S2_RDWR;
>> +}
>> +
>>  struct kvm;
>>
>> -static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>> +static inline void coherent_icache_guest_page(struct kvm *kvm, hva_t hva,
>> +                                             unsigned long size)
>>  {
>>         /*
>>          * If we are going to insert an instruction page and the icache is
>> @@ -120,8 +132,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>>          * need any kind of flushing (DDI 0406C.b - Page B3-1392).
>>          */
>>         if (icache_is_pipt()) {
>> -               unsigned long hva = gfn_to_hva(kvm, gfn);
>> -               __cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
>> +               __cpuc_coherent_user_range(hva, hva + size);
>>         } else if (!icache_is_vivt_asid_tagged()) {
>>                 /* any kind of VIPT cache */
>>                 __flush_icache_all();
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 0988d9e..26ced77 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/mman.h>
>>  #include <linux/kvm_host.h>
>>  #include <linux/io.h>
>> +#include <linux/hugetlb.h>
>>  #include <trace/events/kvm.h>
>>  #include <asm/pgalloc.h>
>>  #include <asm/cacheflush.h>
>> @@ -41,6 +42,8 @@ static unsigned long hyp_idmap_start;
>>  static unsigned long hyp_idmap_end;
>>  static phys_addr_t hyp_idmap_vector;
>>
>> +#define kvm_pmd_huge(_x)       (pmd_huge(_x) || pmd_trans_huge(_x))

Also, have a look at Steve's latest patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/199812.html

He has the exact same define, so there's room for consolidation there as
well. Not a big issue though, and we can keep that for a later cleanup.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
