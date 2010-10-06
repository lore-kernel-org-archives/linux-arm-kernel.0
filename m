From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 7 Oct 2010 00:46:13 +0900
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <20101006153710.GS13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
	<20101006122736.GL13563@erda.amd.com>
	<20101006123950.GA29118@linux-sh.org>
	<20101006131825.GO13563@erda.amd.com>
	<20101006133041.GA29273@linux-sh.org>
	<20101006141347.GA32376@linux-sh.org>
	<20101006153710.GS13563@erda.amd.com>
Message-ID: <20101006154613.GA10220@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 05:37:10PM +0200, Robert Richter wrote:
> On 06.10.10 10:13:47, Paul Mundt wrote:
> > if there were a generic perf to oprofile pmu name mangler that did this
> 
> Or, do you mean here to derive an oprofile name from the pmu string in
> a generic way? I was suggesting this for SH when commenting on version
> 3 of this patch set. We dropped this idea to keep changes simple for
> this initial patch set, because it was much easier to implement it
> with strcmp() and the pmu strings are not expected to be changed for
> sh in the near future.
> 
Yes, this is what I meant, so it seems we basically have a consensus
after all.

> So, can't we use op_name_from_perf_name() from [PATCH -v3 6/6] for SH
> here and implement a perf_pmu_name() function for sh that is part of
> perf's generic interface? 
> 
As long as perf_pmu_name() is generically provided and we just have
architecture overrides as necessary, then this is fine. If
perf_pmu_name() is __weak then we can provide an override in the SH code
that returns the PMU name without issue, and we don't have to expose
sh_pmu generically, so this is the solution I prefer.

That is assuming that perf folks are ok with a generic perf_pmu_name()
anyways!

Once that is provided, we can simply have the oprofile wrapper provide a
generic op_name_from_perf_name() that does the arch/perf_pmu_name()
string contstruction for the oprofile case, and then start killing off
the special cases.

> Later we can add a generic function for sh ...
> 
> > it would cover almost all of the ARM cases already, the SH strings I'm
> > happy to convert to work this way, and a good chunk of the PowerPC PMUs
> > would work fine, too. PowerPC already has an oprofile CPU string in its
> > CPU spec, so this would be even more trivial to wire up there if such a
> > generic interface were to exist.
> > 
> > This would just leave x86 as the odd one out, but I suppose if x86 were
> > to move to the oprofile perf wrapper in the future then a bit of id to
> > name mangling as an override wouldn't be too much work.
> 
> ... and also other architectures on top of these patches.
> 
That sounds like a plan to me.
