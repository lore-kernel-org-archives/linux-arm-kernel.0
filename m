From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 13 May 2011 15:55:35 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110513131800.GA7883@elte.hu>
References: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins>  <20110513131800.GA7883@elte.hu>
Message-ID: <1305294935.2466.64.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cut the microblaze list since its bouncy.

On Fri, 2011-05-13 at 15:18 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> > > I think the sanest semantics is to run all active callbacks as well.
> > > 
> > > For example if this is used for three stacked security policies - as if 3 LSM 
> > > modules were stacked at once. We'd call all three, and we'd determine that at 
> > > least one failed - and we'd return a failure. 
> > 
> > But that only works for boolean functions where you can return the
> > multi-bit-or of the result. What if you need to return the specific
> > error code.
> 
> Do you mean that one filter returns -EINVAL while the other -EACCES?
> 
> Seems like a non-problem to me, we'd return the first nonzero value.

Assuming the first is -EINVAL, what then is the value in computing the
-EACCESS? Sounds like a massive waste of time to me.

> > Also, there's bound to be other cases where people will want to employ
> > this, look at all the various notifier chain muck we've got, it already
> > deals with much of this -- simply because users need it.
> 
> Do you mean it would be easy to abuse it? What kind of abuse are you most 
> worried about?

I'm not worried about abuse, I'm saying that going by the existing
notifier pattern always visiting all entries on the callback list is
undesired.

> > Then there's the whole indirection argument, if you don't need
> > indirection, its often better to not use it, I myself much prefer code
> > to look like:
> > 
> >    foo1(bar);
> >    foo2(bar);
> >    foo3(bar);
> > 
> > Than:
> > 
> >    foo_notifier(bar);
> > 
> > Simply because its much clearer who all are involved without me having
> > to grep around to see who registers for foo_notifier and wth they do
> > with it. It also makes it much harder to sneak in another user, whereas
> > its nearly impossible to find new notifier users.
> > 
> > Its also much faster, no extra memory accesses, no indirect function
> > calls, no other muck.
> 
> But i suspect this question has been settled, given the fact that even pure 
> observer events need and already process a chain of events? Am i missing 
> something about your argument?

I'm saying that there's reasons to not use notifiers passive or active.

Mostly the whole notifier/indirection muck comes up once you want
modules to make use of the thing, because then you need dynamic
management of the callback list.

(Then again, I'm fairly glad we don't have explicit callbacks in
kernel/cpu.c for all the cpu-hotplug callbacks :-)

Anyway, I oppose for the existing events to gain an active role.
