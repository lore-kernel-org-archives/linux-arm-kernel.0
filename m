From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jan 2011 23:24:27 +0000
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100422001417.GF27575@shareable.org>
References: <20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
	<20100421100008.GE13114@shareable.org>
	<20100421192911.GA26616@n2100.arm.linux.org.uk>
	<20100421195225.GS27575@shareable.org>
	<20100421202115.GH26616@n2100.arm.linux.org.uk>
	<20100421204718.GY27575@shareable.org>
	<20100421205745.GI26616@n2100.arm.linux.org.uk>
	<20100422001417.GF27575@shareable.org>
Message-ID: <20110108232427.GA19891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 01:14:17AM +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > Ok, since you seem to have a clear idea how to convert this into a double
> > nested loop, try converting it:
> > 
> > 						@ 0 <= r0 <= 0x7fffff06
> >                 ldr     r2, .LC0 (loops_per_jiffy)
> >                 ldr     r2, [r2]                @ max = 0x01ffffff
> >                 mov     r0, r0, lsr #14         @ max = 0x0001ffff
> >                 mov     r2, r2, lsr #10         @ max = 0x00007fff
> >                 mul     r0, r2, r0              @ max = 2^32-1
> >                 movs    r0, r0, lsr #6
> >                 moveq   pc, lr
> > 1:              subs    r0, r0, #1
> >                 bhi     1b
> >                 mov     pc, lr
> > 
> > into two loops without losing the precision - note that the multiply
> > is part of a 'dividing by multiply+shift' technique.
> 
> 	ldr	r2, loops_per_jiffy
> 	ldr	r3, microseconds_per_jiffy
>         mov     r4, r2
> 1:      subs    r4, r4, r3
>         bhi     1b
>         subs    r0, r0, #1
>         add     r4, r4, r2
>         bhi     1b
>         mov     pc, lr
> 
> Goodnight :)

I thought I'd dig this out and give it a go - but it has problems.  Let's
say usec_per_jiffy is 10000.  Initially, loops_per_jiffy is 1<<12 or 4096
at boot.

If udelay() is used prior to calibration (it is - see things like OMAP/8250
console drivers which use udelay(1)), the initial loops_per_jiffy value
will be used.

So, r0 = 10000.  r3 = 10000.  r2 = 4096.

	mov	r4, r2		@ r4 := 4096
1:	subs	r4, r4, r3	@ r4 -= 10000 := -5904
	bhi	1b		@ not taken
	subs	r0, r0, #1	@ r0 -= 1 := 9999
	add	r4, r4, r2	@ r4 += 4096 := -1808 (or 4294965488)
	bhi	1b		@ taken

That's the first iteration.  The next iteration:

1:	subs	r4, r4, r3	@ r4 -= 10000 := 4294955488
	bhi	1b		@ taken
1:	subs	r4, r4, r3	@ r4 -= 10000 := 4294945488
	bhi	1b		@ taken
... which means we have about 429493 loops to go ...

So this becomes an extremely slow loop - it works when loops_per_jiffy >
usec_per_jiffy.

Even with a value of 8192 (the first tried lpj in the calibration loop),
things eventually go wrong - r4 on each iteration goes -1808, -3616, ..
-9040 and then we're into the problem above - and this will be the case
for anyone with HZ=100.

So, this solution has undesirable behaviours... and this is what I've
come up with - we manually increase the lpj and decrease the required
delay by a power of two until we meet the necessary preconditions
(lpj >= usec/jiffy).

.LC0:		.long	loops_per_jiffy
		.long	(1000000 + (HZ / 2))/HZ

ENTRY(__delay)
                ldr     r3, .LC0 + 4		@ usec/jiffy
                mov     r2, r0
                mov     r0, r3
                b       2f
ENTRY(__udelay)
                ldr     r2, .LC0
                ldr     r3, .LC0 + 4		@ usec/jiffy
                ldr     r2, [r2]		@ lpj
2:              cmp     r2, r3
                movcc   r2, r2, lsl #1
                movcc   r0, r0, lsr #1
                bcc     2b
                mov     ip, r2
1:              subs    ip, ip, r3
                addls   ip, ip, r2
                sublss  r0, r0, #2
                bhi     1b
                mov     pc, lr

Note that I've also tweaked the loop a little to make the cycle count
(in theory) around the loop the same no matter what it does.

This way, I get the same lpj calibration value as the old way - which is
good as with the old way, we were calibrating just this loop:

1:		subs	r0, r0, #1
		bhi	1b
		mov	pc, lr

where r0 = lpj and the target delay time was 1 jiffy.

Now, what sparked this off was:

> > We could go to ns delays, but then we have a big problem - the cost of
> > calculating the number of loops starts to become significant compared to
> > the delays - and that's a quality of implementation factor.  In fact,
> > the existing cost has always been significant for short delays for
> > slower (sub-100MHz) ARMs.
> 
> I'm surprised it makes much difference to, say, 20MHz ARMs because you
> could structure it as a nested loop, the inner one executed once per
> microsecond and calibrated to 1us.  The delays don't have to be super
> accurate.

With this nested loop approach we can't go to ns resolution.
nsec_per_jiffy would be 10000000, and with an initial loops_per_jiffy
of 4096 or 8192, this would be extremely bad.

That said, I do think your approach has merit - especially as we're
now seeing CPUs in the 2000 BogoMips range, and our existing solution
goes bad at 3355 BogoMips.  As the board I have is something like 8
months old we've probably got what, 10 months left according to Moore's
law?
