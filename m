From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 12 Nov 2013 11:28:57 +0000
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <528193A0.7050505@codeaurora.org> (Stephen Boyd's message of
 "Mon, 11 Nov 2013 18:34:08 -0800")
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.10.1311092357090.2314@knanqh.ubzr>
 <528193A0.7050505@codeaurora.org>
Message-ID: <yw1xli0tvoxy.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 11/09/13 21:03, Nicolas Pitre wrote:
>> Bah..... NAK. We are doing runtime patching of the kernel for many
>> many things already. So why not do the same here?
>
> static keys are a form of runtime patching, albeit not as extreme as
> you're suggesting.
>
>>
>> The obvious strategy is to simply overwrite the start of the existing 
>> __aeabi_idiv code with the "sdiv r0, r0, r1" and "bx lr" opcodes.  
>>
>> Similarly for the unsigned case.
>
> I was thinking the same thing when I wrote this, but I didn't know how
> to tell the compiler to either inline this function or to let me inilne
> an assembly stub with some section magic.
>
>>
>> That let you test the hardware capability only once during boot instead 
>> of everytime a divide operation is performed.
>
> The test for hardware capability really isn't done more than once during
> boot. The assembly is like so at compile time
>
> 00000000 <__aeabi_idiv>:
>    0:   nop     {0}
>    4:   b       0 <___aeabi_idiv>
>    8:   sdiv    r0, r0, r1
>    c:   bx      lr
>
> and after we test and find support for the instruction it will be
> replaced with
>
> 00000000 <__aeabi_idiv>:
>    0:   b       8
>    4:   b       0 <___aeabi_idiv>
>    8:   sdiv    r0, r0, r1
>    c:   bx      lr
>
> Unfortunately we still have to jump to this function. It would be great
> if we could inline this function at the call site but as I already said
> I don't know how to do that.

Ideally the bl instruction at the call site would be patched over with
sdiv/udiv when supported.  This would leave things exactly as they are
for hardware without div capability and incur only the call setup cost
(but no actual call) on div-capable hardware.  No, I don't know how to
achieve this.

-- 
M?ns Rullg?rd
mans at mansr.com
