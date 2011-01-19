From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Jan 2011 13:12:51 -0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <20110119115737.GC31652@n2100.arm.linux.org.uk>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<000001cbb7cd$7cb9c840$762d58c0$@deacon@arm.com>
	<20110119115737.GC31652@n2100.arm.linux.org.uk>
Message-ID: <000101cbb7da$93e05fe0$bba11fa0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for the insight.

> On Wed, Jan 19, 2011 at 11:39:09AM -0000, Will Deacon wrote:
> > 3.) Rework the GIC code so that an IRQ can target multiple CPUs and remove
> >     the distributor-level masking. I think this was originally done so that
> >     we can service different IRQs simultaneously, but with the deprecation
> >     of IRQF_DISABLED I'm not sure if this is still an issue. If not, then
> >     we can change to masking at the CPU interfaces which will make
> >     supporting your combined IRQ much easier.
> 
> If an interrupt is routed to multiple cores simultaneously, then you end
> up with a number of problems:
> 
> 1. Each time an interrupt occurs, you wake up all CPUs.
> 2. One CPU wins the race and starts to handle the interrupt.  The others
>    are left spinning on a lock waiting.  Eventually the lock is dropped
>    and they too enter the handler.
> 3. Another race ensues on the drivers own spinlock.  The winning CPU
>    possibly holds this lock for the duration of its handling.  Meanwhile
>    the other CPUs are left spinning waiting for the lock to be dropped.
> 4. When the winning CPU drops the lock, it returns IRQ_HANDLED.  The other
>    CPUs find that there is no IRQ pending from the device, and return
>    IRQ_NONE.
> 
> (4) may result in the spurious/unhandled IRQ code eventually disabling
> the interrupt.

I don't think these are a problem if we only allow IRQs to be affine to
multiple CPUs when the IRQF_PERCPU flag is set. All other interrupts will
concern only a single CPU and the corresponding CPU interface.

For these PERCPU interrupts, the wakeups and lock contention is part of the
deal - that's a consequence of setting an affinity mask containing multiple
CPUs.

It's worth noting that the Virtualisation Extensions (Cortex-A15) only provide
a virtualised view of the CPU interfaces. The distributor must be trapped using
a second-stage translation by the hypervisor, so accessing it becomes a massive
overhead in the critical interrupt path in Linux.

Will
