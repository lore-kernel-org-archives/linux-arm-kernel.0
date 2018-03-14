From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 14 Mar 2018 13:05:09 +0000
Subject: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
In-Reply-To: <4e7fd404-fb7b-ee38-4a78-8ee091ae07cf@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
 <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
 <20180306160721.GJ4589@e105550-lin.cambridge.arm.com>
 <8ac3567c-9fd8-4b0c-121c-287a027b5156@arm.com>
 <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
 <4e7fd404-fb7b-ee38-4a78-8ee091ae07cf@arm.com>
Message-ID: <20180314130509.GM4589@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 10:19:50AM -0600, Jeremy Linton wrote:
> Hi,
> 
> On 03/07/2018 07:06 AM, Morten Rasmussen wrote:
> >On Tue, Mar 06, 2018 at 04:22:18PM -0600, Jeremy Linton wrote:
> >>>>>>To do this correctly, we should really base that on the cache
> >>>>>>topology immediately below the NUMA node (for NUMA in socket) >> or below the physical package for normal NUMA configurations.
> >>>>>
> >>>>>That means we wouldn't support multi-die NUMA nodes?
> >>>>
> >>>>You mean a bottom level NUMA domain that crosses multiple sockets/dies? That
> >>>>should work. This patch is picking the widest cache layer below the smallest
> >>>>of the package or numa grouping. What actually happens depends on the
> >>>>topology. Given a case where there are multiple dies in a socket, and the
> >>>>numa domain is at the socket level the MC is going to reflect the caching
> >>>>topology immediately below the socket. In the case of multiple dies, with a
> >>>>cache that crosses them in socket, then the MC is basically going to be the
> >>>>socket, otherwise if the widest cache is per die, or some narrower grouping
> >>>>(cluster?) then that is what ends up in the MC. (this is easier with some
> >>>>pictures)
> >>>
> >>>That is more or less what I meant. I think I got confused with the role
> >>>of "DIE" level, i.e. that top non-NUMA level, in this. The DIE level
> >>>cpumask spans exactly the NUMA node, so IIUC we have three scenarios:
> >>>
> >>>1. Multi-die/socket/physical package NUMA node
> >>>    Top non-NUMA level (DIE) spans multiple packages. Bottom NUMA level
> >>>    spans multiple multi-package nodes. The MC mask reflects the last-level
> >>>    cache within the NUMA node which is most likely per-die or per-cluster
> >>>    (inside each die).
> >>>
> >>>2. physical package == NUMA node
> >>>    The top non-NUMA (DIE) mask is the same as the core sibling mask.
> >>>    If there is cache spanning the entire node, the scheduler topology
> >>>    will eliminate a layer (DIE?), so bottom NUMA level would be right on
> >>>    top of MC spanning multiple physical packages. If there is no
> >>>    node-wide last level cache, DIE is preserved and MC matches the span
> >>>    of the last level cache.
> >>>
> >>>3. numa-in-package
> >>>    Top non-NUMA (DIE) mask is not reflecting the actual die, but is
> >>>    reflecting the NUMA node. MC has a span equal to the largest share
> >>>    cache span smaller than or equal to the the NUMA node. If it is
> >>>    equal, DIE level is eliminated, otherwise DIE is preserved, but
> >>>    doesn't really represent die. Bottom non-NUMA level spans multiple
> >>>    in-package NUMA nodes.
> >>>
> >>>As you said, multi-die nodes should work. However, I'm not sure if
> >>>shrinking MC to match a cache could cause us trouble, or if it should
> >>>just be shrunk to be the smaller of the node mask and core siblings.
> >>
> >>Shrinking to the smaller of the numa or package is fairly trivial change,
> >>I'm good with that change too.. I discounted it because there might be an
> >>advantage in case 2 if the internal hardware is actually a case 3 (or just
> >>multiple rings/whatever each with a L3). In those cases the firmware vendor
> >>could play around with whatever representation serves them the best.
> >
> >Agreed. Distributed last level caches and interconnect speeds makes it
> >virtually impossible to define MC in a way that works well for everyone
> >based on the topology information we have at hand.
> >
> >>
> >>>Unless you have a node-wide last level cache DIE level won't be
> >>>eliminated in scenario 2 and 3, and could cause trouble. For
> >>>numa-in-package, you can end up with a DIE level inside the node where
> >>>the default flags don't favour aggressive spreading of tasks. The same
> >>>could be the case for per-package nodes (scenario 2).
> >>>
> >>>Don't we end up redefining physical package to be last level cache
> >>>instead of using the PPTT flag for scenario 2 and 3?
> >>
> >>I'm not sure I understand, core_siblings isn't changing (its still per
> >>package). Only the MC mapping which normally is just core_siblings. For all
> >>intents right now this patch is the same as v6, except for the
> >>numa-in-package where the MC domain is being shrunk to the node siblings.
> >>I'm just trying to setup the code for potential future cases where the LLC
> >>isn't equal to the node or package.
> >
> >Right, core_siblings remains the same. The scheduler topology just looks
> >a bit odd as we can have core_siblings spanning the full true physical
> >package and have DIE level as a subset of that with an MC level where
> >the MC siblings is a much smaller subset of cpus than core_siblings.
> >
> >IOW, it would lead to having one topology used by the scheduler and
> >another used by the users of topology_core_cpumask() (which is not
> >many I think).
> >
> >Is there a good reason for diverging instead of adjusting the
> >core_sibling mask? On x86 the core_siblings mask is defined by the last
> >level cache span so they don't have this issue.
> 
> I'm overwhelmingly convinced we are doing the right thing WRT the core
> siblings at the moment. Its exported to user space, and the general
> understanding is that its a socket. Even with numa in package/on die if you
> run lscpu, lstopo, etc... They all understand the system topology correctly
> doing it this way (AFAIK).

Right. As said in my reply to Brice, I thought MC level and sysfs were
aligned, but they clearly aren't. I agree that treating them different
is the right thing to do.

> >I would prefer this simpler solution as it should eliminate DIE level
> >for all numa-in-package configurations. Although, I think we should consider
> >just shrinking the core_sibling mask instead of having a difference MC
> >mask (cpu_coregroup_mask). Do you see any problems in doing that?I'm
> My strongest opinion is leaning toward core_siblings being correct as it
> stands. How the scheduler deals with that is less clear. I will toss the
> above as a separate patch, and we can forget this one. I see dropping DIE as
> a larger patch set defining an arch specific scheduler topology and tweaking
> the individual scheduler level/flags/tuning. OTOH, unless there is something
> particularly creative there, I don't see how to avoid NUMA domains pushing
> deeper into the cache/system topology. Which means filling the MC layer (and
> possible others) similarly to the above snippit.

Agreed that core_siblings is correct. With the simple solution DIE
shouldn't show up for any numa_in_package configurations allowing NUMA
to sit directly on top of MC, which should mean that flags should be
roughly okay.
