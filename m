From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Aug 2013 19:16:36 +0100
Subject: [Linaro-acpi] [PATCH 0/3] Interrupt priority patch set
In-Reply-To: <1db399be587d446b955bdc608d2a4260@BY2PR07MB092.namprd07.prod.outlook.com>
References: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
 <20130826171501.GD6617@n2100.arm.linux.org.uk>
 <1db399be587d446b955bdc608d2a4260@BY2PR07MB092.namprd07.prod.outlook.com>
Message-ID: <20130826181636.GE6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 05:29:10PM +0000, Lurndal, Scott wrote:
>   The System Error Int/Exception (known on armv7 as ABORT) is a bit closer
> to the semantics that NMI provides on x86 (with the exception that the
> SEI can be masked by the PSTATE.A flag).  I don't believe that linux currently
> uses SEI's for any generic purpose.

I can only talk about Aarch32.

An abort (which, if you're referring to the PSR A flag is what you are
referring to) is much better than an interrupt, because it can occur at
any time from any context - except as you note when the A flag masks it.
It gets completely out of the "irq priority" and "irq masked so can't
receive it" problems.

>   Many of us have been requesting ARM to add a real non-maskable interrupt,
> but it is claimed that prioritization is sufficient for most needs (a claim
> with which I disagree).

So I disagree with wanting a "non-maskable interrupt" - what you want is
for the system to raise an _exception_ when something bad happens.  As
I understand it, this is exactly what happens if you have systems with
ECC or parity.  There's error codes in the fault status register for
prefetch (instruction) and data exceptions to indicate parity errors.

There's support in the architecture for external peripherals and memory
subsystems to raise "external aborts" when things go wrong too, which
can be precise (happen at the point when the instruction is executed)
or imprecise (happen sometime later.)

So, I believe ARM have already done what's necessary: what is more hit
and miss is whether any particular vendor implements any of this stuff,
and that's not ARM's problem - that's the vendors problem.

OMAP does - OMAP raises aborts if you (for example) access a peripheral
when all its clocks are turned off.  On the other hand, Marvell Dove
wedges the CPU solid when that happens.

Yes, it may not be called an "interrupt" and it may not be a pin on the
interrupt controller, but just because x86 does that doesn't mean it's
the best solution everywhere.
