From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 6 Apr 2017 09:50:33 +0530
Subject: [PATCH 3/3] perf tool, arm64, thunderx2: Add implementation
 defined events for ThunderX2
In-Reply-To: <20170405100548.GA10833@leverpostej>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1491291403-29893-4-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170404122828.GB8551@leverpostej>
 <CAFpQJXWTQ=gX63NHPoUST0oU9cP4xo+2fdr-p7ifhvJ6x-ih+A@mail.gmail.com>
 <20170405100548.GA10833@leverpostej>
Message-ID: <CAFpQJXX9pt2R8TrLv0z=JT2VJxQROCn3cxPbaYiOEOFAT=Fg2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 5, 2017 at 3:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Apr 05, 2017 at 02:42:39PM +0530, Ganapatrao Kulkarni wrote:
>> On Tue, Apr 4, 2017 at 5:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Apr 04, 2017 at 01:06:43PM +0530, Ganapatrao Kulkarni wrote:
>> >> This is not a full event list, but a short list of useful events.
>> >>
>> >> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> >> ---
>> >>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +
>> >>  .../arm64/thunderx2/implementation-defined.json    | 72 ++++++++++++++++++++++
>> >>  2 files changed, 74 insertions(+)
>> >>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>> >>  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>> >>
>> >> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> >> new file mode 100644
>> >> index 0000000..ba30e43
>> >> --- /dev/null
>> >> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> >> @@ -0,0 +1,2 @@
>> >> +Family-model,Version,Filename,EventType
>> >> +0x00000000420f5161,v1,thunderx2,core
>> >> diff --git a/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>> >> new file mode 100644
>> >> index 0000000..360e084
>> >> --- /dev/null
>> >> +++ b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>> >> @@ -0,0 +1,72 @@
>> >> +[
>> >> +    {
>> >> +        "PublicDescription": "Attributable Level 1 data cache access, read",
>> >> +        "EventCode": "0x40",
>> >> +        "EventName": "l1d_cache_access_read",
>> >> +        "BriefDescription": "l1d cache access, read",
>> >> +     "CPU" :"armv8_pmuv3_0"
>> >
>> > Please let's not hard-code the name like this. Surely we can get rid of this?
>> >
>> > The kernel doesn't currently name PMUs as armv8_pmuv3_*, and as that can
>> > differ across DT/ACPI and in big.LITTLE, I don't think it makes sense to
>> > try to rely one particular string regardless.
>>
>> This string/name is fixed for a platform. having name here is essential to
>> know which devices among pmu (armv8_pmuv3_0, breakpoint, software)
>> devices, these jevents to be added.
>> also this json file is specific to a arch/soc/board, it is not a
>> generic file to be common.
>
> This file describe the events of a CPU PMU, and CPUs are not specific to
> a platform in general. There are many systems using Cortex-A57, for
> example.
>
> Across big.LITTLE SoCs with Cortex-A57, there's no guarantee as to
> whether the Cortex-A57 cores would be named armv8_pmuv3_0, or
> armv8_pmuv3_1, etc. This would depend on the boot CPU, probe order of
> secondaries, etc.

OK, we may not have complete name however, common part can be used to recognize
the PMU CORE devices from /sys/bus/event_source/devices
i.e we can have CPU id as "armv8_pmuv3".

same is extended to UNCORE as well.

mapfile.csv file will have entry for both BIG and LITTLE processors event files.
the jevents creates table of pmu_events_map for all entries present in
mapfile.csv file
while lookup, which ever pmu matches the cpuid of pmu_events_map
then corresponding table created from json file is used to add the
jevents to that PMU.

>
> I appreciate that your platform is homnogeneous, and you may not expect
> the core to be reused in any heterogeneous system. However, I think that
> if we're going to make this work for arm64 we should handle the general
> case, rather than only having it support a limited set of platforms.
>
> Currently, we don't have an "official" way of identifying which PMUs are
> CPU PMUs, but one way we could idtentify them would be to look at if
> they have a "cpus" attribute under sysfs (rather than a "cpumask"
> attribute).
>
> Thanks,
> Mark.

thanks
Ganapat
