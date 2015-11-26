From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 26 Nov 2015 00:07:48 +0000
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr> (Nicolas
 Pitre's message of "Wed, 25 Nov 2015 18:09:13 -0500 (EST)")
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
Message-ID: <yw1x8u5lpqqz.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 25 Nov 2015, Stephen Boyd wrote:
>
>> The ARM compiler inserts calls to __aeabi_uidiv() and
>> __aeabi_idiv() when it needs to perform division on signed and
>> unsigned integers. If a processor has support for the udiv and
>> sdiv division instructions the calls to these support routines
>> can be replaced with those instructions. Now that recordmcount
>> records the locations of calls to these library functions in
>> two sections (one for udiv and one for sdiv), iterate over these
>> sections early at boot and patch the call sites with the
>> appropriate division instruction when we determine that the
>> processor supports the division instructions. Using the division
>> instructions should be faster and less power intensive than
>> running the support code.
>
> A few remarks:
>
> 1) The code assumes unconditional branches to __aeabi_idiv and 
>    __aeabi_uidiv. What if there are conditional branches? Also, tail 
>    call optimizations will generate a straight b opcode rather than a bl 
>    and patching those will obviously have catastrophic results.  I think 
>    you should validate the presence of a bl before patching over it.

I did a quick check on a compiled kernel I had nearby, and there are no
conditional or tail calls to those functions, so although they should
obviously be checked for correctness, performance is unlikely to matter
for those.

However, there are almost half as many calls to __aeabi_{u}idivmod as to
the plain div functions, 129 vs 228 for signed and unsigned combined.
For best results, these functions should also be patched with the
hardware instructions.  Obviously the call sites for these can't be
patched.

> 2) For those cases where a call to __aeabi_uidiv and __aeabi_idiv is not 
>    patched due to (1), you could patch a uidiv/idiv plus "bx lr" 
>    at those function entry points too.
>
> 3) In fact I was wondering if the overhead of the branch and back is 
>    really significant compared to the non trivial cost of a idiv 
>    instruction and all the complex infrastructure required to patch 
>    those branches directly, and consequently if the performance 
>    difference is actually worth it versus simply doing (2) alone.

Depending on the operands, the div instruction can take as few as 3
cycles on a Cortex-A7.

-- 
M?ns Rullg?rd
mans at mansr.com
