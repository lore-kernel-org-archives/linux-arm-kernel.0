From: wad@chromium.org (Will Drewry)
Date: Mon, 16 May 2011 10:29:56 -0500
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110516124304.GC7128@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<1305299455.2076.26.camel@localhost.localdomain>
	<20110514073015.GB9307@elte.hu>
	<BANLkTi=1CBKevjg3+fYFZF9zWtQVw-W9hQ@mail.gmail.com>
	<20110516124304.GC7128@elte.hu>
Message-ID: <BANLkTimcYyTxUDN4QysyOitTJYJP9ZavZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 7:43 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Will Drewry <wad@chromium.org> wrote:
>
>> > Note, i'm not actually asking for the moon, a pony and more.
>> >
>> > I fully submit that we are yet far away from being able to do a full LSM
>> > via this mechanism.
>> >
>> > What i'm asking for is that because the syscall point steps taken by Will
>> > look very promising so it would be nice to do *that* in a slightly more
>> > flexible scheme that does not condemn it to be limited to the syscall
>> > boundary and such ...
>>
>> What do you suggest here?
>>
>> From my brief exploration of the ftrace/perf (and seccomp) code, I don't see
>> a clean way of integrating over the existing interfaces to the ftrace
>> framework (e.g., the global perf event pump seems to be a mismatch), but I
>> may be missing something obvious. [...]
>
> Well, there's no global perf event pump. Here we'd obviously want to use
> buffer-less events that do no output (pumping) whatsoever - i.e. just counting
> events with filters attached.

Cool - I missed these entirely.  I'll get reading :)

> What i suggest is to:
>
> ?- share syscall events ? ? ? ?# you are fine with that as your patch makes use of them
> ?- share the scripting engine ?# you are fine with that as your patch makes use of it
>
> ?- share *any* other event to do_exit() a process at syscall exit time
>
> ?- share any other active event that kernel developers specifically enable
> ? for active use to impact security-relevant execution even sooner than
> ? syscall exit time - not just system calls
>
> ?- share the actual facility that manages (sets/gets) filters

These make sense to me at a high level.  I'll throw in a few initial
comments, but I'll be back for a round-two once I catch up on the rest
of the perf code.

> So right now you have this structure for your new feature:
>
> ?Documentation/trace/seccomp_filter.txt | ? 75 +++++
> ?arch/x86/kernel/ldt.c ? ? ? ? ? ? ? ? ?| ? ?5
> ?arch/x86/kernel/tls.c ? ? ? ? ? ? ? ? ?| ? ?7
> ?fs/proc/array.c ? ? ? ? ? ? ? ? ? ? ? ?| ? 21 +
> ?fs/proc/base.c ? ? ? ? ? ? ? ? ? ? ? ? | ? 25 +
> ?include/linux/ftrace_event.h ? ? ? ? ? | ? ?9
> ?include/linux/seccomp.h ? ? ? ? ? ? ? ?| ? 98 +++++++
> ?include/linux/syscalls.h ? ? ? ? ? ? ? | ? 54 ++--
> ?include/trace/syscall.h ? ? ? ? ? ? ? ?| ? ?6
> ?kernel/Makefile ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1
> ?kernel/fork.c ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?8
> ?kernel/perf_event.c ? ? ? ? ? ? ? ? ? ?| ? ?7
> ?kernel/seccomp.c ? ? ? ? ? ? ? ? ? ? ? | ?144 ++++++++++-
> ?kernel/seccomp_filter.c ? ? ? ? ? ? ? ?| ?428 +++++++++++++++++++++++++++++++++
> ?kernel/sys.c ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 11
> ?kernel/trace/Kconfig ? ? ? ? ? ? ? ? ? | ? 10
> ?kernel/trace/trace_events_filter.c ? ? | ? 60 ++--
> ?kernel/trace/trace_syscalls.c ? ? ? ? ?| ? 96 ++++++-
> ?18 files changed, 986 insertions(+), 79 deletions(-)
>
> Firstly, one specific problem i can see is that kernel/seccomp_filter.c
> hardcodes to the system call boundary. Which is fine to a prototype
> implementation (and obviously fine for something that builds upon seccomp) but
> not fine in terms of a flexible Linux security feature :-)
>
> You have hardcoded these syscall assumptions via:
>
> ?struct seccomp_filter {
> ? ? ? ?struct list_head list;
> ? ? ? ?struct rcu_head rcu;
> ? ? ? ?int syscall_nr;
> ? ? ? ?struct syscall_metadata *data;
> ? ? ? ?struct event_filter *event_filter;
> ?};

(This structure is a bit different in the new rev of the patch, but
nothing relevant to this specific part of the discussion :)

> Which comes just because you chose to enumerate only syscall events - instead
> of enumerating all events.

While I'm willing to live with the tradeoff, using ftrace event
numbers from FTRACE_SYSCALLS means that the filter will be unable to
hook a fair number of syscalls: execve, clone, etc  (all the ptregs
fixup syscalls on x86) and anything that returns int instead of long
(on x86).  Though the last two patches in the initial patch series
provided a proposed clean up for the latter :/

The current revision of the seccomp filter patch can function in a
bitmask-like state when CONFIG_FTRACE is unset or
CONFIG_FTRACE_SYSCALLS is unset.  This also means any platform with
CONFIG_SECCOMP support can start using this right away, but I realize
that is more of a short-term gain rather than a long-term one.

> Instead of that please bind to all events instead - syscalls are just one of
> the many events we have. Type 'perf list' and see how many event types we have,
> and quite a few could be enabled for 'active feedback' sandboxing as well.
>
> Secondly, and this is really a variant of the first problem you have, the way
> you process event filter 'failures' is pretty limited. You utilize the regular
> seccomp method which works by calling into __secure_computing() and silently
> accepting syscalls or generating a hard do_exit() on even the slightest of
> filter failures.
>
> Instead of that what we'd want to have is to have regular syscall events
> registered, *and* enabled for such active filtering purposes. The moment the
> filter hits such an 'active' event would set the TIF_NOTIFY_RESUME flag and
> some other attribute in the task and the kernel would do a do_exit() at the
> earliest of opportunities before calling the syscall or at the
> return-from-syscall point latest.
>
> Note that no seccomp specific code would have to execute here, we can already
> generate events both at syscall entry and at syscall exit points, the only new
> bit we'd need is for the 'kill the task' [or abort the syscall] policy action.
>
> This is *far* more generic still yields the same short-term end result as far
> as your sandboxing is concerned.

Almost :/  I still need to review the code you've pointed out, but, at
present, the ftrace hooks occur after the seccomp and syscall auditing
hooks.  This means that that code is exposed no matter what in this
model.  To trim the exposed surface to userspace, we really need those
early hooks.  While I can see both hacky and less hacky approaches
around this, it stills strikes me that the seccomp thread flag and
early interception are good to reuse.  One option might be to allow
seccomp to be a secure-syscall event source, but I suspect that lands
more on the hack-y side of the fence :)

Anyway, I'll read up on the other filters and try to understand
exactly how per-task, counting perf events are being handled.

> What we'd need for this is a way to mark existing TRACE_EVENT()s as 'active'.
> We'd mark all syscall events as 'active' straight away.

It seems like we'll still end up special casing system calls no matter
what as they are the userland vector into the kernel.  Marking
syscalls active right away sounds roughly equivalent to calling
prctl(PR_SET_SECCOMP, 2).  This could easily be done following the
model of syscall_nr_to_meta() since that enumerates every system call
meta data entry which yields both entry and exit event numbers. Of
course, I'd need to understand how that ties in with the per-task,
counting code.

> [ Detail: these trace events return a return code, which the calling code can
> ?use, that way event return values could be used sooner than syscall exit
> ?points. IRQ code could make use of it as well, so for example this way we
> ?could filter based early packet inspection, still in the IRQ code. ]
>
> Then what your feature would do is to simply open up the events you are
> interested in (just as counting events, without any buffers), and set 'active'
> filters in them them to 'deny/allow' specific combinations of parameters only.
>
> Thirdly, you have added a separate facility to set/query filters via /proc,
> this lives mostly in /proc/<pid>/seccomp_filter. This seccomp specificity would
> go away altogether: it should be possible to query existing events and filters
> even outside of the seccomp facility, so if you want something explicit here
> beyond the current event ioctl() to set filters please improve the generic
> facility - which right now is poorer than what you have implemented so it's in
> good need to be improved! :-)

I haven't looked at the other interface, so I will.  I know about the
existence of the perf_event_open syscall, but that's about it.  Would
it make sense to use the same syscall in a unified-interface world?
Even if the right way, semantically it seems awkward.

> All in one such a solution would enable us to reuse code in a lot more deeper
> fashion while still providing all the functionality you are interested in.
> These are all short-term concerns, not pie-in-the-sky future ideal LSM
> concerns.

Thanks for the concrete feedback! I'll follow up again once I better
understand the code you're citing as well as the existing userland
interface to it.

cheers!
will
