From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 13 May 2011 14:54:52 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <1305290612.2466.17.camel@twins>
References: <1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins>
Message-ID: <20110513125452.GD3924@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2011-05-13 at 14:39 +0200, Peter Zijlstra wrote:
> > 
> > >       event_vfs_getname(result);
> > >       result = check_event_vfs_getname(result); 
> 
> Another fundamental difference is how to treat the callback chains for
> these two.
> 
> Observers won't have a return value and are assumed to never fail,
> therefore we can always call every entry on the callback list.
> 
> Active things otoh do have a return value, and thus we need to have
> semantics that define what to do with that during callback iteration,
> when to continue and when to break. Thus for active elements its
> impossible to guarantee all entries will indeed be called.

I think the sanest semantics is to run all active callbacks as well.

For example if this is used for three stacked security policies - as if 3 LSM 
modules were stacked at once. We'd call all three, and we'd determine that at 
least one failed - and we'd return a failure.

Even if the first one failed already we'd still want to trigger *all* the 
failures, because security policies like to know when they have triggered a 
failure (regardless of other active policies) and want to see that failure 
event (if they are logging such events).

So to me this looks pretty similar to observer callbacks as well, it's the 
natural extension to an observer callback chain.

Observer callbacks are simply constant functions (to the caller), those which 
never return failure and which never modify any of the parameters.

It's as if you argued that there should be separate syscalls/facilities for 
handling readonly files versus handling read/write files.

Thanks,

	Ingo
