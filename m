From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 14 Jun 2011 07:56:28 -0600
Subject: [PATCH 2/3] ARM: gic: add OF based initialization
In-Reply-To: <20110613221447.GI13643@n2100.arm.linux.org.uk>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
	<1307456541-11026-3-git-send-email-robherring2@gmail.com>
	<20110613165316.GF18161@ponder.secretlab.ca>
	<20110613221447.GI13643@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=eYVftJLyckv5Jpz-Qq1KpPc7AgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 4:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 13, 2011 at 10:53:16AM -0600, Grant Likely wrote:
>> On Tue, Jun 07, 2011 at 09:22:20AM -0500, Rob Herring wrote:
>> > +- interrupt-controller : Identifies the node as an interrupt controller
>> > +- #interrupt-cells : Specifies the number of cells needed to encode an
>> > + ?interrupt source. ?The type shall be a <u32> and the value shall be 1.
>> > +- reg : Specifies base physical address(s) and size of the GIC registers. The
>> > + ?first 2 values are the GIC distributor register base and size. The 2nd 2
>> > + ?values are the GIC cpu interface register base and size.
>> > +- irq-start : The first actual interrupt that is connected to h/w.
>>
>> Drop irq-start. ?That's a Linux internal implementation detail, and
>> Linux can easily handle dynamic assignment of irq ranges.
>
> Something has to be done with the IRQs on GIC, because Linux probably
> won't have a 1:1 mapping between the hardware IRQ numbers and the Linux
> IRQ numbers
>
> Have you seen the patches from Marc which deal with the per-CPU
> interrupts by creating individual Linux IRQ numbers for each CPU for
> each per-CPU interrupt? ?So you can end up with 16 per-CPU x 4 CPUs =
> 64 Linux interrupts for 16 "hardware" interrupts.
>
> How would DT deal with that - and how would you specify a connection
> between a per-CPU PMU and one of the per-CPU interrupts?

In general, bindings focus on the hardware and hardware configuration
instead of what Linux needs internally.  For a lot of interrupt
controllers, an irq specifier consists of two u32 values.  The first
value being the hardware irq number (perhaps 0-15 in this case), and
the second value being a set of flags.

Without looking deeply and the GIC interface details, I suspect that
the CPU affinity would best be represented as a field in the flags
value.

The per-CPU PMU connections then wouldn't be any different from any
other irq in that the irq specifier would include a CPU affinity
value.

>
> The sensible thing from a DT point of view I think would be to ignore
> that abstraction, and have some kind of mapping layer between DT and
> drivers which knew about that.

Yup, and that is exactly what is done.  On powerpc it uses the virtual
irq infrastructure.  For ARM and everyone else, there are patches on
list for irq_domain which implements the required behaviour.  The
interrupt controller driver can make decisions about how to map the
hardware irq to a linux irq number.  For most irq controllers, it will
be a simple 1:1 mapping, but for something complex like the gic, it
can do something different if need be.

> ?But that sounds like a world of pain.

Actually, it turns out not to be.  We've been needing/wanting some
form of irq_domains anyway for a while now to better manage hwirq ->
linuxirq mappings.  Adding DT to the mix means also suppling a DT
decode function to get the hwirq number from the interrupt specifier.

I'll be reposting a bunch of patches in the next few days that fills
in most of the missing pieces for irq mapping.

g.
