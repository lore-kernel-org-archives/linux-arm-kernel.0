From: r.sricharan@ti.com (R Sricharan)
Date: Mon, 4 Feb 2013 16:40:36 +0530
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned
 addresses
In-Reply-To: <510F3CA3.7080604@ti.com>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
 <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
 <20130201174246.GJ5151@arm.com> <510F3BA8.8070700@ti.com>
 <510F3CA3.7080604@ti.com>
Message-ID: <510F972C.6020103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 04 February 2013 10:14 AM, R Sricharan wrote:
> On Monday 04 February 2013 10:10 AM, R Sricharan wrote:
>> Hi Catalin,
>>
>> [ snip..]
>>>
>>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>>> index 9f06102..47154f3 100644
>>> --- a/arch/arm/mm/mmu.c
>>> +++ b/arch/arm/mm/mmu.c
>>> @@ -581,34 +581,36 @@ static void __init alloc_init_section(pud_t
>>> *pud, unsigned long addr,
>>>                         const struct mem_type *type)
>>>   {
>>>       pmd_t *pmd = pmd_offset(pud, addr);
>>> +    unsigned long next;
>>>
>>> -    /*
>>> -     * Try a section mapping - end, addr and phys must all be aligned
>>> -     * to a section boundary.  Note that PMDs refer to the individual
>>> -     * L1 entries, whereas PGDs refer to a group of L1 entries making
>>> -     * up one logical pointer to an L2 table.
>>> -     */
>>> -    if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) ==
>>> 0) {
>>> -        pmd_t *p = pmd;
>>> +    do {
>>> +        next = pmd_addr_end(addr, end);
>>> +
>>> +        /*
>>> +         * Try a section mapping - next, addr and phys must all be
>>> +         * aligned to a section boundary.  Note that PMDs refer to the
>>> +         * individual L1 entries, whereas PGDs refer to a group of L1
>>> +         * entries making up one logical pointer to an L2 table.
>>> +         */
>>> +        if (((addr | next | phys) & ~SECTION_MASK) == 0) {
>>> +            pmd_t *p = pmd;
>>>
>>     There is a  need to do page mappings even when all the addresses
>>     are aligned. This was added with CMA, which required the initial
>>     mappings to be set with 2 level tables.
>>
>     Sorry, i wanted to ask type->prot_sect is removed here and is that
>    intentional?
       Tested this patch on OMAP5. The type->prot_sect check is
       required, without which mappings are not even created for CMA.
       (ie) type->prot_sect is not set when this function is called
       in CMA context, thus no valid mapping is created.

       After fixing this, the LPAE + CMA enabled combination booted
       fine on OMAP5.

Regards,
  Sricharan
