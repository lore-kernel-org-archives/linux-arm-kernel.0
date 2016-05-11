From: luke.starrett@broadcom.com (Luke Starrett)
Date: Wed, 11 May 2016 14:36:46 -0400
Subject: [PATCH 1/1] arm64: Add ARM64 optimized IP checksum routine
In-Reply-To: <57332BB8.9060004@arm.com>
References: <1462904847-28369-1-git-send-email-luke.starrett@broadcom.com>
 <57332BB8.9060004@arm.com>
Message-ID: <25c62b93-672f-296f-ad8f-e8dd144a3a20@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/11/2016 8:55 AM, Robin Murphy wrote:
> Hi Luke,
>
> On 10/05/16 19:27, Luke Starrett wrote:
>> This change implements an optimized checksum for arm64, based loosely on
>> the original arch/arm implementation.  Load-pair is used for the initial
>> 16B load, reducing the overall number of loads to two for packets 
>> without
>> IP options.  Instruction count is reduced by ~3x compared to generic C
>> implementation.  Changes were tested against LE and BE operation and for
>> all possible mis-alignments.
>>
>> Signed-off-by: Luke Starrett <luke.starrett@broadcom.com>
>> ---
>>   arch/arm64/include/asm/checksum.h | 57 
>> +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/checksum.h
>>
>> diff --git a/arch/arm64/include/asm/checksum.h 
>> b/arch/arm64/include/asm/checksum.h
>> new file mode 100644
>> index 0000000..15629d7
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/checksum.h
>> @@ -0,0 +1,57 @@
>> +/*
>> + * Copyright 2016 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation (the "GPL").
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License version 2 (GPLv2) for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * version 2 (GPLv2) along with this source code.
>> + *
>> + * ip_fast_csum() loosely derived from original arch/arm implementation
>> + */
>> +
>> +#ifndef __ASM_ARM64_CHECKSUM_H
>> +#define __ASM_ARM64_CHECKSUM_H
>> +
>> +/*
>> + * This is a version of ip_compute_csum() optimized for IP headers,
>> + * which always checksum on 4 octet boundaries.
>> + */
>> +static inline __sum16
>> +ip_fast_csum(const void *iph, unsigned int ihl)
>> +{
>> +    u64 tmp, sum;
>> +
>> +    __asm__ __volatile__ (
>> +"    ldp    %0, %3, [%1], #16\n"
>> +"    sub    %2, %2, #4\n"
>> +"    adds    %0, %0, %3\n"
>> +"1:    ldr    %w3, [%1], #4\n"
>> +"    sub    %2, %2, #1\n"
>> +"    adcs    %0, %0, %3\n"
>
> This looks suspicious - the following tst is going to zero the carry 
> flag, so either setting the flags is unnecessary, or things are 
> working by chance.
>
Yes, you are correct.  Thinking about this a bit, it is working by 
chance as you expected, given the second adcs is adding a 32b quantity 
to the prior 64b result and unlikely (though not impossible) to produce 
a carry.  I'll reorder this.

>> +"    tst    %2, #15\n"
>> +"    bne    1b\n"
>> +"    adc    %0, %0, xzr\n"
>
> Similarly, you should never get here with the carry flag set, so this 
> is just a pointless nop.
>
>> +"    ror    %3, %0, #32\n"
>> +"    add     %0, %0, %3\n"
>> +"    lsr    %0, %0, #32\n"
>> +"    ror    %w3, %w0, #16\n"
>> +"    add     %w0, %w0, %w3\n"
>> +"    lsr    %0, %0, #16\n"
>> +    : "=r" (sum), "=r" (iph), "=r" (ihl), "=r" (tmp)
>> +    : "1" (iph), "2" (ihl)
>> +    : "cc", "memory");
>> +
>> +    return (__force __sum16)(~sum);
>> +}
>
> Given that dodginess, and that there doesn't seem to be anything here 
> which absolutely _demands_ assembly voodoo, can we not just have an 
> optimised C implementation working on larger chunks, along the lines 
> of Alpha?
>
I would agree, though I couldn't see any obvious way to reduce from 
individual loads to 'ldp' without requiring some level of inlining, and 
at that point just decided to do the whole thing inline.  It was clear 
though that reducing to a single ldp + ldr in the mainstream case was 
beneficial.

Luke


> Robin.
>
>> +
>> +#define ip_fast_csum ip_fast_csum
>> +#include <asm-generic/checksum.h>
>> +
>> +#endif    /* __ASM_ARM64_CHECKSUM_H */
>>
>
