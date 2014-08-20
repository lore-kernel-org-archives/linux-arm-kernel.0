From: keescook@chromium.org (Kees Cook)
Date: Wed, 20 Aug 2014 07:16:34 -0500
Subject: [PATCH v4 2/8] ARM: expand fixmap region to 3MB
In-Reply-To: <20140819122653.GH23128@arm.com>
References: <1407949593-16121-1-git-send-email-keescook@chromium.org>
 <1407949593-16121-3-git-send-email-keescook@chromium.org>
 <20140819122653.GH23128@arm.com>
Message-ID: <CAGXu5jJRx8e2_9jpMYApH8maJog_z2YAs2ihoD4SFNfvPqn2Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 7:26 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Kees, Rob,
>
> On Wed, Aug 13, 2014 at 06:06:27PM +0100, Kees Cook wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> With commit a05e54c103b0 ("ARM: 8031/2: change fixmap mapping region to
>> support 32 CPUs"), the fixmap region was expanded to 2MB, but it
>> precluded any other uses of the fixmap region. In order to support other
>> uses the fixmap region needs to be expanded beyond 2MB. Fortunately, the
>> adjacent 1MB range 0xffe00000-0xfff00000 is availabe.
>>
>> Remove fixmap_page_table ptr and lookup the page table via the virtual
>> address so that the fixmap region can span more that one pmd. The 2nd
>> pmd is already created since it is shared with the vector page.
>
> [...]
>
>> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
>> index 45aeaaca9052..81061987ac45 100644
>> --- a/arch/arm/mm/highmem.c
>> +++ b/arch/arm/mm/highmem.c
>> @@ -18,19 +18,20 @@
>>  #include <asm/tlbflush.h>
>>  #include "mm.h"
>>
>> -pte_t *fixmap_page_table;
>> -
>>  static inline void set_fixmap_pte(int idx, pte_t pte)
>>  {
>>       unsigned long vaddr = __fix_to_virt(idx);
>> -     set_pte_ext(fixmap_page_table + idx, pte, 0);
>> +     pte_t *ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
>> +
>> +     set_pte_ext(ptep, pte, 0);
>>       local_flush_tlb_kernel_page(vaddr);
>>  }
>
> Minor comment, but we can drop the ifx parameter here now, right? It looks a
> bit weird having a setter/getter pair of functions where the type signatures
> aren't the inverse.

idx is used to get the vaddr here. I suppose the various users of
these functions in highmem could be reworked, but that doesn't look
sensible either. Maybe it's just the names of the functions that are
confusing?

-Kees

-- 
Kees Cook
Chrome OS Security
