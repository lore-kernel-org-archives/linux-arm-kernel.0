From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Mar 2012 09:56:11 +0100
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <20120327174152.GA905@mvista.com>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
 <274124B9C6907D4B8CE985903EAA19E91B2D5798D9@SI-MBX06.de.bosch.com>
 <20120327133226.GE18738@mudshark.cambridge.arm.com>
 <20120327174152.GA905@mvista.com>
Message-ID: <20120328085611.GA11524@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 06:41:52PM +0100, George G. Davis wrote:
> On Tue, Mar 27, 2012 at 02:32:26PM +0100, Will Deacon wrote:
> > I have a theory about what goes on:
> > 
> > Say we have a valid (i.e. non-faulting) page which contains a load instruction
> > that will fault. A CPU executes this load and takes a data abort but at the
> > same time another CPU marks the page being executed as old. So when the
> > original CPU tries to load the faulting instruction in do_thumb_abort, we take
> > a second data abort (assumedly because we don't have a D-side TLB entry for the
> > text page, so we immediately see that it is old) and, because interrupts were
> > not yet re-enabled in the first fault, they are not enabled in the nested fault
> > either.
> 
> This is precisely what happened here.  The only difference is that the traces
> I've reviewed faulted at "not_thumb:" while attempting to read the userspace
> ARM instruction which lead to the (second) data abort with interrupts disabled.

Right, I think that's the same problem though.

> > Possible solutions:
> > 
> > (1) Enable interrupts if they are enabled in the faulting context before
> >     loading instructions on the dabt path.
> > 
> > (2) Use the FSR to determine whather a fault is due to a read or a write on
> >     ARMv6 - only load and disassemble the instruction on 1136 CPUs affected
> >     by erratum #325103 (which aren't SMP, so cannot hit the problem above).
> 
> We submitted a change similar to (2) above to the ARM Linux kernel mailing
> list for RFC [1] over a year ago.  That change [1] is similar to your change
> below.

Apologies, I missed that. Are you happy for me to continue with my change
below? I'd really like it if Peter could confirm it fixes his problem.

> > The latter is probably best. Please can you try the patch below? I've
> > checked that it does the right thing on an r0p1 1136 core using a simple
> > fork/swp program to trigger a CoW.
> 
> I tested your patch but only on a CPU_V6K based SMP machine.  In this
> case, ARM_ERRATA_326103 depends on CPU_V6, so is left disabled, renderring
> this patch functionally equivaltent to [1] below.

Thanks George. Do you have a testcase for reliably reproducing the deadlock
without this patch applied?

> FYI/FWIW, your patch above suffered whitespace damage.

That'll be the sorry excuse for an email system that I'm forced to use.
Perhaps the list archive has a better version:

http://lists.arm.linux.org.uk/lurker/attach/1 at 20120327.133226.639a8b79.attach

Will
