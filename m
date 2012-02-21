From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 17:24:09 +0000
Subject: ARM tracehook support
In-Reply-To: <4F43CF0C.2020301@mentor.com>
References: <4F4268D5.7070103@mentor.com>
 <20120220154748.GG25462@mudshark.cambridge.arm.com>
 <4F428C39.40906@mentor.com> <4F43CF0C.2020301@mentor.com>
Message-ID: <20120221172408.GJ23133@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wade,

Thanks for following this up.

On Tue, Feb 21, 2012 at 05:06:20PM +0000, Wade Farnsworth wrote:
> >
> > I believe the 6 argument constraint is a specific to
> > syscall_get_arguments(). Notice the comment in
> > include/asm-generic/syscall.h:
> >
> > /*
> > [...]
> > *
> > * It's only valid to call this when @task is stopped for tracing on
> > * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
> > * It's invalid to call this with @i + @n > 6; we only support system calls
> > * taking up to 6 arguments.
> > */
> >
> > Additionally, if you'll look at the other architectures' implementations
> > you'll see similar code.

In which case could we #define this somewhere to make it more obvious?

> In a nutshell, the argument is that syscall_get_arguments() doesn't need 
> to know about any of the argument semantics, they just pass all 
> registers that may contain arguments back up the stack.  It's then up to 
> the tracer to interpret the arguments.  The argument is similar for 
> syscall_set_arguments().  Since the same register set is used for both 
> EABI and OABI, there doesn't need to be any specific handling of one 
> versus the other here.

Ok, if the low-level code doesn't need to interpret arguments then that
should be fine. sys_arm_fadvise64_64 would be the tricky case, but the
argument ordering seems to have been chosen explicitly to place the 64-bit
offsets naturally on even registers, fitting it neatly into 6 registers.

Once you've rebased the code, please post a new version so it can be
reviewed again.

Cheers,

Will
