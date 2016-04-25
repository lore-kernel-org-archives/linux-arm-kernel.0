From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Apr 2016 18:58:37 +0100
Subject: linux-next: perf issue on big.LITTLE since 26657848502b7847
Message-ID: <20160425175837.GB3141@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When booting an arm64 defconfig linux-next (next-20160422) on an ARM
Juno system, I hit a WARN_ON_ONCE in perf_pmu_register (see backtrace at
the end of this email).

This was introduced by commit 26657848502b7847 ("perf/core: Verify we
have a single perf_hw_context PMU") where we forcefully prevent multiple
PMUs from sharing perf_hw_context (with a warning), and force additional
PMUs to use perf_invalid_context.

Generally that makes sense, but unfortunately it breaks systems which
genuinely do have disparate HW (i.e. CPU) PMUs, such as Juno, which has
both Cortex-A57 PMUs and Cortex-A53 PMUs. We register a logical PMU for
each microarchitecture, which accept CPU-bound events for relevant CPUs,
or task-bound events. One task may have events for multiple logical PMUs
(and hence, they must share perf_hw_context).

The commit message for 26657848502b7847 mentions that the check is
intended to ensure that round-robin scheduling of events works, though
we already work around that issue by other means. In commit
66eb579e66ecfea5 ("perf: allow for PMU-specific event filtering"), we
added a PMU-specific callback specifically to avoid this issue, which we
wired up for ARM in commit c904e32a69b7c779 ("arm: perf: filter
unschedulable events").

Are you happy to revert 26657848502b787 for the timebeing? Or to somehow
predicate the check such that it doesn't adversely affect those HW PMUs?

Evidently we don't want perf_hw_context to be shared, but I don't
currently have a better way of supporting systems with disparate HW
PMUs. I'm happy to try a different approach (e.g. supporting multiple HW
contexts for a task), if that's preferable.

Thanks,
Mark.

[    1.074182] hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7 counters available
[    1.082451] ------------[ cut here ]------------
[    1.087051] WARNING: CPU: 3 PID: 1 at kernel/events/core.c:7858 perf_pmu_register+0x3b0/0x3b8
[    1.095520] Modules linked in:
[    1.098558] 
[    1.100046] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc4-next-20160422 #4
[    1.107396] Hardware name: ARM Juno development board (r1) (DT)
[    1.113274] task: ffffffc976ca0000 ti: ffffffc976ca8000 task.ti: ffffffc976ca8000
[    1.120712] PC is at perf_pmu_register+0x3b0/0x3b8
[    1.125470] LR is at perf_pmu_register+0x318/0x3b8
[    1.130229] pc : [<ffffff80081499b0>] lr : [<ffffff8008149918>] pstate: 80000045
[    1.137578] sp : ffffffc976cabb80
[    1.140871] x29: ffffffc976cabb80 x28: 0000000000000005 
[    1.146155] x27: 0000000000000005 x26: ffffff8008b55ca0 
[    1.151439] x25: ffffffc9764719f0 x24: ffffffc9764719d8 
[    1.156723] x23: ffffffc976471800 x22: 0000000000000007 
[    1.162006] x21: ffffff8008b6e000 x20: ffffff8008c01000 
[    1.167289] x19: ffffffc976471800 x18: ffffffffffffffff 
[    1.172573] x17: 0000000000000000 x16: 0000000100000000 
[    1.177856] x15: ffffffc976e17b89 x14: 746e756f63203720 
[    1.183140] x13: 2c72657669726420 x12: 0000000000000010 
[    1.188423] x11: 0000000000000020 x10: 0101010101010101 
[    1.193706] x9 : 0000000000000002 x8 : ffffffc97ffafc00 
[    1.198989] x7 : 0000000000000000 x6 : 0000000000000000 
[    1.204271] x5 : ffffffffffffffff x4 : 0000000000000000 
[    1.209554] x3 : 0000000000000000 x2 : 0000000000000001 
[    1.214836] x1 : 0000000000000001 x0 : ffffff8008beb030 
[    1.220119] 
[    1.221613] ---[ end trace cc9297aab225740b ]---
[    1.226197] Call trace:
[    1.228631] Exception stack(0xffffffc976cab9c0 to 0xffffffc976cabae0)
[    1.235029] b9c0: ffffffc976471800 ffffff8008c01000 ffffffc976cabb80 ffffff80081499b0
[    1.242815] b9e0: ffffffc976cab9f0 ffffff8008638a4c ffffffc976cabb10 ffffff8008638de4
[    1.250599] ba00: 0000000000000000 0000000000000000 ffffffc976cabb70 ffffff80089f10c8
[    1.258384] ba20: ffffffc97ffe2658 ffffffbefe800ae0 ffffffc9764719f0 ffffff8008b55ca0
[    1.266168] ba40: 0000000000000005 0000000000000005 ffffffc976cabae0 ffffff8008179a6c
[    1.273952] ba60: ffffff8008beb030 0000000000000001 0000000000000001 0000000000000000
[    1.281736] ba80: 0000000000000000 ffffffffffffffff 0000000000000000 0000000000000000
[    1.289520] baa0: ffffffc97ffafc00 0000000000000002 0101010101010101 0000000000000020
[    1.297304] bac0: 0000000000000010 2c72657669726420 746e756f63203720 ffffffc976e17b89
[    1.305088] [<ffffff80081499b0>] perf_pmu_register+0x3b0/0x3b8
[    1.310886] [<ffffff800865d068>] arm_pmu_device_probe+0x390/0x5b8
[    1.316942] [<ffffff80080912dc>] armv8_pmu_device_probe+0x1c/0x28
[    1.322997] [<ffffff800845e3c0>] platform_drv_probe+0x50/0xb8
[    1.328704] [<ffffff800845c8a4>] driver_probe_device+0x204/0x2b0
[    1.334670] [<ffffff800845c9fc>] __driver_attach+0xac/0xb0
[    1.340121] [<ffffff800845a850>] bus_for_each_dev+0x60/0xa0
[    1.345656] [<ffffff800845c030>] driver_attach+0x20/0x28
[    1.350933] [<ffffff800845bc20>] bus_add_driver+0x1d0/0x238
[    1.356468] [<ffffff800845d1c0>] driver_register+0x60/0xf8
[    1.361918] [<ffffff800845e300>] __platform_driver_register+0x40/0x48
[    1.368317] [<ffffff8008a73c1c>] register_armv8_pmu_driver+0x18/0x20
[    1.374629] [<ffffff8008081a10>] do_one_initcall+0x38/0x128
[    1.380165] [<ffffff8008a70cc8>] kernel_init_freeable+0x14c/0x1f0
[    1.386220] [<ffffff800876e560>] kernel_init+0x10/0x100
[    1.391412] [<ffffff8008084e10>] ret_from_fork+0x10/0x40
[    1.396731] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
