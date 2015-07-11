From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 10 Jul 2015 18:19:05 -0700
Subject: [PATCH v4 0/2] arm/arm64: KVM: Optimize arm64 fp/simd,
 saves 30-50% on exits for non-VHE
Message-ID: <1436577547-5646-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followp to previous iteration but implemented on top of VHE patches. 
Only non-VHE path is addressied by this patch. In second patch 32-bit handler 
is updated to keep exit handling consistent with 64-bit code, and nothing
has changed.

Currently we save/restore fp/simd on each exit, the first  patch optimizes 
arm64 save/restore, we only do so on Guest access. hackbench and
several lmbench tests show anywhere from 30% to 50% of exits don't 
save/restore fp/simd register set.

Tested on Foundation Model, unfortuntely not tested yet on VHE enabled model.

Mario Smarduch (2):
  Optimize arm64 non-VHE fpsimd skip 30-50% save/restore on exits
  keep arm vfp/simd exit handling consistent with arm64

 arch/arm/kvm/interrupts.S        | 14 +++++-----
 arch/arm64/include/asm/kvm_arm.h |  5 +++-
 arch/arm64/kvm/hyp.S             | 58 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 66 insertions(+), 11 deletions(-)

-- 
1.9.1
