From: viktor.rosendahl@nokia.com (Viktor Rosendahl)
Date: Wed, 30 Mar 2011 17:09:43 +0300
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <alpine.LFD.2.00.1103291235380.11889@xanadu.home>
References: <1301087944.2744.85.camel@computer2.home>
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
	<alpine.LFD.2.00.1103281822170.11889@xanadu.home>
	<4D91C1EF.1040102@nokia.com>
	<alpine.LFD.2.00.1103291235380.11889@xanadu.home>
Message-ID: <4D9339A7.30606@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2011 07:55 PM, ext Nicolas Pitre wrote:
>
> Sorry, I meant r15-indexed with a write back.
>

OK, I guess it was kind of implicit in your message but I missed it.

>> Now, I admit that it's possible that somewhere beyond the horizon of my
>> understanding there is some good reason to do two LDRs into adjacent registers
>> from adjacent memory addresses, instead of merging them into one LDRD.
>
> In this case I suspect that the loaded values were pushed to the literal
> pool, and it is hard for the compiler to ensure the placement is always
> 64-bit aligned.
>

I guess you are right, I missed that LDRD/STRD needs to be double word 
aligned for the older alignment models. In the ARMv7 model, word 
alignment is enough.

>> BTW, in my kernel, LDR indexed by r15 is a really common instruction at the
>> very beginning of functions. I am not sure why; it could have something to do
>> with the fact that the kernel is compiled without frame pointers.
>
> No, it's all about literal pool usage.

Yes, of course it's the literals. I was silly to think otherwise :)

>
> But nowhere will you find pc-indexed addressing with a writeback.
> That's one of the cases I think should be rejected upfront instead of
> evaluating this possibility which is likely to never happen in practice
> each time the instruction is emulated.
>

Currently, we are not checking for that case at all, so the only missing 
part would be to modify the decoding logic. I just sent a patch for that.

best regards,

Viktor
