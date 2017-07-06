From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 6 Jul 2017 12:08:52 -0500
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170629111102.GB11040@leverpostej>
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
 <20170629111102.GB11040@leverpostej>
Message-ID: <20170706120852.df0dfc52afbb49008ed9bb55@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Jun 2017 12:11:02 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Jun 28, 2017 at 07:59:53PM -0500, Kim Phillips wrote:
> > arm-trusted-firmware, btw, has just been updated to enable SPE at lower
> > ELs, so I don't have to use a hacked-up version anymore.
> > 
> > I also updated my BL33 to the latest upstream u-boot
> > vexpress_aemv8a_dram_defconfig, and at least now the kernel continues
> > to boot, even though it can't bring up 6 of the 7 secondary CPUs.
> 
> Do you mean that you replaced the bootwrapper with u-boot?

no, sorry, arm-trusted-firmware wants a BL33 image, which u-boot
provides.

Sorry but I guess I'm not using the bootwrapper, and we are launching
the model in completely different manners.

The bootwrapper input is a kernel and a dtb, and it emits a dtb and a
linux-system.axf file, the latter of which I don't see how to launch
the model with:  The model script I'm using uses a kernel, dtb, and an
fip.bin and bl1.bin.

Can you share how you invoke the model, presumably with the .axf file?  

> The --with-cpu-ids option *adds* CPU nodes, but leaves the broken ones,
> and your CPU phandles (and PPI partitions for the SPE node(s)) will all
> be wrong. Linux is still seeing those erroneous CPU nodes (presumably
> taking Linux CPU ids 2-7).
> 
> Generally, --with-cpu-ids doesn't work as you'd expect, which is why it
> got removed in favour of assuming an initally correct DT.
> 
> Please fix the DT instead. With a fixed DT, and commit ccdc936924b3682d,
> the bootwrapper won't further mangle your DT.

OK, changing the CPU IDs alone didn't work (kernel didn't even say hi),
but taking what commit ccdc936924b3682d does to the cpu_on/off
properties makes it work for my arm-trusted-firmware (non-boot-wrapper)
invocation, so I have to use the wrapper if I change my DT CPUs for the
time being.

So I'm OK now for at least the two-partition, four CPUs each setup, but
for topologies as described in Marc/Will's fvp-base.dts commit, I don't
see how to run without knowing how to make the axf file work with the
model, i.e., solely with the boot-wrapper.

Thanks,

Kim
