From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Nov 2010 14:27:22 +0000
Subject: [PATCH 3/5] ARM: pgtable: introduce pteval_t to represent a pte
	value
In-Reply-To: <AANLkTi=iT_wG22WTax=2TUz7OPqgqvbFaqcz22h+c7=y@mail.gmail.com>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
	<E1PIlop-0007qc-1e@rmk-PC.arm.linux.org.uk>
	<AANLkTi=iT_wG22WTax=2TUz7OPqgqvbFaqcz22h+c7=y@mail.gmail.com>
Message-ID: <AANLkTiky6fWBLJm6E3y-5-JHe15hok_g3RoyuAHzisxx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2010 14:23, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On 17 November 2010 17:29, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> --- a/arch/arm/include/asm/pgtable.h
>> +++ b/arch/arm/include/asm/pgtable.h
>> @@ -10,6 +10,7 @@
>> ?#ifndef _ASMARM_PGTABLE_H
>> ?#define _ASMARM_PGTABLE_H
>>
>> +#include <linux/const.h>
>> ?#include <asm-generic/4level-fixup.h>
>> ?#include <asm/proc-fns.h>
>>
>> @@ -165,30 +166,30 @@ extern void __pgd_error(const char *file, int line, pgd_t);
>> ?* The PTE table pointer refers to the hardware entries; the "Linux"
>> ?* entries are stored 1024 bytes below.
>> ?*/
>> -#define L_PTE_PRESENT ? ? ? ? ?(1 << 0)
>> -#define L_PTE_YOUNG ? ? ? ? ? ?(1 << 1)
>> -#define L_PTE_FILE ? ? ? ? ? ? (1 << 2) ? ? ? ?/* only when !PRESENT */
>> -#define L_PTE_DIRTY ? ? ? ? ? ?(1 << 6)
>> -#define L_PTE_WRITE ? ? ? ? ? ?(1 << 7)
>> -#define L_PTE_USER ? ? ? ? ? ? (1 << 8)
>> -#define L_PTE_EXEC ? ? ? ? ? ? (1 << 9)
>> -#define L_PTE_SHARED ? ? ? ? ? (1 << 10) ? ? ? /* shared(v6), coherent(xsc3) */
>> +#define L_PTE_PRESENT ? ? ? ? ?(_AT(pteval_t, 1) << 0)
>> +#define L_PTE_YOUNG ? ? ? ? ? ?(_AT(pteval_t, 1) << 1)
>> +#define L_PTE_FILE ? ? ? ? ? ? (_AT(pteval_t, 1) << 2) /* only when !PRESENT */
>> +#define L_PTE_DIRTY ? ? ? ? ? ?(_AT(pteval_t, 1) << 6)
>> +#define L_PTE_WRITE ? ? ? ? ? ?(_AT(pteval_t, 1) << 7)
>> +#define L_PTE_USER ? ? ? ? ? ? (_AT(pteval_t, 1) << 8)
>> +#define L_PTE_EXEC ? ? ? ? ? ? (_AT(pteval_t, 1) << 9)
>> +#define L_PTE_SHARED ? ? ? ? ? (_AT(pteval_t, 1) << 10) ? ? ? ?/* shared(v6), coherent(xsc3) */
>
> One of my patches which adds pmdval_t etc. also defines the PMD_SECT_*
> macros with _AT(pmdval_t...). For consistency in the same file, I
> defined the PTE_* as _AT(pteval_t), though the latter are only used in
> .S files.

Ah, there is PTE_EXT_NG. Fortunately, that's bit 11 and it fits in
32-bit. So my proposal is to add _AT(pteval_t) to the PTE_*
definitions as well, unless you want to add a corresponding
L_PTE_EXT_NG.

-- 
Catalin
