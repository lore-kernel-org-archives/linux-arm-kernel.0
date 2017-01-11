From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 11 Jan 2017 15:33:52 +0000
Subject: Unhandled level 2 translation fault (11) at 0x000000b8, esr
 0x92000046, rpi3 (aarch64)
In-Reply-To: <20170111144902.GA20288@e104818-lin.cambridge.arm.com>
References: <CAGDbNAD7-TM6+x0A3FebTOPYmqQqbm1w29ZwH+9qePaAvhxTKw@mail.gmail.com>
 <20161230151323.583b7ac5@xhacker>
 <CAGDbNAAGqFqt7X+=XYRLAp=L_fTv9dAAe=wu4T_W-FCGqnYHHg@mail.gmail.com>
 <20170109151354.GC7593@e104818-lin.cambridge.arm.com>
 <CAGDbNAC-8w1xytLuzWTMnWLi8=j1ShkwE3CLXQ5q75m_RibCMA@mail.gmail.com>
 <20170110121423.GF19960@e104818-lin.cambridge.arm.com>
 <20170111144902.GA20288@e104818-lin.cambridge.arm.com>
Message-ID: <20170111153349.GK3699@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:49:03PM +0000, Catalin Marinas wrote:
> On Tue, Jan 10, 2017 at 12:14:23PM +0000, Catalin Marinas wrote:
> > On Mon, Jan 09, 2017 at 07:06:19PM +0100, Bas van Tiel wrote:
> > > > I defined STACKSIZE to the kernel's SIGSTKSZ (16384) and it seems to run
> > > > fine, though I'll leave it longer/overnight (on a Juno board). With the
> > > > 4K signal stack it was crashing shortly after start.
> > > 
> > > I tried the STACKSIZE of 16384 for both the RPI3 and the PINEA64 board
> > > and still see the same behaviour of crashing. Sometimes the process
> > > is also blocked for a long time before it crashes.
> > > 
> > > Setting the interval to 200 usec [5 Khz] will help to crash it faster.
> > > 
> > > To further isolate the issue I will create a kernel module (based on a
> > > hrtimer) that will sent a periodic signal to the registered process
> > > and execute the same sighandler logic to check if the problem is still
> > > there.
> > 
> > I lowered the interval to 100us (it was 100ms in the original file) and
> > I can indeed trigger segfault easily on Juno. But it doesn't fail in the
> > same way every time, I sometimes get permission fault, other times bad
> > frame.
> 
> With 100us interval, it segfaults on x86 fairly quickly as well, so I
> don't think it's a kernel issue.

To be able to take a signal at all, stacks need to be at least SIGSTKSZ
bytes in practice:


diff --git a/context_demo.c b/context_demo.c
index 2cc63f7..b1f3bbc 100644
--- a/context_demo.c
+++ b/context_demo.c
@@ -22,7 +22,7 @@
 
 
 #define NUMCONTEXTS 10              /* how many contexts to make */
-#define STACKSIZE 4096              /* stack size */
+#define STACKSIZE SIGSTKSZ          /* stack size */
 #define INTERVAL 100                /* timer interval in nanoseconds */
 
 sigset_t set;                       /* process wide signal mask */


The other issue looks a bit subtler, to do with signal masking.

SIGALRM will be masked on entry to timer_interrupt() and restored on
return, due to and absence of SA_NODEFER from sa_flags when calling
sigaction.  (Setting SIGALRM in sa_mask also has this effect, but this
is redundant without SA_NODEFER.)

However, by explicitly clearing this signal from
signal_context.uc_sigmask, we'll enter scheduler() with SIGALRM
unmasked.  If a new SIGALRM is taken before scheduler() has called
setcontext(), we'll pile up another signal on signal_stack and call
schedule() again, still on signal_stack ... and this can repeat
indefinitely.

There's no need to clear SIGALRM from the signal mask: it will be
cleared when timer_interrupt() returns after resuming an interrupted
task (as part of the signal frame restore work done by rt_sigreturn).
So:

@@ -61,7 +61,6 @@ timer_interrupt(int j, siginfo_t *si, void *old_context)
     signal_context.uc_stack.ss_sp = signal_stack;
     signal_context.uc_stack.ss_size = STACKSIZE;
     signal_context.uc_stack.ss_flags = 0;
-    sigemptyset(&signal_context.uc_sigmask);
     makecontext(&signal_context, scheduler, 1);
 
     /* save running thread, jump to scheduler */

For me, this seems to fix the problem.

It also makes sense of what we've seen: we need either short timer
intervals, slow machines, or high system load (or some combination) in
order to take enough extra signals in scheduler() to cause a stack
overflow.

I can't see the purpose of running scheduler() in its own context here,
except so that it doesn't contribute stack overhead to the thread
stacks (which hardly seems worthwhile, since its overhead is probably a
lot smaller than the signal overhead anyway -- maybe I'm missing
something).

makeconext() and swapcontext() are obsoleted by POSIX.1-2008 and
considered non-portable (see makecontext(3), swapcontext(3)).  Really,
the ucontext API should not be used for anything except cooperative
switching now (certainly this covered the vast majority or real-world
usage the last time I looked into it).  For anything else, pthreads
almost certainly do it better.

Cheers
---Dave
