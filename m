From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 27 Apr 2016 13:24:15 +0100
Subject: [PATCH RFC 05/10] ARM: Extract cp15 operations from cache flush
 code
In-Reply-To: <20160427092154.GI19428@n2100.arm.linux.org.uk>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
 <1461226702-27160-6-git-send-email-vladimir.murzin@arm.com>
 <20160427092154.GI19428@n2100.arm.linux.org.uk>
Message-ID: <5720AF6F.3050404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/16 10:21, Russell King - ARM Linux wrote:
> On Thu, Apr 21, 2016 at 09:18:17AM +0100, Vladimir Murzin wrote:
>> @@ -278,7 +273,7 @@ ENTRY(v7_coherent_user_range)
>>  	ALT_UP(W(nop))
>>  #endif
>>  1:
>> - USER(	mcr	p15, 0, r12, c7, c11, 1	)	@ clean D line to the point of unification
>> + USER(	dccmvau	r12 )		@ clean D line to the point of unification
> 
> While this is correct for this patch, I think it's incorrect for the v7m
> variant.  dccmvau expands to several instructions, the first is a mov,
> and the effect of the above will be to mark the mov as the user-accessing
> instruction, not the instruction which cleans the D line.
> 

Would open coded variant guarded with M_CLASS/AR_CLASS be acceptable here?

>> @@ -287,13 +282,11 @@ ENTRY(v7_coherent_user_range)
>>  	sub	r3, r2, #1
>>  	bic	r12, r0, r3
>>  2:
>> - USER(	mcr	p15, 0, r12, c7, c5, 1	)	@ invalidate I line
>> + USER(	icimvau r12 )	@ invalidate I line
> 
> Same problem.
>> @@ -358,13 +351,13 @@ v7_dma_inv_range:
>>  	ALT_SMP(W(dsb))
>>  	ALT_UP(W(nop))
>>  #endif
>> -	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
>> +	dccimvac r0 ne
> 
> I'd prefer the:
> 
> 	.irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
> 	.macro	dccimvac\c, ...
> 	.endm
> 	.endr
> 
> approach, so you can use
> 
> 	dccimvacne r0
> 
> here.
> 

I'll change.

Thanks!
Vladimir

>>  
>>  	tst	r1, r3
>>  	bic	r1, r1, r3
>> -	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D / U line
>> +	dccimvac r1 ne
>>  1:
>> -	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
>> +	dcimvac r0
>>  	add	r0, r0, r2
>>  	cmp	r0, r1
>>  	blo	1b
>> @@ -386,7 +379,7 @@ v7_dma_clean_range:
>>  	ALT_UP(W(nop))
>>  #endif
>>  1:
>> -	mcr	p15, 0, r0, c7, c10, 1		@ clean D / U line
>> +	dccmvac r0			@ clean D / U line
>>  	add	r0, r0, r2
>>  	cmp	r0, r1
>>  	blo	1b
>> @@ -408,7 +401,7 @@ ENTRY(v7_dma_flush_range)
>>  	ALT_UP(W(nop))
>>  #endif
>>  1:
>> -	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
>> +	dccimvac r0			 @ clean & invalidate D / U line
>>  	add	r0, r0, r2
>>  	cmp	r0, r1
>>  	blo	1b
>> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
>> index c671f34..a82800a 100644
>> --- a/arch/arm/mm/proc-macros.S
>> +++ b/arch/arm/mm/proc-macros.S
>> @@ -66,29 +66,6 @@
>>  	.endm
>>  
>>  /*
>> - * dcache_line_size - get the minimum D-cache line size from the CTR register
>> - * on ARMv7.
>> - */
>> -	.macro	dcache_line_size, reg, tmp
>> -	mrc	p15, 0, \tmp, c0, c0, 1		@ read ctr
>> -	lsr	\tmp, \tmp, #16
>> -	and	\tmp, \tmp, #0xf		@ cache line size encoding
>> -	mov	\reg, #4			@ bytes per word
>> -	mov	\reg, \reg, lsl \tmp		@ actual cache line size
>> -	.endm
>> -
>> -/*
>> - * icache_line_size - get the minimum I-cache line size from the CTR register
>> - * on ARMv7.
>> - */
>> -	.macro	icache_line_size, reg, tmp
>> -	mrc	p15, 0, \tmp, c0, c0, 1		@ read ctr
>> -	and	\tmp, \tmp, #0xf		@ cache line size encoding
>> -	mov	\reg, #4			@ bytes per word
>> -	mov	\reg, \reg, lsl \tmp		@ actual cache line size
>> -	.endm
>> -
>> -/*
>>   * Sanity check the PTE configuration for the code below - which makes
>>   * certain assumptions about how these bits are laid out.
>>   */
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index 6fcaac8..c7bcc0c 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -18,6 +18,7 @@
>>  #include <asm/pgtable.h>
>>  
>>  #include "proc-macros.S"
>> +#include "v7-cache-macros.S"
>>  
>>  #ifdef CONFIG_ARM_LPAE
>>  #include "proc-v7-3level.S"
>> diff --git a/arch/arm/mm/v7-cache-macros.S b/arch/arm/mm/v7-cache-macros.S
>> new file mode 100644
>> index 0000000..5212383
>> --- /dev/null
>> +++ b/arch/arm/mm/v7-cache-macros.S
>> @@ -0,0 +1,124 @@
>> +/*
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>> + *
>> + * Copyright (C) 2012 ARM Limited
>> + *
>> + * Author: Jonathan Austin <jonathan.austin@arm.com>
>> + */
>> +
>> +.macro	read_ctr, rt
>> +	mrc     p15, 0, \rt, c0, c0, 1
>> +.endm
>> +
>> +.macro	read_ccsidr, rt
>> +	mrc     p15, 1, \rt, c0, c0, 0
>> +.endm
>> +
>> +.macro read_clidr, rt
>> +	mrc	p15, 1, \rt, c0, c0, 1
>> +.endm
>> +
>> +.macro	write_csselr, rt
>> +	mcr     p15, 2, \rt, c0, c0, 0
>> +.endm
>> +
>> +/*
>> + * dcisw: invalidate data cache by set/way
>> + */
>> +.macro dcisw, rt
>> +	mcr     p15, 0, \rt, c7, c6, 2
>> +.endm
>> +
>> +/*
>> + * dccisw: clean and invalidate data cache by set/way
>> + */
>> +.macro dccisw, rt
>> +	mcr	p15, 0, \rt, c7, c14, 2
>> +.endm
>> +
>> +/*
>> + * dccimvac: Clean and invalidate data cache line by MVA to PoC.
>> + */
>> +.macro dccimvac, rt, cond = al
>> +	mcr\cond	p15, 0, \rt, c7, c14, 1
>> +.endm
>> +
>> +/*
>> + * dcimvac: Invalidate data cache line by MVA to PoC
>> + */
>> +.macro dcimvac, rt
>> +	mcr	p15, 0, r0, c7, c6, 1
>> +.endm
>> +
>> +/*
>> + * dccmvau: Clean data cache line by MVA to PoU
>> + */
>> +.macro dccmvau, rt
>> +	mcr	p15, 0, \rt, c7, c11, 1
>> +.endm
>> +
>> +/*
>> + * dccmvac: Clean data cache line by MVA to PoC
>> + */
>> +.macro dccmvac,  rt
>> +	mcr	p15, 0, \rt, c7, c10, 1
>> +.endm
>> +
>> +/*
>> + * icimvau: Invalidate instruction caches by MVA to PoU
>> + */
>> +.macro icimvau, rt
>> +	mcr	p15, 0, \rt, c7, c5, 1
>> +.endm
>> +
>> +/*
>> + * Invalidate the icache, inner shareable if SMP, invalidate BTB for UP.
>> + */
>> +.macro invalidate_icache, rt
>> +	mov	\rt, #0
>> +	ALT_SMP(mcr	p15, 0, \rt, c7, c1, 0)		@ icialluis: I-cache invalidate inner shareable
>> +	ALT_UP(mcr	p15, 0, \rt, c7, c5, 0)		@ iciallu: I+BTB cache invalidate
>> +.endm
>> +
>> +/*
>> + * Invalidate the BTB, inner shareable if SMP.
>> + */
>> +.macro invalidate_bp, rt
>> +	mov	\rt, #0
>> +	ALT_SMP(mcr	p15, 0, \rt, c7, c1, 6)		@ bpiallis: invalidate BTB inner shareable
>> +	ALT_UP(mcr	p15, 0, \rt, c7, c5, 6)		@ bpiall: invalidate BTB
>> +.endm
>> +
>> +/*
>> + * dcache_line_size - get the minimum D-cache line size from the CTR register
>> + * on ARMv7.
>> + */
>> +	.macro	dcache_line_size, reg, tmp
>> +	read_ctr \tmp
>> +	lsr	\tmp, \tmp, #16
>> +	and	\tmp, \tmp, #0xf		@ cache line size encoding
>> +	mov	\reg, #4			@ bytes per word
>> +	mov	\reg, \reg, lsl \tmp		@ actual cache line size
>> +	.endm
>> +
>> +/*
>> + * icache_line_size - get the minimum I-cache line size from the CTR register
>> + * on ARMv7.
>> + */
>> +	.macro	icache_line_size, reg, tmp
>> +	read_ctr \tmp
>> +	and	\tmp, \tmp, #0xf		@ cache line size encoding
>> +	mov	\reg, #4			@ bytes per word
>> +	mov	\reg, \reg, lsl \tmp		@ actual cache line size
>> +	.endm
>> -- 
>> 1.7.9.5
>>
> 
