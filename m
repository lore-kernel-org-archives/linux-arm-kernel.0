From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 16:04:09 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212154110.GQ4360@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 12 Dec 2013 15:41:10 +0000")
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
Message-ID: <yw1xk3fahx8m.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, Dec 12, 2013 at 04:04:17PM +0100, Maxime Bizon wrote:
>> 
>> On Thu, 2013-12-12 at 14:48 +0000, Russell King - ARM Linux wrote:
>> 
>> > Even so, the code _is_ buggy, because if the protocol value had bits
>> > 15-8 set, then this would go wrong for all the same reasons that
>> > you've found.  GCC is definitely ignoring the outter (uint16_t) cast
>> > in the above.
>> 
>> ok I'll file a gcc bug report to get their input on this.
>
> Actually, it may not be a gcc bug at all.
>
> One of the issues here is that internally, GCC tracks the "machine mode"
> of a register, where "mode" basically means the type of register it is.
> In this case, the register will be in "half integer" mode when it is
> passed into the assembler, and gcc does _not_ promote it.
>
> We can see this in the RTL:
>
> (insn 11 10 12 3 ../t.c:9 (set (reg:SI 143 [ sum ])
>         (asm_operands:SI ("mov  %0, %1") ("=&r") 0 [
>                 (subreg:HI (reg:SI 148) 0)
>             ]
>              [
>                 (asm_input:HI ("r") (null):0)
>             ]
>              [] ../t.c:12)) -1 (nil))
>
> Note that "HI" for the input register 148.  What this means is that the
> compiler "knows" that it's supposed to be a 16-bit quantity, and has
> recorded that fact, and _will_ truncate it down to 16-bit when it needs
> to be promoted.
>
> Since the asm() only asks for a "register", that's what we get - a
> register which _happens_ to be in HI mode containing the value.  However,
> there's no way to tell that from the assembly code itself (GCC doesn't
> have the facility to do conditional assembly generation depending on
> the argument type passed into it.)
>
> What this means is that passing "unsigned short"s into an asm is dodgy.

If that's the intended behaviour, the compiler really ought to error or
warn when this happens.  It's far too easy to accidentally fall foul of
this.

> What's more, I've just had this confirmed by compiler people in ARM Ltd -
> we can't rely on the state of the upper 16 bits when passing a u16 into
> an asm().  So, it seems that it _is_ a kernel bug after all.

With that being the official stance, the proper fix appears to be to
explicitly cast all 8/16-bit asm operands to a 32-bit type.  Good luck
finding them.

-- 
M?ns Rullg?rd
mans at mansr.com
