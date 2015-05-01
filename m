From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 May 2015 15:07:57 +0100
Subject: [PATCH 2/4] ARM perf: Fix the pmu node name in warning message
In-Reply-To: <554386C2.6020609@arm.com>
References: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
 <1429797033-3787-2-git-send-email-will.deacon@arm.com>
 <554386C2.6020609@arm.com>
Message-ID: <20150501140757.GC28975@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 02:59:30PM +0100, Sudeep Holla wrote:
> 
> 
> On 23/04/15 14:50, Will Deacon wrote:
> > With commit 9fd85eb502a7 ("ARM: pmu: add support for interrupt-affinity
> > property"), we print a warning when we find a PMU SPI with a missing
> > missing interrupt-affinity property in a pmu node. Unfortunately, we
> > pass the wrong (NULL) device node to of_node_full_name, resulting in
> > unhelpful messages such as:
> >
> >   hw perfevents: Failed to parse <no-node>/interrupt-affinity[0]
> >
> > This patch fixes the name to that of the pmu node.
> >
> > Fixes: 9fd85eb502a7 (ARM: pmu: add support for interrupt-affinity property)
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >   arch/arm/kernel/perf_event_cpu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> > index becf7ad6eddc..213919ba326f 100644
> > --- a/arch/arm/kernel/perf_event_cpu.c
> > +++ b/arch/arm/kernel/perf_event_cpu.c
> > @@ -322,7 +322,7 @@ static int of_pmu_irq_cfg(struct platform_device *pdev)
> >   				      i);
> >   		if (!dn) {
> >   			pr_warn("Failed to parse %s/interrupt-affinity[%d]\n",
> > -				of_node_full_name(dn), i);
> > +				of_node_full_name(pdev->dev.of_node), i);
> >   			break;
> 
> With old DT we will see this message and one might think perf is broken.
> But since the code still assumes SPIs are listed in order of *logical*
> CPU number and continues to work, does it make sense to update the
> warning accordingly ?

The issue is that while it may work in that configuration, it can easily
be made to not work. So even if things happen to align, we should warn
when we don't have explicit information regarding the affinity.

Do you have a suggestion for a better error message to cover that?

Thanks
Mark.
