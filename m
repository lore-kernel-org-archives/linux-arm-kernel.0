From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 30 Dec 2011 17:25:41 -0500
Subject: ftrace performance impact with different configuration
In-Reply-To: <23257775.9kkYY4quUh@laptop>
References: <CALZhoSRVNp=Sj2u2GHiQhuHOEdrfiM58KzG+RutvJV=8CoCpTQ@mail.gmail.com>
 <CAH+eYFDb4r235jAGjr7j5R5C+9YK9WeXXjVZGWQUB=330sOi0Q@mail.gmail.com>
 <1325175685.24045.5.camel@gandalf.stny.rr.com> <23257775.9kkYY4quUh@laptop>
Message-ID: <1325283941.24045.15.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-12-30 at 14:07 +0100, Philippe R?tornaz wrote:

> Sorry about being a bit naive, but why it is not possible to do it in two 
> steps ?
> call stop_machine to put the jmp which skip the call to mcount
> Then wait until all tasks hits schedule() (synchronize_sched() ?)

Here's the problem. With a preemptible kernel, hitting schedule() does
not mean that you can guarantee that all tasks have not been
interrupted.


	nop (use to be push lr)
	------------> interrupt
			set NEED_RESCHED
			end of interrupt
			preempt_schedule()
				schedule()

	[ another processes is now running ]
	call stop_machine()
	put in push lr
	call stop_machine()
	put in call to mcount

	everything seems to be running fine.

	the low priority task gets scheduled again...


				schedule() finishes
			preempt_schedule() finishes
			back at tail of return_from_intr in entry_64.S
			iret
	call mcount
			pop lr (which was never pushed)
			jmp lr

Now we jump back to some random stuff and the stack is corrupted.

There's no way to safely modify two instructions that depend on each
other in a preemptible kernel, with the exception of waiting for all
CPUs to hit idle (which may never happen on a busy system). And even
that may be racy.

-- Steve

> Then modify both instructions to put in place the two nops since we know that 
> nobody is calling mcount.
