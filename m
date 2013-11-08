From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Nov 2013 11:04:19 -0800
Subject: [PATCH] ARM: Use udiv/sdiv for __aeabi_{u}idiv library functions
In-Reply-To: <yw1xr4aqx1vi.fsf@unicorn.mansr.com>
References: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
 <yw1xr4aqx1vi.fsf@unicorn.mansr.com>
Message-ID: <527D35B3.9020702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/13 09:02, M?ns Rullg?rd wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
>
>> +int __aeabi_idiv(int numerator, int denominator)
>> +{
>> +	if (static_key_false(&cpu_has_idiv)) {
>> +		int ret;
>> +
>> +		asm volatile (
>> +		".arch_extension idiv\n"
>> +		"sdiv %0, %1, %2"
>> +		: "=&r" (ret)
> There is no need for the & in the output constraint.  Dropping it allows
> using one of the source registers as destination which may sometimes be
> beneficial.

Ok. Thanks. That does seem to improve things.

before:

00000000 <__aeabi_idiv>:
   0:   e320f000        nop     {0}
   4:   eafffffe        b       0 <___aeabi_idiv>
   8:   e713f110        sdiv    r3, r0, r1
   c:   e1a00003        mov     r0, r3
  10:   e12fff1e        bx      lr

00000014 <__aeabi_uidiv>:
  14:   e320f000        nop     {0}
  18:   eafffffe        b       0 <___aeabi_uidiv>
  1c:   e733f110        udiv    r3, r0, r1
  20:   e1a00003        mov     r0, r3
  24:   e12fff1e        bx      lr

after:

00000000 <__aeabi_idiv>:
   0:   e320f000        nop     {0}
   4:   eafffffe        b       0 <___aeabi_idiv>
   8:   e710f110        sdiv    r0, r0, r1
   c:   e12fff1e        bx      lr

00000010 <__aeabi_uidiv>:
  10:   e320f000        nop     {0}
  14:   eafffffe        b       0 <___aeabi_uidiv>
  18:   e730f110        udiv    r0, r0, r1
  1c:   e12fff1e        bx      lr


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
