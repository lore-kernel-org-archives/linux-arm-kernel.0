From: tuffkidtt@gmail.com (Gavin Guo)
Date: Tue, 8 May 2012 11:40:44 +0800
Subject: Some questions in v6_copy_user_highpage_aliasing
Message-ID: <CAAh6nknA37QL2FeZDWvGwkndxKkR7RC1c46-DdzVs+2tUcv5=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have traced v6_copy_user_highpage_aliasing in arch/arm/mm/copypage-v6.c
and found some questions.

 72 /*
 73  * Copy the page, taking account of the cache colour.
 74  */
 75 static void v6_copy_user_highpage_aliasing(struct page *to,
 76         struct page *from, unsigned long vaddr)
 77 {
 78         unsigned int offset = CACHE_COLOUR(vaddr);
 79         unsigned long kfrom, kto;
 80

I think the following statement is to solve aliasing problem that
kernel & user address map to the same physical frame. When
the kernel mapping is dirty, writing back is needed before the copy_page()
is used. Because the color bit of user space address & kernel one
may be difference which cause inconsistency. Now, the problem is
what is the scenario of dirty cache. When does the PG_dcache_dirty
set ? In normal copy-on-write case, I think the if clause will be false.

 81         if (test_and_clear_bit(PG_dcache_dirty, &from->flags))
 82                 __flush_dcache_page(page_mapping(from), from);
 83

The problem is similar with before. Two virtual address map to "to",
in order to avoid the problem that when "kto" is copied with data "kfrom".
The cache data belong to kernel address mapping to "to" will not match
with the user one. Thus, invalidation of cache mapped by kernel address
is needed. But I don't know what will happen if invalidating
cache is removed. Where is the place that the problem will happen ?

 84         /* FIXME: not highmem safe */
 85         discard_old_kernel_data(page_address(to));
 86
 87         /*
 88          * Now copy the page using the same cache colour as the
 89          * pages ultimate destination.
 90          */
 91         spin_lock(&v6_lock);
 92
 93         set_pte_ext(TOP_PTE(from_address) + offset,
pfn_pte(page_to_pfn(from), PAGE_KERNEL), 0);
 94         set_pte_ext(TOP_PTE(to_address) + offset,
pfn_pte(page_to_pfn(to), PAGE_KERNEL), 0);
 95
 96         kfrom = from_address + (offset << PAGE_SHIFT);
 97         kto   = to_address + (offset << PAGE_SHIFT);
 98
 99         flush_tlb_kernel_page(kfrom);
100         flush_tlb_kernel_page(kto);
101
102         copy_page((void *)kto, (void *)kfrom);
103
104         spin_unlock(&v6_lock);
105 }

Thanks for your help, any comment is appreciated.

Regards,
Gavin
