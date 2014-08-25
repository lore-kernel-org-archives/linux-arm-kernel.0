From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 25 Aug 2014 11:34:34 -0700
Subject: [PATCHv3 5/7] arm64: Factor out fixmap initialiation from ioremap
In-Reply-To: <CAGXu5jK64cOKkh0pSj63P3O0ZXuyCJET7w-W=9qd6b74pxRH4w@mail.gmail.com>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>	<1408584039-12735-6-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jK64cOKkh0pSj63P3O0ZXuyCJET7w-W=9qd6b74pxRH4w@mail.gmail.com>
Message-ID: <53FB81BA.2040908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/2014 10:45 PM, Kees Cook wrote:
> On Wed, Aug 20, 2014 at 6:20 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>>
>> The fixmap API was originally added for arm64 for
>> early_ioremap purposes. It can be used for other purposes too
>> so move the initialization from ioremap to somewhere more
>> generic. This makes it obvious where the fixmap is being set
>> up and allows for a cleaner implementation of __set_fixmap.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
...
>> +void __init early_fixmap_init(void)
>> +{
>> +       pgd_t *pgd;
>> +       pud_t *pud;
>> +       pmd_t *pmd;
>> +       unsigned long addr = FIXADDR_START;
>> +
>> +       pgd = pgd_offset_k(addr);
>> +       pgd_populate(&init_mm, pgd, bm_pud);
>> +       pud = pud_offset(pgd, addr);
>> +       pud_populate(&init_mm, pud, bm_pmd);
>> +       pmd = pmd_offset(pud, addr);
>> +       pmd_populate_kernel(&init_mm, pmd, bm_pte);
>> +
>> +       /*
>> +        * The boot-ioremap range spans multiple pmds, for which
>> +        * we are not preparted:
>> +        */
>> +       BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
>> +                    != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
>> +
>> +       if ((pmd != fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)))
>> +            || pmd != fixmap_pmd(fix_to_virt(FIX_BTMAP_END))) {
>> +               WARN_ON(1);
>> +               pr_warn("pmd %p != %p, %p\n",
>> +                       pmd, fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)),
>> +                       fixmap_pmd(fix_to_virt(FIX_BTMAP_END)));
>> +               pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
>> +                       fix_to_virt(FIX_BTMAP_BEGIN));
>> +               pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
>> +                       fix_to_virt(FIX_BTMAP_END));
>> +
>> +               pr_warn("FIX_BTMAP_END:       %d\n", FIX_BTMAP_END);
>> +               pr_warn("FIX_BTMAP_BEGIN:     %d\n", FIX_BTMAP_BEGIN);
>> +       }
>> +}
>> +
>> +void __set_fixmap(enum fixed_addresses idx,
>> +                              phys_addr_t phys, pgprot_t flags)
>> +{
>> +       unsigned long addr = __fix_to_virt(idx);
>> +       pte_t *pte;
>> +
>> +       if (idx >= __end_of_fixed_addresses) {
>> +               BUG();
>> +               return;
>> +       }
> 
> Is it worth cleaning this up into BUG_ON instead of BUG; return; ?
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees

I'm guessing this was set up for error handling even if CONFIG_BUG
is turned off.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
