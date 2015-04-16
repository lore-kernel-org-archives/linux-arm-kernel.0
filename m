From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Apr 2015 17:11:58 +0100
Subject: [GIT PULL] arm64: updates for 4.1
Message-ID: <20150416161158.GG25640@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the core arm64 updates for 4.1. Highlights include a significant
rework to head.S (allowing us to boot on machines with physical memory at
a really high address), an AES performance boost on Cortex-A57 and the
ability to run a 32-bit userspace with 64k pages (although this requires
said userspace to be built with a recent binutils).

The head.S rework spilt over into KVM, so there are some changes under
arch/arm/ which have been acked by Marc Zyngier (KVM co-maintainer).
In particular, the linker script changes caused us some issues in -next,
so there are a few merge commits where we had to apply fixes on top of
a stable branch.

Please pull.

Cheers,

Will

--->8

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 6d1966dfd6e0ad2f8aa4b664ae1a62e33abe1998:

  arm64: fix midr range for Cortex-A57 erratum 832075 (2015-04-01 11:12:03 +0100)

----------------------------------------------------------------
arm64 updates for 4.1:

The main change here is a significant head.S rework that allows us to
boot on machines with physical memory at a really high address without
having to increase our mapped VA range. Other changes include:

- AES performance boost for Cortex-A57
- AArch32 (compat) userspace with 64k pages
- Cortex-A53 erratum workaround for #845719
- defconfig updates (new platforms, PCI, ...)

----------------------------------------------------------------
Alexander Graf (1):
      arm64: Enable CONFIG_COMPAT also for 64k page size

Andreas Schwab (1):
      arm64: fix implementation of mmap2 compat syscall

Ard Biesheuvel (14):
      arm64/crypto: issue aese/aesmc instructions in pairs
      ARM, arm64: kvm: get rid of the bounce page
      arm64: add macros for common adrp usages
      arm64: remove processor_id
      arm64: remove __switch_data object from head.S
      arm64: use PC-relative reference for secondary_holding_pen_release
      arm64: merge __enable_mmu and __turn_mmu_on
      arm64: remove __calc_phys_offset
      arm64: enforce x1|x2|x3 == 0 upon kernel entry as per boot protocol
      ARM: kvm: implement replacement for ld's LOG2CEIL()
      arm64: mm: increase VA range of identity map
      arm64: KVM: use ID map with increased VA range if required
      ARM: kvm: assert on HYP section boundaries not actual code size
      ARM: kvm: round HYP section to page size instead of log2 upper bound

Bo Yan (1):
      arm64: fix midr range for Cortex-A57 erratum 832075

Daniel Borkmann (1):
      arm64: mm: unexport set_memory_ro and set_memory_rw

Ganapatrao Kulkarni (1):
      arm64: kconfig: increase NR_CPUS range to 2-4096.

Joe Perches (1):
      arm64: Use bool function return values of true/false not 1/0

Marc Zyngier (4):
      arm64: Get rid of struct cpu_table
      arm64: insn: Add aarch64_insn_decode_immediate
      arm64: alternative: Allow immediate branch as alternative instruction
      arm64: Extract feature parsing code from cpu_errata.c

Mark Rutland (7):
      arm64: apply alternatives for !SMP kernels
      arm64: fix hyp mode mismatch detection
      arm64: log CPU boot modes
      arm64: fixmap: make FIX_TEXT_POKE0 permanent
      arm64: fixmap: check idx is definitely valid
      arm64: head.S: ensure visibility of page tables
      arm64: head.S: ensure idmap_t0sz is visible

Peter Crosthwaite (1):
      arm64: Implement cpu_relax as yield

Steve Capper (1):
      arm64: Adjust EFI libstub object include logic

Suzuki K. Poulose (1):
      arm64: perf: reject groups spanning multiple HW PMUs

Will Deacon (8):
      arm64: proc: remove unused cpu_get_pgd macro
      Merge branch 'aarch64/kvm-bounce-page' into aarch64/for-next/core
      dt: pmu: extend ARM PMU binding to allow for explicit interrupt affinity
      arm64: pmu: add support for interrupt-affinity property
      Merge branch 'aarch64/kvm-bounce-page' into aarch64/for-next/core
      Merge branch 'aarch64/kvm-bounce-page' into aarch64/for-next/core
      arm64: defconfig: updates for 4.1
      arm64: errata: add workaround for cortex-a53 erratum #845719

 Documentation/devicetree/bindings/arm/pmu.txt |   7 +
 arch/arm/include/asm/kvm_mmu.h                |  10 +
 arch/arm/kernel/vmlinux.lds.S                 |  11 +-
 arch/arm/kvm/mmu.c                            |  69 +++----
 arch/arm64/Kconfig                            |  35 +++-
 arch/arm64/Makefile                           |   2 +-
 arch/arm64/configs/defconfig                  |  14 +-
 arch/arm64/crypto/aes-ce-ccm-core.S           |  12 +-
 arch/arm64/crypto/aes-ce.S                    |  10 +-
 arch/arm64/include/asm/assembler.h            |  48 +++++
 arch/arm64/include/asm/cpufeature.h           |  18 +-
 arch/arm64/include/asm/cputable.h             |  30 ---
 arch/arm64/include/asm/dma-mapping.h          |   2 +-
 arch/arm64/include/asm/fixmap.h               |   2 +-
 arch/arm64/include/asm/insn.h                 |   1 +
 arch/arm64/include/asm/kvm_mmu.h              |  33 ++++
 arch/arm64/include/asm/mmu_context.h          |  43 +++++
 arch/arm64/include/asm/page.h                 |   6 +-
 arch/arm64/include/asm/pgtable-hwdef.h        |   7 +-
 arch/arm64/include/asm/pmu.h                  |   1 +
 arch/arm64/include/asm/proc-fns.h             |   9 -
 arch/arm64/include/asm/processor.h            |   6 +-
 arch/arm64/include/asm/smp_plat.h             |   2 +
 arch/arm64/include/asm/unistd32.h             |   2 +-
 arch/arm64/kernel/Makefile                    |   4 +-
 arch/arm64/kernel/alternative.c               |  55 +++++-
 arch/arm64/kernel/asm-offsets.c               |   4 -
 arch/arm64/kernel/cpu_errata.c                |  47 ++---
 arch/arm64/kernel/cpufeature.c                |  47 +++++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/cputable.c                  |  33 ----
 arch/arm64/kernel/entry.S                     |  20 ++
 arch/arm64/kernel/entry32.S                   |  18 ++
 arch/arm64/kernel/head.S                      | 261 +++++++++-----------------
 arch/arm64/kernel/insn.c                      |  81 ++++++--
 arch/arm64/kernel/perf_event.c                |  78 +++++++-
 arch/arm64/kernel/setup.c                     |  55 ++++--
 arch/arm64/kernel/smp.c                       |   3 +-
 arch/arm64/kernel/sys32.c                     |   1 +
 arch/arm64/kernel/vmlinux.lds.S               |  17 +-
 arch/arm64/kvm/hyp-init.S                     |  25 +++
 arch/arm64/mm/mmu.c                           |  12 +-
 arch/arm64/mm/pageattr.c                      |   2 -
 arch/arm64/mm/proc-macros.S                   |  10 +
 arch/arm64/mm/proc.S                          |   3 +
 45 files changed, 748 insertions(+), 409 deletions(-)
 delete mode 100644 arch/arm64/include/asm/cputable.h
 create mode 100644 arch/arm64/kernel/cpufeature.c
 delete mode 100644 arch/arm64/kernel/cputable.c
