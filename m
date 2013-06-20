From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Jun 2013 11:54:58 +0100
Subject: [PATCH 02/10] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <20130619193318.70a9988a@skate>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
 <1371645406-16873-3-git-send-email-ben.dooks@codethink.co.uk>
 <20130619193318.70a9988a@skate>
Message-ID: <51C2DF82.3030404@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/13 18:33, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Wed, 19 Jun 2013 13:36:38 +0100, Ben Dooks wrote:
>
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +	@ in BE8, we load data in BE, but instructions still in LE
>> +	bic	ip, ip, #0xff000000
>> +	orr	ip, ip, r6, lsl#24
>> +#else
>>   	bic	ip, ip, #0x000000ff
>>   	orr	ip, ip, r6	@ mask in offset bits 31-24
>> +#endif
>>   	str	ip, [r7, r3]
>>   2:	cmp	r4, r5
>>   	ldrcc	r7, [r4], #4	@ use branch for delay slot
>
> As was suggested in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/150782.html,
> you could put this patch later in the series and use the ARM_BE8()
> macro you introduce in the next patch.
>
> Also in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/150784.html,
> the same reviewer suggested to name the macro BE8() to make it fit like
> ARM() and THUMB() in the margin left by the indentation of assembly
> code. And also to add LE() to make the above code look like:
>
> BE8(	bic ip, ip, #0xff000000)
> BE8(	orr ip, ip, r6, lsl#24)
> LE(	bic ip, ip, #0x000000ff)
> LE(	orr ip, ip, r6)

Actually, that doesn't work as LE is not the inverse of BE8 as
it could also be when the kernel is being compiled in BE32.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
