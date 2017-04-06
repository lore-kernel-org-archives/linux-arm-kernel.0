From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 6 Apr 2017 10:55:33 +0100
Subject: [PATCH 3/3] perf tool, arm64, thunderx2: Add implementation
 defined events for ThunderX2
In-Reply-To: <CAFpQJXX9pt2R8TrLv0z=JT2VJxQROCn3cxPbaYiOEOFAT=Fg2Q@mail.gmail.com>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1491291403-29893-4-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170404122828.GB8551@leverpostej>
 <CAFpQJXWTQ=gX63NHPoUST0oU9cP4xo+2fdr-p7ifhvJ6x-ih+A@mail.gmail.com>
 <20170405100548.GA10833@leverpostej>
 <CAFpQJXX9pt2R8TrLv0z=JT2VJxQROCn3cxPbaYiOEOFAT=Fg2Q@mail.gmail.com>
Message-ID: <20170406095533.GB29947@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 09:50:33AM +0530, Ganapatrao Kulkarni wrote:
> On Wed, Apr 5, 2017 at 3:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Apr 05, 2017 at 02:42:39PM +0530, Ganapatrao Kulkarni wrote:
> >> On Tue, Apr 4, 2017 at 5:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Tue, Apr 04, 2017 at 01:06:43PM +0530, Ganapatrao Kulkarni wrote:

> >> >> +     "CPU" :"armv8_pmuv3_0"
> >> >
> >> > Please let's not hard-code the name like this. Surely we can get rid of this?
> >> >
> >> > The kernel doesn't currently name PMUs as armv8_pmuv3_*, and as that can
> >> > differ across DT/ACPI and in big.LITTLE, I don't think it makes sense to
> >> > try to rely one particular string regardless.
> >>
> >> This string/name is fixed for a platform. having name here is essential to
> >> know which devices among pmu (armv8_pmuv3_0, breakpoint, software)
> >> devices, these jevents to be added.
> >> also this json file is specific to a arch/soc/board, it is not a
> >> generic file to be common.
> >
> > This file describe the events of a CPU PMU, and CPUs are not specific to
> > a platform in general. There are many systems using Cortex-A57, for
> > example.
> >
> > Across big.LITTLE SoCs with Cortex-A57, there's no guarantee as to
> > whether the Cortex-A57 cores would be named armv8_pmuv3_0, or
> > armv8_pmuv3_1, etc. This would depend on the boot CPU, probe order of
> > secondaries, etc.
> 
> OK, we may not have complete name however, common part can be used to recognize
> the PMU CORE devices from /sys/bus/event_source/devices
> i.e we can have CPU id as "armv8_pmuv3".

For better or worse, that's not the case on DT systems.

I'd much rather that we identified the CPU PMUs without requiring
particular names (e.g by looking for a "cpus" attribute).

> same is extended to UNCORE as well.

Could you elaborate on that? I'm not sure I follow.

> mapfile.csv file will have entry for both BIG and LITTLE processors event files.
> the jevents creates table of pmu_events_map for all entries present in
> mapfile.csv file
> while lookup, which ever pmu matches the cpuid of pmu_events_map
> then corresponding table created from json file is used to add the
> jevents to that PMU.

Sorry, but I don't follow how that's related to the above.

Thanks,
Mark.
