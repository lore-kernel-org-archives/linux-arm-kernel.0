From: james.morse@arm.com (James Morse)
Date: Mon, 1 Oct 2018 14:49:05 +0100
Subject: [PATCH v5 3/6] arm64/mm: Create the initial page table in the
 init_pg_dir.
In-Reply-To: <20180924133437.zr2u5c42rfmhro6o@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-4-yaojun8558363@gmail.com>
 <20180924133437.zr2u5c42rfmhro6o@lakrids.cambridge.arm.com>
Message-ID: <d3e8eae0-3429-d0ab-9e77-a56e26791450@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 24/09/18 14:34, Mark Rutland wrote:
> On Mon, Sep 17, 2018 at 12:43:30PM +0800, Jun Yao wrote:
>> Create the initial page table in the init_pg_dir. And update the
>> init_mm.pgd to make sure that pgd_offset_k() works correctly. When
>> the final page table is created, we redirect the init_mm.pgd to the
>> swapper_pg_dir.

>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index de2aaea00bd2..cf8a58211b80 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -376,7 +376,7 @@ __create_page_tables:
>>  	/*
>>  	 * Map the kernel image (starting with PHYS_OFFSET).
>>  	 */
>> -	adrp	x0, swapper_pg_dir
>> +	adrp	x0, init_pg_dir
>>  	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
>>  	add	x5, x5, x23			// add KASLR displacement
>>  	mov	x4, PTRS_PER_PGD
>> @@ -439,6 +439,11 @@ __primary_switched:
>>  	bl	__pi_memset
>>  	dsb	ishst				// Make zero page visible to PTW
>>  
>> +	// Update init_mm.pgd
>> +	adrp	x0, init_pg_dir
>> +	adr_l	x1, init_mm
>> +	str	x0, [x1, #MM_PGD]
>> +
> 
> We should be able to set this up statically with INIT_MM_CONTEXT(). i.e.
> in <asm/mmu.h> have:
> 
> #define INIT_MM_CONTEXT(name)	\
> 	.pgd = init_pg_dir

Aha, I didn't think this would be possible because we end up setting .pgd twice,
but gcc says that's fine, it gets the last value:
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

(and it looks like clang has a test for this)


Thanks,

James
