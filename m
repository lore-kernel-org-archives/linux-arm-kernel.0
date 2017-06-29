From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 29 Jun 2017 12:11:02 +0100
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical Profiling
 Extension
In-Reply-To: <20170628195953.6cde9604068dd90bbef3bf5f@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <20170612110823.GA27319@leverpostej>
 <20170612112048.69561e8d067488e8689de755@arm.com>
 <20170615105735.b89183a9190a261d3b8d132a@arm.com>
 <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
 <20170628195953.6cde9604068dd90bbef3bf5f@arm.com>
Message-ID: <20170629111102.GB11040@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 07:59:53PM -0500, Kim Phillips wrote:
> On Wed, 28 Jun 2017 12:26:02 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Jun 27, 2017 at 04:07:58PM -0500, Kim Phillips wrote:

> > > > > Meanwhile, when using fvp-base.dtb, my model setup stops booting the
> > > > > kernel after "smp: Bringing up secondary CPUs ...".  If I however take
> > > > > the second SPE node from fvp-base.dts and add it to my working device
> > > > > tree, I get this during the driver probe:
> > > > > 
> > > > > [    1.042063] arm_spe_pmu spe-pmu at 0: probed for CPUs 0-7 [max_record_sz 64, align 1, features 0xf]
> > > > > [    1.043582] arm_spe_pmu spe-pmu at 1: probed for CPUs 0-7 [max_record_sz 64, align 1, features 0xf]
> > > > > [    1.043631] genirq: Flags mismatch irq 6. 00004404 (arm_spe_pmu) vs. 00004404 (arm_spe_pmu)
> > > > 
> > > > Looks like you've screwed up your IRQ partitions, so you are effectively
> > > > registering the same device twice, which then blows up due to lack of shared
> > > > irqs.
> > > > 
> > > > Either remove one of the devices, or use IRQ partitions to restrict them
> > > > to unique sets of CPUs.
> > > 
> > > Right, but since I want to get parity with what you're running -
> > > fvp_base.dtb - I tried to debug the hang after "smp: Bringing up
> > > secondary CPUs ..." problem, and could only debug it to the PSCI driver
> > > hitting one of these cases:
> > > 
> > > case PSCI_RET_INVALID_PARAMS:
> > > case PSCI_RET_INVALID_ADDRESS:
> > 
> > Sounds like your DT is describing CPUs that don't exist (or perhaps the
> > same CPU several times). Certainly, PSCI and the kernel disagree on
> > which CPUS exist.
> > 
> > What exact DT are you using?
> 
> the one this commit to linux-will's perf/spe branch provides:
> 
> commit 2a73de57eaf61cdfd61be1e20a46e4a2c326775f
> Author: Marc Zyngier <marc.zyngier@arm.com>
> Date:   Tue Mar 11 18:14:45 2014 +0000
> 
>     arm64: dts: add model device-tree
>     
>     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> > Are you using the bootwrapper, or ATF? I'm guessing you're using the
> > bootwrapper.
> 
> I'm using the wrapper to wrap arm-trusted-firmware (ATF?) objects, so,
> both?  I noticed the wrapper I was using was pretty old, so I updated
> it.

Ok. So what's likely happening is that ATF and the bootwrapper's FDT
disagree as to the set of CPUs. You're using ATF's PSCI implementation,
and not the boot-wrapper's.

I don't know how ATF enumerates CPUs on the model, so I can't offer much
guidance here other than fixing your DT to match whatever ATF believes
exists.

> arm-trusted-firmware, btw, has just been updated to enable SPE at lower
> ELs, so I don't have to use a hacked-up version anymore.
> 
> I also updated my BL33 to the latest upstream u-boot
> vexpress_aemv8a_dram_defconfig, and at least now the kernel continues
> to boot, even though it can't bring up 6 of the 7 secondary CPUs.

Do you mean that you replaced the bootwrapper with u-boot?

I'm a little confused here.

Regardless, it sounds like whatever DT is passed to the kernel still
doesn't match the real model configuration.

> > Which version of the bootwrapepr are you using? If it doesn't have
> > commit:
> > 
> >   ccdc936924b3682d ("Dynamically determine the set of CPUs")
> > 
> > ... have you configured it appropriately with --with-cpu-ids?
> > 
> > How is your model configured?
> 
> CLUSTER0_NUM_CORES=4
> CLUSTER1_NUM_CORES=4
> 
> > Which CPU IDs does it think exist?
> 
> 1,2,3,4,0x100,0x101,0x102,0x103
> 
> ...which are different from the above device tree!:
> 
> 0,0x100,0x200,0x300,0x10000,0x10100,0x10200,0x10300
> 
> So I imagine that's the problem, thanks!

Sounds like it, yes.

> I don't see how to tell the model to put the CPUs at different
> addresses, only a lot of GICv3 redistributor switches? 

I don't know how to do this, sorry.

> btw, where can I get updates to the run-model.sh scripts?  Answer
> off-list?

I don't know which script you're referring to. Contact whoever you got
it from initially?

[...]

> > > I can't tell which part of the fvp-base device tree is not liked by the
> > > firmware; I tried different combinations of the PSCI node, different CPU
> > > enumerations (cpu at 100 vs cpu at 1), removing idle-states properties...any
> > > hints appreciated.
> > 
> > The bootwrapper doesn't support idle. So no idle-states should be in the
> > DT.
> > 
> > If you can share your DT, bootwrapper configuration, and model
> > configuration, I can try to debug this with you.
> 
> I reverted the wrapper's ccdc936924b3682d ("Dynamically determine the
> set of CPUs") commit you mentioned above, and specified the cpu-ids
> manually, and am now running with 8 CPUs, although linux enumerates
> them as 0,1,8,9,10,11,12,13?

The --with-cpu-ids option *adds* CPU nodes, but leaves the broken ones,
and your CPU phandles (and PPI partitions for the SPE node(s)) will all
be wrong. Linux is still seeing those erroneous CPU nodes (presumably
taking Linux CPU ids 2-7).

Generally, --with-cpu-ids doesn't work as you'd expect, which is why it
got removed in favour of assuming an initally correct DT.

Please fix the DT instead. With a fixed DT, and commit ccdc936924b3682d,
the bootwrapper won't further mangle your DT.

Thanks,
Mark.
