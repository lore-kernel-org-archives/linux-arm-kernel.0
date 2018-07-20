From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Fri, 20 Jul 2018 11:25:52 +0100
Subject: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
In-Reply-To: <20180719133222.GL17271@n2100.armlinux.org.uk>
References: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
 <20180719100109.GH17271@n2100.armlinux.org.uk>
 <20180719133222.GL17271@n2100.armlinux.org.uk>
Message-ID: <20180720102552.GC19287@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 02:32:22PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 19, 2018 at 11:01:10AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 19, 2018 at 11:42:50AM +0200, Dietmar Eggemann wrote:
> > > Hi,
> > > 
> > > running v4.18-rc5 (plus still missing "power: vexpress: fix corruption in
> > > notifier registration", otherwise I get this rcu_sched stall issue) on TC2
> > > (A7 boot) with vanilla multi_v7_defconfig plus
> > > CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:
> > > 
> > > ...
> > >  CPUX: Spectre v2: incorrect context switching function, system vulnerable
> > > ...
> > > 
> > > messages.
> > > 
> > > Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.
> > 
> > or disable big.Little if you want the hardening.
> > 
> > The choices are currently either protection against Spectre or big.Little
> > support since the two are mutually exclusive at the moment.
> 
> An alternative would be to give the patches in the attachment a test.
> They're not finished yet, so I haven't sent them out, but still worth
> testing.

Thanks for sharing. I can confirm that your patches do cure the flood of warnings.

TC2 booting on A7:

[    0.002922] CPU: Testing write buffer coherency: ok
[    0.003347] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.004022] Setting up static identity map for 0x80100000 - 0x80100060
[    0.004265] ARM CCI driver probed
[    0.004648] TC2 power management initialized
[    0.004930] Hierarchical SRCU implementation.
[    0.006956] smp: Bringing up secondary CPUs ...
[    0.008712] CPU1: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.008720] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.009934] CPU2: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.009940] CPU2: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.011147] CPU3: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.012350] CPU4: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.012468] smp: Brought up 1 node, 5 CPUs
[    0.012490] SMP: Total of 5 processors activated (240.00 BogoMIPS).
[    0.012499] CPU: All CPU(s) started in SVC mode.

TC2 booting on A15:

[    0.002045] CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.002311] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002809] Setting up static identity map for 0x80100000 - 0x80100060
[    0.003000] ARM CCI driver probed
[    0.003408] TC2 power management initialized
[    0.003637] Hierarchical SRCU implementation.
[    0.005177] smp: Bringing up secondary CPUs ...
[    0.006170] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.006176] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.008137] CPU2: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.009304] CPU3: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.010405] CPU4: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.010537] smp: Brought up 1 node, 5 CPUs
[    0.010562] SMP: Total of 5 processors activated (240.00 BogoMIPS).
[    0.010572] CPU: All CPU(s) started in SVC mode.

No further warnings for either configuration.

For reference, this a partial output from later in the boot process when
booting on A7 with 4.18-rc5 _without_ your patches:

[    5.576176] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel at redhat.com
[    5.601689] cpu cpu0: bL_cpufreq_init: CPU 0 initialized
[    5.618670] cpu cpu1: bL_cpufreq_init: CPU 1 initialized
[    5.635583] arm_big_little: bL_cpufreq_register: Registered platform driver: vexpress-spc
[    5.661112] mmci-pl18x 1c050000.mmci: Got CD GPIO
[    5.675235] mmci-pl18x 1c050000.mmci: Got WP GPIO
[    5.687783] CPU2: Spectre v2: incorrect context switching function, system vulnerable
[    5.689623] mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 26,27 (pio)
[    5.713217] CPU1: Spectre v2: incorrect context switching function, system vulnerable
[    5.718044] CPU2: Spectre v2: incorrect context switching function, system vulnerable
[    5.727896] CPU2: Spectre v2: incorrect context switching function, system vulnerable
