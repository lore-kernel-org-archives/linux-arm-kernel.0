From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 17 Nov 2017 16:38:51 +0000
Subject: [RFC PATCH 0/4] Initial KVM SVE support hacks
Message-ID: <1510936735-6762-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Throwing out an RFC here now that I've got something _sort of_ working.

This is based on the base SVE patches as now present in
torvalds/master [1], but not on Christoffer's SVE optimisations (for
now).

In a slightly older version of this code I have seen host user tasks
reaching task_fpsimd_save() with the wrong ZCR setup.  This _might_
now be fixed, but if reviewers can pay particular attention to dodgy
looking trapping control or missing context switching that would be
much appreciated!


Notes:

Currently, I grow the vcpu slab size to be large enough to accommodate
the SVE state dangling at the end, and extend the existing FPSIMD
handling paths in KVM to deal with SVE.

Guests are allowed to use SVE whenever the system supports it, and
full SVE context is tracked unconditionally for each vcpu.


The next things to decide are

 a) how broken this implementation approach is

 b) how (or whether) to enable userspace to control whether SVE is
    available to the guest and if so with what maximum vector length

 c) what the ioctl interface should look like.


Patches 1-3 contain some relevant tweaks and fixes.

Patch 4 contains the actual implementation: this is consciously a bit
of a hack today -- more detailed notes in the commit message.


[1] c9b012e5f4a1 ("Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")


Dave Martin (4):
  arm64: fpsimd: Abstract out binding of task's fpsimd context to the
    cpu.
  arm64/sve: KVM: Avoid dereference of dead task during guest entry
  arm64/sve: KVM: Ensure user SVE use traps after vcpu execution
  arm64/sve: KVM: Basic SVE support

 arch/arm64/include/asm/fpsimdmacros.h |  8 +++++
 arch/arm64/include/asm/kvm_host.h     | 30 ++++++++++++++++++
 arch/arm64/include/asm/kvm_hyp.h      |  4 +++
 arch/arm64/include/asm/sysreg.h       |  1 +
 arch/arm64/kernel/asm-offsets.c       |  8 +++++
 arch/arm64/kernel/entry-fpsimd.S      |  1 -
 arch/arm64/kernel/fpsimd.c            | 53 +++++++++++++++++++------------
 arch/arm64/kvm/handle_exit.c          |  2 +-
 arch/arm64/kvm/hyp/entry.S            | 60 ++++++++++++++++++++++++++++-------
 arch/arm64/kvm/hyp/fpsimd.S           | 12 +++++++
 arch/arm64/kvm/hyp/hyp-entry.S        |  7 ++++
 arch/arm64/kvm/hyp/switch.c           | 46 ++++++++++++++++++++++++++-
 arch/arm64/kvm/reset.c                | 18 +++++++++++
 arch/arm64/kvm/sys_regs.c             | 39 ++++++++++++++++-------
 virt/kvm/arm/arm.c                    | 18 ++++++++---
 15 files changed, 256 insertions(+), 51 deletions(-)

-- 
2.1.4
