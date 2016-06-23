From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Jun 2016 17:54:47 +0000
Subject: [PATCH v20 00/14] arm64 kexec kernel patches
Message-ID: <cover.1466702804.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the core support for kexec re-boot and kdump on ARM64.  This
version of the series combines Takahiro's kdump patches with my kexec patches.
Please consider all patches for inclusion.

Takahiro has done some extensive testing for this version with various
configurations af endian, image format, memory options and layouts, etc.

To load a second stage kernel and execute a kexec re-boot or to work with kdump
on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
merged upstream, are needed.  Please update to the latest if you have been using
an older version.

To examine vmcore (/proc/vmcore), you should use
  - gdb v7.7 or later (only useful for non-KASLR kernel)
  - crash utility master branch (coming v7.1.6 or later)
    For crash KASLR/CONFIG_RANDOMIZE_BASE support see [3].

[1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
[2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
[3]  https://www.redhat.com/archives/crash-utility/2016-May/msg00078.html

Changes for v20 (June 23, 2016, 25m):

  o Rebase to Linux-4.7-rc4.
  o Add missing break statement in kexec_list_flush.
  o Add a check for a return value of parse_crashkernel().
  o Fix a wrong check against misalignment of allocated crash kernel region.

Changes for v19 (June 16, 2016, 25m):

  o Rebase to Linux-4.7-rc3.
  o Added more VMCOREINFO's (VA_BITS, PHYS_OFFSET).
  o Remove some unneeded included files.
  o Remove kmap() usage.
  o Remove kexec_is_dtb() routine.
  o Change #ifdef to IS_ENABLED(CONFIG_HOTPLUG_CPU).
  o Fix kexec_list_flush() to flush all list entries.
  o Use ENTRY(arm64_relocate_new_kernel).
  o Remove unused segment start in arm64_relocate_new_kernel.

Changes for v18 (June 9, 2016, 25m):

  o Rebase to Linux-4.7-rc2.
  o Change ret to br in __cpu_soft_restart().
  o Add cpu_install_idmap() call and hyp checks to cpu_soft_restart().
  o Don't return from HVC_SOFT_RESTART.

Changes for v17 (June 9, 2016, 25m):

  o Rebase to Linux-4.7-rc2.
  o Change ret to br in __cpu_soft_restart().
  o Add cpu_install_idmap() call to cpu_soft_restart().

Changes for v17 (June 3, 2016, 25m):

  o Rebase to Linux-4.7-rc1.
  o Added one VMCOREINFO parameter to vmcore for crash utility.
  o Added a check for CPUs stuck in kernel.
  o Re-implemented cpu_soft_restart() to be executed only in hyp-stub.
  o Added some kernel documentation about added device tree properties.
  o Fixed a returned value of pstate in crash_setup_regs(). Now return
    a faked pstate since we have no way to get the current pstate.

Changes for v16 (Apr 14, 2016, 23m):

  o Rebase to Linux-4.6-rc3.
  o Don't try to explicitly enter EL2 at machine_kexec() when VHE in use
  o Add unreachable() in case of ipi_cpu_crash_stop()
  o Add more "#ifdef" to eliminate code unused when !CONFIG_KEXEC_CORE
  o Fix a build error around ipi_cpu_crash_stop() when !CONFIG_HOTPLUG_CPU
  o Revert "arm64: Add new hcall HVC_CALL_FUNC"
  o Revert "Convert hcalls to use HVC immediate value"
    (replaced by James' "hyp/kvm: Extend hyp-stub API to allow function calls
     at EL2")

  Modified by James:
  o Add missing icache maintenance + isb to __kvm_hyp_reset()
  o Rework kvm cpu hotplug for VHE

  Added by James:
  o arm64: head.S: el2_setup() to accept sctlr_el1 as an argument
  o arm64: hyp/kvm: Extend hyp-stub API to allow function calls at EL2
  o arm64: kvm: Move lr save/restore from do_el2_call into EL1
  o arm64: kvm: Move the do_el2_call macro to a header file

Changes for v15 (Mar 14, 2016, 22m):

  o Rebase to Linux-4.5.
  o Remove DEBUG conditional in 'Add pr_debug output'.

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

The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:

  Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v20

for you to fetch changes up to e212cd53fdf9d09923408eb906fe0228d22432a9:

  Documentation: dt: usable-memory and elfcorehdr nodes for arm64 kexec (2016-06-23 10:01:38 -0700)

----------------------------------------------------------------
AKASHI Takahiro (7):
      arm64: kdump: reserve memory for crash dump kernel
      arm64: limit memory regions based on DT property, usable-memory
      arm64: kdump: implement machine_crash_shutdown()
      arm64: kdump: add kdump support
      arm64: kdump: add VMCOREINFO's for user-space coredump tools
      arm64: kdump: enable kdump in the arm64 defconfig
      arm64: kdump: update a kernel doc

Geoff Levand (4):
      arm64: Add back cpu reset routines
      arm64/kexec: Add core kexec support
      arm64/kexec: Enable kexec in the arm64 defconfig
      arm64/kexec: Add pr_debug output

James Morse (3):
      arm64: hibernate: Don't hibernate on systems with stuck CPUs
      arm64: smp: Add function to determine if cpus are stuck in the kernel
      Documentation: dt: usable-memory and elfcorehdr nodes for arm64 kexec

 Documentation/devicetree/bindings/chosen.txt |  28 +++
 Documentation/kdump/kdump.txt                |  15 +-
 arch/arm64/Kconfig                           |  21 ++
 arch/arm64/configs/defconfig                 |   2 +
 arch/arm64/include/asm/hardirq.h             |   2 +-
 arch/arm64/include/asm/kexec.h               |  87 ++++++++
 arch/arm64/include/asm/smp.h                 |  16 ++
 arch/arm64/include/asm/virt.h                |   5 +
 arch/arm64/kernel/Makefile                   |   3 +
 arch/arm64/kernel/cpu-reset.S                |  54 +++++
 arch/arm64/kernel/cpu-reset.h                |  34 ++++
 arch/arm64/kernel/crash_dump.c               |  71 +++++++
 arch/arm64/kernel/hibernate.c                |   6 +
 arch/arm64/kernel/hyp-stub.S                 |  10 +-
 arch/arm64/kernel/machine_kexec.c            | 288 +++++++++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S          | 130 ++++++++++++
 arch/arm64/kernel/setup.c                    |   7 +-
 arch/arm64/kernel/smp.c                      |  79 ++++++++
 arch/arm64/mm/init.c                         | 154 ++++++++++++++
 include/uapi/linux/kexec.h                   |   1 +
 20 files changed, 1009 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/cpu-reset.S
 create mode 100644 arch/arm64/kernel/cpu-reset.h
 create mode 100644 arch/arm64/kernel/crash_dump.c
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

-- 
2.5.0
