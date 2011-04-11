From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Apr 2011 12:12:30 +0100
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <BANLkTinAcAudWKvipYVLyijUrLZVFozBWQ@mail.gmail.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<BANLkTinAcAudWKvipYVLyijUrLZVFozBWQ@mail.gmail.com>
Message-ID: <1302520350.24286.48.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-08 at 19:10 +0100, Linus Walleij wrote:
> Hi Will, thanks for this quite informative letter!

Hi Linus,

> On Fri, Apr 8, 2011 at 7:15 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > Implementing support for Counting System PMUs can reuse a lot of the
> > functionality in perf_event.c (for example, struct arm_pmu) but the low-level
> > accessors should be separate and a new struct pmu should be used. This means
> > that we will want multiple instances of struct arm_pmu and a method to translate
> > from a struct pmu to a struct arm_pmu. We'll also need to clean up some of the
> > armpmu_* functions to ensure the correction indirection is used when invoking
> > per-pmu functions.
> 
> What I start wondering at this point in the description is that there is some
> implicit assumption that counting system PMU:s is an arch/arm/* thing,
> that they should even be named arm_* and I guess as such they are
> some PrimeCell kind of thing.

PMUs are typically built into other devices (the one which they're
profiling) so they tend to be tightly-coupled to some other code.
So yes, for things like a PMU in a graphics chip, there should be a
separate struct pmu which lives near the graphics driver.

However, for things like CPUs, busses and cache-controllers they should
probably live under arch/arm/. I'd like to identify the common code for
these PMUs, like we have done for the CPU, rather than see half a dozen
struct pmus for L2 cache-controllers appear from nowhere.

> I am thinking that a SoC vendor like Renesas may be implementing a
> System PMU monitoring a bus shared between an SH and and ARM
> core.

> Unless you're ARM Ltd you can also think about vendors doing System
> PMU IP blocks and synthesizing these in both ARM and other-arch
> systems.
> 
> So maybe this needs an multiarch-spanning solution? I start
> thinking about decoupling these babies from the arch and abstracting
> them into something like drivers/perf
> 
Well, the PMU registration mechanism in perf is already common to all
architectures. I'm just trying to make sure that we identify common PMU
code under arch/arm/ and avoid duplication under different platforms. 

PMUs that need to operate on shared busses and the like will likely have
their own struct pmu which can indeed live somewhere more generic.

Cheers,

Will
