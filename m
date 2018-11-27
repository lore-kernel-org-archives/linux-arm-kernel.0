From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Nov 2018 15:35:53 +0000
Subject: [PATCH] arm: always update thread_info->syscall
In-Reply-To: <20181127105620.GD30658@n2100.armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
 <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
 <20181127105620.GD30658@n2100.armlinux.org.uk>
Message-ID: <20181127153553.GE30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 10:56:20AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 27, 2018 at 08:30:32AM -0200, Rafael David Tinoco wrote:
> > On 11/26/18 9:44 PM, Russell King - ARM Linux wrote:
> > >On Mon, Nov 26, 2018 at 11:41:11PM +0000, Russell King - ARM Linux wrote:
> > >>On Mon, Nov 26, 2018 at 11:33:03PM +0000, Russell King - ARM Linux wrote:
> > >>>On Mon, Nov 26, 2018 at 08:53:35PM -0200, Rafael David Tinoco wrote:
> > >>>>Right now, only way for task->thread_info->syscall to be updated is if
> > >>>>if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
> > >>>>(similar to what has_syscall_work() checks for arm64).
> > >>>>
> > >>>>This means that "->syscall" will only be updated if we are tracing the
> > >>>>syscalls through ptrace, for example. This is NOT the same behavior as
> > >>>>arm64, when pt_regs->syscallno is updated in the beginning of svc0
> > >>>>handler for *every* syscall entry.
> > >>>
> > >>>So when was it decided that the syscall number will always be required
> > >>>(we need it to know how far back this has to be backported).
> > >>
> > >>PS, I rather object to the fact that the required behaviour seems to
> > >>change, arch maintainers aren't told about it until... some test is
> > >>created at some random point in the future which then fails.
> > >>
> > >>Surely there's a better way to communicate changes in requirements
> > >>than discovery-by-random-bug-report ?
> > >
> > >Final comment for tonight - the commit introducing /proc/*/syscall says:
> > >
> > >     This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
> > >     These use task_current_syscall() to show the task's current system call
> > >     number and argument registers, stack pointer and PC.  For a task blocked
> > >     but not in a syscall, the file shows "-1" in place of the syscall number,
> > >     followed by only the SP and PC.  For a task that's not blocked, it shows
> > >     "running".
> > >
> > >Please validate that a blocked task does indeed show -1 with your patch
> > >applied.
> > 
> > Will do. This is done in an upper level (collect_syscall <-
> > task_current_syscall <- proc_pid_syscall):
> > 
> > 	if (!try_get_task_stack(target)) {
> > 		/* Task has no stack, so the task isn't in a syscall. */
> > 		*sp = *pc = 0;
> > 		*callno = -1;
> > 		return 0;
> > 	}
> > 
> > I think only missing part for arm was that one, but will confirm, after
> > fixing usage of "r7" for obtaining "scno". Will send a v2 in this thread.
> 
> There's another question - what's the expected behaviour when we
> restart a syscall using the restartblock mechanism?  Is the syscall
> number expected to be __NR_restart_syscall or the original syscall
> number?
> 
> I can't find anywhere that this detail is specified (damn the lack
> of API documentation - I'm tempted to say that we won't implement
> this until it gets documented properly, and that test can continue
> failing until such time that happens.)

Having looked around, it seems that the /proc/<PID>/syscall interface
was sneaked into the kernel.  The patch series which added it was
sent in 2008 with a covering message that made no mention of this new
interface, instead stating:

  http://lkml.iu.edu/hypermail/linux/kernel/0807.2/0551.html

   Most of these changes move code around with little or no change,
   and they should not break anything or change any behavior.

While that statement is absolutely correct, it doesn't highlight the
fact that the set of patches _also_ include a brand new userspace
interface exposing things like syscall numbers and arguments in /proc.

There appears to be no documentation at all of this interface, so there
is no definition of how it is supposed to work or what it is supposed
to expose beyond what little information is in the original patch:

  http://lkml.iu.edu/hypermail/linux/kernel/0807.2/0577.html

   This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
   These use task_current_syscall() to show the task's current system call
   number and argument registers, stack pointer and PC. For a task blocked
   but not in a syscall, the file shows "-1" in place of the syscall number,
   followed by only the SP and PC. For a task that's not blocked, it shows
   "running".

This really isn't a good place to be - this is why commit messages
should _not_ just describe what the changes are doing, also _why_ they
are being made.  Also, any new user interface needs to be fully and
properly documented, because years later, people will move away,
knowledge will be lost, and that leaves us with a maintainability
problem, exactly like we have right now with this.

With the lack of interface documentation, how do we even know whether
the /proc/*/syscall is supposed to show the syscall number of non-traced
threads?  How do we know that the test that found this is actually
correct in reporting a failure?  How do we know whether it's supposed to
expose __NR_restart_syscall?

So, I thought I'd write a test program:

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/fcntl.h>
#include <unistd.h>

static int read_file(const char *fn, char *buf, size_t size)
{
	int fd, ret, nr;

	fd = open(fn, O_RDONLY);
	if (fd == -1)
		return -1;

	for (nr = 0; nr < size; nr += ret) {
		ret = read(fd, buf + nr, size - nr);
		if (ret <= 0)
			break;
	}

	close(fd);

	return nr ? nr : ret;
}

int main()
{
	char fn[64], buf[256];
	int pid, ret;

	pid = fork();
	if (pid == 0) {
		/* child */
		sleep(5);
		exit(0);
	}

	/* parent */
	sleep(1);
	snprintf(fn, sizeof(fn), "/proc/%d/syscall", pid);
	ret = read_file(fn, buf, sizeof(buf));

	printf("%.*s", ret, buf);

	kill(pid, SIGCONT);
	sleep(1);

	ret = read_file(fn, buf, sizeof(buf));

	printf("%.*s", ret, buf);

	return 0;
}

On x86 (32-bit app on 64-bit kernel), it has this behaviour:

$ ./syscall-test
162 0xffcc5a6c 0xffcc5a6c 0x48d09000 0x0 0xffcc5af4 0xffcc5a74 0xffcc5a2c 0xf77dfa59
162 0xffcc5a6c 0xffcc5a6c 0x48d09000 0x0 0xffcc5af4 0xffcc5a74 0xffcc5a2c 0xf77dfa59

which looks good, except:

$ strace -o /dev/null -f ./syscall-test
162 0xffc0070c 0xffc0070c 0x48d09000 0x0 0xffc00794 0xffc00714 0xffc006cc 0xf77f3a59
0 0xffc0070c 0xffc0070c 0x48d09000 0x0 0xffc00794 0xffc00714 0xffc006cc 0xf77f3a59

So, if we're syscall ptracing a program, __NR_restart_syscall gets
exposed through this interface, but if we aren't, it isn't exposed.
Which version is correct?  *shrug*, no documentation...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
