From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:20:58 +0100
Subject: [PATCH 00/22] arm64: Consolidate CPU feature handling
Message-ID: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This is an updated reincarnation of my "arm64: Expose CPU feature registers"
series [1], which does much more.

This series introduces a new infrastructure to keep track of the CPU
feature registers on ARMv8-A for arm64 kernel. It provides the safe value
of a CPU feature register across all the CPUs on (a heterogeneous) system.
The infrastructure checks the individual CPU feature registers as they are
brought online (during system boot up) and udpates the status of each of
the feature bits across the system. Once all the active CPUs are brought online
(i.e, smp_cpus_done() ), the system can compute a reliable set of capabilities
(arm64_features CPU capability and ELF HWCAP). This allows system to operate
safely on CPUs with differing capabilities. Any new CPU brought up(hotplugged in)
should have all the established capabilities, failing which could be disastrous.
(e.g, alternative code patched in for a feature avaialble on the system). We
add a hotplug notifier to check if the new CPU is missing any of the advertised
capabilities and prevents it from turning online if it is.

Also consolidates the users of the feature registers, (KVM, debug, CPU capability,
ELF HWCAP, cpuinfo and CPU feature Sanity chec) to make use of the system wide
safe value of the feature to make safer decisions. As mentioned above, the
calculation of the system CPU capabilities and ELF HWCAP is delayed until
smp_cpus_done() and makes use of the value from the infrastructure. The cpu_errata
capability checks still go through each CPU and is not impacted by this series
(not delayed).

At the end, we add a new ABI to expose the CPU feature registers to the user
space via emulation of MRS. The system exposes only a limited set
of feature values (See the documentation patch) from the above infrastructure.
The feature bits that are not exposed are set to the 'safe value' which implies
'not supported'.

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

[1] RFC post : https://lkml.org/lkml/2015/7/24/152

---
Changes since V1:
  - Rebased to 4.3-rc1
  - Consolidate HWCAP, capability check into the new infrastructure
  - Add a new HWCAP 'cpuid' to announce the ABI
  - Pulled in Steve's patch to expose midr/revidr via sysfs
  - Changes to documentation.

Steve Capper (1):
  arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs

Suzuki K. Poulose (21):
  arm64: Make the CPU information more clear
  arm64: Delay ELF HWCAP initialisation until all CPUs are up
  arm64: Move cpu feature detection code
  arm64: Move mixed endian support detection
  arm64: Move /proc/cpuinfo handling code
  arm64: sys_reg: Define System register encoding
  arm64: Keep track of CPU feature registers
  arm64: Consolidate CPU Sanity check to CPU Feature infrastructure
  arm64: Read system wide CPUID value
  arm64: Cleanup mixed endian support detection
  arm64: Populate cpuinfo after notify_cpu_starting
  arm64: Delay cpu feature checks
  arm64: Make use of system wide capability checks
  arm64: Cleanup HWCAP handling
  arm64: Move FP/ASIMD hwcap handling to common code
  arm64/debug: Make use of the system wide safe value
  arm64/kvm: Make use of the system wide safe values
  arm64: Add helper to decode register from instruction
  arm64: cpufeature: Track the user visible fields
  arm64: Expose feature registers by emulating MRS
  arm64: feature registers: Documentation

 Documentation/arm64/cpu-feature-registers.txt |  209 ++++++
 arch/arm64/include/asm/cpu.h                  |    1 +
 arch/arm64/include/asm/cpufeature.h           |   76 +-
 arch/arm64/include/asm/cputype.h              |   15 -
 arch/arm64/include/asm/hw_breakpoint.h        |   14 +-
 arch/arm64/include/asm/hwcap.h                |    8 +
 arch/arm64/include/asm/insn.h                 |    2 +
 arch/arm64/include/asm/processor.h            |    2 +-
 arch/arm64/include/asm/sysreg.h               |  177 ++++-
 arch/arm64/include/uapi/asm/hwcap.h           |    1 +
 arch/arm64/kernel/cpufeature.c                |  922 ++++++++++++++++++++++++-
 arch/arm64/kernel/cpuinfo.c                   |  305 ++++----
 arch/arm64/kernel/debug-monitors.c            |    6 +-
 arch/arm64/kernel/fpsimd.c                    |   16 +-
 arch/arm64/kernel/hw_breakpoint.c             |   19 +-
 arch/arm64/kernel/insn.c                      |   29 +
 arch/arm64/kernel/setup.c                     |  233 +------
 arch/arm64/kernel/smp.c                       |   12 +-
 arch/arm64/kvm/reset.c                        |    2 +-
 arch/arm64/kvm/sys_regs.c                     |   12 +-
 arch/arm64/mm/fault.c                         |    2 +-
 21 files changed, 1605 insertions(+), 458 deletions(-)
 create mode 100644 Documentation/arm64/cpu-feature-registers.txt

-- 
1.7.9.5
