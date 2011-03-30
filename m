From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2011 21:43:51 +0200
Subject: [PATCH V5 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <20110330191506.GD2939@n2100.arm.linux.org.uk>
References: <1301444651-18008-1-git-send-email-john.linn@xilinx.com>
	<201103301529.03648.arnd@arndb.de>
	<20110330191506.GD2939@n2100.arm.linux.org.uk>
Message-ID: <201103302143.51409.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2011 21:15:06 Russell King - ARM Linux wrote:
> And how do you deal with PCMCIA implementations where each socket has
> its own separate IO space, each maybe several MB large and may be spread
> across several MB of memory with the PCMCIA attribute and PCMCIA memory
> spaces interspersed.  Remember that PCMCIA drivers assume PCI/ISA IO
> support.

I would assume that the majority of implementations uses regular (64KB)
I/O spaces per bus, so within 1 MB, that could fit 16 of them.

> What about platforms which have a real ISA IO space in addition to the
> PCMCIA IO spaces?

I'd do the same as on powerpc: One of them gets registered as the "primary"
bus, which gets the first 64KB. This one is typically the only
one that can support legacy ISA devices with hardcoded I/O port numbers.

Any other bus (PCI, PCMCIA, secondary ISA if needed) can go into one
of the other 15 64KB slots.

> Things aren't as simple as you'd like them to be, and sometimes changing
> this stuff changes userland too (think PCMCIA needing the IO regions
> declared to it from userspace during boot.)

Can you give an example what hardware or driver needs this?

Anyway, the idea is more to have a standard implementation that can be
used by most platforms without causing pain, getting us one step
closer to a multiplatform kernel. If one of the more obscure platforms
doesn't fit, it can still use its own variant and not be part of the
multiplatform configuration. There are a lot of other things needed
before we get there anyway.

	Arnd
