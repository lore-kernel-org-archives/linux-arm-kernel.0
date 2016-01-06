From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Jan 2016 14:17:12 +0000
Subject: [PATCH 2/2] arm64: factor work_pending state machine to C
In-Reply-To: <20160106134313.GK563@leverpostej>
References: <20160105172106.GA7088@leverpostej>
 <1452015215-29506-2-git-send-email-mark.rutland@arm.com>
 <20160106134313.GK563@leverpostej>
Message-ID: <20160106141712.GO6301@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 01:43:14PM +0000, Mark Rutland wrote:
> On Tue, Jan 05, 2016 at 05:33:35PM +0000, Mark Rutland wrote:
> > Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
> > state machine that can be difficult to reason about due to duplicated
> > code and a large number of branch targets.
> > 
> > This patch factors the common logic out into the existing
> > do_notify_resume function, converting the code to C in the process,
> > making the code more legible.
> > 
> > This patch tries to mirror the existing behaviour as closely as possible
> > while using the usual C control flow primitives. There should be no
> > functional change as a result of this patch.
> 
> I realised there is a problem with this for kernel built with
> TRACE_IRQFLAGS, as local_irq_{enable,disable}() will verify that the IRQ
> state is as expected.
> 
> In ret_fast_syscall we disable irqs behind the back of the tracer, so
> when we get into do_notify_resume we'll get a splat.
> 
> In the non-syscall cases we do not disable interrupts first, so we can't
> balance things in do_notify_resume.
> 
> We can either add a trace_hardirqs_off call to ret_fast_syscall, or we
> can use raw_local_irq_{disable,enable}. The latter would match the
> current behaviour (and is a nicer diff). Once the syscall path is moved
> to C it would be possible to use the non-raw variants all-over.
> 
> Catalin, are you happy with using the raw accessors in do_notify_resume,
> or would you prefer using trace_hardirqs_off?

I would prefer the explicit trace_hardirqs_off annotation, even though
it is a few more lines.

-- 
Catalin
