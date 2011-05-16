From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 16 May 2011 13:03:42 -0400
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110516165249.GB10929@elte.hu>
References: <1305289146.2466.8.camel@twins> <20110513122646.GA3924@elte.hu>
	<1305290370.2466.14.camel@twins> <1305290612.2466.17.camel@twins>
	<20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
	<20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
	<20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
Message-ID: <1305565422.5456.21.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> > way multiple callbacks can be registered. How would:
> > 
> > 	err = event_x();
> > 	if (err == -EACCESS) {
> > 
> > be handled? [...]
> 
> The default behavior would be something obvious: to trigger all callbacks and 
> use the first non-zero return value.


But how do we know which callback that was from? There's no ordering of
what callbacks are called first.

> 
> > [...] Would we need a way to prioritize which call back gets the return 
> > value? One way I guess would be to add a check_event option, where you pass 
> > in an ENUM of the event you want:
> > 
> > 	event_x();
> > 	err = check_event_x(MYEVENT);
> > 
> > If something registered itself as "MYEVENT" to event_x, then you get the 
> > return code of MYEVENT. If the MYEVENT was not registered, a -ENODEV or 
> > something could be returned. I'm sure we could even optimize it such a way if 
> > no active events have been registered to event_x, that check_event_x() will 
> > return -ENODEV without any branches.
> 
> I would keep it simple and extensible - that way we can complicate it when the 
> need arises! :)

The above is rather trivial to implement. I don't think it complicates
anything.

-- Steve
