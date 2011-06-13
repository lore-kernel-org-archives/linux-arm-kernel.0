From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 23:14:47 +0100
Subject: [PATCH 2/3] ARM: gic: add OF based initialization
In-Reply-To: <20110613165316.GF18161@ponder.secretlab.ca>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
	<1307456541-11026-3-git-send-email-robherring2@gmail.com>
	<20110613165316.GF18161@ponder.secretlab.ca>
Message-ID: <20110613221447.GI13643@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 10:53:16AM -0600, Grant Likely wrote:
> On Tue, Jun 07, 2011 at 09:22:20AM -0500, Rob Herring wrote:
> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- #interrupt-cells : Specifies the number of cells needed to encode an
> > +  interrupt source.  The type shall be a <u32> and the value shall be 1.
> > +- reg : Specifies base physical address(s) and size of the GIC registers. The
> > +  first 2 values are the GIC distributor register base and size. The 2nd 2
> > +  values are the GIC cpu interface register base and size.
> > +- irq-start : The first actual interrupt that is connected to h/w.
> 
> Drop irq-start.  That's a Linux internal implementation detail, and
> Linux can easily handle dynamic assignment of irq ranges.

Something has to be done with the IRQs on GIC, because Linux probably
won't have a 1:1 mapping between the hardware IRQ numbers and the Linux
IRQ numbers

Have you seen the patches from Marc which deal with the per-CPU
interrupts by creating individual Linux IRQ numbers for each CPU for
each per-CPU interrupt?  So you can end up with 16 per-CPU x 4 CPUs =
64 Linux interrupts for 16 "hardware" interrupts.

How would DT deal with that - and how would you specify a connection
between a per-CPU PMU and one of the per-CPU interrupts?

The sensible thing from a DT point of view I think would be to ignore
that abstraction, and have some kind of mapping layer between DT and
drivers which knew about that.  But that sounds like a world of pain.
