From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 13 May 2011 17:02:15 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <1305294936.2466.65.camel@twins>
References: <20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<20110513124902.GC3924@elte.hu> <1305294936.2466.65.camel@twins>
Message-ID: <20110513150215.GD32688@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2011-05-13 at 14:49 +0200, Ingo Molnar wrote:
> > 
> > So given that by your own admission it makes sense to share the facilities at 
> > the low level, i also argue that it makes sense to share as high up as 
> > possible. 
> 
> I'm not saying any such thing, I'm saying that it might make sense to
> observe active objects and auto-create these observation points. That
> doesn't make them similar or make them share anything.

Well, they would share the lowest level call site:

	result = check_event_vfs_getname(result);

You call it 'auto-generated call site', i call it a shared (single line) call 
site. The same thing as far as the lowest level goes.

Now (the way i understood it) you'd want to stop the sharing right after that. 
I argue that it should go all the way up.

Note: i fully agree that there should be events where filters can have no 
effect whatsoever. For example if this was written as:

	check_event_vfs_getname(result);

Then it would have no effect. This is decided by the subsystem developers, 
obviously. So whether an event is 'active' or 'passive' can be enforced at the 
subsystem level as well.

As far as the event facilities go, 'no effect observation' is a special-case of 
'active observation' - just like read-only files are a special case of 
read-write files.

Thanks,

	Ingo
