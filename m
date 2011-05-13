From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 13 May 2011 14:43:32 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <1305290370.2466.14.camel@twins>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu>  <1305290370.2466.14.camel@twins>
Message-ID: <1305290612.2466.17.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-13 at 14:39 +0200, Peter Zijlstra wrote:
> 
> >       event_vfs_getname(result);
> >       result = check_event_vfs_getname(result); 

Another fundamental difference is how to treat the callback chains for
these two.

Observers won't have a return value and are assumed to never fail,
therefore we can always call every entry on the callback list.

Active things otoh do have a return value, and thus we need to have
semantics that define what to do with that during callback iteration,
when to continue and when to break. Thus for active elements its
impossible to guarantee all entries will indeed be called.
