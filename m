From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 May 2018 19:19:49 +0100
Subject: [PATCH v3 0/5]
In-Reply-To: <20180518143913.26306-1-marc.zyngier@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
Message-ID: <20180521181948.GB19122@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thanks for this.

On Fri, May 18, 2018 at 03:39:08PM +0100, Marc Zyngier wrote:
> PMUv3 has been introduced with ARMv8 and, while it has only been used
> on 64bit systems so far, it would definitely be useful for 32bit
> guests running under KVM/arm64, for example.
> 
> There is also the case of people natively running 32bit kernels on
> 64bit HW and trying to upstream unspeakable hacks, hoping that the
> stars will align and that they'll win the lottery (see [1]).
> 
> So let's try again, and make the PMUv3 driver usable for everyone.
> 
> This is done in three steps:
> (1) Move the driver from arch/arm64 to drivers/perf
> (2) Add a handful of system register accessors so that we can reuse
>     the driver on 32bit
> (3) Provide the same accessors on 32bit, enable compilation, and
>     make it the default selection for mach-virt.
> 
> Tested on a Seattle box with 32bit guests.

I think we should go ahead with something like this, but I don't think
we're quite there with these patches. If we're going to move the arch code
out into drivers, let's do that for the perf_event* files under arch/arm/
as well. Then we could have a structure along the lines of:


  drivers/perf/arm_pmu.c			- As it is today
  drivers/perf/arm_cpu/xscale_pmu.c		- Only builds for 32-bit
  drivers/perf/arm_cpu/armv6_pmu.c		- Only builds for 32-bit
  drivers/perf/arm_cpu/arch_pmu.c		- Works for v7/v8 on
                                                  both 32-bit and 64-bit

The latter can then pull in whatever accessors it needs from the arch
code headers.

I know it's more of an invasive change, but this way we always end up
running the same code on the two architectures and it will be much easier
to maintain.

Will
