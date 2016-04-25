From: james.morse@arm.com (James Morse)
Date: Mon, 25 Apr 2016 18:10:37 +0100
Subject: [PATCH v8 00/13] arm64: kernel: Add support for
 hibernate/suspend-to-disk
Message-ID: <1461604250-12789-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the latest version of hibernate for arm64, based on arm64's
for-next/core with latest commit  1dff8083a024 ("mm: replace open coded
page to virt conversion with page_to_virt()").

Patch 5 will conflict with Sudeep's cpu notifier fix that landed in rc4:
> 06a71a24bae5 ("arm64: KVM: unregister notifiers in hyp mode teardown path").
"arm64: kvm: allows kvm cpu hotplug" in this series removes the cpu hotplug
notifiers, instead depending on the notifier in core kvm code to use the
provided hardware enable/disable functions.
The resolution is to remove the cpu-hotplug notifier register and unregister
code, but leave the low power 'cpu_pm' notifier as it is after Sudeep's patch.

Resuming with a different kernel version will be rife with untested code.
(e.g. using a VHE enabled kernel to resume a non-VHE kernel). As the only
use-case is distributions allowing hibernate/resume after a kernel upgrade,
it makes sense for this to be supported by distribution kernels. (it works
provided nothing at EL2 has changed)

This series can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/v8

Changes since v7:
 * Squashed 'Prevent resume from a different kernel version' into the main patch
 * Removed el2_setup() address details from the arch-header, added the physical
   address of __hyp_stub_vectors.
 * Removed patch "el2_setup() to accept sctlr_el1 as an argument"
 * Removed el2_setup cleaning from hibernate-asm.S
 * Removed code checking hyp support is the same

 * Moved the kvm-torn-down guest entry handling into handle_exit(),
 * Added an exception type for hyp-stub to return to any kvm_call_hyp() caller
 * Removed the patch moving do_el2_call, as now kexec_reset can't use
   kvm_call_hyp() against the hyp-stub.
 * Removed comments describing 'special' x0 values for hvc in terms of PAGE_SIZE

 * Added copyright header to hibernate-asm.S
 * Split shared dsb around hibernate-asm.S PoU cleaning and icache-invalidate
 * Reworked page table copying code to use p?d_offset()
 * Removed PTRS_PER_P?D checks, using p?d_none() instead
 * Added !is_kernel_in_hyp_mode() checks to prevent el2 re-configure with VHE
 * Changed create_safe_exec_page() prototype to receive the dst_addr, instead
   of passing it back,
 * Changed the allocator prototype passed to create_safe_exec_page() to reduce
   the amount of casting.

 * Removed use of push/pop in sleep.S
 * Fixed mis-use of ENDPROC() in sleep.S
 * Removed misleading comment from suspend.c about struct mm_context being
   saved on the stack and restored after suspend. cpu_uninstall_idmap() does
   this based on current->active_mm.

 * Added kconfig depends on CPU_PM.
 * Used Lorenzo's commit message for 'Refuse to hibernate if the boot cpu...'


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


[v7] https://lwn.net/Articles/682293/
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
  arm64: hyp/kvm: Make hyp-stub extensible
  arm64: Add new asm macro copy_page

James Morse (8):
  arm64: kvm: Move lr save/restore from do_el2_call into EL1
  arm64: kernel: Rework finisher callback out of __cpu_suspend_enter()
  arm64: Change cpu_resume() to enable mmu early then access sleep_sp by
    va
  arm64: kernel: Include _AC definition in page.h
  arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
  PM / Hibernate: Call flush_icache_range() on pages restored in-place
  arm64: kernel: Add support for hibernate/suspend-to-disk
  arm64: hibernate: Refuse to hibernate if the boot cpu is offline

 arch/arm/include/asm/kvm_host.h    |  10 +-
 arch/arm/include/asm/kvm_mmu.h     |   1 +
 arch/arm/kvm/arm.c                 | 119 ++++++----
 arch/arm/kvm/mmu.c                 |   5 +
 arch/arm64/Kconfig                 |   8 +
 arch/arm64/include/asm/assembler.h | 101 +++++++-
 arch/arm64/include/asm/kvm_arm.h   |  11 -
 arch/arm64/include/asm/kvm_asm.h   |   3 +
 arch/arm64/include/asm/kvm_host.h  |  13 +-
 arch/arm64/include/asm/kvm_mmu.h   |   1 +
 arch/arm64/include/asm/memory.h    |   3 +
 arch/arm64/include/asm/page.h      |   2 +
 arch/arm64/include/asm/suspend.h   |  32 ++-
 arch/arm64/include/asm/sysreg.h    |  19 +-
 arch/arm64/include/asm/virt.h      |  16 ++
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/asm-offsets.c    |  10 +-
 arch/arm64/kernel/head.S           |   5 +-
 arch/arm64/kernel/hibernate-asm.S  | 157 +++++++++++++
 arch/arm64/kernel/hibernate.c      | 470 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  45 +++-
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 157 +++++--------
 arch/arm64/kernel/suspend.c        | 102 ++++----
 arch/arm64/kernel/vmlinux.lds.S    |  15 ++
 arch/arm64/kvm/handle_exit.c       |   7 +
 arch/arm64/kvm/hyp-init.S          |  43 +++-
 arch/arm64/kvm/hyp.S               |  11 +-
 arch/arm64/kvm/hyp/hyp-entry.S     |  10 +-
 arch/arm64/kvm/reset.c             |  14 ++
 arch/arm64/mm/cache.S              |   2 -
 arch/arm64/mm/proc-macros.S        |  98 --------
 arch/arm64/mm/proc.S               |  56 ++---
 kernel/power/swap.c                |  18 ++
 34 files changed, 1173 insertions(+), 393 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.8.0.rc3
