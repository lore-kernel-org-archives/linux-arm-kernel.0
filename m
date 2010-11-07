From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Nov 2010 17:12:18 +0000
Subject: ARM stacktrace and SMP
In-Reply-To: <4CD38343.8080406@codeaurora.org>
References: <4CD38343.8080406@codeaurora.org>
Message-ID: <20101107171218.GD1759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 04, 2010 at 09:08:35PM -0700, Jeff Ohlstein wrote:
> I am looking at the stacktrace support on arm, namely with respect to its
> support for SMP. I'm curious as to what is different between the ARM support
> and the support on other platforms.
>
> I found this quote from Russell:
> >This is unsafe on SMP - 'tsk == current' has no meaning where SMP systems
> >are concerned - the fact that tsk is not current does not mean that it
> >isn't running on another CPU.
> >
> >Basically, if a thread is running on a CPU, thread_saved_fp() is invalid.
> >
> >So, the question is: what guarantees do we have here that 'tsk' is not
> >running on another CPU?
>
> What harm can come from using an invalid thread_saved_fp()?

It's not just thread_saved_fp(), but all the other thread saved values.
Without these being known to be valid, the unwinder can't hope to do any
unwinding.

> Is there any
> possibility that attempting to unwind a process stack with an invalid frame
> pointer could cause a system crash, or will it just return garbage stack
> frames?

I suspect so - especially as the unwinder needs to be able to retrieve
values from the stack.

> Do other platforms simply ignore this issue?

Other platforms don't have to walk the Dwarf unwind information.

> We are interested in
> dumping stack trace data for all processes when our target crashes, so
> even potentially inaccurate data is better than nothing.

Have you thought of using the existing system debugging options via sysrq?

> As far as actually fixing it is concerned, is there a way to stop a given
> task from being scheduled, or wait until it is descheduled if it is running?
> I didn't see anything like that at first glance, other than stop_machine
> which is rather heavy-handed.

The more complexity you want to do when the system crashes, the more
probable that you won't be able to get information out of the target
when it has crashed.  Normally, a crash means something got corrupted,
and trying to schedule afterwards can cause additional crashes.
