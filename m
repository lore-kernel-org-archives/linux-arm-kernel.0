From: pelcan@codeaurora.org (Philip Elcan)
Date: Mon, 26 Mar 2018 20:51:45 -0400
Subject: [PATCH] arm64: tlbflush: avoid writing RES0 bits
In-Reply-To: <20180326100220.zbu4dfojofmbesp4@lakrids.cambridge.arm.com>
References: <1521666172-2494-1-git-send-email-pelcan@codeaurora.org>
 <20180326100220.zbu4dfojofmbesp4@lakrids.cambridge.arm.com>
Message-ID: <9624b762-a26e-36da-b0a2-4087f0a2069c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/26/2018 6:02 AM, Mark Rutland wrote:
> On Wed, Mar 21, 2018 at 05:02:52PM -0400, Philip Elcan wrote:
>> Bits [47:44] of the TLBI register operand are RES0 for instructions that
>> require a VA, per the ARM ARM spec, so TLBI operations should avoid writing
>> non-zero values to these bits.
>>
>> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 9e82dd7..dbd22a9 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -60,6 +60,9 @@
>>  		__tlbi(op, (arg) | USER_ASID_FLAG);				\
>>  } while (0)
>>  
>> +/* This macro masks out RES0 bits in the TLBI operand */
>> +#define __TLBI_VADDR(addr) (addr & ~GENMASK_ULL(47, 44))
> 
> If we're going to mask the address bits, it would be simpler to keep the
> valid bits than to clear the invalid bits. i.e.
> 
> #define __TLBI_VADDR(addr) (addr & GENMASK_ULL(43, 0))
> 
> Maybe we want a helper that does all of the addr / asid shifting and
> masking, so we do that in one place rather than spreading it across all
> helpers, e.g.
> 
> #define __tlbi_addr(addr, asid)				\
> ({							\
> 	unsigned long __ta = (addr) >> 12;		\
> 	__ta &= GENMASK_ULL(43, 0);			\
> 	__ta |= (asid) << 48;				\
> 	__ta;						\
> })
> 
> Thanks,
> Mark.
> 

That makes sense and addresses Robin's comment as well. I'll send out a
v2 with your suggestion.

Thanks,
Philip

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
