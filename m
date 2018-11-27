From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Nov 2018 10:56:20 +0000
Subject: [PATCH] arm: always update thread_info->syscall
In-Reply-To: <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
 <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
Message-ID: <20181127105620.GD30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 08:30:32AM -0200, Rafael David Tinoco wrote:
> On 11/26/18 9:44 PM, Russell King - ARM Linux wrote:
> >On Mon, Nov 26, 2018 at 11:41:11PM +0000, Russell King - ARM Linux wrote:
> >>On Mon, Nov 26, 2018 at 11:33:03PM +0000, Russell King - ARM Linux wrote:
> >>>On Mon, Nov 26, 2018 at 08:53:35PM -0200, Rafael David Tinoco wrote:
> >>>>Right now, only way for task->thread_info->syscall to be updated is if
> >>>>if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
> >>>>(similar to what has_syscall_work() checks for arm64).
> >>>>
> >>>>This means that "->syscall" will only be updated if we are tracing the
> >>>>syscalls through ptrace, for example. This is NOT the same behavior as
> >>>>arm64, when pt_regs->syscallno is updated in the beginning of svc0
> >>>>handler for *every* syscall entry.
> >>>
> >>>So when was it decided that the syscall number will always be required
> >>>(we need it to know how far back this has to be backported).
> >>
> >>PS, I rather object to the fact that the required behaviour seems to
> >>change, arch maintainers aren't told about it until... some test is
> >>created at some random point in the future which then fails.
> >>
> >>Surely there's a better way to communicate changes in requirements
> >>than discovery-by-random-bug-report ?
> >
> >Final comment for tonight - the commit introducing /proc/*/syscall says:
> >
> >     This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
> >     These use task_current_syscall() to show the task's current system call
> >     number and argument registers, stack pointer and PC.  For a task blocked
> >     but not in a syscall, the file shows "-1" in place of the syscall number,
> >     followed by only the SP and PC.  For a task that's not blocked, it shows
> >     "running".
> >
> >Please validate that a blocked task does indeed show -1 with your patch
> >applied.
> 
> Will do. This is done in an upper level (collect_syscall <-
> task_current_syscall <- proc_pid_syscall):
> 
> 	if (!try_get_task_stack(target)) {
> 		/* Task has no stack, so the task isn't in a syscall. */
> 		*sp = *pc = 0;
> 		*callno = -1;
> 		return 0;
> 	}
> 
> I think only missing part for arm was that one, but will confirm, after
> fixing usage of "r7" for obtaining "scno". Will send a v2 in this thread.

There's another question - what's the expected behaviour when we
restart a syscall using the restartblock mechanism?  Is the syscall
number expected to be __NR_restart_syscall or the original syscall
number?

I can't find anywhere that this detail is specified (damn the lack
of API documentation - I'm tempted to say that we won't implement
this until it gets documented properly, and that test can continue
failing until such time that happens.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
