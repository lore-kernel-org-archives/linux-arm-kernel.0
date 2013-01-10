From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 10 Jan 2013 09:51:15 +0000
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130110.083143.258958175573018571.hdoyu@nvidia.com>
References: <50EC7450.4070806@wwwdotorg.org>
 <20130109.074946.1167125688535781408.hdoyu@nvidia.com>
 <20130109113432.GA22147@e102568-lin.cambridge.arm.com>
 <20130110.083143.258958175573018571.hdoyu@nvidia.com>
Message-ID: <20130110095115.GB4728@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 06:31:43AM +0000, Hiroshi Doyu wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote @ Wed, 9 Jan 2013 12:34:32 +0100:

[...]

> > > > But that all said, I'm not convinced it's a good idea to force the
> > > > information to be present in DT when it's just duplicating stuff that
> > > > can be runtime-probed from the HW...
> > > 
> > > That's also my concern somewhat.
> > > 
> > > The main purpose to DT CPU core detection is for multiple CPU
> > > clusters. SCU/MRC cannot know anything outside of their own
> > > clusters. In tegra, we have 4 Cortex-A9/A15 core plus 1 shadow
> > > core. Switching those clusters is done transparently. The last A9/A15
> > > core is transparently switched back and forth to the shadow one. So in
> > > this case, SCU/MRC detection seems to work fine.
> > 
> > You can probe the number of cores through SCU but remember
> > that MPIDRs of existing CPUs are generated, not probed if the DT is not
> > present (smp_setup_processor_id()). cpu_logical_map content, before the
> > DT bindings were introduced, or even now if DT /cpu nodes are bogus, is
> > simply generated as a sequential number but is not *probeable* per-se.
> 
> Honestly I don't understand the above so well. Could you please
> explain a little bit more?

The DT /cpu bindings provide the kernel with a list of MPIDR ("reg"
property) of all CPUs in the system. What I wanted to say is that, you
can probe in HW the number of cores in some situations, but the DT
provides more information than that, so I was debating the "duplicating
stuff that can be runtime probed" point.

In some platforms you can probe the number of cores in HW, but the MPIDR
of existing CPUs is "generated" in smp_setup_processor_id() (you cannot
probe the MPIDR of CPUs that are off or held in a pen), as a sequential number
and stored in the cpu_logical_map. This works well for single cluster systems,
since the MPIDR[23:0] of processors in a single cluster system is a sequential
number starting from 0 (well, at least MPIDR[7:0], but let's not get bogged
down into details).

For multi-cluster systems this fails, and DT comes to the rescue along
with its companion parsing function, arm_dt_init_cpu_maps().

The long and short of it is: DT /cpu nodes are not there just for number
of cores counting, but there is more. Probably on Tegra this is not
needed at the moment, but this provides the groundwork for a generic and
solid solution for all upcoming ARM platforms.

I hope this helps, let me know if it is not clear.

Lorenzo
