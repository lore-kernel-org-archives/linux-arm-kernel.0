From: klimov.linux@gmail.com (Alexey Klimov)
Date: Wed, 22 Jul 2015 17:25:08 +0300
Subject: [PATCH v3 1/5] mm: kasan: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <1437561037-31995-2-git-send-email-a.ryabinin@samsung.com>
References: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
 <1437561037-31995-2-git-send-email-a.ryabinin@samsung.com>
Message-ID: <CALW4P++z9oJhWNCLLOV0xChdbNVuqokEBmzut08XKfQe1viknw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Could you please check minor comments below?

On Wed, Jul 22, 2015 at 1:30 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> Introduce generic kasan_populate_zero_shadow(start, end).
> This function maps kasan_zero_page to the [start, end] addresses.
>
> In follow on patches it will be used for ARMv8 (and maybe other
> architectures) and will replace x86_64 specific populate_zero_shadow().
>
> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
> ---
>  arch/x86/mm/kasan_init_64.c |   8 +--
>  include/linux/kasan.h       |   8 +++
>  mm/kasan/Makefile           |   2 +-
>  mm/kasan/kasan_init.c       | 142 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 155 insertions(+), 5 deletions(-)
>  create mode 100644 mm/kasan/kasan_init.c
>

[..]

> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
> new file mode 100644
> index 0000000..37fb46a
> --- /dev/null
> +++ b/mm/kasan/kasan_init.c
> @@ -0,0 +1,142 @@
> +#include <linux/bootmem.h>
> +#include <linux/init.h>
> +#include <linux/kasan.h>
> +#include <linux/kernel.h>
> +#include <linux/memblock.h>
> +#include <linux/pfn.h>
> +
> +#include <asm/page.h>
> +#include <asm/pgalloc.h>
> +

Are you releasing code under GPL?
Shouldn't there be any license header in such new file?


> +static __init void *early_alloc(size_t size, int node)
> +{
> +       return memblock_virt_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
> +                                       BOOTMEM_ALLOC_ACCESSIBLE, node);
> +}
> +
> +static int __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
> +                               unsigned long end)
> +{
> +       pte_t *pte = pte_offset_kernel(pmd, addr);
> +       pte_t zero_pte;
> +
> +       zero_pte = pfn_pte(PFN_DOWN(__pa(kasan_zero_page)), PAGE_KERNEL);
> +       zero_pte = pte_wrprotect(zero_pte);
> +
> +       while (addr + PAGE_SIZE <= end) {
> +               set_pte_at(&init_mm, addr, pte, zero_pte);
> +               addr += PAGE_SIZE;
> +               pte = pte_offset_kernel(pmd, addr);
> +       }
> +       return 0;
> +}
> +
> +static int __init zero_pmd_populate(pud_t *pud, unsigned long addr,
> +                               unsigned long end)
> +{
> +       int ret = 0;
> +       pmd_t *pmd = pmd_offset(pud, addr);
> +       unsigned long next;
> +
> +       do {
> +               next = pmd_addr_end(addr, end);
> +
> +               if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
> +                       pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +                       continue;
> +               }
> +
> +               if (pmd_none(*pmd)) {
> +                       void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +                       if (!p)
> +                               return -ENOMEM;
> +                       pmd_populate_kernel(&init_mm, pmd, p);
> +               }
> +               zero_pte_populate(pmd, addr, pmd_addr_end(addr, end));
> +       } while (pmd++, addr = next, addr != end);
> +
> +       return ret;

In zero_{pgd, pud, pmd}_populate you're not resetting ret variable
used as return value inside function so maybe you don't need ret
variable at all. What about return 0 in the end and -ENOMEM in error
case?



> +}
> +
> +static int __init zero_pud_populate(pgd_t *pgd, unsigned long addr,
> +                               unsigned long end)
> +{
> +       int ret = 0;
> +       pud_t *pud = pud_offset(pgd, addr);
> +       unsigned long next;
> +
> +       do {
> +               next = pud_addr_end(addr, end);
> +               if (IS_ALIGNED(addr, PUD_SIZE) && end - addr >= PUD_SIZE) {
> +                       pmd_t *pmd;
> +
> +                       pud_populate(&init_mm, pud, kasan_zero_pmd);
> +                       pmd = pmd_offset(pud, addr);
> +                       pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +                       continue;
> +               }
> +
> +               if (pud_none(*pud)) {
> +                       void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +                       if (!p)
> +                               return -ENOMEM;
> +                       pud_populate(&init_mm, pud, p);
> +               }
> +               zero_pmd_populate(pud, addr, pud_addr_end(addr, end));
> +       } while (pud++, addr = next, addr != end);
> +
> +       return ret;
> +}
> +
> +static int __init zero_pgd_populate(unsigned long addr, unsigned long end)
> +{
> +       int ret = 0;
> +       pgd_t *pgd = pgd_offset_k(addr);
> +       unsigned long next;
> +
> +       do {
> +               next = pgd_addr_end(addr, end);
> +
> +               if (IS_ALIGNED(addr, PGDIR_SIZE) && end - addr >= PGDIR_SIZE) {
> +                       pud_t *pud;
> +                       pmd_t *pmd;
> +
> +                       /*
> +                        * kasan_zero_pud should be populated with pmds
> +                        * at this moment.
> +                        * [pud,pmd]_populate*() bellow needed only for
> +                        * 3,2 - level page tables where we don't have
> +                        * puds,pmds, so pgd_populate(), pud_populate()
> +                        * is noops.
> +                        */
> +                       pgd_populate(&init_mm, pgd, kasan_zero_pud);
> +                       pud = pud_offset(pgd, addr);
> +                       pud_populate(&init_mm, pud, kasan_zero_pmd);
> +                       pmd = pmd_offset(pud, addr);
> +                       pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +                       continue;
> +               }
> +
> +               if (pgd_none(*pgd)) {
> +                       void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +                       if (!p)
> +                               return -ENOMEM;
> +                       pgd_populate(&init_mm, pgd, p);
> +               }
> +               zero_pud_populate(pgd, addr, next);

But you're not checking return value after zero_pud_populate() and
zero_pmd_populate() that might fail with ENOMEM.
Is it critical here on init or can they be converted to return void?


> +/**
> + * kasan_populate_zero_shadow - populate shadow memory region with
> + *                               kasan_zero_page
> + * @start - start of the memory range to populate
> + * @end   - end of the memory range to populate
> + */
> +void __init kasan_populate_zero_shadow(const void *start, const void *end)
> +{
> +       if (zero_pgd_populate((unsigned long)start, (unsigned long)end))
> +               panic("kasan: unable to map zero shadow!");
> +}
> --
> 2.4.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best regards, Klimov Alexey
