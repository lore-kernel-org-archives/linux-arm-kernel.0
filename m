From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Feb 2015 18:34:28 +0000
Subject: [GIT PULL] arm64 updates for 3.20
Message-ID: <20150211183428.GA21381@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patches below. The EFI changes going via the arm64
tree have been acked by Matt Fleming. There is also a patch adding
sys_*stat64 prototypes to include/linux/syscalls.h, acked by Andrew
Morton.

Thanks.

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to d476d94f180af3f0fca77394651d4a98f4df1c54:

  arm64: compat: Remove incorrect comment in compat_siginfo (2015-02-02 16:44:39 +0000)

----------------------------------------------------------------
arm64 updates for 3.20:

- reimplementation of the virtual remapping of UEFI Runtime Services in
  a way that is stable across kexec
- emulation of the "setend" instruction for 32-bit tasks (user
  endianness switching trapped in the kernel, SCTLR_EL1.E0E bit set
  accordingly)
- compat_sys_call_table implemented in C (from asm) and made it a
  constant array together with sys_call_table
- export CPU cache information via /sys (like other architectures)
- DMA API implementation clean-up in preparation for IOMMU support
- macros clean-up for KVM
- dropped some unnecessary cache+tlb maintenance
- CONFIG_ARM64_CPU_SUSPEND clean-up
- defconfig update (CPU_IDLE)

----------------------------------------------------------------
Ard Biesheuvel (10):
      arm64/mm: add explicit struct_mm argument to __create_mapping()
      arm64/mm: add create_pgd_mapping() to create private page tables
      efi: split off remapping code from efi_config_init()
      efi: efistub: allow allocation alignment larger than EFI_PAGE_SIZE
      arm64/efi: set EFI_ALLOC_ALIGN to 64 KB
      arm64/efi: move SetVirtualAddressMap() to UEFI stub
      arm64/efi: remove free_boot_services() and friends
      arm64/efi: remove idmap manipulations from UEFI code
      arm64/efi: handle potential failure to remap memory map
      arm64/efi: move virtmap init to early initcall

Catalin Marinas (10):
      Merge tag 'for-3.20' of http://git.linaro.org/people/ard.biesheuvel/linux-arm into upstream
      Merge branch 'arm64/common-esr-macros' of git://git.kernel.org/.../mark/linux
      arm64: Combine coherent and non-coherent swiotlb dma_ops
      compat: Declare compat_sys_sigpending and compat_sys_sigprocmask prototypes
      syscalls: Declare sys_*stat64 prototypes if __ARCH_WANT_(COMPAT_)STAT64
      arm64: Implement the compat_sys_call_table in C
      arm64: Remove asm/syscalls.h
      arm64: Enable CPU_IDLE in defconfig
      arm64: Fix section mismatch on alloc_init_p[mu]d()
      arm64: compat: Remove incorrect comment in compat_siginfo

Dave P Martin (1):
      arm64: Avoid breakage caused by .altmacro in fpsimd save/restore macros

Jiang Liu (1):
      smp, ARM64: Kill SMP single function call interrupt

Kevin Hao (1):
      arm64: kill off the libgcc dependency

Laura Abbott (2):
      arm64: use fixmap for text patching
      arm64: add better page protections to arm64

Lorenzo Pieralisi (1):
      arm64: kernel: remove ARM64_CPU_SUSPEND config option

Mark Rutland (14):
      arm64: remove broken cachepolicy code
      arm64: introduce common ESR_ELx_* definitions
      arm64: move to ESR_ELx macros
      arm64: decode ESR_ELx.EC when reporting exceptions
      arm64: kvm: move to ESR_ELx macros
      arm64: remove ESR_EL1_* macros
      arm64: kvm: remove ESR_EL2_* macros
      arm64: kvm: decode ESR_ELx.EC when reporting exceptions
      arm64: respect mem= for EFI
      arm64: Fix overlapping VA allocations
      arm64: mm: dump: add missing includes
      arm64: make sys_call_table const
      arm64: drop unnecessary cache+tlb maintenance
      arm64: mm: use *_sect to check for section maps

Min-Hua Chen (1):
      arm64: add ioremap physical address information

Robin Murphy (1):
      arm64: implement generic IOMMU configuration

Sudeep Holla (1):
      arm64: kernel: add support for cpu cache information

Suzuki K. Poulose (4):
      arm64: Fix SCTLR_EL1 initialisation
      arm64: Track system support for mixed endian EL0
      arm64: Consolidate hotplug notifier for instruction emulation
      arm64: Emulate SETEND for AArch32 tasks

Will Deacon (1):
      arm64: uapi: expose our struct ucontext to the uapi headers

zhichang.yuan (1):
      arm64:mm: free the useless initial page table

 Documentation/arm64/legacy_instructions.txt    |  12 +
 arch/arm64/Kconfig                             |  18 +-
 arch/arm64/Kconfig.debug                       |  23 ++
 arch/arm64/Makefile                            |   3 -
 arch/arm64/configs/defconfig                   |   2 +
 arch/arm64/include/asm/cacheflush.h            |   5 +
 arch/arm64/include/asm/cachetype.h             |  29 +-
 arch/arm64/include/asm/compat.h                |   1 -
 arch/arm64/include/asm/cpu_ops.h               |   8 +-
 arch/arm64/include/asm/cpufeature.h            |   2 +
 arch/arm64/include/asm/cpuidle.h               |   6 +
 arch/arm64/include/asm/cputype.h               |  17 ++
 arch/arm64/include/asm/dma-mapping.h           |  11 +-
 arch/arm64/include/asm/efi.h                   |  30 ++-
 arch/arm64/include/asm/esr.h                   | 117 +++++---
 arch/arm64/include/asm/fixmap.h                |   1 +
 arch/arm64/include/asm/fpsimdmacros.h          |  43 ++-
 arch/arm64/include/asm/hardirq.h               |   2 +-
 arch/arm64/include/asm/io.h                    |   5 +-
 arch/arm64/include/asm/kvm_arm.h               |  73 +----
 arch/arm64/include/asm/kvm_emulate.h           |  28 +-
 arch/arm64/include/asm/memory.h                |  10 +-
 arch/arm64/include/asm/mmu.h                   |   5 +-
 arch/arm64/include/asm/pgtable.h               |   8 +
 arch/arm64/include/asm/ptrace.h                |   7 +
 arch/arm64/include/asm/suspend.h               |   2 -
 arch/arm64/include/asm/syscalls.h              |  30 ---
 arch/arm64/include/asm/unistd.h                |   3 +
 arch/arm64/include/uapi/asm/Kbuild             |   1 +
 arch/arm64/include/{ => uapi}/asm/ucontext.h   |   8 +-
 arch/arm64/kernel/Makefile                     |   6 +-
 arch/arm64/kernel/armv8_deprecated.c           | 205 ++++++++++----
 arch/arm64/kernel/asm-offsets.c                |   2 +-
 arch/arm64/kernel/cacheinfo.c                  | 128 +++++++++
 arch/arm64/kernel/cpuidle.c                    |  20 ++
 arch/arm64/kernel/cpuinfo.c                    |  34 ++-
 arch/arm64/kernel/efi.c                        | 356 ++++++++-----------------
 arch/arm64/kernel/entry.S                      |  66 ++---
 arch/arm64/kernel/{sys32.S => entry32.S}       |  34 +--
 arch/arm64/kernel/hw_breakpoint.c              |   2 +-
 arch/arm64/kernel/insn.c                       |  47 +++-
 arch/arm64/kernel/psci.c                       |   2 -
 arch/arm64/kernel/setup.c                      |  22 +-
 arch/arm64/kernel/signal32.c                   |   7 +-
 arch/arm64/kernel/smp.c                        |  10 +-
 arch/arm64/kernel/suspend.c                    |  21 --
 arch/arm64/kernel/sys.c                        |   5 +-
 arch/arm64/kernel/sys32.c                      |  51 ++++
 arch/arm64/kernel/traps.c                      |  50 +++-
 arch/arm64/kernel/vmlinux.lds.S                |  17 +-
 arch/arm64/kvm/emulate.c                       |   5 +-
 arch/arm64/kvm/handle_exit.c                   |  39 +--
 arch/arm64/kvm/hyp.S                           |  17 +-
 arch/arm64/kvm/inject_fault.c                  |  14 +-
 arch/arm64/kvm/sys_regs.c                      |  23 +-
 arch/arm64/mm/dma-mapping.c                    | 116 ++++----
 arch/arm64/mm/dump.c                           |  30 ++-
 arch/arm64/mm/fault.c                          |   2 +-
 arch/arm64/mm/init.c                           |  25 +-
 arch/arm64/mm/ioremap.c                        |   1 +
 arch/arm64/mm/mm.h                             |   2 +
 arch/arm64/mm/mmu.c                            | 342 +++++++++++++++---------
 arch/arm64/mm/proc.S                           |  14 +-
 drivers/cpuidle/Kconfig.arm64                  |   1 -
 drivers/cpuidle/cpuidle-arm64.c                |   1 -
 drivers/firmware/efi/efi.c                     |  56 ++--
 drivers/firmware/efi/libstub/arm-stub.c        |  59 ++++
 drivers/firmware/efi/libstub/efi-stub-helper.c |  25 +-
 drivers/firmware/efi/libstub/efistub.h         |   4 +
 drivers/firmware/efi/libstub/fdt.c             |  62 ++++-
 include/linux/compat.h                         |   9 +
 include/linux/efi.h                            |   2 +
 include/linux/syscalls.h                       |   8 +-
 73 files changed, 1533 insertions(+), 919 deletions(-)
 delete mode 100644 arch/arm64/include/asm/syscalls.h
 rename arch/arm64/include/{ => uapi}/asm/ucontext.h (88%)
 create mode 100644 arch/arm64/kernel/cacheinfo.c
 rename arch/arm64/kernel/{sys32.S => entry32.S} (80%)
 create mode 100644 arch/arm64/kernel/sys32.c

-- 
Catalin
