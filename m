From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Thu, 12 May 2011 14:15:42 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110512074850.GA9937@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
Message-ID: <20110512121539.GA7410@nowhere>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 09:48:50AM +0200, Ingo Molnar wrote:
> To restrict execution to system calls.
> 
> Two observations:
> 
> 1) We already have a specific ABI for this: you can set filters for events via 
>    an event fd.
> 
>    Why not extend that mechanism instead and improve *both* your sandboxing
>    bits and the events code? This new seccomp code has a lot more
>    to do with trace event filters than the minimal old seccomp code ...
> 
>    kernel/trace/trace_event_filter.c is 2000 lines of tricky code that
>    interprets the ASCII filter expressions. kernel/seccomp.c is 86 lines of
>    mostly trivial code.
> 
> 2) Why should this concept not be made available wider, to allow the 
>    restriction of not just system calls but other security relevant components 
>    of the kernel as well?
> 
>    This too, if you approach the problem via the events code, will be a natural 
>    end result, while if you approach it from the seccomp prctl angle it will be
>    a limited hack only.
> 
> Note, the end result will be the same - just using a different ABI.
> 
> So i really think the ABI itself should be closer related to the event code. 
> What this "seccomp" code does is that it uses specific syscall events to 
> restrict execution of certain event generating codepaths, such as system calls.
> 
> Thanks,
> 
> 	Ingo

What's positive with that approach is that the code is all there already.
Create a perf event for a given trace event, attach a filter to it.

What needs to be added is an override of the effect of the filter. By default
it's dropping the event, but there may be different flavours, including sending
a signal. All in one, extending the current code to allow that looks trivial.

The negative points are that

* trace events are supposed to stay passive and not act on the system, except
doing some endpoint things like writing to a buffer. We can't call do_exit()
from a tracepoint for example, preemption is disabled there.

* Also, is it actually relevant to extend that seccomp filtering to other events
than syscalls? Exposing kernel events to filtering sounds actually to me bringing
a new potential security issue. But with fine restrictions this can probably
be dealt with. Especially if by default only syscalls can be filtered

* I think Peter did not want to give such "active" role to perf in the system.
