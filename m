From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 30 Aug 2017 10:01:25 +0100
Subject: [PATCH 0/3] Fix single step for traps
Message-ID: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When single stepping a trapped/emulated instruction, the instruction not being
actually executed, the PE ends up single stepping the instruction we return to
after ERET-ing from the trap.

The issue affects traps in the kernel and emulated instructions in KVM guests.

This patch series ensures we properly single step trapped instruction.

First patch is just to avoid raw values when using single stepping
registers/bits.
Patches 2 and 3 fix the issue for kernel and kvm respectively.

Cheers,

Julien

Julien Thierry (3):
  arm64: Use existing defines for mdscr
  arm64: Fix single stepping in kernel traps
  arm64: kvm: Fix single step for guest skipped instructions

 arch/arm64/include/asm/assembler.h   |  5 +++--
 arch/arm64/include/asm/kvm_asm.h     |  2 ++
 arch/arm64/include/asm/kvm_emulate.h |  2 ++
 arch/arm64/include/asm/traps.h       |  2 ++
 arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/traps.c            | 21 ++++++++++++++++-----
 arch/arm64/kvm/debug.c               | 12 +++++++++++-
 arch/arm64/kvm/hyp/switch.c          | 12 ++++++++++++
 9 files changed, 53 insertions(+), 13 deletions(-)

--
1.9.1
