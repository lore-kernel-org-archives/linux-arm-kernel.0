From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Oct 2013 10:51:42 +0100
Subject: [PATCH v2 2/3] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <CA+=Sn1kErSHjRkUsxB_2WzXj6Fn-OcnUb42R_WR-hJEaVrL8VQ@mail.gmail.com>
References: <1380534251-4464-1-git-send-email-vijay.kilari@gmail.com>
 <1380534251-4464-3-git-send-email-vijay.kilari@gmail.com>
 <20130930163654.GJ26036@mudshark.cambridge.arm.com>
 <CALicx6vpX6nm=zdBZTY57EgPRphcjMzwFxug6CAa_U21u4_4Cw@mail.gmail.com>
 <20131002101846.GC28311@mudshark.cambridge.arm.com>
 <CA+=Sn1kErSHjRkUsxB_2WzXj6Fn-OcnUb42R_WR-hJEaVrL8VQ@mail.gmail.com>
Message-ID: <20131007095141.GD465@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Oct 04, 2013 at 10:51:02PM +0100, Andrew Pinski wrote:
> On Wed, Oct 2, 2013 at 3:18 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Oct 01, 2013 at 11:53:01AM +0100, Vijay Kilari wrote:
> >> In fact, the arch_kgdb_breakpoint is called from only one place from
> >> kernel/debug/debug_core.c and there is no way for the compiler to
> >> reorder the block
> >> as it has two write barriers around it:
> >>         wmb(); /* Sync point before breakpoint */
> >>         arch_kgdb_breakpoint();
> >>         wmb(); /* Sync point after breakpoint */
> >
> > A write barrier just looks like a memory clobber to the compiler, which
> > isn't enough to stop this being reordered wrt breakpoints.
> 
> Yes this will be a full schedule barrier due to the inline-asm being a
> volatile inline-asm (implicitly because there are no outputs).  What I
> meant about the compiler could move around code only happens when you
> don't there are other implicit non schedule barrier instructions, in
> this case wmb is an volatile inline-asm which is also a scheduler
> barrier.

volatile != scheduling barrier (example below).

> > In fact, I don't
> > think is actually solvable with GCC since there is no way to emit a full
> > scheduling barrier using asm constraints (we'd need an intrinsic I think).
> >
> > You could try clobbering every register, but that's filthy, and will likely
> > cause reload to generate some dreadful spills.
> 
> Actually this is enough since both inline-asms (the one for wmb and
> arch_kgdb_breakpoint) are going to be treated as volatile by the
> compiler so it will not schedule those two inline-asm with respect of
> each other.

That's true: the asms will not be optimised away and/or moved across each
other. However, other code *can* move across then, which strikes me as odd
when we're dealing with breakpoints.

E.g:

8<---

#define wmb()	__asm__ __volatile__ ("dsb" ::: "memory")

static inline void nop(void)
{
	asm ("nop");
}

int foo(int *bar)
{
	int baz, i;

	baz = *bar;

	for (i = 0; i < 10; ++i)
		baz++;

	wmb();
	nop();
	wmb();

	return baz;
}

--->8

Assembles to the following with GCC 4.9 for ARM:

00000000 <foo>:
   0:	e5900000 	ldr	r0, [r0]
   4:	f57ff04f 	dsb	sy
   8:	e320f000 	nop	{0}
   c:	f57ff04f 	dsb	sy
  10:	e280000a 	add	r0, r0, #10
  14:	e12fff1e 	bx	lr

So, whilst loading the parameter hazards against the memory clobber of the
wmb()s, the loop (optimised to the single add) is now at the end of the
function. If I wanted a breakpoint after that loop had finished, it's now no
longer true.

> Note all other targets (ARM, PPC, x86, tile, etc.) all use a static
> inline function which does exactly the same as what is being added
> here.

Agreed, I didn't mean to imply this was an issue with this particular patch.
I'm just curious as to why this has been deemed acceptable by other
architectures, when it doesn't look especially useful to me.

Will
