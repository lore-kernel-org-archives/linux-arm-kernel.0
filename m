From: alex@ghiti.fr (Alex Ghiti)
Date: Thu, 5 Jul 2018 10:48:53 +0000
Subject: [PATCH v3 02/11] hugetlb: Introduce generic version of
 hugetlb_free_pgd_range
In-Reply-To: <005bf713-fb51-bf29-5f86-6f244cd49f35@c-s.fr>
References: <20180705051640.790-1-alex@ghiti.fr>
 <20180705051640.790-3-alex@ghiti.fr>
 <005bf713-fb51-bf29-5f86-6f244cd49f35@c-s.fr>
Message-ID: <bd8ee99c-a89b-c114-9b0e-8e36601c50c6@ghiti.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My bad, when I moved the #include <asm-generic/hugeltb.h> at the bottom 
of the file, I did not pay attention to that #ifdef.
I'm going to fix powerpc and check other architectures if I did not make 
the same mistake.
I'll send a v4 as soon as possible.

Thanks for your comment,

Alex

On 07/05/2018 10:22 AM, Christophe Leroy wrote:
>
>
> On 07/05/2018 05:16 AM, Alexandre Ghiti wrote:
>> arm, arm64, mips, parisc, sh, x86 architectures use the
>> same version of hugetlb_free_pgd_range, so move this generic
>> implementation into asm-generic/hugetlb.h.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>
> Build failure on mpc885_ads_defconfig
>
> ? CC????? arch/powerpc/kernel/setup-common.o
> In file included from arch/powerpc/kernel/setup-common.c:37:
> ./include/linux/hugetlb.h:191:65: error: expected identifier or '(' 
> before '{' token
> ?#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) 
> ({BUG(); 0; })
> ???????????????????????????????????????????????????????????????? ^
> ./include/asm-generic/hugetlb.h:44:20: note: in expansion of macro 
> 'hugetlb_free_pgd_range'
> ?static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> ??????????????????? ^~~~~~~~~~~~~~~~~~~~~~
>
> see below
>
>> ---
>> ? arch/arm/include/asm/hugetlb.h???? | 12 ++----------
>> ? arch/arm64/include/asm/hugetlb.h?? | 10 ----------
>> ? arch/ia64/include/asm/hugetlb.h??? |? 5 +++--
>> ? arch/mips/include/asm/hugetlb.h??? | 13 ++-----------
>> ? arch/parisc/include/asm/hugetlb.h? | 12 ++----------
>> ? arch/powerpc/include/asm/hugetlb.h |? 4 +++-
>> ? arch/sh/include/asm/hugetlb.h????? | 12 ++----------
>> ? arch/sparc/include/asm/hugetlb.h?? |? 4 +++-
>> ? arch/x86/include/asm/hugetlb.h???? | 11 ++---------
>> ? include/asm-generic/hugetlb.h????? | 11 +++++++++++
>> ? 10 files changed, 30 insertions(+), 64 deletions(-)
>>
>
> [snip]
>
>> diff --git a/arch/powerpc/include/asm/hugetlb.h 
>> b/arch/powerpc/include/asm/hugetlb.h
>> index 3225eb6402cc..de46ee16b615 100644
>> --- a/arch/powerpc/include/asm/hugetlb.h
>> +++ b/arch/powerpc/include/asm/hugetlb.h
>> @@ -4,7 +4,6 @@
>> ? ? #ifdef CONFIG_HUGETLB_PAGE
>> ? #include <asm/page.h>
>> -#include <asm-generic/hugetlb.h>
>> ? ? extern struct kmem_cache *hugepte_cache;
>> ? @@ -113,6 +112,7 @@ static inline void flush_hugetlb_page(struct 
>> vm_area_struct *vma,
>> ? void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long 
>> vmaddr);
>> ? #endif
>> ? +#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>> ? void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long 
>> addr,
>> ????????????????? unsigned long end, unsigned long floor,
>> ????????????????? unsigned long ceiling);
>> @@ -193,4 +193,6 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, 
>> unsigned long addr,
>> ? }
>> ? #endif /* CONFIG_HUGETLB_PAGE */
>> ? +#include <asm-generic/hugetlb.h>
>> +
>
> That include was previously inside #ifdef CONFIG_HUGETLB_PAGE.
> Why put it outside ?
>
> Christophe
>
