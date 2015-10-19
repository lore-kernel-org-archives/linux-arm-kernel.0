From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:00:23 +0100
Subject: [PATCHv4 00/24] arm64: Consolidate CPU feature handling
Message-ID: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces a new infrastructure to keep track of the CPU
feature registers on ARMv8-A for arm64 kernel. It provides the safe value
of a CPU feature register across all the CPUs on (a heterogeneous) system.
The infrastructure checks the individual CPU feature registers as they are
brought online (during system boot up) and udpates the status of each of
the feature bits across the system. Once all the active CPUs are brought
online (i.e, smp_cpus_done() ), the system can compute a reliable set of
capabilities (arm64_features CPU capability and ELF HWCAP). This allows
system to operate safely on CPUs with differing capabilities. Any new CPU
brought up(hotplugged in) should have all the established capabilities,
failing which could be disastrous. (e.g, alternative code patched in for
a feature avaialble on the system). We add a hotplug notifier to check if
the new CPU is missing any of the advertised capabilities and prevents it
from turning online if it is.

Also consolidates the users of the feature registers, (KVM, debug, CPU
capability, ELF HWCAP, cpuinfo and CPU feature Sanity check) to make use
of the system wide safe value of the feature to make safer decisions.
As mentioned above, the calculation of the system CPU capabilities and
ELF HWCAP is delayed until smp_cpus_done() and makes use of the value
from the infrastructure. The cpu_errata capability checks still go
through each CPU and is not impacted by this series (not delayed).

At the end( Patches 19-24 ) , we add a new ABI to expose the CPU feature
registers to the user space via emulation of MRS. The system exposes only a
limited set of feature values (See the documentation patch) from the above
infrastructure. The feature bits that are not exposed are set to the 'safe
value' which implies 'not supported'.

Apart from the selected feature registers, we expose MIDR_EL1 (Main
ID Register). The user should be aware that, reading MIDR_EL1 can be
tricky on a heterogeneous system (just like getcpu()). We export the
value of the current CPU where 'MRS' is executed. REVIDR is not exposed
via MRS, since we cannot guarantee atomic access to both MIDR and REVIDR
(task migration). So they both are exposed via sysfs under :

	/sys/devices/system/cpu/cpu$ID/identification/
							\- midr
							\- revidr

The ABI useful for the toolchains (e.g, gcc, dynamic linker, JIT) to make
better runtime decisions based on what is available.

The series applies on top of aarch64 for-next/core branch and
is also available here :

	git://linux-arm.org/linux-skp.git cpu-ftr/v4-aarch64-4.3-next

Older versions:

[1] https://lkml.org/lkml/2015/7/24/152 - RFC
[2] https://lkml.org/lkml/2015/9/16/452 - V1
[3] https://lkml.org/lkml/2015/10/5/517 - V2
[4] https://lkml.org/lkml/2015/10/13/635 - V3

Changes since V3:
  - Rebased to linux-aarch64 for-next/core
  - Get rid of cpu hotplug notifiers and blocking in the
    notifier
  - Refactor check_cpu_capabilities()
  - Sort the register table at boot time
  - Delay the message from secondary processor until it turns online
  - Rename
	get_arm64_sys_reg => get_arm64_ftr_reg
	ftr_mask => arm64_ftr_mask

Changes since V2:
  - Fix build error reported by kbuild test robot
  - Don't change the encoding for sys_reg()
  - Fail the incapable CPU by cpu_die(), and mark it absent
  - Fix errno for sysfs file creation for revidr/midr. (Reported by Russell King)
  - Roll back and remove the sysfs entries if we fail to get_cpu_device()
  - Change feature type
  - Added another fix to use the per-cpu cpuinfo area after the
    area is initialised
  - Rename types and use binary search for indexing

Changes since V1:
  - Rebased to 4.3-rc4
  - Fixed patch errors reported by Dave Martin
  - Fixed build break with !CONFIG_PERF_EVENTS reported by Vladimir Murzin
  - Updated documentation on the types of features
  - Added Tested-by: James Morse for cpu capability checks

Changes since RFC:
  - Rebased to 4.3-rc1
  - Consolidate HWCAP, capability check into the new infrastructure
  - Add a new HWCAP 'cpuid' to announce the ABI
  - Pulled in Steve's patch to expose midr/revidr via sysfs
  - Changes to documentation.


Steve Capper (1):
  arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs

Suzuki K. Poulose (23):
  arm64: Make the CPU information more clear
  arm64: Delay ELF HWCAP initialisation until all CPUs are up
  arm64: Delay cpuinfo_store_boot_cpu
  arm64: Move cpu feature detection code
  arm64: Move mixed endian support detection
  arm64: Move /proc/cpuinfo handling code
  arm64: Handle width of a cpuid feature
  arm64: Keep track of CPU feature registers
  arm64: Consolidate CPU Sanity check to CPU Feature infrastructure
  arm64: Read system wide CPUID value
  arm64: Cleanup mixed endian support detection
  arm64: Refactor check_cpu_capabilities
  arm64: Delay cpu feature capability checks
  arm64/capabilities: Make use of system wide safe value
  arm64/HWCAP: Use system wide safe values
  arm64: Move FP/ASIMD hwcap handling to common code
  arm64/debug: Make use of the system wide safe value
  arm64/kvm: Make use of the system wide safe values
  arm64: Documentation - Expose CPU feature registers
  arm64: Define helper for sys_reg id manipulation
  arm64: Add helper to decode register from instruction
  arm64: cpufeature: Track the user visible fields
  arm64: Expose feature registers by emulating MRS

 Documentation/arm64/cpu-feature-registers.txt |  225 ++++++
 arch/arm64/include/asm/cpu.h                  |    5 +
 arch/arm64/include/asm/cpufeature.h           |   96 ++-
 arch/arm64/include/asm/cputype.h              |   15 -
 arch/arm64/include/asm/hw_breakpoint.h        |    9 +-
 arch/arm64/include/asm/hwcap.h                |    8 +
 arch/arm64/include/asm/insn.h                 |    2 +
 arch/arm64/include/asm/processor.h            |    2 +-
 arch/arm64/include/asm/sysreg.h               |  162 ++++-
 arch/arm64/include/uapi/asm/hwcap.h           |    1 +
 arch/arm64/kernel/cpu_errata.c                |    2 +-
 arch/arm64/kernel/cpufeature.c                |  963 ++++++++++++++++++++++++-
 arch/arm64/kernel/cpuinfo.c                   |  324 +++++----
 arch/arm64/kernel/debug-monitors.c            |    6 +-
 arch/arm64/kernel/fpsimd.c                    |   16 +-
 arch/arm64/kernel/insn.c                      |   29 +
 arch/arm64/kernel/setup.c                     |  241 +------
 arch/arm64/kernel/smp.c                       |   12 +-
 arch/arm64/kvm/reset.c                        |    2 +-
 arch/arm64/kvm/sys_regs.c                     |   12 +-
 arch/arm64/mm/fault.c                         |    2 +-
 21 files changed, 1684 insertions(+), 450 deletions(-)
 create mode 100644 Documentation/arm64/cpu-feature-registers.txt

-- 
1.7.9.5
