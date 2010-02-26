From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Feb 2010 22:03:52 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267220980.23523.1820.camel@pasglop>
References: <1266445892.16346.306.camel@pasglop>
	<1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
	<1266979170.23523.1660.camel@pasglop>
	<1267202674.14703.70.camel@e102109-lin.cambridge.arm.com>
	<1267220980.23523.1820.camel@pasglop>
Message-ID: <20100226220351.GE23933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2010 at 08:49:40AM +1100, Benjamin Herrenschmidt wrote:
> It will deadlock if you use normal IRQs. I don't see a good way around
> that other than using a higher-level type of IRQs. I though ARM has
> something like that (FIQs ?). Can you use those guys for IPIs ?

If the hardware did support using FIQs for IPIs, this would not be
desirable because then it takes it away from the SoC folk to do what
they will with it.

In the past, it's been used as a fast CPU-driven "DMA" interface -
some SoCs have been wired up in such a way that's the only use
available for the FIQ.

The other problem we'd encounter using FIQs for IPIs is that some IPIs
need to take locks - and in order to make that safe, we'd either need
another class of locks which disable IRQs and FIQs together, or we'd
need to disable FIQs everywhere we disable IRQs - at which point FIQs
become utterly pointless.

(There only differences between FIQ and IRQ are:
 - on simultaneous raising of both, the FIQ will be called before the IRQ.
 - each has its own (single) vector.
 - invocation of FIQ masks IRQ.

What I'm saying is that what gives FIQ an advantage for SoC people is
that it's bare bones light weight and therefore extremely fast - as soon
as you load it up with additional complexity, it becomes less useful.)
