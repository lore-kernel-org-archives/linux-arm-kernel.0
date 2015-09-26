From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sat, 26 Sep 2015 16:43:27 -0700
Subject: [PATCH v2 0/2] KVM/arm: enhance arvm7 vfp/simd lazy switch support
Message-ID: <1443311009-4811-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current lazy vfp/simd implementation switches hardware context only on 
guest access and again on exit to host, otherwise hardware context is
skipped.

This patch set builds on that functionality and executes a hardware context 
switch only when  vCPU is scheduled out or returns to user space.

Patches were tested on FVP sw platform. FP crunching applications summing up 
values, with outcome compared to known result were executed on several guests, 
and host. 

Changes since v1->v2:
* Fixed vfp/simd trap configuration to enable trace trapping
* Removed set_hcptr branch label
* Fixed handling of FPEXC to restore guest and host versions on vcpu_put

Mario Smarduch (2):
  add hooks for armv7 fp/simd lazy switch support
  enable armv7 fp/simd lazy switch

 arch/arm/include/asm/kvm_asm.h  |  1 +
 arch/arm/include/asm/kvm_host.h |  6 +++++
 arch/arm/kernel/asm-offsets.c   |  2 ++
 arch/arm/kvm/arm.c              | 17 ++++++++++++
 arch/arm/kvm/interrupts.S       | 60 ++++++++++++++++++++++++++++++-----------
 arch/arm/kvm/interrupts_head.S  | 12 ++++++---
 6 files changed, 79 insertions(+), 19 deletions(-)

-- 
1.9.1
