From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Jul 2016 17:14:02 +0100
Subject: [PATCH 08/11] arm64: pmu: Provide cpumask attribute for PMU
In-Reply-To: <20160711155834.GC7691@leverpostej>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-9-git-send-email-jeremy.linton@arm.com>
 <20160707162103.GD9270@leverpostej> <5783B5C3.8090000@arm.com>
 <20160711155834.GC7691@leverpostej>
Message-ID: <20160711161401.GC27013@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 04:58:35PM +0100, Mark Rutland wrote:
> On Mon, Jul 11, 2016 at 10:05:39AM -0500, Jeremy Linton wrote:
> > On 07/07/2016 11:21 AM, Mark Rutland wrote:
> > >Have you tested trying to stat on a particular PMU? e.g.
> > >
> > >$ perf stat -e armv8_cortex_a53/cpu_cycles/ ls
> > >
> > >I found that the presence of a cpumask file would cause (at least some
> > >versions) of perf-stat to hang, and was holding off adding a cpumask
> > >until we had a solution to that.
> > 
> > I guess that is more proof that any tiny change can break things..
> > Another "fix" is to make the cpumap_print_to_pagebuf's first
> > parameter false which apparently keeps perf from understanding the
> > cpu mask and forces the user to use numactl, which is ugly because
> > numactrl doesn't understand the mask in that format either.
> 
> If we have a cpumask, it should be in keeping with the usual style.
> 
> > I guess fixing perf is probably the best bet here...
> 
> Indeed.
> 
> The major issue is that it's not clear to me how to avoid breaking
> existing binaries when adding the cpumask. I suspect that we have to
> expose it under a different name. :/

Well, we need to understand exactly why the cpumask breaks those older
perf builds before we do that. Is it expecting some behaviour that we
don't honour, or does it break on other architectures providing a
cpumask too?

> > >See [1,2] for more details on that.

That makes it sound specific to big/little. Did perf used to work on
those systems without a cpumask? I understand that it might not have
hung, but did it actually provide meaningful data?

I'm not against renaming the cpumask if that's our only option, but I'd
like to understand (and document) how we arrive at that, if we actually
do.

Will
