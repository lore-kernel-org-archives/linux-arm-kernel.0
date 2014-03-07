From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 07 Mar 2014 08:22:06 -0500
Subject: [RFC PATCH] arm64: Fix __addr_ok and __range_ok macros
In-Reply-To: <20140306082023.GA4160@redhat.com>
References: <1394059289-3972-1-git-send-email-cov@codeaurora.org>
 <20140306082023.GA4160@redhat.com>
Message-ID: <5319C7FE.3090300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

Thanks for the comments.

On 03/06/2014 03:20 AM, Michael S. Tsirkin wrote:
> On Wed, Mar 05, 2014 at 05:41:28PM -0500, Christopher Covington wrote:
>> Without this, the following scenario is incorrectly determined
>> to be invalid.
>>
>> addr 0x7f_ffffe000 size 8192 addr_limit 0x80_00000000
>>
>> This behavior was observed while trying to vmsplice the stack
>> as part of a CRIU dump of a process.
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  arch/arm64/include/asm/uaccess.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index edb3d5c..9309024 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -66,12 +66,12 @@ static inline void set_fs(mm_segment_t fs)
>>  #define segment_eq(a,b)	((a) == (b))
>>  
>>  /*
>> - * Return 1 if addr < current->addr_limit, 0 otherwise.
>> + * Return 1 if addr <= current->addr_limit, 0 otherwise.
>>   */
>>  #define __addr_ok(addr)							\
>>  ({									\
>>  	unsigned long flag;						\
>> -	asm("cmp %1, %0; cset %0, lo"					\
>> +	asm("cmp %1, %0; cset %0, ls"					\
>>  		: "=&r" (flag)						\
>>  		: "r" (addr), "0" (current_thread_info()->addr_limit)	\
>>  		: "cc");						\
> 
> 
> BTW can this use mov %0, #0 like arch/arm/include/asm/uaccess.h does?

The A32 implementation uses "movlo", a conditional move instruction. My
reading of section 3.2 Conditional Instructions of the ARMv8 ISA overview [1]
and other documentation has led me to believe conditional move instructions as
such are not available in A64, hence the choice of "cset".

1.
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.genc010197a/index.html

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
