From: nikolay.borisov@arm.com (Nikolay Borisov)
Date: Tue, 17 Jun 2014 16:12:04 +0100
Subject: [PATCH RESEND 0/7] Fix backtrace support in THUMB2 mode
In-Reply-To: <20140617144929.GA1929@n2100.arm.linux.org.uk>
References: <1400837196-22339-1-git-send-email-Nikolay.Borisov@arm.com>
 <20140617144929.GA1929@n2100.arm.linux.org.uk>
Message-ID: <000001cf8a3e$7ff4aa60$7fddff20$@borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: 17 June 2014 15:49
> To: Nikolay Borisov
> Cc: linux-arm-kernel at lists.infradead.org; jld at mozilla.com;
> rric at kernel.org; a.p.zijlstra at chello.nl; Will Deacon;
> sboyd at codeaurora.org; dave.long at linaro.org; u.kleine-
> koenig at pengutronix.de; Dave P Martin
> Subject: Re: [PATCH RESEND 0/7] Fix backtrace support in THUMB2 mode
> 
> On Fri, May 23, 2014 at 10:26:29AM +0100, Nikolay Borisov wrote:
> > Currently all the code which deals with backtrace support assumes
> that R11
> > is the frame-pointer. While this is the case for ARM mode and is
> explicitly
> > documented in the AAPCS, this is not the case for THUMB2 mode.
> >
> > There is no official document requiring that R11 has to be the frame
> pointer
> > and GCC uses R7 as FP and given that R7's usage is so intertwined
> within GCC's
> > mechanics it is unlikely to change, so fixing backtrace in THUMB2
> mode seems
> > in order.
> >
> > This patch series rectifies the problem by first fixing the
> > thread_save_fp macro to reference the correct register. Furthermore,
> there
> > a lot of repetetive sequences of code such as :
> >
> > stackframe.fp = pt_regs->ARM_fp
> > stackframe.lr = pt_regs->ARM_lr
> >
> > so introducing a function arm_get_current_stack_frame which both
> > hides this repetition and also utilizes teh frame_pointer(regs) macro
> > to reference the correct register depending on the mode.
> >
> > Finally, change all the call sites so that they utilize the new
> routine.
> 
> Can someone please explain to me what the point of this churn is?
> 

During my testing with a THUMB2 kernel it turned out that no stacktrace
information was being printed when either magic-sysrq was used
or the 'ps -Al' command executed. The commit message of patch 8069/1 does
list those uses cases as failures resulting from this bug. 

Are you able to obtain backtrace support from a THUMB2 kernel using the 
the correct magic sysrq to dump the current threads stacktrace?

This thread started by Jed David also sheds some light on the issue: 
https://lkml.org/lkml/2013/7/12/469


> Let's start with a summary of Thumb2 kernel building.  When a Thumb2
> kernel is built, we may build it with or without frame pointers.  In
> either case, we always require the unwinder.
> 
> When the unwinder is in use, we don't use the APCS backtracing support.
> The APCS backtracing support makes use of the frame pointer (and
> requires
> frame pointer support.)
> 
> The unwinder, although it is given what would be in the frame pointer
> register, never reads from this value - the only registers that the
> unwinder cares about is the stack pointer (so it can read values off
> the stack), LR (in case PC is zero) and the PC value itself (so it can
> work out where in the unwind information to start the unwinding
> process.
> 
> The unwinder does write to the FP entry, but this is not really used
> for anything (in much the same way that it writes to the other
> registers.)  It also prints the FP value in its debugging, though what
> use that is can be argued.
> 
> So, although the code /may/ look weird, and not really conform to what
> is expected, don't see any bug with the code as it stands today (with
> the exception of one c_backtrace() call in arm_syscall, which should
> probably be fixed - but that's an entirely separate problem.)
> 
> While we may deem that introducing arm_get_current_stackframe() is
> a useful cleanup, that's all it should be...
> 
> Am I missing something?
> 
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up...
> slowly
> improving, and getting towards what was expected from it.
