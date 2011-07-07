From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:13 +0100
Subject: [RFC PATCH 00/17] ARM: common idle infrastructure
Message-ID: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a first attempt at providing a consolidation of idle
code for the ARM processor architecture and a request for comment on
the provided methodology.
It relies and it is based on kernel features such as suspend/resume,
pm notifiers and common code for cpu_reset().

It integrates latest patches from ALKML for cpu pm notifiers and a cpu_reset 
function hook. Patches are included in the patchset for completeness.

The patchset depends on the following patches, whose links are provided
for completeness:

https://patchwork.kernel.org/patch/882892/
https://patchwork.kernel.org/patch/873692/
https://patchwork.kernel.org/patch/873682/
https://patchwork.kernel.org/patch/873672/

The idle framework defines a common entry point in [sr_entry.S] 

cpu_enter_idle(cstate, rstate, flags)

where:

C-state [CPU state]:
    
0 - RUN MODE
1 - STANDBY
2 - DORMANT (not supported by this patch)
3 - SHUTDOWN
    
R-state [CLUSTER state]
    
0 - RUN
1 - STANDBY (not supported by this patch)
2 - L2 RAM retention
3 - SHUTDOWN 

flags:

SR_SAVE_L2: L2 registers saved and restored on shutdown
SR_SAVE_SCU: SCU reset on cluster wake-up

The assembly entry point checks the targeted state and executes wfi, 
entering a shallow c-state or call into the sr framework to put the cpu
and cluster in low-power state. If the target is a deep low-power state
it saves the current stack pointer and registers on the stack for the resume
path.

On deep-power state entry, since the CPU is hitting the off state, the
code switches page tables (cloned from init_mm at boot) to cater for 1:1
mapping of kernel code, data, and uncached reserved memory pages obtained
from platform code through a hook:

platform_context_pointer(size)

Every platform using the framework should implement this hook to return
reserved memory pages that are going to be mapped as uncached and 1:1 mapped
to cater for the MMU off resume path. 
This decision has been made in order to avoid fiddling with L2 when CPU
enters low-power (context should be flushed to L3 so that a CPU can fetch it
from memory when the MMU is off).

On the resume path the CPU loads a non-cacheable stack pointer to cater for
the MMU enabling path, and after switching page tables returns to the OS.

The non-cacheable stack simplifies the L2 management in that, since for single
CPU shutdown the L2 is still enabled, on MMU resume some stack used before
the MMU is turned on might still be present and valid in L2 leading to 
corruption. After MMU is enabled a few bytes of the stack frame are copied
back to the Linux stack and execution resumes.

Generic subsystem save/restore is triggered by cpu pm notifiers, to 
save/restore GIC, VFP, PMU state automatically.

The patchset introduces a new notifier chain which notifies listeners of
a required platform shutdown/wakeup. Platform code should register to the chain
and execute all actions required to put the system in low-power mode when
called. It is called within a virtual address space cloned from init_mm at
arch_initcall.

On cluster shutdown L2 cache memory should be either cleaned (complete shutdown)
or just save L2 logic (L2 RAM retained). This is a major issue since
on power-down the stack points to cacheable memory that must be cleaned
from L2 before disabling the L2 controller.
Current code performing that action is a hack and provides ground for
discussions. The stack might be switched to non-cacheable on power down
but by doing this code relying on thread_info is broken unless that
struct is copied across the stack switch.

Atomicity of the code is provided by strongly ordered locking algorithm 
(Lamport's Bakery) since when CPUs are out of coherency and the D$ look-up
are disabled normal spinlocks based on ldrex/strex are not functional.
Atomicity of L2 clean/invalidate L2 and reset of SCU are fundamental
to guarantee system stability.
Lamport's bakery code is provided for completeness and it can be 
ignored; please refer to the patch commit note.

Entry on low-power mode is performed by a function pointer (*sr_sleep), to
allow platforms to override the default behaviour (and possibly execute
from different memory spaces).

Tested on dual-core A9 Cluster through all system low-power states 
supported by the patchset. A8, A5 support compile tested. 

Colin Cross (3):
  ARM: Add cpu power management notifiers
  ARM: gic: Use cpu pm notifiers to save gic state
  ARM: vfp: Use cpu pm notifiers to save vfp state

Lorenzo Pieralisi (13):
  ARM: kernel: save/restore kernel IF
  ARM: kernel: save/restore generic infrastructure
  ARM: kernel: save/restore v7 assembly helpers
  ARM: kernel: save/restore arch runtime support
  ARM: kernel: v7 resets support
  ARM: kernel: save/restore v7 infrastructure support
  ARM: kernel: add support for Lamport's bakery locks
  ARM: kernel: add SCU reset hook
  ARM: mm: L2x0 save/restore support
  ARM: kernel: save/restore 1:1 page tables
  ARM: perf: use cpu pm notifiers to save pmu state
  ARM: PM: enhance idle pm notifiers
  ARM: kernel: save/restore build infrastructure

Will Deacon (1):
  ARM: proc: add definition of cpu_reset for ARMv6 and ARMv7 cores

 arch/arm/Kconfig                       |   18 ++
 arch/arm/common/gic.c                  |  212 +++++++++++++++++++++++
 arch/arm/include/asm/cpu_pm.h          |   69 ++++++++
 arch/arm/include/asm/lb_lock.h         |   34 ++++
 arch/arm/include/asm/outercache.h      |   22 +++
 arch/arm/include/asm/smp_scu.h         |    3 +-
 arch/arm/include/asm/sr_platform_api.h |   28 +++
 arch/arm/kernel/Makefile               |    5 +
 arch/arm/kernel/cpu_pm.c               |  265 ++++++++++++++++++++++++++++
 arch/arm/kernel/lb_lock.c              |   85 +++++++++
 arch/arm/kernel/perf_event.c           |   22 +++
 arch/arm/kernel/reset_v7.S             |  109 ++++++++++++
 arch/arm/kernel/smp_scu.c              |   33 ++++-
 arch/arm/kernel/sr.h                   |  162 +++++++++++++++++
 arch/arm/kernel/sr_api.c               |  197 +++++++++++++++++++++
 arch/arm/kernel/sr_arch.c              |   74 ++++++++
 arch/arm/kernel/sr_context.c           |   23 +++
 arch/arm/kernel/sr_entry.S             |  213 +++++++++++++++++++++++
 arch/arm/kernel/sr_helpers.h           |   56 ++++++
 arch/arm/kernel/sr_mapping.c           |   78 +++++++++
 arch/arm/kernel/sr_platform.c          |   48 +++++
 arch/arm/kernel/sr_power.c             |   26 +++
 arch/arm/kernel/sr_v7.c                |  298 ++++++++++++++++++++++++++++++++
 arch/arm/kernel/sr_v7_helpers.S        |   47 +++++
 arch/arm/mm/cache-l2x0.c               |   63 +++++++
 arch/arm/mm/proc-v6.S                  |    5 +
 arch/arm/mm/proc-v7.S                  |    7 +
 arch/arm/vfp/vfpmodule.c               |   40 +++++
 28 files changed, 2238 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/cpu_pm.h
 create mode 100644 arch/arm/include/asm/lb_lock.h
 create mode 100644 arch/arm/include/asm/sr_platform_api.h
 create mode 100644 arch/arm/kernel/cpu_pm.c
 create mode 100644 arch/arm/kernel/lb_lock.c
 create mode 100644 arch/arm/kernel/reset_v7.S
 create mode 100644 arch/arm/kernel/sr.h
 create mode 100644 arch/arm/kernel/sr_api.c
 create mode 100644 arch/arm/kernel/sr_arch.c
 create mode 100644 arch/arm/kernel/sr_context.c
 create mode 100644 arch/arm/kernel/sr_entry.S
 create mode 100644 arch/arm/kernel/sr_helpers.h
 create mode 100644 arch/arm/kernel/sr_mapping.c
 create mode 100644 arch/arm/kernel/sr_platform.c
 create mode 100644 arch/arm/kernel/sr_power.c
 create mode 100644 arch/arm/kernel/sr_v7.c
 create mode 100644 arch/arm/kernel/sr_v7_helpers.S

-- 
1.7.4.4
