From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 12 Oct 2012 11:21:39 +0800
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for
 secondary CPUs
In-Reply-To: <5076F2AE.6030509@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
 <5074A74A.8010803@wwwdotorg.org>
 <1349946918.19413.130.camel@jlo-ubuntu-64.nvidia.com>
 <5076F2AE.6030509@wwwdotorg.org>
Message-ID: <1350012099.20241.10.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 00:24 +0800, Stephen Warren wrote:
> On 10/11/2012 03:15 AM, Joseph Lo wrote:
> > On Wed, 2012-10-10 at 06:38 +0800, Stephen Warren wrote:
> >> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> >>> This supports power-gated (LP2) idle on secondary CPUs for Tegra30.
> >>> The secondary CPUs can go into LP2 state independently. When CPU goes
> >>> into LP2 state, it saves it's state and puts itself to flow controlled
> >>> WFI state. After that, it will been power gated.
> >>
> >>> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> >>
> >>> +void __cpuinit tegra_clear_cpu_in_lp2(int cpu)
> >>> +{
> >>> +	spin_lock(&tegra_lp2_lock);
> >>> +	BUG_ON(!cpumask_test_cpu(cpu, &tegra_in_lp2));
> >>> +	cpumask_clear_cpu(cpu, &tegra_in_lp2);
> >>> +
> >>> +	/*
> >>> +	 * Update the IRAM copy used by the reset handler. The IRAM copy
> >>> +	 * can't use used directly by cpumask_clear_cpu() because it uses
> >>> +	 * LDREX/STREX which requires the addressed location to be inner
> >>> +	 * cacheable and sharable which IRAM isn't.
> >>> +	 */
> >>> +	writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
> >>> +	dsb();
> >>
> >> Why not /just/ store the data in IRAM, and read/write directly to it,
> >> rather than maintaining an SDRAM-based copy of it?
> >>
> >> Then, wouldn't the body of this function be simply:
> >>
> >> spin_lock();
> >> BUG_ON(!(tegra_cpu_lp2_mask & BIT(cpu)));
> >> tegra_cpu_lp2_mask |= BIT(cpu);
> >> spin_unlock();
> >>
> > 
> > It may not simple like this. To maintain it identical to a cpumask. It
> > may look likes below. Because I need to compare it with cpu_online_mask.
> 
> Oh, the comparison against cpu_online_mask() is what I was missing. I
> guess that offline CPUs don't go into LP2, so you can't just check that
> tegra_cpu_lp2_mask == (1 << num_cpus()) - 1.
> 
> One way to avoid that might be to maintain a cpu_in_lp2_count variable
> alongside the mask, and simply compare that against num_online_cpus()
> rather than comparing the two masks. At least that would avoid the
> following line:
> 
> >>> +	writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
> 
> ... making use of knowledge of the internal structure of the struct
> cpumask type.
> 
> However, given the comparison requirement, either way is probably fine.

OK. I got your idea now. And I rechecked it today. The method that you
suggested original could satisfy the usage here. It could maintain the
CPUs go into LP2 as a cpumask. I just verified it. Will update in next
version.

Thanks,
Joseph
