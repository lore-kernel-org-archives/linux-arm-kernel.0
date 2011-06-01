From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 14:22:33 +0100
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601211751.69b85eeb@tom-ThinkPad-T410>
References: <20110601154259.12487694@tom-ThinkPad-T410>
	<20110601093436.GF3660@n2100.arm.linux.org.uk>
	<20110601211751.69b85eeb@tom-ThinkPad-T410>
Message-ID: <20110601132233.GG3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 09:17:51PM +0800, Ming Lei wrote:
> Hi,
> 
> On Wed, 1 Jun 2011 10:34:36 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Wed, Jun 01, 2011 at 03:42:59PM +0800, Ming Lei wrote:
> > > @@ -435,6 +435,10 @@ __irq_usr:
> > >  	usr_entry
> > >  	kuser_cmpxchg_check
> > >  
> > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > 
> > I think this wants to be CONFIG_IRQSOFF_TRACER.
> 
> IMO, this should be CONFIG_TRACE_IRQFLAGS because we
> want to trace interrupt disable and enable here, but
> enabling CONFIG_IRQSOFF_TRACER means interrupt-off
> latency tracer will be switched on, see kernel/trace/Kconfig.

If CONFIG_IRQSOFF_TRACER is not set, we don't bother telling the tracer
that we've turned IRQs on for userspace when we exit from the kernel,
and we don't bother telling the tracer that we've turned IRQs off when
entering from userspace back into the kernel.

So, making this depend on CONFIG_TRACE_IRQFLAGS looks wrong to me.
