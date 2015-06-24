From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Jun 2015 17:21:58 +0100
Subject: [GIT PULL] arm64 updates for 4.2
Message-ID: <20150624162156.GA27052@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates below. Thanks.

The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 86dca36e6ba019650a94cadf922ea3d06dec0182:

  arm64: use private ratelimit state along with show_unhandled_signals (2015-06-19 16:26:15 +0100)

----------------------------------------------------------------
arm64 updates for 4.2, mostly refactoring/clean-up:

- CPU ops and PSCI (Power State Coordination Interface) refactoring
  following the merging of the arm64 ACPI support, together with
  handling of Trusted (secure) OS instances

- Using fixmap for permanent FDT mapping, removing the initial dtb
  placement requirements (within 512MB from the start of the kernel
  image). This required moving the FDT self reservation out of the
  memreserve processing

- Idmap (1:1 mapping used for MMU on/off) handling clean-up

- Removing flush_cache_all() - not safe on ARM unless the MMU is off.
  Last stages of CPU power down/up are handled by firmware already

- "Alternatives" (run-time code patching) refactoring and support for
  immediate branch patching, GICv3 CPU interface access

- User faults handling clean-up

And some fixes:

- Fix for VDSO building with broken ELF toolchains

- Fixing another case of init_mm.pgd usage for user mappings (during
  ASID roll-over broadcasting)

- Fix for FPSIMD reloading after CPU hotplug

- Fix for missing syscall trace exit

- Workaround for .inst asm bug

- Compat fix for switching the user tls tpidr_el0 register

----------------------------------------------------------------
Anders Roxell (2):
      arm64: Mark PMU interrupt IRQF_NO_THREAD
      arm64: Allow forced irq threading

Ard Biesheuvel (4):
      of/fdt: split off FDT self reservation from memreserve processing
      arm64: use fixmap region for permanent FDT mapping
      arm64: reduce ID map to a single page
      arm64: drop sleep_idmap_phys and clean up cpu_resume()

Catalin Marinas (3):
      Merge branch 'for-next/cpu-init' of git://git.kernel.org/.../arm64/linux
      Merge branch 'arm64/psci-rework' of git://git.kernel.org/.../mark/linux
      arm64: Do not attempt to use init_mm in reset_context()

Dave P Martin (1):
      arm64: mm: Fix freeing of the wrong memmap entries with !SPARSEMEM_VMEMMAP

Hou Pengyang (1):
      arm64: perf: Fix callchain parse error with kernel tracepoint events

Janet Liu (2):
      arm64: kernel thread don't need to save fpsimd context.
      arm64: fix bug for reloading FPSIMD state after CPU hotplug.

Josh Stone (1):
      arm64: fix missing syscall trace exit

Lorenzo Pieralisi (2):
      ARM64: kernel: make cpu_ops hooks DT agnostic
      ARM64: kernel: unify ACPI and DT cpus initialization

Marc Zyngier (7):
      arm64: insn: Add aarch64_{get,set}_branch_offset
      arm64: Rework alternate sequence for ARM erratum 845719
      arm64: alternative: Allow immediate branch as alternative instruction
      arm64: alternative: Merge alternative-asm.h into alternative.h
      arm64: alternative: Work around .inst assembler bugs
      arm64: alternative: Introduce feature for GICv3 CPU interface
      arm64: KVM: Switch vgic save/restore to alternative_insn

Mark Rutland (11):
      arm64: kill flush_cache_all()
      arm/arm64: kvm: add missing PSCI include
      arm64: smp_plat: add get_logical_index
      arm64: smp: consistently use error codes
      arm64: psci: remove unnecessary id indirection
      arm64: psci: support unsigned return values
      arm64: psci: account for Trusted OS instances
      arm64: psci: kill psci_power_state
      arm64: psci: remove ACPI coupling
      arm64: defconfig: enable memtest
      arm64: entry: fix context tracking for el0_sp_pc

Michal Simek (1):
      arm64: Rename temp variable in read*_relaxed()

Paul E. McKenney (1):
      arm64: Use common outgoing-CPU-notification code

Sudeep Holla (1):
      arm64: kernel: rename __cpu_suspend to keep it aligned with arm

Vladimir Murzin (4):
      arm64: mm: remove reference to tlb.S from comment block
      arm64: compat: print compat_sp instead of sp
      arm64: show unhandled SP/PC alignment faults
      arm64: use private ratelimit state along with show_unhandled_signals

Will Deacon (3):
      arm64: context-switch user tls register tpidr_el0 for compat tasks
      arm64: psci: fix !CONFIG_HOTPLUG_CPU build warning
      arm64: vdso: work-around broken ELF toolchains in Makefile

 Documentation/arm64/booting.txt          |  10 +-
 arch/arm/include/asm/kvm_host.h          |   5 -
 arch/arm/kvm/psci.c                      |   2 +
 arch/arm/mm/init.c                       |   1 +
 arch/arm64/Kconfig                       |   1 +
 arch/arm64/configs/defconfig             |   1 +
 arch/arm64/include/asm/acpi.h            |  19 +--
 arch/arm64/include/asm/alternative-asm.h |  29 ----
 arch/arm64/include/asm/alternative.h     |  46 +++++-
 arch/arm64/include/asm/boot.h            |  14 ++
 arch/arm64/include/asm/cacheflush.h      |   5 -
 arch/arm64/include/asm/cpu_ops.h         |  27 ++--
 arch/arm64/include/asm/cpufeature.h      |   8 +-
 arch/arm64/include/asm/cpuidle.h         |   8 +-
 arch/arm64/include/asm/fixmap.h          |  15 ++
 arch/arm64/include/asm/insn.h            |   3 +
 arch/arm64/include/asm/io.h              |   8 +-
 arch/arm64/include/asm/kvm_asm.h         |   5 -
 arch/arm64/include/asm/kvm_host.h        |  23 ---
 arch/arm64/include/asm/mmu.h             |   1 +
 arch/arm64/include/asm/perf_event.h      |   7 +
 arch/arm64/include/asm/proc-fns.h        |   4 -
 arch/arm64/include/asm/processor.h       |  19 ++-
 arch/arm64/include/asm/psci.h            |  12 +-
 arch/arm64/include/asm/smp.h             |   2 +-
 arch/arm64/include/asm/smp_plat.h        |  16 ++
 arch/arm64/include/asm/suspend.h         |   2 +-
 arch/arm64/include/asm/system_misc.h     |  14 +-
 arch/arm64/include/asm/tlbflush.h        |   2 -
 arch/arm64/kernel/acpi.c                 | 123 +---------------
 arch/arm64/kernel/alternative.c          |  71 ++++++++-
 arch/arm64/kernel/asm-offsets.c          |   1 -
 arch/arm64/kernel/cpu_ops.c              |  72 +++++----
 arch/arm64/kernel/cpufeature.c           |  16 ++
 arch/arm64/kernel/cpuidle.c              |  11 +-
 arch/arm64/kernel/entry.S                |  37 +++--
 arch/arm64/kernel/fpsimd.c               |  31 ++++
 arch/arm64/kernel/head.S                 |  52 +------
 arch/arm64/kernel/insn.c                 |  60 ++++++++
 arch/arm64/kernel/perf_event.c           |   2 +-
 arch/arm64/kernel/process.c              |  62 +++-----
 arch/arm64/kernel/psci.c                 | 244 ++++++++++++++++--------------
 arch/arm64/kernel/setup.c                |  37 ++---
 arch/arm64/kernel/signal32.c             |   4 +-
 arch/arm64/kernel/sleep.S                |   9 +-
 arch/arm64/kernel/smp.c                  | 246 +++++++++++++++++++++++--------
 arch/arm64/kernel/smp_spin_table.c       |   8 +-
 arch/arm64/kernel/suspend.c              |   9 +-
 arch/arm64/kernel/traps.c                |   5 +-
 arch/arm64/kernel/vdso/Makefile          |   4 +
 arch/arm64/kernel/vmlinux.lds.S          |  11 +-
 arch/arm64/kvm/hyp.S                     |  18 +--
 arch/arm64/mm/Makefile                   |   2 +
 arch/arm64/mm/cache.S                    |  75 +---------
 arch/arm64/mm/context.c                  |   8 +
 arch/arm64/mm/fault.c                    |  12 +-
 arch/arm64/mm/flush.c                    |   1 -
 arch/arm64/mm/init.c                     |   2 +-
 arch/arm64/mm/mmu.c                      |  66 +++++++++
 arch/arm64/mm/proc.S                     |  46 ------
 arch/powerpc/kernel/prom.c               |   1 +
 drivers/of/fdt.c                         |  19 ++-
 include/linux/of_fdt.h                   |   2 +
 virt/kvm/arm/vgic.c                      |   3 -
 64 files changed, 938 insertions(+), 741 deletions(-)
 delete mode 100644 arch/arm64/include/asm/alternative-asm.h
 create mode 100644 arch/arm64/include/asm/boot.h

-- 
Catalin
