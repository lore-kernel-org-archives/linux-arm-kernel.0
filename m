From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 21:57:45 +0100
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421204718.GY27575@shareable.org>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
	<20100421100008.GE13114@shareable.org>
	<20100421192911.GA26616@n2100.arm.linux.org.uk>
	<20100421195225.GS27575@shareable.org>
	<20100421202115.GH26616@n2100.arm.linux.org.uk>
	<20100421204718.GY27575@shareable.org>
Message-ID: <20100421205745.GI26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 09:47:18PM +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > You don't understand the issue.  On older ARMs, the single 32-bit
> > multiply is not cheap; it shows up as having a significant time
> > expense for very short delays - and that _does_ matter.
> > 
> > Consider system performance where you're driving a bus using udelay()
> > to provide 1us timings, but udelay ends up taking 10us instead every
> > time because of the calculation for number of loops for a 1us timing.
> 
> Hence nested loop.  You don't multiply.  No calculation.

Ok, since you seem to have a clear idea how to convert this into a double
nested loop, try converting it:

						@ 0 <= r0 <= 0x7fffff06
                ldr     r2, .LC0 (loops_per_jiffy)
                ldr     r2, [r2]                @ max = 0x01ffffff
                mov     r0, r0, lsr #14         @ max = 0x0001ffff
                mov     r2, r2, lsr #10         @ max = 0x00007fff
                mul     r0, r2, r0              @ max = 2^32-1
                movs    r0, r0, lsr #6
                moveq   pc, lr
1:              subs    r0, r0, #1
                bhi     1b
                mov     pc, lr

into two loops without losing the precision - note that the multiply
is part of a 'dividing by multiply+shift' technique.
