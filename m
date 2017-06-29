From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 28 Jun 2017 19:59:53 -0500
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170628112601.GD5981@leverpostej>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <20170612110823.GA27319@leverpostej>
 <20170612112048.69561e8d067488e8689de755@arm.com>
 <20170615105735.b89183a9190a261d3b8d132a@arm.com>
 <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
Message-ID: <20170628195953.6cde9604068dd90bbef3bf5f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jun 2017 12:26:02 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Jun 27, 2017 at 04:07:58PM -0500, Kim Phillips wrote:
> > I'm close to finishing the bts version of userspace, and have been
> > testing a bit more thoroughly, so now I consistently see the excessive
> > PADding when recording a CPU that's idle. I.e., when I taskset the perf
> > record to the same CPU I specify to record's -C (taskset -c n perf
> > record -C n), I get max. twenty-odd number of PAD bytes at the end of
> > the AUX buffers in the perf.data file.  If, OTOH, I taskset -c n perf
> > record -C m, where m != n, I get a couple of valid event records in the
> > buffer, and the rest of the buffer is filled with PADding.
> > 
> > It wouldn't be a problem except that it's wastes too much space
> > sometimes.  Here is a good output buffer sample from a --mmap-pages=,12
> > run, with only 4 PADs tacked onto the end:
> > 
> > 0xd190 [0x30]: PERF_RECORD_AUXTRACE size: 0x48  offset: 0  ref: 0xe914f7e3ce  idx: 0  tid: -1  cpu: 2
> > .
> > . ... ARM SPE data: size 72 bytes
> > .  00000000:  4a 01                                           B COND
> 
> [...]
> 
> > .  0000003b:  71 a5 39 e1 14 e9 00 00 00                      TS 1001077684645
> > .  00000044:  00                                              PAD
> > .  00000045:  00                                              PAD
> > .  00000046:  00                                              PAD
> > .  00000047:  00                                              PAD
> > 
> > whereas this one - from later on in the same run - is over 99% PADs: 
> > 
> > 0xd250 [0x30]: PERF_RECORD_AUXTRACE size: 0x5fc0  offset: 0xfffff4ae0044  ref: 0xe91cead1dd  idx: 0  tid: -1  cpu: 2
> > .
> > . ... ARM SPE data: size 24512 bytes
> > .  00000000:  4a 00                                           B
> 
> [...]
> 
> > .  000000b0:  71 8f 4e e1 14 e9 00 00 00                      TS 1001077689999
> > .  000000b9:  00                                              PAD
> > ...ALL PADs...ALL PADs...ALL PADs...ALL PADs...ALL PADs...ALL PADs...
> > .  00005fbf:  00                                              PAD
> 
> Interesting.
> 
> If you cat /proc/interrupts, do you see many more SPE interrupts on CPU
> n than on m?

When n == m, I see approx. 1 IRQ per SPE buffer full.

When n != m, I see neither CPU n or m incur SPE interrupts; the
workload ran but didn't get recorded, or, rather, 'idleness' got
recorded instead.

> Otherwise, I wonder if this is some odd interaction with idle. Can you
> try to forcefully load that other CPU?
> 
> e.g. run something like:
> 
> 	taskset -c <n> sh -c 'while true; do done'
> 
> ... in parallel with the tracer.

If I do a:

taskset -c 1 sh -c 'while true; do echo blah > /dev/null' & 
taskset -c 0 perf record -C 1 ...

then non-idleness and non-PADdingness get recorded.

> For reference, what was your event sample period (i.e. the value of
> perf_event_attr::sample_period)?
> 
> Did you modify that at all with PERF_EVENT_IOC_PERIOD?

If that's the same as 'perf record -c <period>', then, yes, I set
the period to values such as 512, 1024.

> > > > Meanwhile, when using fvp-base.dtb, my model setup stops booting the
> > > > kernel after "smp: Bringing up secondary CPUs ...".  If I however take
> > > > the second SPE node from fvp-base.dts and add it to my working device
> > > > tree, I get this during the driver probe:
> > > > 
> > > > [    1.042063] arm_spe_pmu spe-pmu at 0: probed for CPUs 0-7 [max_record_sz 64, align 1, features 0xf]
> > > > [    1.043582] arm_spe_pmu spe-pmu at 1: probed for CPUs 0-7 [max_record_sz 64, align 1, features 0xf]
> > > > [    1.043631] genirq: Flags mismatch irq 6. 00004404 (arm_spe_pmu) vs. 00004404 (arm_spe_pmu)
> > > 
> > > Looks like you've screwed up your IRQ partitions, so you are effectively
> > > registering the same device twice, which then blows up due to lack of shared
> > > irqs.
> > > 
> > > Either remove one of the devices, or use IRQ partitions to restrict them
> > > to unique sets of CPUs.
> > 
> > Right, but since I want to get parity with what you're running -
> > fvp_base.dtb - I tried to debug the hang after "smp: Bringing up
> > secondary CPUs ..." problem, and could only debug it to the PSCI driver
> > hitting one of these cases:
> > 
> > case PSCI_RET_INVALID_PARAMS:
> > case PSCI_RET_INVALID_ADDRESS:
> 
> Sounds like your DT is describing CPUs that don't exist (or perhaps the
> same CPU several times). Certainly, PSCI and the kernel disagree on
> which CPUS exist.
> 
> What exact DT are you using?

the one this commit to linux-will's perf/spe branch provides:

commit 2a73de57eaf61cdfd61be1e20a46e4a2c326775f
Author: Marc Zyngier <marc.zyngier@arm.com>
Date:   Tue Mar 11 18:14:45 2014 +0000

    arm64: dts: add model device-tree
    
    Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

> Are you using the bootwrapper, or ATF? I'm guessing you're using the
> bootwrapper.

I'm using the wrapper to wrap arm-trusted-firmware (ATF?) objects, so,
both?  I noticed the wrapper I was using was pretty old, so I updated
it.

arm-trusted-firmware, btw, has just been updated to enable SPE at lower
ELs, so I don't have to use a hacked-up version anymore.

I also updated my BL33 to the latest upstream u-boot
vexpress_aemv8a_dram_defconfig, and at least now the kernel continues
to boot, even though it can't bring up 6 of the 7 secondary CPUs.

> Which version of the bootwrapepr are you using? If it doesn't have
> commit:
> 
>   ccdc936924b3682d ("Dynamically determine the set of CPUs")
> 
> ... have you configured it appropriately with --with-cpu-ids?
> 
> How is your model configured?

CLUSTER0_NUM_CORES=4
CLUSTER1_NUM_CORES=4

> Which CPU IDs does it think exist?

1,2,3,4,0x100,0x101,0x102,0x103

...which are different from the above device tree!:

0,0x100,0x200,0x300,0x10000,0x10100,0x10200,0x10300

So I imagine that's the problem, thanks!

I don't see how to tell the model to put the CPUs at different
addresses, only a lot of GICv3 redistributor switches?  btw, where can
I get updates to the run-model.sh scripts?  Answer off-list?

> > Note: it's yet another place I have to manually instrument the error
> > path in a kernel driver in lieu of it being more naturally verbose by
> > itself; I *implore* you to reconsider adding proper user messaging to
> > arm_spe_pmu_event_init().
> 
> Given this is a FW configuration issue (i.e. a system-level error), I'm
> more than happy to make the PSCI driver messages more helpful where
> possible.
> 
> That's completely orthogonal to the SPE debug messages for requests made
> by the user.

I respectfully disagree, given the current state of the interfaces
involved.

> > I can't tell which part of the fvp-base device tree is not liked by the
> > firmware; I tried different combinations of the PSCI node, different CPU
> > enumerations (cpu at 100 vs cpu at 1), removing idle-states properties...any
> > hints appreciated.
> 
> The bootwrapper doesn't support idle. So no idle-states should be in the
> DT.
> 
> If you can share your DT, bootwrapper configuration, and model
> configuration, I can try to debug this with you.

I reverted the wrapper's ccdc936924b3682d ("Dynamically determine the
set of CPUs") commit you mentioned above, and specified the cpu-ids
manually, and am now running with 8 CPUs, although linux enumerates
them as 0,1,8,9,10,11,12,13?

Thanks for your continued support,

Kim
