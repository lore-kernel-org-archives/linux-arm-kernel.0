From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Jul 2016 16:58:35 +0100
Subject: [PATCH 08/11] arm64: pmu: Provide cpumask attribute for PMU
In-Reply-To: <5783B5C3.8090000@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-9-git-send-email-jeremy.linton@arm.com>
 <20160707162103.GD9270@leverpostej> <5783B5C3.8090000@arm.com>
Message-ID: <20160711155834.GC7691@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 10:05:39AM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 07/07/2016 11:21 AM, Mark Rutland wrote:
> >Hi Jeremy,
> >
> >Apologies for the late reply on this.
> >
> >On Tue, Jun 21, 2016 at 12:11:46PM -0500, Jeremy Linton wrote:
> >>With heterogeneous PMUs its helpful to know which PMUs are bound
> >>to each CPU. Provide that information with a cpumask sysfs entry
> >>similar to other PMUs.
> >
> >Have you tested trying to stat on a particular PMU? e.g.
> >
> >$ perf stat -e armv8_cortex_a53/cpu_cycles/ ls
> >
> >I found that the presence of a cpumask file would cause (at least some
> >versions) of perf-stat to hang, and was holding off adding a cpumask
> >until we had a solution to that.
> 
> Nice!
> 
> I guess that is more proof that any tiny change can break things..
> Another "fix" is to make the cpumap_print_to_pagebuf's first
> parameter false which apparently keeps perf from understanding the
> cpu mask and forces the user to use numactl, which is ugly because
> numactrl doesn't understand the mask in that format either.

If we have a cpumask, it should be in keeping with the usual style.

> I guess fixing perf is probably the best bet here...

Indeed.

The major issue is that it's not clear to me how to avoid breaking
existing binaries when adding the cpumask. I suspect that we have to
expose it under a different name. :/

> >See [1,2] for more details on that.
> >
> >>Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >>---
> >>  arch/arm64/kernel/perf_event.c | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >
> >This should be generic across the arm-pmu code, and so should live under
> >drivers/perf/.
> 
> Which is where i had it initially, but (IIRC) getting to work there
> required some core pmu changes that seemed a little ugly.

That was my experience from local refactoring, too.

> I guess I didn't like the idea of reallocating the per pmu attr group
> or tweaking the pmu core code.. So I just moved it into perf_event
> where it fit more naturally.

I don't think we need to allocate the attr group per pmu (we get the PMU
pointer from the dev, so the attr group can be shared).

I think we can share the logic, the cpumask attr, and the cpumask
attr_group in drivers/perf/arm_pmu.c, exposing a common
arm_pmu_cpumask_attr_group pointer via the arm_pmu header.

Then all each driver needs to wire up is a single pointer in its
attr_groups array, which isn't so bad.

Thanks,
Mark.

> 
> 
> 
> >
> >Thanks,
> >Mark.
> >
> >[1] http://lkml.kernel.org/r/1467907474-3290-1-git-send-email-mark.rutland at arm.com
> >[2] http://lkml.kernel.org/r/1467907474-3290-2-git-send-email-mark.rutland at arm.com
> >
> >>diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> >>index 356fa6c..dae73ea 100644
> >>--- a/arch/arm64/kernel/perf_event.c
> >>+++ b/arch/arm64/kernel/perf_event.c
> >>@@ -533,6 +533,26 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {
> >>
> >>  PMU_FORMAT_ATTR(event, "config:0-9");
> >>
> >>+static ssize_t
> >>+cpumask_show(struct device *dev, struct device_attribute *attr, char *page)
> >>+{
> >>+	struct pmu *pmu = dev_get_drvdata(dev);
> >>+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
> >>+
> >>+	return cpumap_print_to_pagebuf(true, page, &cpu_pmu->supported_cpus);
> >>+}
> >>+static DEVICE_ATTR_RO(cpumask);
> >>+
> >>+static struct attribute *armv8_pmuv3_attrs[] = {
> >>+	 &dev_attr_cpumask.attr,
> >>+	 NULL,
> >>+};
> >>+
> >>+static struct attribute_group armv8_pmuv3_attr_group = {
> >>+	.attrs = armv8_pmuv3_attrs,
> >>+};
> >>+
> >>+
> >>  static struct attribute *armv8_pmuv3_format_attrs[] = {
> >>  	&format_attr_event.attr,
> >>  	NULL,
> >>@@ -544,6 +564,7 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
> >>  };
> >>
> >>  static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
> >>+	&armv8_pmuv3_attr_group,
> >>  	&armv8_pmuv3_events_attr_group,
> >>  	&armv8_pmuv3_format_attr_group,
> >>  	NULL,
> >>--
> >>2.5.5
> >>
> >
> 
