From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Nov 2017 20:11:33 +0000
Subject: [GIT PULL] arm64: updates for 4.15
Message-ID: <20171114201132.GB18699@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 updates for 4.15. As per usual, there is a
summary in the tag, but the big highlight is support for the Scalable Vector
Extension (SVE) which required extensive ABI work to ensure we don't break
existing applications by blowing away their signal stack with the rather large
new vector context (<= 2 kbit per vector register). There's further work to
be done optimising things like exception return, but the ABI is solid now.

Much of the line count comes from some new PMU drivers we have, but they're
pretty self-contained and I suspect we'll have more of them in future.

Finally, there are a few small conflicts that have been addressed in -next, but
I've also included my resolution below [1].

Cheers,

Will

[1]:

diff --cc arch/arm64/Kconfig
index 6205f52,df296b7..e6fa0f5
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -21,25 -21,8 +21,25 @@@ config ARM6
  	select ARCH_HAS_STRICT_KERNEL_RWX
  	select ARCH_HAS_STRICT_MODULE_RWX
  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
- 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
+ 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 +	select ARCH_INLINE_READ_LOCK if !PREEMPT
 +	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
 +	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPT
 +	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPT
 +	select ARCH_INLINE_READ_UNLOCK if !PREEMPT
 +	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPT
 +	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPT
 +	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPT
 +	select ARCH_INLINE_WRITE_LOCK if !PREEMPT
 +	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPT
 +	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPT
 +	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPT
 +	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPT
 +	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPT
 +	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPT
 +	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPT
  	select ARCH_USE_CMPXCHG_LOCKREF
 +	select ARCH_USE_QUEUED_RWLOCKS
  	select ARCH_SUPPORTS_MEMORY_FAILURE
  	select ARCH_SUPPORTS_ATOMIC_RMW
  	select ARCH_SUPPORTS_NUMA_BALANCING
diff --cc arch/arm64/kernel/fpsimd.c
index 5d547de,931fd8d..143b3e7
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@@ -442,6 -1296,6 +1296,6 @@@ static int __init fpsimd_init(void
  	if (!(elf_hwcap & HWCAP_ASIMD))
  		pr_notice("Advanced SIMD is not implemented\n");
  
- 	return 0;
+ 	return sve_sysctl_init();
  }
 -late_initcall(fpsimd_init);
 +core_initcall(fpsimd_init);
diff --cc drivers/acpi/arm64/iort.c
index de56394,7dc964f..95255ec
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@@ -1215,7 -1326,7 +1357,8 @@@ static void __init iort_init_platform_d
  	struct acpi_table_iort *iort;
  	struct fwnode_handle *fwnode;
  	int i, ret;
 +	bool acs_enabled = false;
+ 	const struct iort_dev_config *ops;
  
  	/*
  	 * iort_table and iort both point to the start of IORT table, but
@@@ -1235,12 -1346,8 +1378,11 @@@
  			return;
  		}
  
 +		if (!acs_enabled)
 +			acs_enabled = iort_enable_acs(iort_node);
 +
- 		if ((iort_node->type == ACPI_IORT_NODE_SMMU) ||
- 			(iort_node->type == ACPI_IORT_NODE_SMMU_V3)) {
- 
+ 		ops = iort_get_dev_cfg(iort_node);
+ 		if (ops) {
  			fwnode = acpi_alloc_fwnode_static();
  			if (!fwnode)
  				return;
diff --cc drivers/perf/Makefile
index 9402dc8,4f5815d..710a013
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@@ -1,6 -1,6 +1,7 @@@
 +# SPDX-License-Identifier: GPL-2.0
  obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
  obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+ obj-$(CONFIG_HISI_PMU) += hisilicon/
  obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o

--->8

The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 6cfa7cc46b1a7a15d81d5389c99cfca633c12b8e:

  arm64: Make ARMV8_DEPRECATED depend on SYSCTL (2017-11-13 16:05:55 +0000)

----------------------------------------------------------------
arm64 updates for 4.15

Plenty of acronym soup here:

- Initial support for the Scalable Vector Extension (SVE)
- Improved handling for SError interrupts (required to handle RAS events)
- Enable GCC support for 128-bit integer types
- Remove kernel text addresses from backtraces and register dumps
- Use of WFE to implement long delay()s
- ACPI IORT updates from Lorenzo Pieralisi
- Perf PMU driver for the Statistical Profiling Extension (SPE)
- Perf PMU driver for Hisilicon's system PMUs
- Misc cleanups and non-critical fixes

----------------------------------------------------------------
Arvind Yadav (1):
      acpi/arm64: pr_err() strings should end with newlines

Ben Hutchings (1):
      arm64: elf.h: Correct comment about READ_IMPLIES_EXEC propagation

Catalin Marinas (1):
      arm64: Implement arch-specific pte_access_permitted()

Dave Martin (30):
      arm64: asm-bug: Renumber macro local labels to avoid clashes
      regset: Add support for dynamically sized regsets
      arm64: fpsimd: Correctly annotate exception helpers called from asm
      arm64: signal: Verify extra data is user-readable in sys_rt_sigreturn
      arm64: KVM: Hide unsupported AArch64 CPU features from guests
      arm64: efi: Add missing Kconfig dependency on KERNEL_MODE_NEON
      arm64: Port deprecated instruction emulation to new sysctl interface
      arm64: fpsimd: Simplify uses of {set,clear}_ti_thread_flag()
      arm64/sve: System register and exception syndrome definitions
      arm64/sve: Low-level SVE architectural state manipulation functions
      arm64/sve: Kconfig update and conditional compilation support
      arm64/sve: Signal frame and context structure definition
      arm64/sve: Low-level CPU setup
      arm64/sve: Core task context handling
      arm64/sve: Support vector length resetting for new processes
      arm64/sve: Signal handling support
      arm64/sve: Backend logic for setting the vector length
      arm64: cpufeature: Move sys_caps_initialised declarations
      arm64/sve: Probe SVE capabilities and usable vector lengths
      arm64/sve: Preserve SVE registers around kernel-mode NEON use
      arm64/sve: Preserve SVE registers around EFI runtime service calls
      arm64/sve: ptrace and ELF coredump support
      arm64/sve: Add prctl controls for userspace vector length management
      arm64/sve: Add sysctl to set the default vector length for new processes
      arm64/sve: KVM: Prevent guests from using SVE
      arm64/sve: KVM: Treat guest SVE use as undefined instruction execution
      arm64/sve: KVM: Hide SVE from CPU features exposed to guests
      arm64/sve: Detect SVE and activate runtime support
      arm64/sve: Add documentation
      arm64: Make ARMV8_DEPRECATED depend on SYSCTL

Hanjun Guo (3):
      ACPI/IORT: Look up IORT node through struct fwnode_handle pointer
      ACPI/IORT: Enable special index ITS group mappings for IORT nodes
      ACPI/IORT: Add SMMUv3 specific special index mapping handling

James Morse (8):
      arm64: explicitly mask all exceptions
      arm64: introduce an order for exceptions
      arm64: Move the async/fiq helpers to explicitly set process context flags
      arm64: Mask all exceptions during kernel_exit
      arm64: entry.S: Remove disable_dbg
      arm64: entry.S: convert el1_sync
      arm64: entry.S convert el0_sync
      arm64: entry.S: convert elX_irq

Jason A. Donenfeld (2):
      arm64: support __int128 on gcc 5+
      arm64: Implement __lshrti3 library function

Julien Thierry (8):
      arm_arch_timer: Expose event stream status
      arm64: use WFE for long delays
      arm64: Update fault_info table with new exception types
      irqdesc: Add function to identify percpu_devid irqs
      arm/arm64: pmu: Distinguish percpu irq and percpu_devid irq
      arm64: Use existing defines for mdscr
      arm64: Fix single stepping in kernel traps
      arm64: Fix static use of function graph

Kees Cook (1):
      arm64: Always use REFCOUNT_FULL

Lorenzo Pieralisi (4):
      ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID guard
      ACPI/IORT: Improve functions return type/storage class specifier indentation
      ACPI/IORT: Make platform devices initialization code SMMU agnostic
      ACPI/IORT: Enable SMMUv3/PMCG IORT MSI domain set-up

Mark Rutland (4):
      arm64: consistently log boot/secondary CPU IDs
      arm64: docs: describe ELF hwcaps
      arm64: consistently log ESR and page table
      arm64: vdso: fix clock_getres for 4GiB-aligned res

Mark Salyzyn (1):
      arm64: Avoid aligning normal memory pointers in __memcpy_{to,from}io

Masahiro Yamada (1):
      arm64: remove unneeded copy to init_utsname()->machine

Matthieu CASTET (1):
      dma mapping : export caller to vmallocinfo

Neil Leeder (1):
      perf: qcom_l2_pmu: add event names

Nick Desaulniers (1):
      arm64: prevent regressions in compressed kernel image size when upgrading to binutils 2.27

Shaokun Zhang (7):
      drivers/perf: arm_pmu_acpi: drop redundant acpi_disabled check
      Documentation: perf: hisi: Documentation for HiSilicon SoC PMU driver
      perf: hisi: Add support for HiSilicon SoC uncore PMU driver
      perf: hisi: Add support for HiSilicon SoC L3C PMU driver
      perf: hisi: Add support for HiSilicon SoC HHA PMU driver
      perf: hisi: Add support for HiSilicon SoC DDRC PMU driver
      arm64: MAINTAINERS: hisi: Add HiSilicon SoC PMU support

Stephen Boyd (1):
      arm64: Unconditionally support {ARCH_}HAVE_NMI{_SAFE_CMPXCHG}

Suzuki K Poulose (4):
      arm64: Expose support for optional ARMv8-A features
      arm64: Fix the feature type for ID register fields
      perf: arm_spe: Prevent module unload while the PMU is in use
      arm-ccn: perf: Prevent module unload while PMU is in use

Thomas Meyer (1):
      arm64: dma-mapping: Cocci spatch "vma_pages"

Will Deacon (14):
      arm64: mm: Remove useless and wrong comments from fault.c
      Merge tag 'acpi/iort-for-v4.15' of git://git.kernel.org/.../lpieralisi/linux into aarch64/for-next/core
      genirq: export irq_get_percpu_devid_partition to modules
      perf/core: Export AUX buffer helpers to modules
      perf/core: Add PERF_AUX_FLAG_COLLISION to report colliding samples
      arm64: sysreg: Move SPE registers and PSB into common header files
      arm64: head: Init PMSCR_EL2.{PA,PCT} when entered at EL2 without VHE
      dt-bindings: Document devicetree binding for ARM SPE
      drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension
      Merge branch 'for-next/perf' into aarch64/for-next/core
      arm64: traps: Don't print stack or raw PC/LR values in backtraces
      arm64: traps: Pretty-print pstate in register dumps
      arm64: uapi: Remove PSR_Q_BIT
      arm64: Don't walk page table for user faults in do_mem_abort

Xie XiuQi (1):
      arm64: entry.S: move SError handling into a C function for future expansion

Yisheng Xie (1):
      arm64: suspend: remove useless included file

Yury Norov (2):
      arm64: move TASK_* definitions to <asm/processor.h>
      arm64: fix documentation on kernel pages mappings to HYP VA

 Documentation/arm64/cpu-feature-registers.txt     |   18 +-
 Documentation/arm64/elf_hwcaps.txt                |  160 +++
 Documentation/arm64/memory.txt                    |   10 +-
 Documentation/arm64/sve.txt                       |  508 +++++++++
 Documentation/devicetree/bindings/arm/spe-pmu.txt |   20 +
 Documentation/perf/hisi-pmu.txt                   |   53 +
 MAINTAINERS                                       |    7 +
 arch/arm/include/asm/arch_timer.h                 |    1 +
 arch/arm/include/asm/kvm_host.h                   |    3 +
 arch/arm64/Kconfig                                |   18 +-
 arch/arm64/Makefile                               |   10 +-
 arch/arm64/include/asm/arch_timer.h               |    1 +
 arch/arm64/include/asm/asm-bug.h                  |    8 +-
 arch/arm64/include/asm/assembler.h                |   51 +-
 arch/arm64/include/asm/barrier.h                  |    2 +
 arch/arm64/include/asm/cpu.h                      |    4 +
 arch/arm64/include/asm/cpucaps.h                  |    3 +-
 arch/arm64/include/asm/cpufeature.h               |   42 +
 arch/arm64/include/asm/daifflags.h                |   72 ++
 arch/arm64/include/asm/elf.h                      |    4 +-
 arch/arm64/include/asm/esr.h                      |    3 +-
 arch/arm64/include/asm/fpsimd.h                   |   71 +-
 arch/arm64/include/asm/fpsimdmacros.h             |  148 +++
 arch/arm64/include/asm/irqflags.h                 |   40 +-
 arch/arm64/include/asm/kvm_arm.h                  |    5 +-
 arch/arm64/include/asm/kvm_host.h                 |   11 +
 arch/arm64/include/asm/memory.h                   |   15 -
 arch/arm64/include/asm/pgtable.h                  |   14 +
 arch/arm64/include/asm/processor.h                |   28 +
 arch/arm64/include/asm/sysreg.h                   |  121 ++
 arch/arm64/include/asm/thread_info.h              |    5 +
 arch/arm64/include/asm/traps.h                    |    8 +
 arch/arm64/include/uapi/asm/hwcap.h               |    6 +
 arch/arm64/include/uapi/asm/ptrace.h              |  139 ++-
 arch/arm64/include/uapi/asm/sigcontext.h          |  120 +-
 arch/arm64/kernel/Makefile                        |    2 -
 arch/arm64/kernel/armv8_deprecated.c              |   23 +-
 arch/arm64/kernel/cpufeature.c                    |  204 ++--
 arch/arm64/kernel/cpuinfo.c                       |   12 +
 arch/arm64/kernel/debug-monitors.c                |    5 +-
 arch/arm64/kernel/entry-fpsimd.S                  |   17 +
 arch/arm64/kernel/entry-ftrace.S                  |   12 +-
 arch/arm64/kernel/entry.S                         |  128 ++-
 arch/arm64/kernel/fpsimd.c                        |  908 ++++++++++++++-
 arch/arm64/kernel/head.S                          |   30 +-
 arch/arm64/kernel/hibernate.c                     |    5 +-
 arch/arm64/kernel/io.c                            |   12 +-
 arch/arm64/kernel/machine_kexec.c                 |    4 +-
 arch/arm64/kernel/process.c                       |   64 +-
 arch/arm64/kernel/ptrace.c                        |  280 ++++-
 arch/arm64/kernel/setup.c                         |   15 +-
 arch/arm64/kernel/signal.c                        |  179 ++-
 arch/arm64/kernel/signal32.c                      |    2 +-
 arch/arm64/kernel/smp.c                           |   18 +-
 arch/arm64/kernel/suspend.c                       |    8 +-
 arch/arm64/kernel/traps.c                         |  109 +-
 arch/arm64/kernel/vdso/gettimeofday.S             |    2 +-
 arch/arm64/kvm/handle_exit.c                      |    8 +
 arch/arm64/kvm/hyp/debug-sr.c                     |   24 +-
 arch/arm64/kvm/hyp/switch.c                       |   12 +-
 arch/arm64/kvm/sys_regs.c                         |  292 ++++-
 arch/arm64/lib/Makefile                           |    2 +-
 arch/arm64/lib/delay.c                            |   23 +-
 arch/arm64/lib/tishift.S                          |   80 ++
 arch/arm64/mm/dma-mapping.c                       |    5 +-
 arch/arm64/mm/fault.c                             |   72 +-
 arch/arm64/mm/proc.S                              |    9 +-
 drivers/acpi/arm64/gtdt.c                         |    2 +-
 drivers/acpi/arm64/iort.c                         |  258 ++++-
 drivers/bus/arm-ccn.c                             |    1 +
 drivers/clocksource/arm_arch_timer.c              |   25 +-
 drivers/perf/Kconfig                              |   15 +
 drivers/perf/Makefile                             |    2 +
 drivers/perf/arm_pmu.c                            |   10 +-
 drivers/perf/arm_pmu_acpi.c                       |    3 -
 drivers/perf/arm_pmu_platform.c                   |    4 +-
 drivers/perf/arm_spe_pmu.c                        | 1249 +++++++++++++++++++++
 drivers/perf/hisilicon/Makefile                   |    1 +
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c     |  463 ++++++++
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c      |  473 ++++++++
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c      |  463 ++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c          |  447 ++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h          |  102 ++
 drivers/perf/qcom_l2_pmu.c                        |   54 +
 fs/binfmt_elf.c                                   |   10 +-
 include/clocksource/arm_arch_timer.h              |   10 +-
 include/linux/acpi_iort.h                         |    4 +-
 include/linux/cpuhotplug.h                        |    3 +
 include/linux/irqdesc.h                           |    8 +
 include/linux/regset.h                            |   67 +-
 include/uapi/linux/elf.h                          |    1 +
 include/uapi/linux/perf_event.h                   |    1 +
 include/uapi/linux/prctl.h                        |    9 +
 kernel/events/ring_buffer.c                       |    4 +
 kernel/irq/irqdesc.c                              |    1 +
 kernel/sys.c                                      |   12 +
 virt/kvm/arm/arm.c                                |    3 +
 97 files changed, 7399 insertions(+), 601 deletions(-)
 create mode 100644 Documentation/arm64/elf_hwcaps.txt
 create mode 100644 Documentation/arm64/sve.txt
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 Documentation/perf/hisi-pmu.txt
 create mode 100644 arch/arm64/include/asm/daifflags.h
 create mode 100644 arch/arm64/lib/tishift.S
 create mode 100644 drivers/perf/arm_spe_pmu.c
 create mode 100644 drivers/perf/hisilicon/Makefile
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h
