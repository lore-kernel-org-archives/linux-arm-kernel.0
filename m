From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 25 Jul 2013 11:34:38 +0100
Subject: [PATCH 03/14] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <20130725102541.GC24642@n2100.arm.linux.org.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-4-git-send-email-ben.dooks@codethink.co.uk>
 <20130724143335.GL11072@mudshark.cambridge.arm.com>
 <51EFF1B2.4050609@codethink.co.uk>
 <20130725101442.GA5609@mudshark.cambridge.arm.com>
 <20130725102541.GC24642@n2100.arm.linux.org.uk>
Message-ID: <51F0FF3E.3050206@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/13 11:25, Russell King - ARM Linux wrote:
> On Thu, Jul 25, 2013 at 11:14:42AM +0100, Will Deacon wrote:
>> What's wrong with the following?
>
> Is this like a challenge to find the silly mistake?
>
>> @@ -581,8 +581,13 @@ __fixup_a_pv_table:
>>          b       2f
>>   1:     add     r7, r3
>>          ldrh    ip, [r7, #2]
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +       and     ip, 0x008f
>> +       orr     ip, ip, r6, lsl #24
>> +#else
>>          and     ip, 0x8f00
>>          orr     ip, r6  @ mask in offset bits 31-24
>> +#endif
>>          strh    ip, [r7, #2]
>
> Well, ip is being loaded/stored as 16bit, but you're putting r6 in to
> ip's bits 31-24, which are going to be ignored by the following strh.
>
> The comment "@ mask in offset bits 31-24" refers to the physical address
> bits here, which are already pre-shifted to bits 7-0 in r6.

I looked into this, and the code before this loop does:

	clz	r7, r6
	lsr	r6, #24
	lsl	r6, r7
	bic	r6, #0x0080
	lsrs	r7, #1
	orrcs	r6, #0x0080
	orr	r6, r6, r7, lsl #12
	orr	r6, #0x4000
	b	2f

Note that r6 has bits that are not in the 0..7 range, which makes life
difficult when dealing with the loop. If we are going to change the
loop then we will have to pre rev16 r6 before going in to it.

IE:

	lsls	r6, #24
	beq	2f
	clz	r7, r6
	lsr	r6, #24
	lsl	r6, r7
	bic	r6, #0x0080
	lsrs	r7, #1
	orrcs	r6, #0x0080
	orr	r6, r6, r7, lsl #12
	orr	r6, #0x4000
  ARM_BE8(rev16	r6, r6)
	b	2f
1:	add     r7, r3
	ldrh	ip, [r7, #2]
#ifdef CONFIG_CPU_ENDIAN_BE8
	and	ip, 0x008f
#else
	and	ip, 0x8f00
#endif
	orr	ip, r6	@ mask in offset bits 31-24
	strh	ip, [r7, #2]
2:	cmp	r4, r5
	ldrcc	r7, [r4], #4	@ use branch for delay slot
	bcc	1b
	bx	lr




-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
