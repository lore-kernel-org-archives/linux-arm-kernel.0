From: james.morse@arm.com (James Morse)
Date: Wed, 27 Apr 2016 17:46:59 +0100
Subject: [PATCH v9 00/14] arm64: kernel: Add support for
 hibernate/suspend-to-disk
Message-ID: <1461775633-29715-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the today's version of hibernate for arm64, based on arm64's
for-next/core with latest commit 6a1f54711447 ("arm64: acpi: add acpi=on
cmdline option to prefer ACPI boot over DT").

Patch 6 will conflict with Sudeep's cpu notifier fix that landed in rc4:
> 06a71a24bae5 ("arm64: KVM: unregister notifiers in hyp mode teardown path").
"arm64: kvm: allows kvm cpu hotplug" in this series removes the cpu hotplug
notifiers, instead depending on the notifier in core kvm code to use the
provided hardware enable/disable functions.
The resolution is to remove the cpu-hotplug notifier register and unregister
code, but leave the low power 'cpu_pm' notifier as it is after Sudeep's patch.

This series can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/v9

Changes since v8:
 * Moved hyp-gone code out from 'arm64: kvm: allows kvm cpu hotplug'

 * Added break before make to the two ttbr1 switches in hibernate-asm.S
 * Added comments to hibernate-asm.S about where this executes from, and where
 * its data is
 * Removed comments referring to el2_setup() (missed from previous version)

 * Replaced set_p?d() for p?d_populate() equivalents
 * Added isb to create_safe_exec_page() switch
 * Replaced more p?d_val()s with p?d_none()
 * Added comment about masking out RDONLY bit
 * Wrapped get_safe_page() calls with p?d_none() to avoid leaking memory if
   these levels are merged.


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


[v8] http://www.spinics.net/lists/arm-kernel/msg499992.html
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

James Morse (9):
  arm64: kvm: Move lr save/restore from do_el2_call into EL1
  arm64: hyp/kvm: Make hyp-stub reject kvm_call_hyp()
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
 arch/arm/kvm/arm.c                 | 119 +++++----
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
 arch/arm64/kernel/hibernate-asm.S  | 176 ++++++++++++++
 arch/arm64/kernel/hibernate.c      | 487 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       |  45 +++-
 arch/arm64/kernel/setup.c          |   1 -
 arch/arm64/kernel/sleep.S          | 157 +++++-------
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
 34 files changed, 1209 insertions(+), 393 deletions(-)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.8.0.rc3
