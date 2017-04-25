From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Apr 2017 17:10:37 +0100
Subject: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem
In-Reply-To: <20170418170442.665445272@linutronix.de>
References: <20170418170442.665445272@linutronix.de>
Message-ID: <20170425161037.GA27156@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series appears to break boot on some arm64 platforms, seen with
next-20170424. More info below.

On Tue, Apr 18, 2017 at 07:04:42PM +0200, Thomas Gleixner wrote:
> get_online_cpus() is used in hot pathes in mainline and even more so in
> RT. That can show up badly under certain conditions because every locker
> contends on a global mutex. RT has it's own homebrewn mitigation which is
> an (badly done) open coded implementation of percpu_rwsems with recursion
> support.
> 
> The proper replacement for that are percpu_rwsems, but that requires to
> remove recursion support.
> 
> The conversion unearthed real locking issues which were previously not
> visible because the get_online_cpus() lockdep annotation was implemented
> with recursion support which prevents lockdep from tracking full dependency
> chains. These potential deadlocks are not related to recursive calls, they
> trigger on the first invocation because lockdep now has the full dependency
> chains available.

Catalin spotted next-20170424 wouldn't boot on a Juno system, where we see the
following splat (repeated forever) when we try to bring up the first secondary
CPU:

[    0.213406] smp: Bringing up secondary CPUs ...
[    0.250326] CPU features: enabling workaround for ARM erratum 832075
[    0.250334] BUG: scheduling while atomic: swapper/1/0/0x00000002
[    0.250337] Modules linked in:
[    0.250346] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.11.0-rc7-next-20170424 #2
[    0.250349] Hardware name: ARM Juno development board (r1) (DT)
[    0.250353] Call trace:
[    0.250365] [<ffff000008088510>] dump_backtrace+0x0/0x238
[    0.250371] [<ffff00000808880c>] show_stack+0x14/0x20
[    0.250377] [<ffff00000839d854>] dump_stack+0x9c/0xc0
[    0.250384] [<ffff0000080e3540>] __schedule_bug+0x50/0x70
[    0.250391] [<ffff000008932ecc>] __schedule+0x52c/0x5a8
[    0.250395] [<ffff000008932f80>] schedule+0x38/0xa0
[    0.250400] [<ffff000008935e8c>] rwsem_down_read_failed+0xc4/0x108
[    0.250407] [<ffff0000080fe8e0>] __percpu_down_read+0x100/0x118
[    0.250414] [<ffff0000080c0b60>] get_online_cpus+0x70/0x78
[    0.250420] [<ffff0000081749e8>] static_key_enable+0x28/0x48
[    0.250425] [<ffff00000808de90>] update_cpu_capabilities+0x78/0xf8
[    0.250430] [<ffff00000808d14c>] update_cpu_errata_workarounds+0x1c/0x28
[    0.250435] [<ffff00000808e004>] check_local_cpu_capabilities+0xf4/0x128
[    0.250440] [<ffff00000808e894>] secondary_start_kernel+0x8c/0x118
[    0.250444] [<000000008093d1b4>] 0x8093d1b4

I can reproduce this with the current head of the linux-tip smp/hotplug
branch (commit 77c60400c82bd993), with arm64 defconfig on a Juno R1
system.

When we bring the secondary CPU online, we detect an erratum that wasn't
present on the boot CPU, and try to enable a static branch we use to
track the erratum. The call to static_branch_enable() blows up as above.

I see that we now have static_branch_disable_cpuslocked(), but we don't
have an equivalent for enable. I'm not sure what we should be doing
here.

Thanks,
Mark.

> The following patch series addresses this by
> 
>  - Cleaning up places which call get_online_cpus() nested
> 
>  - Replacing a few instances with cpu_hotplug_disable() to prevent circular
>    locking dependencies.
> 
> The series depends on
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>   plus
>     Linus tree merged in to avoid conflicts
> 
> It's available in git from
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.hotplug
> 
> Changes since V1:
> 
>   - Fixed fallout reported by kbuild bot
>   - Repaired the recursive call in perf
>   - Repaired the interaction with jumplabels (Peter Zijlstra)
>   - Renamed _locked to _cpuslocked
>   - Picked up Acked-bys
> 
> Thanks,
> 
> 	tglx
> 
> -------
>  arch/arm/kernel/hw_breakpoint.c               |    5 
>  arch/mips/kernel/jump_label.c                 |    2 
>  arch/powerpc/kvm/book3s_hv.c                  |    8 -
>  arch/powerpc/platforms/powernv/subcore.c      |    3 
>  arch/s390/kernel/time.c                       |    2 
>  arch/x86/events/core.c                        |    1 
>  arch/x86/events/intel/cqm.c                   |   12 -
>  arch/x86/kernel/cpu/mtrr/main.c               |    2 
>  b/arch/sparc/kernel/jump_label.c              |    2 
>  b/arch/tile/kernel/jump_label.c               |    2 
>  b/arch/x86/events/intel/core.c                |    4 
>  b/arch/x86/kernel/jump_label.c                |    2 
>  b/kernel/jump_label.c                         |   31 ++++-
>  drivers/acpi/processor_driver.c               |    4 
>  drivers/cpufreq/cpufreq.c                     |    9 -
>  drivers/hwtracing/coresight/coresight-etm3x.c |   12 -
>  drivers/hwtracing/coresight/coresight-etm4x.c |   12 -
>  drivers/pci/pci-driver.c                      |   47 ++++---
>  include/linux/cpu.h                           |    2 
>  include/linux/cpuhotplug.h                    |   29 ++++
>  include/linux/jump_label.h                    |    3 
>  include/linux/padata.h                        |    3 
>  include/linux/pci.h                           |    1 
>  include/linux/stop_machine.h                  |   26 +++-
>  kernel/cpu.c                                  |  157 ++++++++------------------
>  kernel/events/core.c                          |    9 -
>  kernel/padata.c                               |   39 +++---
>  kernel/stop_machine.c                         |    7 -
>  28 files changed, 228 insertions(+), 208 deletions(-)
> 
> 
> 
