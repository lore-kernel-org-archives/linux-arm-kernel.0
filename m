From: Dave.Martin@arm.com (Dave Martin)
Date: Fri,  6 Apr 2018 16:01:01 +0100
Subject: [RFC PATCH v2 0/3] KVM: arm64: Optimise FPSIMD context switching
Message-ID: <1523026864-15413-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a respin of my attempt to improve FPSIMD context handling for
KVM, building on the previous RFC [1].

These patches are based on torvalds/master, but it should be sufficient
to cherry-pick commit 20b8547277a6 ("arm64: fpsimd: Split cpu field out
from struct fpsimd_state") onto v4.16.

See the individual patches for detailed explanation.

Some things (still) definitely aren't right yet:

 * Handling of the host SVE state is incomplete: the Hyp code still
   needs to be taught how to save back the host SVE state in the right
   place.  This will eliminate redundant work in some scenarios and
   obviate the need for sve_flush_cpu_state().

   As such, this series breaks the kernel for CONFIG_ARM64_SVE=y.

   Nevertheless, this series gets the code into a shape where fixing
   host SVE handling should be relatively straightforward.  I will
   follow up with patches to sort that out.

 * TIF_SVE is probably not set/cleared in exactly the correct places
   (not tested/exercised, because SVE in general doesn't work here yet).

 * task_fpsimd_save() now appears misnamed, but in lieu of having
   decided on a better name I've just exported this function from
   fpsimd.c for now.

I did try to come up with a diagram to explain the context switching
flow in the final patch, but it proved hard (sorry Marc).  I'm open to
suggestions, but the best option for now is to go look at the code
(which is now in a much cleaner state).

Somewhat tested on the ARM Fast model (with and without VHE) and Juno r0
(non-VHE ... until the firmware bricked itself, but I'm pretty sure that
was unrelated).

Any comments, testing, benchmarks appreciated!

Cheers
---Dave

[1] [RFC PATCH 0/4] KVM: arm64: Optimise FPSIMD context switching
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/567958.html


Christoffer Dall (1):
  KVM: arm/arm64: Introduce kvm_arch_vcpu_run_pid_change

Dave Martin (2):
  KVM: arm64: Convert lazy FPSIMD context switch trap to C
  KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing

 arch/arm/include/asm/kvm_host.h   |  8 +++++
 arch/arm64/include/asm/fpsimd.h   |  5 ++++
 arch/arm64/include/asm/kvm_host.h | 18 ++++++++++++
 arch/arm64/kernel/fpsimd.c        | 31 +++++++++++++++-----
 arch/arm64/kvm/Kconfig            |  1 +
 arch/arm64/kvm/Makefile           |  2 +-
 arch/arm64/kvm/hyp/entry.S        | 57 ++++++++++++++---------------------
 arch/arm64/kvm/hyp/switch.c       | 62 +++++++++++++++++++++++++++++++--------
 include/linux/kvm_host.h          |  9 ++++++
 virt/kvm/Kconfig                  |  3 ++
 virt/kvm/arm/arm.c                |  4 +++
 virt/kvm/kvm_main.c               |  7 ++++-
 12 files changed, 150 insertions(+), 57 deletions(-)

-- 
2.1.4
