From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 13 Jan 2016 17:10:31 +0100
Subject: [PATCH] arm64: Allow vmalloc regions to be set with set_memory_*
In-Reply-To: <CAKv+Gu_A1C9hXgqrYDekoy1YHaRXi_mUF-kYx-TqsOBkWMVjmQ@mail.gmail.com>
References: <1452635187-8057-1-git-send-email-labbott@fedoraproject.org>
 <CAKv+Gu_A1C9hXgqrYDekoy1YHaRXi_mUF-kYx-TqsOBkWMVjmQ@mail.gmail.com>
Message-ID: <CAKv+Gu-73QKAsFQCa=yO5+=DihLXp_AKYyY6QRTVM4nuDH=-8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2016 at 15:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 12 January 2016 at 22:46, Laura Abbott <labbott@fedoraproject.org> wrote:
>>
>> The range of set_memory_* is currently restricted to the module address
>> range because of difficulties in breaking down larger block sizes.
>> vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
>> function ranges and add a comment explaining why the range is restricted
>> the way it is.
>>
>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>> ---
>> This should let the protections for the eBPF work as expected, I don't
>> know if there is some sort of self test for thatL.
>
>
> This is going to conflict with my KASLR implementation, since it puts
> the kernel image right in the middle of the vmalloc area, and the
> kernel is obviously mapped with block mappings. In fact, I am
> proposing enabling huge-vmap for arm64 as well, since it seems an
> improvement generally, but also specifically allows me to unmap the
> __init section using the generic vunmap code (remove_vm_area). But in
> general, I think the assumption that the whole vmalloc area is mapped
> using pages is not tenable.
>
> AFAICT, vmalloc still use pages exclusively even with huge-vmap (but
> ioremap does not). So perhaps it would make sense to check for the
> VM_ALLOC bit in the VMA flags (which I will not set for the kernel
> regions either)
>

Something along these lines, perhaps?

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 3571c7309c5e..bda0a776c58e 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/vmalloc.h>
 #include <linux/sched.h>

 #include <asm/pgtable.h>
@@ -44,6 +45,7 @@ static int change_memory_common(unsigned long addr
        unsigned long end = start + size;
        int ret;
        struct page_change_data data;
+       struct vm_struct *area;

        if (!PAGE_ALIGNED(addr)) {
                start &= PAGE_MASK;
@@ -51,10 +53,14 @@ static int change_memory_common(unsigned long addr,
                WARN_ON_ONCE(1);
        }

-       if (start < MODULES_VADDR || start >= MODULES_END)
-               return -EINVAL;
-
-       if (end < MODULES_VADDR || end >= MODULES_END)
+       /*
+        * Check whether the [addr, addr + size) interval is entirely
+        * covered by precisely one VM area that has the VM_ALLOC flag set
+        */
+       area = find_vm_area((void *)addr);
+       if (!area ||
+           end > (unsigned long)area->addr + area->size ||
+           !(area->flags & VM_ALLOC))
                return -EINVAL;

        data.set_mask = set_mask;


>
>> ---
>>  arch/arm64/mm/pageattr.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 3571c73..274208e 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -36,6 +36,26 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
>>         return 0;
>>  }
>>
>> +static bool validate_addr(unsigned long start, unsigned long end)
>> +{
>> +       /*
>> +        * This check explicitly excludes most kernel memory. Most kernel
>> +        * memory is mapped with a larger page size and breaking down the
>> +        * larger page size without causing TLB conflicts is very difficult.
>> +        *
>> +        * If you need to call set_memory_* on a range, the recommendation is
>> +        * to use vmalloc since that range is mapped with pages.
>> +        */
>> +       if (start >= MODULES_VADDR && start < MODULES_END &&
>> +           end >= MODULES_VADDR && end < MODULES_END)
>> +               return true;
>> +
>> +       if (is_vmalloc_addr(start) && is_vmalloc_addr(end))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>  static int change_memory_common(unsigned long addr, int numpages,
>>                                 pgprot_t set_mask, pgprot_t clear_mask)
>>  {
>> @@ -51,10 +71,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>>                 WARN_ON_ONCE(1);
>>         }
>>
>> -       if (start < MODULES_VADDR || start >= MODULES_END)
>> -               return -EINVAL;
>> -
>> -       if (end < MODULES_VADDR || end >= MODULES_END)
>> +       if (!validate_addr(start, end))
>>                 return -EINVAL;
>>
>>         data.set_mask = set_mask;
>> --
>> 2.5.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
