From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 9 Jan 2013 11:34:32 +0000
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130109.074946.1167125688535781408.hdoyu@nvidia.com>
References: <20130108.165342.1996373920678167735.hdoyu@nvidia.com>
 <20130108162056.GA28618@e106331-lin.cambridge.arm.com>
 <50EC7450.4070806@wwwdotorg.org>
 <20130109.074946.1167125688535781408.hdoyu@nvidia.com>
Message-ID: <20130109113432.GA22147@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 05:49:46AM +0000, Hiroshi Doyu wrote:
> Hi,
> 
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Tue, 8 Jan 2013 20:32:32 +0100:
> 
> > On 01/08/2013 09:21 AM, Mark Rutland wrote:
> > > On Tue, Jan 08, 2013 at 02:53:42PM +0000, Hiroshi Doyu wrote:
> > >> Mark Rutland <mark.rutland@arm.com> wrote @ Tue, 8 Jan 2013 15:28:28 +0100:
> > >>> On Tue, Jan 08, 2013 at 12:47:37PM +0000, Hiroshi Doyu wrote:
> > >>>> The method to detect the number of CPU cores on Cortex-A9 MPCore and
> > >>>> Cortex-A15 MPCore is different. On Cortex-A9 MPCore we can get this
> > >>>> information from the Snoop Control Unit(SCU). On Cortex-A15 MPCore we
> > >>>> have to read it from the system coprocessor(CP15), because the SCU on
> > >>>> Cortex-A15 MPCore does not have software readable registers. This
> > >>>> patch selects the correct method at runtime based on the CPU ID.
> > ...
> > >>>>  static void __init tegra_smp_init_cpus(void)
> > >>>>  {
> > >>>> -	unsigned int i, ncores = scu_get_core_count(scu_base);
> > >>>> +	unsigned int i, cpu_id, ncores;
> > >>>> +	u32 l2ctlr;
> > >>>> +	phys_addr_t pa;
> > >>>> +
> > >>>> +	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
> > >>>> +	switch (cpu_id) {
> > >>>> +	case CPU_CORTEX_A15:
> > >>>> +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> > >>>> +		ncores = ((l2ctlr >> 24) & 3) + 1;
> > >>>> +		break;
> > >>>
> > >>> [...]
> > >>>
> > >>> As mentioned last time [1], you should get this information from the dt
> > >>> instead.
> > >>
> > >> Most of platsmp.c:.smp_init_cpus() implementations seem just to
> > >> overwrite # of cores by SCU/MRC detection. Is there any implementation
> > >> to use the DT's # and skip SCU/MRC detection in .smp_init_cpus()?
> > > 
> > > As far as I can see, there's no other platform which just relies on
> > > arm_dt_init_cpu_maps. Until recently, it didn't exist, so that makes some
> > > sense. As far as I can see, for the Tegra 114 you only need your smp_init_cpus
> > > to call set_smp_cross_call(gic_raise_softirq). Everything else you do seems to
> > > be handled by arm_dt_init_cpus.
> 
> True.
> 
> > > I think the best option would be to have a separate smp_ops for your dt
> > > platforms where we know cpu nodes are populated (e.g. Tegra 114), where
> > > smp_init_cpus is different to that for non-dt platforms. That way non dt
> > > platforms can keep the SCU hack for now, and won't be broken, and the dt
> > > platforms are far removed from the SCU hack and just use common
> > > infrastructure.
> >
> > Tegra doesn't have any non-DT support now.
> 
> What about falling down to SCU/MRC hack only when DT detection fails
> or no /cpus entry in DT?
> 
> Can arm_dt_init_cpu_maps() return if it suceeds or not?

I think the best solution to this problem consists in /me adding a
function, say, arm_dt_nb_cores(), that returns an error if DT probing
failed and the number of cores if it succeeded.

If it fails, you can fall back to SCU detection of cores for legacy
reasons (A9), but from A15 onwards I have quite a strong feeling against
using L2 as number of cores detection mechanism since it does not work
for multi-cluster systems. Fair enough, on Tegra this is not a problem
(now) but I do not want this method to propagate to other platforms where
multi-cluster number of cores detection will fail if we rely on the L2
mechanism.

This means that if the DT /cpu nodes are updated for all Tegra
platforms, DT becomes the mechanism to detect the number of cores
for all of them.

If you allow the A9 SCU mechanism to override the DT information (even
if it is correct) we might end up in the rather unwieldy situation where
there is a disconnect between the cpu_logical_map initialized entries and
the HW probed number of cores (if the DT bindings are correct the
cpu_logical_map entries are initialized by DT).

The gist is:

- if DT /cpu nodes are there and defined properly, we build the
  cpu_logical_map and count the number of cores from DT
- if DT /cpu nodes are missing or bogus we rely on the cpu_logical_map
  in smp_setup_processor_id() and fall back to legacy mechanism to detect
  the number of cores. This just for legacy boards/SoC.

Let me know if this is reasonable please.

> 
> > 
> > If we're going to make Tegra114 read the CPU information from DT, then
> > I'd rather just switch over all Tegra platforms to requiring CPU nodes
> > in the DT. We have few enough SoC variants that it should be easy to
> > switch everything to DT before adding Tegra114 support without causing
> > any problems.
> 
> Possible.
> 
> > But that all said, I'm not convinced it's a good idea to force the
> > information to be present in DT when it's just duplicating stuff that
> > can be runtime-probed from the HW...
> 
> That's also my concern somewhat.
> 
> The main purpose to DT CPU core detection is for multiple CPU
> clusters. SCU/MRC cannot know anything outside of their own
> clusters. In tegra, we have 4 Cortex-A9/A15 core plus 1 shadow
> core. Switching those clusters is done transparently. The last A9/A15
> core is transparently switched back and forth to the shadow one. So in
> this case, SCU/MRC detection seems to work fine.

You can probe the number of cores through SCU but remember
that MPIDRs of existing CPUs are generated, not probed if the DT is not
present (smp_setup_processor_id()). cpu_logical_map content, before the
DT bindings were introduced, or even now if DT /cpu nodes are bogus, is
simply generated as a sequential number but is not *probeable* per-se.
To tell the truth, this works well for all existing ARM platforms in the
mainline but moving forward we'd better stick at bits of information provided
by the DT, at least that's my opinion.

Thoughts ?

Lorenzo
