From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 10 Jul 2013 19:09:28 +0100
Subject: Seg fault occurs when running statically compiled binary from
 kernel using call_usermodehelper
In-Reply-To: <20130710163410.GA30514@mudshark.cambridge.arm.com>
References: <CAOiN93mGTu9w9rVNCrbbH1sccXY9VJhaCmg+dS7Rk9mMgKHBaA@mail.gmail.com>
 <CAOiN93=Nx77RkbNuEJMV617MjV5+GmorF0G3vyLy1SwQcuCs+g@mail.gmail.com>
 <CAOiN93nH9fyHoz4yrZmJ-OKCy6ogdt5bYartXCBgP5eHMUBPdw@mail.gmail.com>
 <20130710163410.GA30514@mudshark.cambridge.arm.com>
Message-ID: <20130710180928.GB2872@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 05:34:11PM +0100, Will Deacon wrote:
> On Wed, Jul 10, 2013 at 11:42:25AM +0100, Ashish Sangwan wrote:
> > Any heads up on this?
> > 
> > or could someone just advice what can we do to debug this?
> > 
> > The ret_from_fork currently looks like following:
> > /*
> >  * This is how we return from a fork.
> >  */
> > ENTRY(ret_from_fork)
> >         bl      schedule_tail
> >         cmp     r5, #0
> >         movne   r0, r4
> >         adrne   lr, BSYM(1f)
> >         movne   pc, r5
> > 1:      get_thread_info tsk
> >         b       ret_slow_syscall
> > ENDPROC(ret_from_fork)
> > 
> > Is this a real issue? Because we are getting this just for static binaries.
> 
> Ok, I've finally got to the bottom of this, but I'm not sure on the best way
> to fix it. The issue is that libc expects r0 to contain a function pointer
> to be invoked at exit (rtld_fini), to clean up after a dynamic linker. If
> this pointer is NULL, then it is ignored. We actually zero this pointer in
> our ELF_PLAT_INIT macro.
> 
> At the same time, we have this strange code called next from the ARM ELF
> loader:
> 
> 	regs->ARM_r2 = stack[2];	/* r2 (envp) */			\
> 	regs->ARM_r1 = stack[1];	/* r1 (argv) */			\
> 	regs->ARM_r0 = stack[0];	/* r0 (argc) */			\
> 
> which puts argc into r0. Usually this gets overwritten by the return value
> of execve (0), so everything hangs together. With kernel threads this is
> different since we do the exec from ____call_usermodehelper on the stack and
> then return to the new application via ret_from_fork, which takes the
> slowpath; popping r0 from pt_regs and making argc visible to the library.
> 
> When the application exits and libc starts running its exit functions, we
> jump to hyperspace.
> 
> My inclination would be to remove the stack popping above (patch below),
> but it's a user-visible change and I'm not sure if something like OABI
> requires it.

It looks like populating r0-r2 is already broken -- libc must be getting
at least argc from the stack and not r0, otherwise it couldn't be
(ab)using r0 for some other purpose before _start.

Do I conclude correctly that the real problem here is a bug in the libc
startup code, which makes incorrect assumptions about the initial r0 in
the statically linked case?

At the ELF entry point, initial r0 is zero, but apparently only by
accident, since there is a clear intent in the kernel for r0=argc, even
if userspace can't have been using this any time recently since it is
normally clobbered with zero.  It seems incorrect for userspace to rely on
either -- but I guess there is no choice but to retain that behaviour now,
since it may break existing binaries which contain that libc bug.

Cheers
---Dave
