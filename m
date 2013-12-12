From: w@1wt.eu (Willy Tarreau)
Date: Thu, 12 Dec 2013 17:04:26 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212154110.GQ4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
Message-ID: <20131212160426.GD31816@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:41:10PM +0000, Russell King - ARM Linux wrote:
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

OK so that means that it's just like having true 16-bit registers except
that it's just a temporary representation and not a feature of the CPU.
The compiler has the right to expect the asm instructions to only use
the lower 16 bits and has no way to verify that.

Then changing the type of the function argument would probably be safer!

Regards,
Willy
