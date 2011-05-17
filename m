From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 May 2011 09:05:28 -0400
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110517124212.GB21441@elte.hu>
References: <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
	<1305294935.2466.64.camel@twins> <20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
Message-ID: <1305637528.5456.723.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-17 at 14:42 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
> > > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> > > > way multiple callbacks can be registered. How would:
> > > > 
> > > > 	err = event_x();
> > > > 	if (err == -EACCESS) {
> > > > 
> > > > be handled? [...]
> > > 
> > > The default behavior would be something obvious: to trigger all callbacks and 
> > > use the first non-zero return value.
> > 
> > But how do we know which callback that was from? There's no ordering of what 
> > callbacks are called first.
> 
> We do not have to know that - nor do the calling sites care in general. Do you 
> have some specific usecase in mind where the identity of the callback that 
> generates a match matters?

Maybe I'm confused. I was thinking that these event_*() are what we
currently call trace_*(), but the event_*(), I assume, can return a
value if a call back returns one.

Thus, we now have the ability to dynamically attach function calls to
arbitrary points in the kernel that can have an affect on the code that
called it. Right now, we only have the ability to attach function calls
to these locations that have passive affects (tracing/profiling).

But you say, "nor do the calling sites care in general". Then what do
these calling sites do with the return code? Are we limiting these
actions to security only? Or can we have some other feature. I can
envision that we can make the Linux kernel quite dynamic here with "self
modifying code". That is, anywhere we have "hooks", perhaps we could
replace them with dynamic switches (jump labels). Maybe events would not
be the best use, but they could be a generic one.

Knowing what callback returned the result would be beneficial. Right
now, you are saying if the call back return anything, just abort the
call, not knowing what callback was called.

-- Steve
