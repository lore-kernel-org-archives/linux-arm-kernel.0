From: mingo@elte.hu (Ingo Molnar)
Date: Mon, 16 May 2011 14:55:05 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
Message-ID: <20110516125505.GE7128@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Will Drewry <wad@chromium.org> wrote:

> I agree with you on many of these points!  However, I don't think that the 
> views around LSMs, perf/ftrace infrastructure, or the current seccomp 
> filtering implementation are necessarily in conflict.  Here is my 
> understanding of how the different worlds fit together and where I see this 
> patchset living, along with where I could see future work going.  Perhaps I'm 
> being a trifle naive, but here goes anyway:
> 
> 1. LSMs provide a global mechanism for hooking "security relevant"
> events at a point where all the incoming user-sourced data has been
> preprocessed and moved into userspace.  The hooks are called every
> time one of those boundaries are crossed.

> 2. Perf and the ftrace infrastructure provide global function tracing
> and system call hooks with direct access to the caller's registers
> (and memory).

No, perf events are not just global but per task as well. Nor are events 
limited to 'tracing' (generating a flow of events into a trace buffer) - they 
can just be themselves as well and count and generate callbacks.

The generic NMI watchdog uses that kind of event model for example, see 
kernel/watchdog.c and how it makes use of struct perf_event abstractions to do 
per CPU events (with no buffrs), or how kernel/hw_breakpoint.c uses it for per 
task events and integrates it with the ptrace hw-breakpoints code.

Ideally Peter's one particular suggestion is right IMO and we'd want to be able 
for a perf_event to just be a list of callbacks, attached to a task and barely 
more than a discoverable, named notifier chain in its slimmest form.

In practice it's fatter than that right now, but we should definitely factor 
out that aspect of it more clearly, both code-wise and API-wise. 
kernel/watchdog.c and kernel/hw_breakpoint.c shows that such factoring out is 
possible and desirable.

> 3. seccomp (as it exists today) provides a global system call entry
> hook point with a binary per-process decision about whether to provide
> "secure computing" behavior.
> 
> When I boil that down to abstractions, I see:
> A. Globally scoped: LSMs, ftrace/perf
> B. Locally/process scoped: seccomp

Ok, i see where you got the idea that you needed to cut your surface of 
abstraction at the filter engine / syscall enumeration level - i think you were 
thinking of it in the ftrace model of tracepoints, not in the perf model of 
events.

No, events are generic and as such per task as well, not just global.

I've replied to your other mail with more specific suggestions of how we could 
provide your feature using abstractions that share code more widely. Talking 
specifics will i hope help move the discussion forward! :-)

Thanks,

	Ingo
