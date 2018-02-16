From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 16 Feb 2018 18:29:29 +0000
Subject: [RFC PATCH 0/2] KVM: arm64: Optime FPSIMD context handling
Message-ID: <1518805771-15346-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to integrate KVM's FPSIMD context handling more
closely with the host, so that we can take advantage of better
knowledge about when the FPSIMD registers are live and whose data they
contain.

These patches are based on:

git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vhe-optimize-v4
ef09bac916ae ("KVM: arm/arm64: Avoid VGICv3 save/restore on VHE with no IRQs")

...and currently completely untested.

They do build for defconfig at least.


This is still a big hack and I may have missed something critical,
so I invite people to come and poke holes it...

Dave Martin (2):
  KVM: arm64: Convert lazy FPSIMD context switch trap to C
  KVM: arm64: Eliminate most redundant FPSIMD saves and restores

 arch/arm64/include/asm/fpsimd.h      |  1 +
 arch/arm64/include/asm/kvm_host.h    | 10 ++++++-
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/include/uapi/asm/kvm.h    | 14 +++++----
 arch/arm64/kernel/fpsimd.c           |  7 ++++-
 arch/arm64/kvm/hyp/entry.S           | 57 ++++++++++++++----------------------
 arch/arm64/kvm/hyp/switch.c          | 37 ++++++++++++++++++++---
 virt/kvm/arm/arm.c                   | 50 +++++++++++++++++++++++++++++++
 8 files changed, 130 insertions(+), 47 deletions(-)

-- 
2.1.4
