From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Nov 2010 09:14:52 +0000
Subject: [PATCH v2 02/20] ARM: LPAE: Factor out 2-level page table
	definitions into separate files
In-Reply-To: <20101115233129.GG31421@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-3-git-send-email-catalin.marinas@arm.com>
	<20101115233129.GG31421@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikrz+yM6idm-aij10vsKZMVSOBfZSdeEJbDRwiC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2010 23:31, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 12, 2010 at 06:00:22PM +0000, Catalin Marinas wrote:
>> This patch moves page table definitions from asm/page.h, asm/pgtable.h
>> and asm/ptgable-hwdef.h into corresponding *-2level* files.
>
> This also introduces pteval_t. ?It would be useful to have the
> introduction of pteval_t as a separate patch, which not only
> introduces the typedef, but also makes use of it.

I can do this. I missed this while splitting my initial big diff.

>> +#ifndef _ASM_PGTABLE_2LEVEL_TYPES_H
>> +#define _ASM_PGTABLE_2LEVEL_TYPES_H
>> +
>> +#undef STRICT_MM_TYPECHECKS
>> +
>> +typedef unsigned long pteval_t;
>> +
>> +#ifdef STRICT_MM_TYPECHECKS
>> +/*
>> + * These are used to make use of C type-checking..
>> + */
>> +typedef struct { unsigned long pte; } pte_t;
>
> This should become:
>
> typedef struct { pteval_t pte; } pte_t;
>
> L_PTE_* can then be declared using linux/const.h stuff to typedef them
> to pteval_t.

I already do this for LPAE but can be done for the 2-level definitions
for consistency.

BTW, do you think it's worth adding STRICT_MM_TYPECHECKS for LPAE as
well? It would probably spot some issues.

> shared_pte_mask also needs to be pteval_t.

That's done in the 3rd version of the series.

> As far as the __p*_error() functions, these should probably be passed
> the pte/pmd/pgd value itself, rather than first passing them through
> __pte_val() et.al.
>
> Of couse, I now have patches for this and my other points... will sort
> them out into a series in the next few days.

Thanks.

-- 
Catalin
