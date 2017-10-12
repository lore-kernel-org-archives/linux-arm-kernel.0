From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 12 Oct 2017 14:43:01 +0100
Subject: [PATCH v3 0/2] Fix single step for traps
Message-ID: <1507815783-39929-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When single stepping a trapped/emulated instruction, the instruction not
being actually executed, the PE ends up single stepping the instruction we
return to after ERET-ing from the trap.

First patch is just to avoid raw values when using single stepping
registers/bits.
Patches 2 fixes the issue for the kernel.

Changes since v1:
* Rename arm64_skip_trapped_instr to arm64_setup_next_instr
* Add defines for AARCH32 and Thumb instruction sizes
* Drop previous KVM patch, Alex Benn?e has a better approach

Changes since v2:
* Move include in assembler.h to the right place
* Use user_fastforward_single_step to update single step state

Cheers,

Julien Thierry

Julien Thierry (2):
  arm64: Use existing defines for mdscr
  arm64: Fix single stepping in kernel traps

 arch/arm64/include/asm/assembler.h   |  5 +++--
 arch/arm64/include/asm/insn.h        |  5 +++++
 arch/arm64/include/asm/traps.h       |  6 ++++++
 arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/traps.c            | 21 ++++++++++++++++-----
 6 files changed, 35 insertions(+), 12 deletions(-)

--
1.9.1
