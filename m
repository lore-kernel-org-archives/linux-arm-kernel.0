From: keescook@chromium.org (Kees Cook)
Date: Wed, 6 Aug 2014 10:28:37 -0700
Subject: [PATCH v3 2/2] ARM : change fixmap mapping region to support 32
 CPUs
In-Reply-To: <alpine.LFD.2.11.1408061317590.6061@knanqh.ubzr>
References: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
 <1397559967-26050-3-git-send-email-sdu.liu@huawei.com>
 <CAL_JsqKE-L2PN3mXHNdTPMEyTMR9ZtbgGB=O_V6nOXN0YC0a4A@mail.gmail.com>
 <alpine.LFD.2.11.1405301441210.17310@knanqh.ubzr>
 <CAGXu5j+ga5Enrsd8LuYarGh1Ozakmi3MNw+b9fZ7ubGUJFZY=w@mail.gmail.com>
 <53E1A3A3.8080706@huawei.com>
 <CAGXu5jKxtm0YAojOLhd_O9AFUAX+xHgEwwB0W_fpN7Xy8wHphQ@mail.gmail.com>
 <alpine.LFD.2.11.1408061317590.6061@knanqh.ubzr>
Message-ID: <CAGXu5jJN9w=Md3aMkYwFcBVanXfSGL1BdZGZ74ic945B_ocuqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 6, 2014 at 10:21 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 6 Aug 2014, Kees Cook wrote:
>
>> With the original code, there is (I think) a page table entry for the
>> fixmap range. For the latter, there isn't. I see a NULL pgd entry
>> fault when trying to use it, and noticed that this only exists under
>> highmem:
>>
>> static void __init kmap_init(void)
>> {
>> #ifdef CONFIG_HIGHMEM
>>         pkmap_page_table = early_pte_alloc(pmd_off_k(PKMAP_BASE),
>>                 PKMAP_BASE, _PAGE_KERNEL_TABLE);
>>
>>         fixmap_page_table = early_pte_alloc(pmd_off_k(FIXADDR_START),
>>                 FIXADDR_START, _PAGE_KERNEL_TABLE);
>> #endif
>> }
>
> The above is wrong.  The fixmap PTEs must be allocated unconditionally
> irrespective of highmem.  So the #endif should be moved up by 3 lines.

That's what I was thinking. I tried this, and things are still weird,
though I think I'm narrowing it down. I made the early_pte_alloc
happen, but after boot it doesn't show up in
/sys/kernel/debug/kernel_page_tables. When I attempt a fixmap text
poke, I get this out of dmesg (lkdtm is reporting the address returned
from the patch mapping):

lkdtm: 80421ac0 mapped RW via ffdefac0
Unable to handle kernel paging request at virtual address ffdefac0
pgd = 9e888000
[ffdefac0] *pgd=9fffc811, *pte=00000000, *ppte=00000000
Internal error: Oops: 807 [#1] SMP ARM

The target address (0xffdefac0) is correct; it's in the range set aside:

#define FIXADDR_START           0xffc00000UL
#define FIXADDR_END             0xffe00000UL
#define FIXADDR_TOP             (FIXADDR_END - PAGE_SIZE)

enum fixed_addresses {
        /* Support 16 CPUs for kmap as the first region of fixmap entries. */
        FIX_KMAP_BEGIN,
        FIX_KMAP_END = 15,

        /* Support writing RO kernel text via kprobes, jump labels, etc. */
        FIX_TEXT_POKE0,
        FIX_TEXT_POKE1,

        __end_of_fixed_addresses
};

But the resulting PTE is in totally the wrong location as reported by
/sys/kernel/debug/kernel_page_tables:

---[ Fixmap Area ]---
0xfffef000-0xffff0000           4K     RW NX SHD MEM/CACHED/WBWA

I continue to dig...

-Kees

-- 
Kees Cook
Chrome OS Security
