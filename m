From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2013 23:04:48 +0100 (CET)
Subject: [patch 2/2] arm: Allow forced irq threading
In-Reply-To: <20130214214931.GK17833@n2100.arm.linux.org.uk>
References: <20130214205204.109023136@linutronix.de>
 <20130214205304.993009840@linutronix.de>
 <20130214214931.GK17833@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1302142256520.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Feb 2013, Russell King - ARM Linux wrote:

> On Thu, Feb 14, 2013 at 08:53:53PM -0000, Thomas Gleixner wrote:
> > All timer interrupts and the perf interrupt are marked NO_THREAD, so
> > its safe to allow forced interrupt threading.
> 
> What effect does this have on IRQ latency, particularly on the slower CPUs?
> 
> If it adds to the IRQ latency, then it must be conditional; there are
> platforms where IRQ latency is important for things like network devices
> to keep up (particularly the SMC NICs).

It does not affect anything unless you add "threadirqs" to the kernel
command line. This command line argument puts the kernel into forced
irq threading mode. Otherwise it just works as now.

And yes, if enabled on the command line it adds latency due to the
delayed invocation of the handler in the thread.

Though for mainline this is primary a debug mechanism where you can
morph the kernel explosion in the interrupt handler into a takedown of
the handler thread instead of crashing the machine completely.
 
Now on RT we force this and I can tell you that even on slow machines
with SMC NICs the overhead seems to be in a range where these systems
can cope with. Of course, if you tweak the scheduling params of the
irq thread low enough you can run into problematic situations. But
that's not an ARM specific problem, that's a general problem of
configuring a RT system.

Thanks,

	tglx
