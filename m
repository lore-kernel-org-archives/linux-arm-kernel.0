From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 22 Apr 2010 01:14:17 +0100
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421205745.GI26616@n2100.arm.linux.org.uk>
References: <4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
	<20100421100008.GE13114@shareable.org>
	<20100421192911.GA26616@n2100.arm.linux.org.uk>
	<20100421195225.GS27575@shareable.org>
	<20100421202115.GH26616@n2100.arm.linux.org.uk>
	<20100421204718.GY27575@shareable.org>
	<20100421205745.GI26616@n2100.arm.linux.org.uk>
Message-ID: <20100422001417.GF27575@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> > > Consider system performance where you're driving a bus using udelay()
> > > to provide 1us timings, but udelay ends up taking 10us instead every
> > > time because of the calculation for number of loops for a 1us timing.
> > 
> > Hence nested loop.  You don't multiply.  No calculation.
> 
> Ok, since you seem to have a clear idea how to convert this into a double
> nested loop, try converting it:
> 
> 						@ 0 <= r0 <= 0x7fffff06
>                 ldr     r2, .LC0 (loops_per_jiffy)
>                 ldr     r2, [r2]                @ max = 0x01ffffff
>                 mov     r0, r0, lsr #14         @ max = 0x0001ffff
>                 mov     r2, r2, lsr #10         @ max = 0x00007fff
>                 mul     r0, r2, r0              @ max = 2^32-1
>                 movs    r0, r0, lsr #6
>                 moveq   pc, lr
> 1:              subs    r0, r0, #1
>                 bhi     1b
>                 mov     pc, lr
> 
> into two loops without losing the precision - note that the multiply
> is part of a 'dividing by multiply+shift' technique.

	ldr	r2, loops_per_jiffy
	ldr	r3, microseconds_per_jiffy
        mov     r4, r2
1:      subs    r4, r4, r3
        bhi     1b
        subs    r0, r0, #1
        add     r4, r4, r2
        bhi     1b
        mov     pc, lr

Goodnight :)
- Jamie

(Admission: I wasn't thinking of high precision when I glibly said two
loops; your challenge prompted me to work it out, and I was pleasantly
surprised to see it come out so neatly.)
