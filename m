From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 6 Oct 2010 23:13:47 +0900
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <20101006133041.GA29273@linux-sh.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
	<20101006122736.GL13563@erda.amd.com>
	<20101006123950.GA29118@linux-sh.org>
	<20101006131825.GO13563@erda.amd.com>
	<20101006133041.GA29273@linux-sh.org>
Message-ID: <20101006141347.GA32376@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 10:30:41PM +0900, Paul Mundt wrote:
> On Wed, Oct 06, 2010 at 03:18:25PM +0200, Robert Richter wrote:
> > I am not against adding the pmu name to the perf API. But the oprofile
> > cpu_type strings are oprofile centric esp. for the userland. So these
> > strings will remain part of oprofile. Also I don't think we want to
> > polute the perf pmu names with it.
> > 
> And those architectures that have opted to use different strings for perf
> events are free to mangle them however they want for the oprofile case.
> It doesn't change the fact that strings are still being managed by all of
> the architectures. The perf PMU names aren't presently locked in to an
> ABI, whereas the oprofile strings are, so it seems fairly straightforward
> to develop standard mangling rules for preventing an oprofile-facing
> string, or to simply reuse the strings verbatim.
> 
So to add a bit of context here, I was just looking at the oprofile
tools. The naming format here is one of:

	<arch>/<pmu>

if there were a generic perf to oprofile pmu name mangler that did this
it would cover almost all of the ARM cases already, the SH strings I'm
happy to convert to work this way, and a good chunk of the PowerPC PMUs
would work fine, too. PowerPC already has an oprofile CPU string in its
CPU spec, so this would be even more trivial to wire up there if such a
generic interface were to exist.

This would just leave x86 as the odd one out, but I suppose if x86 were
to move to the oprofile perf wrapper in the future then a bit of id to
name mangling as an override wouldn't be too much work.
