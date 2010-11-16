From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Nov 2010 09:57:57 +0000
Subject: [PATCH v2 06/20] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <20101115183443.GE31421@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-7-git-send-email-catalin.marinas@arm.com>
	<20101115183443.GE31421@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=aWxekxZ-b59JNOjLArygcxOv1o4HwRt4t_xKh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2010 18:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 12, 2010 at 06:00:26PM +0000, Catalin Marinas wrote:
>> +#define PMD_TYPE_MASK ? ? ? ? ? ? ? ?(_AT(pmd_t, 3) << 0)
>> +#define PMD_TYPE_FAULT ? ? ? ? ? ? ? (_AT(pmd_t, 0) << 0)
>> +#define PMD_TYPE_TABLE ? ? ? ? ? ? ? (_AT(pmd_t, 3) << 0)
>> +#define PMD_TYPE_SECT ? ? ? ? ? ? ? ?(_AT(pmd_t, 1) << 0)
>> +#define PMD_BIT4 ? ? ? ? ? ? (_AT(pmd_t, 0))
>> +#define PMD_DOMAIN(x) ? ? ? ? ? ? ? ?(_AT(pmd_t, 0))
>
> It is really not correct to have these constants type'd as pmd_t.
> The idea behind pmd_t et.al. is to detect when normal arithmetic or
> logical operations are performed on page table entries when the
> accessors instead should be used.

OK, I can add pmdval_t (and pgdval_t) and use it for these definitions.

>> diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
>> index 6630620..a62f093 100644
>> --- a/arch/arm/mm/mm.h
>> +++ b/arch/arm/mm/mm.h
>> @@ -16,10 +16,10 @@ static inline pmd_t *pmd_off_k(unsigned long virt)
>> ?}
>>
>> ?struct mem_type {
>> - ? ? unsigned int prot_pte;
>> - ? ? unsigned int prot_l1;
>> - ? ? unsigned int prot_sect;
>> - ? ? unsigned int domain;
>> + ? ? pgprot_t prot_pte;
>> + ? ? pgprot_t prot_l1;
>> + ? ? pgprot_t prot_sect;
>> + ? ? pgprot_t domain;
>
> Again, this is wrong. ?There's an accessor for pgprot_t typed data. ?This
> causes code to violate it.

OK, I'll define pgprotval_t and accessors.

-- 
Catalin
