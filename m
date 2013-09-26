From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 26 Sep 2013 16:49:25 +0100
Subject: [PATCH 0/3] KVM: ARM: Cortex-A7 support and fixes
Message-ID: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for using KVM on ARM Cortex-A7 CPUs. As the Cortex-A7
is architecturally identical to the A15 there is not a huge amount of code
required, however there are a number of fixups necessary to core KVM code that
testing on A7 has revealed.

I'm open to comments about other ways to share the functionality between A7/A15
while still maintaining the architectural/implementation defined split that
existed between coproc.c and coproc_a15.c - The approach in this series avoids
adding '3 levels' of abstraction and feels like a good compromise that doesn't
require duplication of a lot of the A15 code for A7 but still permits
implementation differences to be fully expressed in coproc_X files.

This patch series has been developed/tested on TC2 with the A15 cluster held in
reset.

Jonathan Austin (3):
  KVM: ARM: fix the size of TTBCR_{T0SZ,T1SZ} masks
  KVM: ARM: Fix calculation of virtual CPU ID
  KVM: ARM: Add support for Cortex-A7

 arch/arm/include/asm/kvm_arm.h  |    4 +-
 arch/arm/include/asm/kvm_asm.h  |    2 +-
 arch/arm/include/uapi/asm/kvm.h |    3 +-
 arch/arm/kvm/Makefile           |    2 +-
 arch/arm/kvm/coproc.c           |  114 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc_a15.c       |  117 +--------------------------------------
 arch/arm/kvm/coproc_a7.c        |   54 ++++++++++++++++++
 arch/arm/kvm/guest.c            |    4 +-
 arch/arm/kvm/reset.c            |   15 ++---
 9 files changed, 186 insertions(+), 129 deletions(-)
 create mode 100644 arch/arm/kvm/coproc_a7.c

-- 
1.7.9.5
