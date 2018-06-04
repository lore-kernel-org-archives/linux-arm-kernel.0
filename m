From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Mon, 4 Jun 2018 11:21:30 +0200
Subject: [PATCH v4 4/5] clocksource: add driver for i.MX EPIT timer
In-Reply-To: <677be207-67be-ccbc-8bb3-ab90bf9d05a7@mentor.com>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-5-peron.clem@gmail.com>
 <677be207-67be-ccbc-8bb3-ab90bf9d05a7@mentor.com>
Message-ID: <CAJiuCcfwiut6rN3d_Yn+zCTLChS8kNUYCmpzHQEFmVxan_qfVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Thu, 31 May 2018 at 10:36, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
>
> Hi Cl?ment,
>
> On 05/30/2018 03:03 PM, Cl?ment P?ron wrote:
> > From: Colin Didier <colin.didier@devialet.com>
> >
> > Add driver for NXP's EPIT timer used in i.MX 6 family of SoC.
> >
> > Signed-off-by: Colin Didier <colin.didier@devialet.com>
> > Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> > ---
>
> [snip]
>
> > +++ b/drivers/clocksource/timer-imx-epit.c
> > @@ -0,0 +1,281 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * i.MX EPIT Timer
> > + *
> > + * Copyright (C) 2010 Sascha Hauer <s.hauer@pengutronix.de>
> > + * Copyright (C) 2018 Colin Didier <colin.didier@devialet.com>
> > + * Copyright (C) 2018 Cl?ment P?ron <clement.peron@devialet.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/err.h>
>
> The included header above still can be removed.

Ok.

>
> I have no more comments about the code, I will try to find time to
> test the driver, but please don't take it as a promise.

Regarding the clks, i think the management of the ipg clk in the
driver is useless
has it is already handled by the imx clk driver.

I remove the ipg clk and test it on i.MX6Q.

My test is limited to disabled the GPT and enabled the EPIT in the device-tree
&gpt {
        status = "disabled";
};

&epit1 {
        status = "okay";
};

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.17.0-rc6 (cperon at cperon-Latitude-7490)
(gcc version 6.4.1 20170707 (Linaro GCC 6.4-2017.08)) #1 SMP PREEMPT
Mon Jun 4 11:13:41 CEST 2018
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Devialet Aerobase
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000]   Normal zone: 2048 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 262144 pages, LIFO batch:31
[    0.000000] random: get_random_bytes called from
start_kernel+0x80/0x398 with crng_init=0
[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s35084 r8192
d22260 u65536
[    0.000000] pcpu-alloc: s35084 r8192 d22260 u65536 alloc=16*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260096
[    0.000000] Kernel command line: console=ttymxc0,115200
root=/dev/nfs rw nfsroot=192.168.0.4:/opt/nfsroot,v3,tcp ip=dhcp
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1029544K/1048576K available (6144K kernel code,
194K rwdata, 1312K rodata, 1024K init, 224K bss, 19032K reserved, 0K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Tasks RCU enabled.\x00
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000012] sched_clock: 32 bits at 66MHz, resolution 15ns, wraps
every 32537631224ns
[    0.000032] clocksource: epit: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 28958491609 ns
[    0.001231] Calibrating delay loop... 1560.57 BogoMIPS (lpj=780288)
[    0.008161] pid_max: default: 32768 minimum: 301
[    0.008336] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.008360] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.009042] CPU: Testing write buffer coherency: ok
[    0.009506] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.014238] Setting up static identity map for 0x10100000 - 0x10100060
[    0.015207] Hierarchical SRCU implementation.
[    0.017208] smp: Bringing up secondary CPUs ...
[    0.029147] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.041146] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.053146] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.053321] smp: Brought up 1 node, 4 CPUs
[    0.053340] SMP: Total of 4 processors activated (6303.74 BogoMIPS).
[    0.053349] CPU: All CPU(s) started in SVC mode.
[    0.054441] devtmpfs: initialized
[    0.063770] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.064454] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.064477] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.064742] pinctrl core: initialized pinctrl subsystem
[    0.066693] NET: Registered protocol family 16
[    0.068623] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.071654] cpuidle: using governor menu
[    0.071802] CPU identified as i.MX6Q, silicon rev 1.2


>
> --
> With best wishes,
> Vladimir
