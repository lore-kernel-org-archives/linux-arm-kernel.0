From: geoff@infradead.org (Geoff Levand)
Date: Fri, 04 Mar 2016 23:51:14 +0000
Subject: [PATCH v14 00/20] arm64 kexec kernel patches v14
Message-ID: <cover.1457135058.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the core support for kexec re-boot and kdump on ARM64.  This
version of the series combines Takahiro's kdump patches with my kexec patches.
Please consider all patches for inclusion.

To load a second stage kernel and execute a kexec re-boot or to work with kdump
on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
merged upstream, are needed.  Please update to the latest if you have been using
an older version.

To examine vmcore (/proc/vmcore), you should use
  - gdb v7.7 or later
  - crash v7.1.1 or later

[1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
[2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git

Changes for v14 (Mar 4, 2016, 22m):

  o Rebase to Linux-4.5-rc6.
  o Rename setup_mm_for_reboot to cpu_install_idmap.
  o kdump: leave non-boot cpus online at crash dump
    As we don't have to make non-boot (crashed) cpus offline at crash dump,
    this patch adds a variant of smp_send_stop().
  o kdump: use a new device-tree property, "linux,elfcorehdr", instead of
    traditional "elfcorehdr=" kernel parameter
  o limit memory regions based on DT property, "usable-memory", instead of
    "mem=" kernel parameter
  o kdump: fix a build error when !CONFIG_KEXEC_CORE
  o kvm: use generic kvm_call_hyp() interface instead of kvm_cpu_reset()
  o kvm: initialize only a primary cpu at init_hyp_mode()

Changes for v13 (Jan 15, 2016, 20m):

  o Rebase to Linux-4.4.
  o Remove align directive from cpu_reset.c.
  o Use inline C wrapper for cpu_soft_restart.
  o Revert the new image d-cache flush changes of v10.
  o Add SCTLR cleanup patch.
  o Change pr_devel to pr_debug.
  o Call flush_icache_range() for reboot_code_buffer.
  o Add .ltorg directive to arm64_relocate_new_kernel.
  o Make new asm macro copy_page.
  o Change cache maintenence from inner-shareable to non-shareable.
  o Rename KEXEC_ARCH_ARM64 to KEXEC_ARCH_AARCH64.

  o arm64: kvm: allows kvm cpu hotplug
    - remove some garbage code from kvm_host.h
  o arm64: kdump: reserve memory for crash dump kernel
    - change CONFIG_KEXEC to CONFIG_KEXEC_CORE
    - don't panic on crash kernel alloc failure
      (thanks to Mark Salter, RH)
  o arm64: kdump: implement machine_crash_shutdown()
    - change "boot/non-boot cpu" to "crashing/non-crashing cpu"
    - introduce is_in_crash_kexec() for readability
    - re-introduce machine_kexec_mask_interrupts(), as arch/arm has,
      to discard unexpected interrupts
    - call crash_save_cpu() before making cpus offline to avoid a possible race
      (thanks to Pratyush Anand/Mark Salter, RH)
  o arm64: kdump: update a kernel doc
    - clarify that we support "Image" format as well as vmlinux in kdump.txt
  o arm64: kdump: relax BUG_ON() if more than one cpus are still active
    - change a warning message at the failure of shooting down non-crahsing cpus

Changes for v12 (Nov 24, 2015, 18m):

  o No changes, rebase to Linux-4.4-rc2.

Changes for v11 (Nov 6, 2015, 18m):

  o Rebase to Linux-4.3.
  o Move the new image d-cache flush from arm64_relocate_new_kernel to machine_kexec.
  o Pass values to arm64_relocate_new_kernel in registers, not in global variables.
  o Fixups to setting the sctlr_el1 and sctlr_el2 flags.

Changes for v10 (Oct 18, 2015, 17m):

  o Rebase to Linux-4.3-rc6.
  o Move tcr_set_idmap_t0sz to assembler.h.
  o Add back simplified cpu_reset routines.
  o Combine kexec + kdump patches.

Changes for v9 (Apr 7, 2015, 11m):

  o Use new upstream flag IND_FLAGS.

Changes for v8 (Mar 19, 2015, 10m):

  o Rebase to Linux-4.0-rc4.
  o Re-boot using purgatory only.

Changes for v7 (Jan 16, 2015, 8m):

  o Rebase to Linux-3.19-rc4.
  o Change from ESR_EL2_ to ESR_ELx_.
  o Remove work-arounds for EFI systems.
  
Changes for v6 (Dec 2, 2014, 7m):

  o Rebase to Linux-3.18-rc2

Changes for v5 (Nov 16, 2014, 6m):

Changes for v4 (Oct 3, 2014, 5m):

Changes for v3 (Sept 23, 2014, 4m):

Changes for v2 (Sep 9, 2014, 4m):

  o Rebase to Linux-3.17-rc4.
  o Move macros from proc-macros.S to assembler.h.
  o Convert hcalls to use ISS field.
  o Add new hcall HVC_CALL_FUNC.
  o Add EL2 switch to soft_restart.

First submission v1 (May 13, 2014):

  o Based on Linux-3.15-rc4.

-Geoff

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v14

for you to fetch changes up to b434c117ad29c98c7a3b9b36a52dc2f93f6aab99:

  arm64: kdump: update a kernel doc (2016-03-04 12:25:15 -0800)

----------------------------------------------------------------
AKASHI Takahiro (7):
      arm64: kvm: allows kvm cpu hotplug
      arm64: kdump: reserve memory for crash dump kernel
      arm64: limit memory regions based on DT property, usable-memory
      arm64: kdump: implement machine_crash_shutdown()
      arm64: kdump: add kdump support
      arm64: kdump: enable kdump in the arm64 defconfig
      arm64: kdump: update a kernel doc

Geoff Levand (11):
      arm64: Fold proc-macros.S into assembler.h
      arm64: Cleanup SCTLR flags
      arm64: Convert hcalls to use HVC immediate value
      arm64: Add new hcall HVC_CALL_FUNC
      arm64: Add new asm macro copy_page
      arm64: Add back cpu_reset routines
      Revert "arm64: mm: remove unused cpu_set_idmap_tcr_t0sz function"
      Revert "arm64: remove dead code"
      arm64/kexec: Add core kexec support
      arm64/kexec: Enable kexec in the arm64 defconfig
      arm64/kexec: Add pr_debug output

James Morse (2):
      arm64: kernel: Include _AC definition in page.h
      arm64: Promote KERNEL_START/KERNEL_END definitions to a header file

 Documentation/kdump/kdump.txt        |  15 +-
 arch/arm/include/asm/kvm_host.h      |  10 +-
 arch/arm/include/asm/kvm_mmu.h       |   1 +
 arch/arm/kvm/arm.c                   | 104 ++++++++-----
 arch/arm/kvm/mmu.c                   |   5 +
 arch/arm64/Kconfig                   |  21 +++
 arch/arm64/configs/defconfig         |   2 +
 arch/arm64/include/asm/assembler.h   | 101 ++++++++++++-
 arch/arm64/include/asm/hardirq.h     |   2 +-
 arch/arm64/include/asm/kexec.h       |  82 +++++++++++
 arch/arm64/include/asm/kvm_arm.h     |  11 --
 arch/arm64/include/asm/kvm_asm.h     |   1 +
 arch/arm64/include/asm/kvm_host.h    |  12 +-
 arch/arm64/include/asm/kvm_mmu.h     |   1 +
 arch/arm64/include/asm/memory.h      |   3 +
 arch/arm64/include/asm/mmu.h         |   1 +
 arch/arm64/include/asm/mmu_context.h |  35 +++--
 arch/arm64/include/asm/page.h        |   2 +
 arch/arm64/include/asm/smp.h         |   5 +
 arch/arm64/include/asm/sysreg.h      |  19 ++-
 arch/arm64/include/asm/virt.h        |  40 +++++
 arch/arm64/kernel/Makefile           |   3 +
 arch/arm64/kernel/cpu-reset.S        |  57 ++++++++
 arch/arm64/kernel/cpu-reset.h        |  29 ++++
 arch/arm64/kernel/crash_dump.c       |  71 +++++++++
 arch/arm64/kernel/head.S             |   3 -
 arch/arm64/kernel/hyp-stub.S         |  49 +++++--
 arch/arm64/kernel/machine_kexec.c    | 273 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S  | 131 +++++++++++++++++
 arch/arm64/kernel/setup.c            |   7 +-
 arch/arm64/kernel/smp.c              |  56 +++++++
 arch/arm64/kvm/hyp-init.S            |  47 +++++-
 arch/arm64/kvm/hyp.S                 |   3 +-
 arch/arm64/kvm/hyp/hyp-entry.S       |   9 +-
 arch/arm64/kvm/reset.c               |  14 ++
 arch/arm64/mm/cache.S                |   2 -
 arch/arm64/mm/init.c                 | 151 +++++++++++++++++++
 arch/arm64/mm/mmu.c                  |  11 ++
 arch/arm64/mm/proc-macros.S          |  98 -------------
 arch/arm64/mm/proc.S                 |   3 -
 include/uapi/linux/kexec.h           |   1 +
 41 files changed, 1294 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/cpu-reset.S
 create mode 100644 arch/arm64/kernel/cpu-reset.h
 create mode 100644 arch/arm64/kernel/crash_dump.c
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.5.0
