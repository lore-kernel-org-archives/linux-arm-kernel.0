From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Oct 2011 18:51:51 +0100
Subject: [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
In-Reply-To: <20111013110928.GT21648@n2100.arm.linux.org.uk>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-6-git-send-email-chaos.youn@samsung.com>
	<4E8C61C4.9090709@arm.com>
	<00ec01cc83f1$81f84430$85e8cc90$%kim@samsung.com>
	<4E8D645D.4020601@arm.com> <4E8ECA1B.5010005@arm.com>
	<20111007151646.GA2398@mudshark.cambridge.arm.com>
	<4E92ECD1.2010303@arm.com>
	<20111013110928.GT21648@n2100.arm.linux.org.uk>
Message-ID: <20111013175151.GB22999@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 12:09:28PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 10, 2011 at 02:02:09PM +0100, Marc Zyngier wrote:
> > On 07/10/11 16:16, Will Deacon wrote:
> > > On Fri, Oct 07, 2011 at 10:44:59AM +0100, Marc Zyngier wrote:
> > >> +static void __cpuinit exynos4_secondary_init(unsigned int cpu)
> > >>  {
> > >>  	void __iomem *dist_base = S5P_VA_GIC_DIST +
> > >> -				(gic_bank_offset * smp_processor_id());
> > >> +				(gic_bank_offset * cpu_logical_map(cpu));
> > > 
> > > Again, I'm deeply suspicious of this code :) Is there not a common memory
> > > alias for the distributor across all of the CPUs?
> > 
> > Kukjin, could you please comment on the presence of a common memory
> > region for the distributor? This seem quite odd...
> 
> It's not odd when you consider that there's per-CPU registers within the
> GIC distributor as well (for the first 32 GIC IRQs) as the per-CPU GIC
> CPU interfaces.

Agreed, but it is odd for those registers not to be banked in hardware. Marc
and I spoke to some of the hardware chaps at ARM and they don't see this as
a common setup in the future, so rather than litter the GIC driver with
__percpu variables, we might be better off adding some extra platform callbacks
to the set that we already have.

Will
