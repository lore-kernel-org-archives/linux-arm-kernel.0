From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2016 17:12:16 +0100
Subject: [GIT PULL] arm64: updates for 4.9
Message-ID: <20160930161215.GM10184@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 updates for 4.9. I'm sending this before
the merge window actually opens, since I'm off fishing next week and
won't have internet access. Catalin will be in the office in case anything
goes wrong.

As for the changes themselves, there is a summary in the tag but it's
a bit all over the place this time with no "killer feature" to speak of.
Support for mismatched cache line sizes should help people seeing whacky
JIT failures on some SoCs, and the big.LITTLE perf updates have been a
long time coming, but a lot of the changes here are cleanups.

We stray outside arch/arm64 in a few areas: the arch/arm/ arch_timer
workaround is acked by Russell, the DT/OF bits are acked by Rob, the
arch_timer clocksource changes acked by Marc, CPU hotplug by tglx and
jump_label by Peter (all CC'd).

There are a couple of minor conflicts with mainline, due to fixes that
were merged after -rc3. I've included the resolution below, but it's
pretty straighforward.

Cheers,

Will

P.S. I've renewed my gpg key, so you may need to refetch it to see the
updated expiry date.

--->8

diff --cc arch/arm64/kernel/head.S
index 3e7b050e99dc,427f6d3f084c..000000000000
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
diff --cc drivers/perf/arm_pmu.c
index f5e1008a223d,77ac1ccb39ed..000000000000
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@@ -970,8 -990,7 +991,8 @@@ static int of_pmu_irq_cfg(struct arm_pm
  	if (cpumask_weight(&pmu->supported_cpus) == 0) {
  		int irq = platform_get_irq(pdev, 0);
  
- 		if (irq >= 0 && irq_is_percpu(irq)) {
+ 		if (irq > 0 && irq_is_percpu(irq)) {
 +			/* If using PPIs, check the affinity of the partition */
  			int ret;
  
  			ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);

--->8

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to db68f3e7594aca77632d56c449bd36c6c931d59a:

  arm64: tlbflush.h: add __tlbi() macro (2016-09-28 10:44:05 +0100)

----------------------------------------------------------------
arm64 updates for 4.9:

- Support for execute-only page permissions
- Support for hibernate and DEBUG_PAGEALLOC
- Support for heterogeneous systems with mismatches cache line sizes
- Errata workarounds (A53 843419 update and QorIQ A-008585 timer bug)
- arm64 PMU perf updates, including cpumasks for heterogeneous systems
- Set UTS_MACHINE for building rpm packages
- Yet another head.S tidy-up
- Some cleanups and refactoring, particularly in the NUMA code
- Lots of random, non-critical fixes across the board

----------------------------------------------------------------
AKASHI Takahiro (1):
      arm64: mark reserved memblock regions explicitly in iomem

Ard Biesheuvel (12):
      arm64: head.S: get rid of x25 and x26 with 'global' scope
      arm64: cpufeature: constify arm64_ftr_bits structures
      arm64: cpufeature: constify arm64_ftr_regs array
      arm64: cpufeature: expose arm64_ftr_reg struct for CTR_EL0
      arm64: kernel: fix style issues in sleep.S
      arm64: kernel: use ordinary return/argument register for el2_setup()
      arm64: head.S: move KASLR processing out of __enable_mmu()
      arm64: kernel: use x30 for __enable_mmu return address
      arm64: kernel: drop use of x24 from primary boot path
      arm64: head.S: use ordinary stack frame for __primary_switched()
      arm64: head.S: document the use of callee saved registers
      arm64: kernel: re-export _cpu_resume() from sleep.S

Catalin Marinas (3):
      arm64: Introduce execute-only page access permissions
      jump_labels: Allow array initialisers
      arm64: Use static keys for CPU features

Chris Metcalf (1):
      arm64: factor work_pending state machine to C

David A. Long (1):
      arm64: Improve kprobes test for atomic sequence

James Morse (7):
      arm64: Create sections.h
      arm64: vmlinux.ld: Add mmuoff data sections and move mmuoff text into idmap
      arm64: hibernate: Support DEBUG_PAGEALLOC
      cpu/hotplug: Allow suspend/resume CPU to be specified
      arm64: hibernate: Resume when hibernate image created on non-boot CPU
      Revert "arm64: hibernate: Refuse to hibernate if the boot cpu is offline"
      arm64: Drop generic xlate_dev_mem_{k,}ptr()

Jeremy Linton (2):
      arm64: pmu: Probe default hw/cache counters
      arm64: pmu: Hoist pmu platform device name

Jisheng Zhang (3):
      arm64: vdso: add __init section marker to alloc_vectors_page
      arm64: vdso: constify vm_special_mapping used for aarch32 vectors page
      arm64: apply __ro_after_init to some objects

Kefeng Wang (8):
      arm64: perf: Use the builtin_platform_driver
      arm64: cleanup unused UDBG_* define
      arm64: mm: drop fixup_init() and mm.h
      of_numa: Use of_get_next_parent to simplify code
      of_numa: Use pr_fmt()
      arm64: numa: Use pr_fmt()
      arm64: Kconfig: select OF/ACPI_NUMA under NUMA config
      arm64: Kconfig: remove SMP dependence for NUMA

Kim Phillips (1):
      arm64: don't select PERF_USE_VMALLOC by default

Kwangwoo Lee (1):
      arm64: mm: convert __dma_* routines to use start, size

Laura Abbott (1):
      arm64: Correctly bounds check virt_addr_valid

Marc Zyngier (1):
      drivers/perf: arm_pmu: Always consider IRQ0 as an error

Mark Rutland (19):
      arm64: hibernate: reduce TLB maintenance scope
      arm64: remove traces of perf_ops_bp
      arm64: always enable DEBUG_RODATA and remove the Kconfig option
      arm64: sysreg: allow write_sysreg to use XZR
      arm64: arch_timer: simplify accessors
      arm64: dcc: simplify accessors
      arm64/kvm: use {read,write}_sysreg()
      arm64: simplify sysreg manipulation
      arm64: simplify contextidr_thread_switch
      drivers/perf: arm_pmu: add common attr group fields
      arm64: perf: move to common attr_group fields
      arm: perf: move to common attr_group fields
      drivers/perf: arm_pmu: only use common attr_groups
      drivers/perf: arm_pmu: expose a cpumask in sysfs
      arm64: alternative: add auto-nop infrastructure
      arm64: use alternative auto-nop
      arm64/kvm: use alternative auto-nop
      arm64: fix dump_backtrace/unwind_frame with NULL tsk
      arm64: tlbflush.h: add __tlbi() macro

Mark Salter (1):
      arm64: pmu: add fallback probe table

Masahiro Yamada (1):
      arm64: remove redundant "select HAVE_CLK"

Michal Marek (1):
      arm64: Set UTS_MACHINE in the Makefile

Paul Gortmaker (1):
      arm64: migrate exception table users off module.h and onto extable.h

Pratyush Anand (2):
      arm64: kprobe: Always clear pstate.D in breakpoint exception handler
      arm64: ftrace: add save_stack_trace_regs()

Robin Murphy (2):
      arm64/io: Allow I/O writes to use {W,X}ZR
      arm64: Remove shadowed asm-generic headers

Scott Wood (3):
      arm64: arch_timer: Add device tree binding for A-008585 erratum
      arm64: arch_timer: Work around QorIQ Erratum A-008585
      arm/arm64: arch_timer: Use archdata to indicate vdso suitability

Suzuki K Poulose (9):
      arm64: Set the safe value for L1 icache policy
      arm64: Use consistent naming for errata handling
      arm64: Rearrange CPU errata workaround checks
      arm64: alternative: Disallow patching instructions using literals
      arm64: insn: Add helpers for adrp offsets
      arm64: alternative: Add support for patching adrp instructions
      arm64: Introduce raw_{d,i}cache_line_size
      arm64: Refactor sysinstr exception handling
      arm64: Work around systems with mismatched cache line sizes

Vladimir Murzin (1):
      arm64: kernel: do not need to reset UAO on exception entry

Will Deacon (9):
      arm64: errata: Pass --fix-cortex-a53-843419 to ld if workaround enabled
      arm64: debug: avoid resetting stepping state machine when TIF_SINGLESTEP
      arm64: hw_breakpoint: convert CPU hotplug notifier to new infrastructure
      arm64: debug: convert OS lock CPU hotplug notifier to new infrastructure
      arm64: debug: report TRAP_TRACE instead of TRAP_HWBRPT for singlestep
      arm64: sysreg: replace open-coded mrs_s/msr_s with {read,write}_sysreg_s
      arm64: barriers: introduce nops and __nops macros for NOP sequences
      arm64: lse: convert lse alternatives NOP padding to use __nops
      MAINTAINERS: Update ARM PMU PROFILING AND DEBUGGING entry

Zhen Lei (8):
      of/numa: remove a duplicated pr_debug information
      of/numa: fix a memory@ node can only contains one memory block
      of/numa: add nid check for memory block
      of/numa: remove a duplicated warning
      arm64/numa: avoid inconsistent information to be printed
      arm64/numa: support HAVE_SETUP_PER_CPU_AREA
      arm64/numa: remove some useless code
      arm64/numa: remove the limitation that cpu0 must bind to node0

zijun_hu (1):
      arm64: remove duplicate macro __KERNEL__ check

 Documentation/arm64/silicon-errata.txt             |   2 +
 .../devicetree/bindings/arm/arch_timer.txt         |   6 +
 Documentation/kernel-parameters.txt                |   9 +
 Documentation/static-keys.txt                      |   9 +
 MAINTAINERS                                        |   6 +-
 arch/arm/Kconfig                                   |   1 +
 arch/arm/include/asm/clocksource.h                 |   8 +
 arch/arm/kernel/perf_event_v7.c                    |  47 +++--
 arch/arm/kernel/vdso.c                             |   2 +-
 arch/arm64/Kconfig                                 |  33 ++--
 arch/arm64/Kconfig.debug                           |  10 --
 arch/arm64/Kconfig.platforms                       |   1 -
 arch/arm64/Makefile                                |  10 ++
 arch/arm64/include/asm/Kbuild                      |   5 -
 arch/arm64/include/asm/acpi.h                      |   8 +-
 arch/arm64/include/asm/alternative.h               |  70 ++++++--
 arch/arm64/include/asm/arch_timer.h                |  82 ++++++---
 arch/arm64/include/asm/assembler.h                 |  53 +++++-
 arch/arm64/include/asm/atomic_lse.h                |  64 +++----
 arch/arm64/include/asm/barrier.h                   |   3 +
 arch/arm64/include/asm/cacheflush.h                |   3 +-
 arch/arm64/include/asm/clocksource.h               |   8 +
 arch/arm64/include/asm/cmpxchg.h                   |   4 +-
 arch/arm64/include/asm/cpufeature.h                |  42 +++--
 arch/arm64/include/asm/cputype.h                   |   6 +-
 arch/arm64/include/asm/dcc.h                       |  14 +-
 arch/arm64/include/asm/esr.h                       |  84 ++++++++-
 arch/arm64/include/asm/hw_breakpoint.h             |  15 +-
 arch/arm64/include/asm/insn.h                      |  11 +-
 arch/arm64/include/asm/io.h                        |  19 +-
 arch/arm64/include/asm/kvm_mmu.h                   |  10 +-
 arch/arm64/include/asm/memory.h                    |   8 +-
 arch/arm64/include/asm/mmu_context.h               |  36 ++--
 arch/arm64/include/asm/pgtable-hwdef.h             |   1 +
 arch/arm64/include/asm/pgtable-prot.h              |   5 +-
 arch/arm64/include/asm/pgtable.h                   |  20 ++-
 arch/arm64/include/asm/processor.h                 |   2 -
 arch/arm64/include/asm/sections.h                  |  30 ++++
 arch/arm64/include/asm/spinlock.h                  |  27 ++-
 arch/arm64/include/asm/suspend.h                   |   3 +
 arch/arm64/include/asm/sysreg.h                    |  44 +++--
 arch/arm64/include/asm/system_misc.h               |   6 -
 arch/arm64/include/asm/thread_info.h               |   3 +
 arch/arm64/include/asm/tlbflush.h                  |  34 +++-
 arch/arm64/include/asm/traps.h                     |   6 +-
 arch/arm64/include/asm/virt.h                      |  15 +-
 arch/arm64/kernel/Makefile                         |   2 +
 arch/arm64/kernel/acpi_numa.c                      |   4 +-
 arch/arm64/kernel/alternative.c                    |  28 ++-
 arch/arm64/kernel/asm-offsets.c                    |   2 +
 arch/arm64/kernel/cacheinfo.c                      |   8 +-
 arch/arm64/kernel/cpu_errata.c                     |  26 ++-
 arch/arm64/kernel/cpu_ops.c                        |   3 +-
 arch/arm64/kernel/cpufeature.c                     | 137 +++++++-------
 arch/arm64/kernel/cpuinfo.c                        |   2 -
 arch/arm64/kernel/debug-monitors.c                 |  48 ++---
 arch/arm64/kernel/entry.S                          |  24 +--
 arch/arm64/kernel/head.S                           | 197 ++++++++++++---------
 arch/arm64/kernel/hibernate-asm.S                  |   6 +-
 arch/arm64/kernel/hibernate.c                      | 118 ++++++++----
 arch/arm64/kernel/hw_breakpoint.c                  |  48 ++---
 arch/arm64/kernel/insn.c                           |  15 +-
 arch/arm64/kernel/kaslr.c                          |   3 +-
 arch/arm64/kernel/perf_event.c                     | 100 ++++++++---
 arch/arm64/kernel/probes/decode-insn.c             |  48 +++--
 arch/arm64/kernel/probes/kprobes.c                 |  36 ++--
 arch/arm64/kernel/process.c                        |  14 +-
 arch/arm64/kernel/relocate_kernel.S                |   2 +-
 arch/arm64/kernel/setup.c                          |  11 +-
 arch/arm64/kernel/signal.c                         |  36 ++--
 arch/arm64/kernel/sleep.S                          |  29 ++-
 arch/arm64/kernel/smp.c                            |  14 +-
 arch/arm64/kernel/smp_spin_table.c                 |   3 +-
 arch/arm64/kernel/stacktrace.c                     |  26 ++-
 arch/arm64/kernel/suspend.c                        |  10 +-
 arch/arm64/kernel/sys_compat.c                     |   2 +-
 arch/arm64/kernel/traps.c                          |  97 ++++++----
 arch/arm64/kernel/vdso.c                           |  36 ++--
 arch/arm64/kernel/vmlinux.lds.S                    |  19 ++
 arch/arm64/kvm/hyp.S                               |   6 +-
 arch/arm64/kvm/sys_regs.c                          |  31 ++--
 arch/arm64/kvm/sys_regs_generic_v8.c               |   6 +-
 arch/arm64/lib/copy_page.S                         |  13 +-
 arch/arm64/mm/cache.S                              |  82 ++++-----
 arch/arm64/mm/dma-mapping.c                        |   9 +-
 arch/arm64/mm/extable.c                            |   2 +-
 arch/arm64/mm/fault.c                              |   7 +-
 arch/arm64/mm/flush.c                              |   2 -
 arch/arm64/mm/init.c                               |  15 +-
 arch/arm64/mm/mm.h                                 |   2 -
 arch/arm64/mm/mmu.c                                |  15 +-
 arch/arm64/mm/numa.c                               | 115 ++++++++----
 arch/arm64/mm/pageattr.c                           |  41 ++++-
 arch/arm64/mm/pgd.c                                |   2 -
 arch/arm64/mm/proc.S                               |  13 +-
 drivers/clocksource/Kconfig                        |  10 ++
 drivers/clocksource/arm_arch_timer.c               | 113 +++++++++++-
 drivers/of/of_numa.c                               |  66 +++----
 drivers/perf/arm_pmu.c                             |  35 +++-
 include/linux/cpu.h                                |   6 +-
 include/linux/cpuhotplug.h                         |   2 +
 include/linux/jump_label.h                         |  12 ++
 include/linux/perf/arm_pmu.h                       |  13 +-
 kernel/cpu.c                                       |   9 +-
 mm/mmap.c                                          |   5 +
 105 files changed, 1699 insertions(+), 972 deletions(-)
 create mode 100644 arch/arm/include/asm/clocksource.h
 create mode 100644 arch/arm64/include/asm/clocksource.h
 create mode 100644 arch/arm64/include/asm/sections.h
 delete mode 100644 arch/arm64/mm/mm.h
