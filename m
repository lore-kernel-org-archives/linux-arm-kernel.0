From: wad@chromium.org (Will Drewry)
Date: Wed, 18 May 2011 21:07:15 -0700
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110517131902.GF21441@elte.hu>
References: <20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
	<20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
	<20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
Message-ID: <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 6:19 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Tue, 2011-05-17 at 14:42 +0200, Ingo Molnar wrote:
>> > * Steven Rostedt <rostedt@goodmis.org> wrote:
>> >
>> > > On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
>> > > > * Steven Rostedt <rostedt@goodmis.org> wrote:
>> > > >
>> > > > > I'm a bit nervous about the 'active' role of (trace_)events, because of the
>> > > > > way multiple callbacks can be registered. How would:
>> > > > >
>> > > > > ? ? ? err = event_x();
>> > > > > ? ? ? if (err == -EACCESS) {
>> > > > >
>> > > > > be handled? [...]
>> > > >
>> > > > The default behavior would be something obvious: to trigger all callbacks and
>> > > > use the first non-zero return value.
>> > >
>> > > But how do we know which callback that was from? There's no ordering of what
>> > > callbacks are called first.
>> >
>> > We do not have to know that - nor do the calling sites care in general. Do you
>> > have some specific usecase in mind where the identity of the callback that
>> > generates a match matters?
>>
>> Maybe I'm confused. I was thinking that these event_*() are what we
>> currently call trace_*(), but the event_*(), I assume, can return a
>> value if a call back returns one.
>
> Yeah - and the call site can treat it as:
>
> ?- Ugh, if i get an error i need to abort whatever i was about to do
>
> or (more advanced future use):
>
> ?- If i get a positive value i need to re-evaluate the parameters that were
> ? passed in, they were changed

Do event_* that return non-void exist in the tree at all now?  I've
looked at the various tracepoint macros as well as some of the other
handlers (trace_function, perf_tp_event, etc) and I'm not seeing any
places where a return value is honored nor could be.  At best, the
perf_tp_event can be short-circuited it in the hlist_for_each, but
it'd still need a way to bubble up a failure and result in not calling
the trace/event that the hook precedes.

Am I missing something really obvious?  I don't feel I've gotten a
good handle on exactly how all the tracing code gets triggered, so
perhaps I'm still a level (or three) too shallow. (I can see the asm
hooks for trace functions and I can see where that translates to
registered calls - like trace_function - but I don't see how the
hooked calls can be trivially aborted).

As is, I'm not sure how the perf and ftrace infrastructure could be
reused cleanly without a fair number of hacks to the interface and a
good bit of reworking.  I can already see a number of challenges
around reusing the sys_perf_event_open interface and the fact that
reimplementing something even as simple as seccomp mode=1 seems to
require a fair amount of tweaking to avoid from being leaky.  (E.g.,
enabling all TRACE_EVENT()s for syscalls will miss unhooked syscalls
so either acceptance matching needs to be propagated up the stack
along with some seccomp-like task modality or seccomp-on-perf would
have to depend on sys_enter events with syscall number predicate
matching and fail when a filter discard applies to all active events.)

At present, I'm leaning back towards the v2 series (plus the requested
minor changes) for the benefit of code clarity and its fail-secure
behavior.  Even just considering the reduced case of seccomp mode 1
being implemented on the shared infrastructure, I feel like I missing
something that makes it viable.  Any clues?

If not, I don't think a seccomp mode 2 interface via prctl would be
intractable if the long term movement is to a ftrace/perf backend - it
just means that the in-kernel code would change to wrap whatever the
final design ended up being.

Thanks and sorry if I'm being dense!

>> Thus, we now have the ability to dynamically attach function calls to
>> arbitrary points in the kernel that can have an affect on the code that
>> called it. Right now, we only have the ability to attach function calls to
>> these locations that have passive affects (tracing/profiling).
>
> Well, they can only have the effect that the calling site accepts and handles.
> So the 'effect' is not arbitrary and not defined by the callbacks, it is
> controlled and handled by the calling code.
>
> We do not want invisible side-effects, opaque hooks, etc.
>
> Instead of that we want (this is the getname() example i cited in the thread)
> explicit effects, like:
>
> ?if (event_vfs_getname(result))
> ? ? ? ?return ERR_PTR(-EPERM);
>
>> But you say, "nor do the calling sites care in general". Then what do
>> these calling sites do with the return code? Are we limiting these
>> actions to security only? Or can we have some other feature. [...]
>
> Yeah, not just security. One other example that came up recently is whether to
> panic the box on certain (bad) events such as NMI errors. This too could be
> made flexible via the event filter code: we already capture many events, so
> places that might conceivably do some policy could do so based on a filter
> condition.

This sounds great - I just wish I could figure out how it'd work :)

>> [...] I can envision that we can make the Linux kernel quite dynamic here
>> with "self modifying code". That is, anywhere we have "hooks", perhaps we
>> could replace them with dynamic switches (jump labels). Maybe events would
>> not be the best use, but they could be a generic one.
>
> events and explicit function calls and explicit side-effects are pretty much
> the only thing that are acceptable. We do not want opaque hooks and arbitrary
> side-effects.
>
>> Knowing what callback returned the result would be beneficial. Right now, you
>> are saying if the call back return anything, just abort the call, not knowing
>> what callback was called.
>
> Yeah, and that's a feature: that way a number of conditions can be attached.
> Multiple security frameworks may have effect on a task or multiple tools might
> set policy action on a given event.
>
> Thanks,
>
> ? ? ? ?Ingo
>
