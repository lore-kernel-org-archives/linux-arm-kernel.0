From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:53 +0000
Subject: [PATCH 00/16] arm64 kexec kernel patches v10
Message-ID: <cover.1445297709.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series adds the core support for kexec re-boot and kdump on ARM64.  This
v10 of the series combines Takahiro's kdump patches with my kexec patches.

To load a second stage kernel and execute a kexec re-boot or to work with kdump
on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
merged upstream, are needed.

I have tested kexec with the ARM Foundation model, and Takahiro has reported
that kdump is working on the 96boards HiKey developer board.  Kexec on EFI
systems works correctly.  More ACPI + kexec testing is needed.

Patch 1 here moves the macros from proc-macros.S to asm/assembler.h so that the
dcache_line_size macro it defines can be uesd by kexec's relocate kernel
routine.

Patches 2 & 3 rework the ARM64 hcall mechanism to give the CPU reset routines
the ability to switch exception levels from EL1 to EL2 for kernels that were
entered in EL2.

Patch 4 allows KVM to handle a CPU reset.

Patches 5-7 add back the ARM64 CPU reset support that was recently removed from
the kernel.

Patches 8-10 add the actual kexec support.

Patches 11-16 add kdump support.

Please consider all patches for inclusion.

[1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
[2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git

-Geoff

The following changes since commit 7379047d5585187d1288486d4627873170d0005a:

  Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v10

for you to fetch changes up to 4cf0c03d6cd1cb4826bb5df679fbcdaf80be0b1c:

  arm64: kdump: relax BUG_ON() if more than one cpus are still active (2015-10-19 15:51:52 -0700)

----------------------------------------------------------------
AKASHI Takahiro (7):
      arm64: kvm: allows kvm cpu hotplug
      arm64: kdump: reserve memory for crash dump kernel
      arm64: kdump: implement machine_crash_shutdown()
      arm64: kdump: add kdump support
      arm64: kdump: update a kernel doc
      arm64: kdump: enable kdump in the arm64 defconfig
      arm64: kdump: relax BUG_ON() if more than one cpus are still active

Geoff Levand (9):
      arm64: Fold proc-macros.S into assembler.h
      arm64: Convert hcalls to use HVC immediate value
      arm64: Add new hcall HVC_CALL_FUNC
      arm64: Add back cpu_reset routines
      arm64: Add EL2 switch to cpu_reset
      Revert "arm64: remove dead code"
      arm64/kexec: Add core kexec support
      arm64/kexec: Add pr_devel output
      arm64/kexec: Enable kexec in the arm64 defconfig

 Documentation/kdump/kdump.txt       |  29 ++++-
 arch/arm/include/asm/kvm_host.h     |  10 +-
 arch/arm/include/asm/kvm_mmu.h      |   1 +
 arch/arm/kvm/arm.c                  |  58 +++------
 arch/arm/kvm/mmu.c                  |   5 +
 arch/arm64/Kconfig                  |  22 ++++
 arch/arm64/configs/defconfig        |   2 +
 arch/arm64/include/asm/assembler.h  |  48 +++++++-
 arch/arm64/include/asm/kexec.h      |  80 ++++++++++++
 arch/arm64/include/asm/kvm_host.h   |  16 ++-
 arch/arm64/include/asm/kvm_mmu.h    |   1 +
 arch/arm64/include/asm/mmu.h        |   1 +
 arch/arm64/include/asm/virt.h       |  49 ++++++++
 arch/arm64/kernel/Makefile          |   3 +
 arch/arm64/kernel/cpu-reset.S       |  76 ++++++++++++
 arch/arm64/kernel/cpu-reset.h       |  20 +++
 arch/arm64/kernel/crash_dump.c      |  71 +++++++++++
 arch/arm64/kernel/head.S            |   1 -
 arch/arm64/kernel/hyp-stub.S        |  43 +++++--
 arch/arm64/kernel/machine_kexec.c   | 237 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S | 163 +++++++++++++++++++++++++
 arch/arm64/kernel/setup.c           |   7 +-
 arch/arm64/kernel/smp.c             |  16 ++-
 arch/arm64/kvm/hyp-init.S           |  34 +++++-
 arch/arm64/kvm/hyp.S                |  44 +++++--
 arch/arm64/mm/cache.S               |   2 -
 arch/arm64/mm/init.c                |  83 +++++++++++++
 arch/arm64/mm/mmu.c                 |  11 ++
 arch/arm64/mm/proc-macros.S         |  64 ----------
 arch/arm64/mm/proc.S                |   3 -
 include/uapi/linux/kexec.h          |   1 +
 31 files changed, 1063 insertions(+), 138 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/cpu-reset.S
 create mode 100644 arch/arm64/kernel/cpu-reset.h
 create mode 100644 arch/arm64/kernel/crash_dump.c
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.5.0
