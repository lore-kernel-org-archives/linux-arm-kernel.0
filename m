From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Nov 2010 17:38:36 +0000
Subject: [PATCH 1/5] ARM: pgtable: switch order of Linux vs hardware page
	tables
In-Reply-To: <AANLkTinn+3TpNrvTwY47npRBwR49dDR6Ny9MAgWdLEOV@mail.gmail.com>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
	<E1PIloA-0007qU-ME@rmk-PC.arm.linux.org.uk>
	<AANLkTinn+3TpNrvTwY47npRBwR49dDR6Ny9MAgWdLEOV@mail.gmail.com>
Message-ID: <AANLkTikG6uaXYNTXmPhbA1v2H+4jRqjKrb4zVmTW-iOk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2010 16:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On 17 November 2010 17:28, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> This switches the ordering of the Linux vs hardware page tables in
>> each page, thereby eliminating some of the arithmetic in the page
>> table walks. ?As we now place the Linux page table at the beginning
>> of the page, we can deal with the offset in the pgt by simply masking
>> it away, along with the other control bits.
> [...]
>> -static inline void __pmd_populate(pmd_t *pmdp, unsigned long pmdval)
>> +static inline void __pmd_populate(pmd_t *pmdp, unsigned long pte, unsigned long prot)
>> ?{
>> + ? ? ? unsigned long pmdval = (pte + PTE_HWTABLE_OFF) | prot;
>
> Since I'm introducing pmdval_t with LPAE patches, would it make sense
> in your patch to pass pteval_t or I should just keep it in my patches?
>
> -static inline void __pmd_populate(pmd_t *pmdp, unsigned long pmdval)
> +static inline void __pmd_populate(pmd_t *pmdp, pteval_t pte, unsigned long prot)

I think your initial version is correct since the pte above is
actually a physical address. We'll change it to phys_addr_t.

-- 
Catalin
