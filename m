From: pistol@cs.duke.edu (Valentin Pistol)
Date: Wed, 23 Jan 2013 12:35:14 -0500
Subject: ARM: hw_breakpoint mismatch breakpoint behaves unexpectedly like
 a match breakpoint on ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <20130123145007.GB26811@mudshark.cambridge.arm.com>
References: <CAPfQmKJaYf6M4iHKuNcHgYZi5R8M7fXdXta34Q=1C0cHKimkyQ@mail.gmail.com>
 <20130122093102.GC12295@mudshark.cambridge.arm.com>
 <CAPfQmK+mwx39J5yWiLCTWbiFL=yL-rw=XZXRkOwGU_byQsDyQA@mail.gmail.com>
 <20130123145007.GB26811@mudshark.cambridge.arm.com>
Message-ID: <CAPfQmKL7trB0Ha4kDFGcPMC8QY4OrH=kAtPV0KppAE6k+FVgFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > So it was managing its own breakpoints and instruction decoding (like
> > gdb would) but didn't take advantage of either mismatch support or
> > hw_breakpoints?
>
> Correct. The code also didn't handle newer instructions especially well,
> with issues on SMP too. Given that the request is only supposed to be
> implemented for architectures with hardware single-step, it made sense to
> remove the code.

Makes sense, thanks for clarifying.

>
> > I'm wondering how pervasive the required changes are to support
> > SINGLESTEP with mismatch breakpoints.
> > If you think it's a good idea I'm very willing to try and add-in such support.
> > Please let me know if there's some obvious issues about going forward
> > with this that you may be aware of.
>
> Given that ARMv8 has hardware single-step, I'd be inclined to implement
> that instead so that we don't have to overload the SINGLESTEP request later
> on. Alternatively, you could implement something like PTRACE_HBPSTEP but I
> think you will run into some problems:

That's very interesting. I'm not very familiar with ARMv8, could you
expand a bit on what exactly ARMv8 provides that offers that hardware
single-step that ARMv7 does not?
Seems it's different than the mismatch breakpoints, which I thought
are sufficient for the task.

>
>         1. Alignment restrictions. Stepping something like a 32-bit Thumb
>            instruction on a halfword boundary will need *two* breakpoints to
>            be added and handled appropriately.
>
>         2. Interaction with mismatch breakpoints being used internally by
>            the kernel. You might be ok here, but you want to check the code
>            which uses mismatch breakpoints to step over breakpoints and
>            watchpoints.

Thanks for providing this insight.
I'm aware of arch/arm/kernel/hw_breakpoint.c and kernel/ptrace.c using
single-step.
Are you thinking of other parts of the kernel as well?

Regarding the existing code to single-step breakpoints and
watchpoints, does it have to do with the trap semantics or is there
more to it?
For instance upon a breakpoint return the faulting instruction will
re-execute, causing a trap loop, hence the need to step over it.
But then again wouldn't this be avoided by unsetting the breakpoint
before returning from the handler?

Regards,
Valentin
