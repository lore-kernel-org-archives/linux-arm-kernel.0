From: james.morse@arm.com (James Morse)
Date: Fri,  1 Apr 2016 17:53:24 +0100
Subject: [PATCH v7 00/16] arm64: kernel: Add support for
 hibernate/suspend-to-disk
Message-ID: <1459529620-22150-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the latest version of hibernate for arm64, based on v4.6-rc1.

Patch 1 was sent as a fix for KVM [0]. It is included here to avoid conflicts
with patch 7 ("arm64: kvm: allows kvm cpu hotplug") after rc2.

After feedback on Kexec's 'arm64: Convert hcalls to use HVC immediate value'
[1], I've merged two of those patches and kept the call-number/function-pointer
in x0 convention and use of 'hvc #0'. The result is patch 6.
It looks like there are no registers that are safe for the hyp-stub to keep
values in, so I've moved the lr save/restore to wrap the 'hvc' call in EL1.
(patches 4 and 5).

Patch 7 conflicted with the VHE changes, the main change is now the
hardware enable/disable calls that used to wrap the gic setup code on one
cpu, now wraps everything in init_subsystems() and runs on all cpus. This
is needed by 0d98d00b8d80 ('arm64: KVM: vgic-v3: Reset LRs at boot time'),
which expects KVM to be initialised on all cpus when it runs.

Patch 8 (arm64: kernel: Rework finisher callback out of __cpu_suspend_enter())
and later are just a straight rebase.

This series can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/v7

[0] http://www.spinics.net/lists/arm-kernel/msg494214.html
[1] http://www.spinics.net/lists/arm-kernel/msg490781.html

Changes since v6:
 * Rebase on v4.6-rc1
 * Merged hcall patches, changed to keep switch on x0,
 * allow lr to be clobbered by hvc calls
 * Added missing icache maintenance + isb from __kvm_hyp_reset()

Changes since v5:
 * Call el2_setup() from hibernate's assembly code
 * Use UTS_VERSION to catch hibernate/resume with different builds

Changes since v4:
 * Mask in current T0SZ bits when restoring tcr_el1.
 * Use el2_setup() to reconfigure el2.
 * Remove fiq calls.
 * Removed kvm_arch_hardware_disable() call.
 * Added 'in_suspend = 0' to avoid 'if (uninitialised-memory) ...'.
 * Removed icache-flush from hibernate-asm.S, this was done in hibernate.c.
 * Commented tlbis.
 * Removed dsb after copy_page(), this behaviour is guaranteed by the
   architecture.

Changes since v3:
 * To work with kaslr:
   * hibernate now uses the arch-header to store the address of the page
     tables, and the point to re-enter the resumed kernel.
   * The el2 vectors are reloaded to point to the 'safe' page, then back to the
     resumed kernel.
   * PoC cleaning is done after the jump to the resumed kernel, as we don't
     know the restored kernel's boundaries in advance.
   * Some variables are accessed via aliases in the linear map, as the kernel
     text is not mapped during resume. restore_pblist is one example.
   * Execute the safe page from the bottom of memory, not the top, so that we
     can restore the resumed kernel's page tables directly.

 * Rebased the common patches onto v13 of kexec
 * Changed hibernate-asm.S to use the new copy_page macro.
 * Changed copy_p?d()s to use the do { } while(); pattern.
 * Added some missing barriers. (dsb after ic ialluis).

Changes since v2:
 * Rewrote restore in-place patch - we can't clean pages in copy_page(), we
   need to publish a list for the architecture to clean
 * Added missing pgprot_val() in hibernate.c, spotted by STRICT_MM_TYPECHECKS
 * Removed 'tcr_set_idmap_t0sz' from proc.S - I missed this when rebase-ing
 * Re-imported the first four patches from kexec v12
 * Rebased onto v4.4-rc2
 * Changes from Pavel Machek's comments

Changes since v1:
 * Removed for_each_process(){ for_each_vma() { } }; cache cleaning, replaced
   with icache_flush_range() call in core hibernate code
 * Rebased onto conflicting tcr_ek1.t0sz bug-fix patch

[v6] http://www.spinics.net/lists/arm-kernel/msg487467.html
[v5] http://www.spinics.net/lists/arm-kernel/msg483595.html
[v4] http://www.spinics.net/lists/arm-kernel/msg477769.html
[v3] http://www.spinics.net/lists/arm-kernel/msg463590.html
[v2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html
[v1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376450.html


AKASHI Takahiro (1):
  arm64: kvm: allows kvm cpu hotplug

Geoff Levand (4):
  arm64: Fold proc-macros.S into assembler.h
  arm64: Cleanup SCTLR flags
  arm64: hyp/kvm: Extend hyp-stub API to allow function calls at EL2
  arm64: Add new asm macro copy_page

James Morse (11):
  arm64: KVM: Register CPU notifiers when the kernel runs at HYP
  arm64: kvm: Move the do_el2_call macro to a header file
  arm64: kvm: Move lr save/restore from do_el2_call into EL1
  arm64: kernel: Rework finisher callback out of __cpu_suspend_enter().
  arm64: Change cpu_resume() to enable mmu early then access sleep_sp by
    va
  arm64: kernel: Include _AC definition in page.h
  arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
  arm64: head.S: el2_setup() to accept sctlr_el1 as an argument
  PM / Hibernate: Call flush_icache_range() on pages restored in-place
  arm64: kernel: Add support for hibernate/suspend-to-disk
  arm64: hibernate: Prevent resume from a different kernel version

 arch/arm/include/asm/kvm_host.h    |  10 +-
 arch/arm/include/asm/kvm_mmu.h     |   1 +
 arch/arm/kvm/arm.c                 | 148 +++++++-----
 arch/arm/kvm/mmu.c                 |   5 +
 arch/arm64/Kconfig                 |   7 +
 arch/arm64/include/asm/assembler.h | 111 ++++++++-
 arch/arm64/include/asm/kvm_arm.h   |  11 -
 arch/arm64/include/asm/kvm_asm.h   |   1 +
 arch/arm64/include/asm/kvm_host.h  |  13 +-
 arch/arm64/include/asm/kvm_mmu.h   |   1 +
 arch/arm64/include/asm/memory.h    |   3 +
 arch/arm64/include/asm/page.h      |   2 +
 arch/arm64/include/asm/suspend.h   |  32 ++-
 arch/arm64/include/asm/sysreg.h    |  19 +-
 arch/arm64/include/asm/virt.h      |  30 ++-
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |  10 +-
 arch/arm64/kernel/head.S           |  24 +-
 arch/arm64/kernel/hibernate-asm.S  | 166 +++++++++++++
 arch/arm64/kernel/hibernate.c      | 478 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  43 +++-
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 155 +++++-------
 arch/arm64/kernel/suspend.c        |  96 ++++----
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/hyp-init.S          |  43 +++-
 arch/arm64/kvm/hyp.S               |  11 +-
 arch/arm64/kvm/hyp/hyp-entry.S     |  23 +-
 arch/arm64/kvm/reset.c             |  14 ++
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  98 --------
 arch/arm64/mm/proc.S               |  56 ++---
 kernel/power/swap.c                |  18 ++
 33 files changed, 1236 insertions(+), 412 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.8.0.rc3
