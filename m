From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Mar 2013 14:05:34 +0000
Subject: [PATCH v2 01/30] arm64: add explicit symbols to ESR_EL1 decoding
In-Reply-To: <20130327135133.GD1863@MacBook-Pro.local>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
 <1364317285-20937-2-git-send-email-marc.zyngier@arm.com>
 <20130327135133.GD1863@MacBook-Pro.local>
Message-ID: <5152FCAE.4020005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/13 13:51, Catalin Marinas wrote:
> On Tue, Mar 26, 2013 at 05:00:56PM +0000, Marc Zyngier wrote:
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -24,6 +24,7 @@
>>  #include <asm/assembler.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/errno.h>
>> +#include <asm/esr.h>
>>  #include <asm/thread_info.h>
>>  #include <asm/unistd.h>
>>  #include <asm/unistd32.h>
>> @@ -239,18 +240,18 @@ ENDPROC(el1_error_invalid)
>>  el1_sync:
>>  	kernel_entry 1
>>  	mrs	x1, esr_el1			// read the syndrome register
>> -	lsr	x24, x1, #26			// exception class
>> -	cmp	x24, #0x25			// data abort in EL1
>> +	lsr	x24, x1, #ESR_EL1_EC_SHIFT	// exception class
>> +	cmp	x24, #ESR_EL1_EC_DABT_EL1	// data abort in EL1
>>  	b.eq	el1_da
>> -	cmp	x24, #0x18			// configurable trap
>> +	cmp	x24, #ESR_EL1_EC_SYS64		// configurable trap
>>  	b.eq	el1_undef
>> -	cmp	x24, #0x26			// stack alignment exception
>> +	cmp	x24, #ESR_EL1_EC_SP_ALIGN	// stack alignment exception
>>  	b.eq	el1_sp_pc
>> -	cmp	x24, #0x22			// pc alignment exception
>> +	cmp	x24, #ESR_EL1_EC_PC_ALIGN	// pc alignment exception
>>  	b.eq	el1_sp_pc
>> -	cmp	x24, #0x00			// unknown exception in EL1
>> +	cmp	x24, #ESR_EL1_EC_UNKNOWN	// unknown exception in EL1
>>  	b.eq	el1_undef
>> -	cmp	x24, #0x30			// debug exception in EL1
>> +	cmp	x24, #ESR_EL1_EC_BREAKPT_EL0	// debug exception in EL1
> 
> Not a problem with your patch as you just replaced the existing values
> but shouldn't we have BREAKPT_EL1 here?

Quite probably indeed. A double case of cut-n-paste programming error,
pass me the brown paper bag...

I'll fix this, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
