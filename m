From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Oct 2012 11:52:23 +0100
Subject: Possible regression in arm/io.h
In-Reply-To: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
Message-ID: <20121024105223.GC23775@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 11:38:14AM +0100, Bastian Hecht wrote:
> Hello Will,

Hello,

> your introduction of the "+Qo" in arch/arm/include/asm/io.h makes some
> drivers fail to compile on newer gnu ARM gccs. Like in
> drivers/mtd/nand/docg4.c there is an offset of 0x800 from a pointer
> used to address I/O memory. This leads to the error message:
> 
> /tmp/ccwLMdCy.s: Error: bad immediate value for 8-bit offset (2048)

Urgh.

> The gnu gcc people tracked it down to the asm directive "+Qo". Do we
> really want to enforce to allow only addresses that are offsetable
> with one byte? If I understand it correctly from the gnu gcc docs, the
> "o" is doing this.
> 
> excerpt from asm/io.h:
> static inline void __raw_writew(u16 val, volatile void __iomem *addr)
> {
>         asm volatile("strh %1, %0"
>                      : "+Qo" (*(volatile u16 __force *)addr)
>                      : "r" (val));
> }
> 
> Bug report:
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=54983
> 
> So do we want to remove the "o" from all __raw_readX and __raw_writeX
> functions? I've tried it and stuff compiles again without errors.

I was under the impression that specifying multiple constraints would mean
that it would try "o", then if that didn't work it would fall back to "Q".
That's certainly the behaviour we've seen in the past... has this changed
with recent toolchains?

The problem with using "Q" on its own is that the compiler tends to generate
the address computation twice: once for "Q" and once for "r" -- this doesn't
happen with "o", where the address is computed once. This leads to an
increase in register pressure and I have seen the compiler choke claiming
that the inline asm block contains "impossible constraints" because it
insists on generating the address twice.

It sounds like we need to:

	(a) Understand what has changed in GCC to cause this error to start
	    cropping up.

	(b) Have a look at the impact of using only "Q" on the generated
	    code (especially register usage for the address).

Will
