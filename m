From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 17 Mar 2014 12:52:25 +0100
Subject: [RFC 0/6] rework sched_domain topology description
In-Reply-To: <532060E7.7010203@arm.com>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <5317B092.7070805@arm.com>
 <CAKfTPtDGbT717Y5F1GoBgr4pnvApG5Gphu2Me_bAFrM0+qsfAg@mail.gmail.com>
 <53186A8A.9060406@arm.com>
 <CAKfTPtCspVk+X3O23ikTt3MZUHVrrp21PyhmrcLF-GwW3OjOqA@mail.gmail.com>
 <531B0FDA.2040302@arm.com>
 <20140311131719.GY9987@twins.programming.kicks-ass.net>
 <532060E7.7010203@arm.com>
Message-ID: <20140317115225.GZ9987@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:28:07PM +0000, Dietmar Eggemann wrote:
> On 11/03/14 13:17, Peter Zijlstra wrote:
> > On Sat, Mar 08, 2014 at 12:40:58PM +0000, Dietmar Eggemann wrote:
> >>>
> >>> I don't have a strong opinion about using or not a cpu argument for
> >>> setting the flags of a level (it was part of the initial proposal
> >>> before we start to completely rework the build of sched_domain)
> >>> Nevertheless, I see one potential concern that you can have completely
> >>> different flags configuration of the same sd level of 2 cpus.
> >>
> >> Could you elaborate a little bit further regarding the last sentence? Do you
> >> think that those completely different flags configuration would make it
> >> impossible, that the load-balance code could work at all at this sd?
> > 
> > So a problem with such an interfaces is that is makes it far too easy to
> > generate completely broken domains.
> 
> I see the point. What I'm still struggling with is to understand why
> this interface is worse then the one where we set-up additional,
> adjacent sd levels with new cpu_foo_mask functions plus different static
> sd-flags configurations and rely on the sd degenerate functionality in
> the core scheduler to fold these levels together to achieve different
> per cpu sd flags configurations.

Well, the folding of SD levels is 'safe' in that it keeps domains
internally consistent.

> IMHO, exposing struct sched_domain_topology_level bar_topology[] to the
> arch is the reason why the core scheduler has to check if the arch
> provides a sane sd setup in both cases.

Up to a point yes. On the other hand; the reason we have the degenerate
stuff is because the topology was generic and might contain pointless
levels because the architecture didn't actually have them.

By moving the topology setup into the arch; that could be made to go
away (not sure you want to do that, but you could).

But yes, by moving the topology setup out of the core code, you need
some extra validation to make sure that whatever you're fed makes some
kind of sense.

> > You can, for two cpus in the same domain provide, different flags; such
> > a configuration doesn't make any sense at all.
> > 
> > Now I see why people would like to have this; but unless we can make it
> > robust I'd be very hesitant to go this route.
> > 
> 
> By making it robust, I guess you mean that the core scheduler has to
> check that the provided set-ups are sane, something like the following
> code snippet in sd_init()
> 
> if (WARN_ONCE(tl->sd_flags & ~TOPOLOGY_SD_FLAGS,
> 		"wrong sd_flags in topology description\n"))
> 	tl->sd_flags &= ~TOPOLOGY_SD_FLAGS;
> 
> but for per cpu set-up's.

So a domain is principally a group of CPUs with the same properties.
However per-cpu domain attributes allows you to specify different domain
properties within the one domain mask.

That's completely broken.

So the way to validate something like that would be:

	cpu = cpumask_first(tl->mask());
	flags = tl->flags(cpu);

	for (;cpu = cpumask_next(cpu, tl->mask()), cpu < nr_cpu_ids;)
		BUG_ON(tl->flags(cpu) != flags);

Or something along those lines.

But for me its far easier to think in the simple one domain one flags
scenario. The whole degenerate folding is a very simple optimization
simply removing redundant levels.
