From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 14:42:23 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386858504.22947.85.camel@sakura.staff.proxad.net> (Maxime
 Bizon's message of "Thu, 12 Dec 2013 15:28:24 +0100")
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu>
 <1386858504.22947.85.camel@sakura.staff.proxad.net>
Message-ID: <yw1xd2l2jflc.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Thu, 2013-12-12 at 15:19 +0100, Willy Tarreau wrote:
>
>> I disagree here, since gcc may decide by itself to inline or not, it must
>> not impact the validity of the emitted code. Inline functions have input
>> and output types for a reason!
>
> but the code emitted is completely different for an inlined "occurence"
> of the function and the non-inlined case.
>
> if a function does not use one of its argument, and it is inlined, then
> in the resulting code you see no trace of it

Again, that's an optimisation that does not alter the semantics of the code.
Although the generated code looks very different, it does the same thing.

>> Hmmm aren't you passing a 16-bit register directly to the ASM for being used
>> as a 32-bit one ? This seems hasardous to me since nowhere you tell gcc how
>> you're going to use the register.
>
> this is exactly what I'm complaining about, the arm code for
> csum_tcpudp_nofold() in the kernel does exactly that.
>
>> Could you check if that fixes it :
>> 
>>  static inline uint32_t asm_add(uint16_t len, uint32_t sum)
>>  {
>>          uint32_t len32 = len;
>
> or change the asm_add() proto to take an "uint32_t len" instead, and yes
> of course that fixes it.

It's a bug.  Please report it to the gcc developers.

-- 
M?ns Rullg?rd
mans at mansr.com
