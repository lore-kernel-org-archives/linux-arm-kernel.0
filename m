From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 6 Oct 2010 21:39:50 +0900
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <20101006122736.GL13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
	<20101006122736.GL13563@erda.amd.com>
Message-ID: <20101006123950.GA29118@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 02:27:36PM +0200, Robert Richter wrote:
> On 04.10.10 16:44:20, Matt Fleming wrote:
> > Introduce perf_pmu_name() helper function that returns the name of the
> > pmu. This gives us a generic way to get the name of a pmu regardless of
> > how an architecture identifies it internally, e.g. ARM uses an id
> > whereas SH currently uses a string.
> 
> I rather want use here the solution we discussed earlier, simply
> including <asm/perf_event.h> and then access sh_pmu->name directly
> from oprofile.
> 
No. Exposing sh_pmu generically is unacceptable. This is already
centrally managed through perf, and if oprofile needs any additional
information then it needs to get that through the perf layer. We already
have the situation that effectively every architecture with perf support
implements a name string already, so making this part of the perf API
hardly seems like that big of a stretch. If the perf people are violently
opposed to this, then of course we can look at alternatives.

sh_pmu is created for use solely by the perf events code, we are not
going to have oprofile poking around in data structures it has no place
knowing anything about when 99% of everything else it is doing is already
abstracted cleanly through the perf events interfaces. Likewise for
special oprofile-specific APIs.
