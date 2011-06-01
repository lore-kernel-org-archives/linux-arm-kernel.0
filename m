From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 15:46:30 +0100
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601222829.6eaad0e6@tom-ThinkPad-T410>
References: <20110601154259.12487694@tom-ThinkPad-T410>
	<20110601093436.GF3660@n2100.arm.linux.org.uk>
	<20110601211751.69b85eeb@tom-ThinkPad-T410>
	<20110601132233.GG3660@n2100.arm.linux.org.uk>
	<20110601222829.6eaad0e6@tom-ThinkPad-T410>
Message-ID: <20110601144630.GL3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 10:28:29PM +0800, Ming Lei wrote:
> From lib/Kconfig.debug:
> 
> 	config PROVE_LOCKING
> 		bool "Lock debugging: prove locking correctness"
> 		......
> 		select TRACE_IRQFLAGS
> 
> you can find locking prove does need to enable TRACE_IRQFLAGS. Meantime,
> we may not enable irq off tracer via below:
> 	
> 	Kernel hacking  --->
> 		Tracers  --->
> 			[ ]   Interrupts-off Latency Tracer	
> 
> so making this depend on CONFIG_TRACE_IRQFLAGS is reasonable.

I still don't see what the problem is.  If CONFIG_IRQSOFF_TRACER is not
set, then we do not tell the kernel that IRQs have been enabled upon exit
to user space, and we do not tell the kernel that IRQs have been disabled
upon entry to kernel space.

So your patch which makes us always report an IRQs off condition on entry
to __irq_usr makes no sense what so ever to me.

Please explain how we get to a situation where we're entering __irq_usr
in the CONFIG_IRQSOFF_TRACER unset case where the kernel incorrectly
believes that IRQs are unmasked.

Once you've done that, now analyze the case where CONFIG_IRQSOFF_TRACER
is set.  There, we tell the kernel that IRQs are enabled before returning
to userspace, and that IRQs are disabled when entering the kernel.  It
is only _now_ that we're missing the irq-off annotation on entry to the
interrupt handler.

Ergo, it should depend on CONFIG_IRQSOFF_TRACER, not CONFIG_TRACE_IRQFLAGS.
