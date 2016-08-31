From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 Aug 2016 12:05:10 +0100
Subject: [PATCH v3 0/7] arm64: clean up early boot function calls
Message-ID: <1472641517-15362-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a couple of places, the early boot code uses non-standard argument,
return value or return address registers when calling functions. This makes
the code more complicated than it needs to be, which was not a problem in the
early days, but with all the recent changes for KASLR, hibernate etc, it
makes sense to clean this up once and for all. This code removes all uses of
callee saved registers on the secondary boot and resume paths, and on the
primary boot path, it only leaves the necessary ones, and documents them
explicitly in patch #7.

I will leave it to the honourable arm64 maintainers to decide if any of
these improvements weigh up against the churn, given that this code has
already been updated numerous times over the past couple of kernel versions.

NOTE: this series applies onto today's for-next/core with fixes/core merged
on top, since it depends on Mark's commit fd363bd417ddb610 ("arm64: avoid TLB
conflict with CONFIG_RANDOMIZE_BASE")

Changes since v2:
- dropped patch that gets rid of x25/x26 as pgdir pointers, it has been merged
  into for-next/core in the mean time
- fixed commit log of #1 to indicate since when the comment that it fixes had
  been incorrect
- merged changes relating to the use of x27 by __enable_mmu() into a single
  patch (#4)
- added Mark's R-b to all patches

Patch #1 fixes some style issues in sleep.S with no functional changes.

Patch #2 removes the use of x20 between el2_setup() and set_cpu_boot_mode_flag()

Patch #3 moves the part of the KASLR processing that resides in __enable_mmu()
into primary_switch() (which is a more suitable place, given that only the
primary boot path ever invokes it)

Patch #4 replaces the special x27 return address of __enable_mmu() with x30/lr.
Given that we can no longer dereference literals containing virtual addresses,
all callers have already been updated to return from __enable_mmu() back to the
idmap before performing a literal load + jump. Using x30 instead of x27 allows
us to merge the code that executes before __enable_mmu() with the code that
executes after it, and to change the invocation of __enable_mmu() itself into a
simple bl instruction.

Patch #5 removes the 'global' x24 register in head.S, containing __PHYS_OFFSET

Patch #6 removes the use of x28 in __primary_switched(), and replaces it with
an ordinary stack frame to preserve the return address.

Ard Biesheuvel (7):
  arm64: kernel: fix style issues in sleep.S
  arm64: kernel: use ordinary return/argument register for el2_setup()
  arm64: head.S: move KASLR processing out of __enable_mmu()
  arm64: kernel: use x30 for __enable_mmu return address
  arm64: kernel: drop use of x24 from primary boot path
  arm64: head.S: use ordinary stack frame for __primary_switched()
  arm64: head.S: document the use of callee saved registers

 arch/arm64/kernel/head.S  | 147 +++++++++++---------
 arch/arm64/kernel/sleep.S |  27 ++--
 2 files changed, 94 insertions(+), 80 deletions(-)

-- 
2.7.4
