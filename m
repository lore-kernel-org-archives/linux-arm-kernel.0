From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:35:57 +0200
Subject: [PATCH v2 0/9] arm64: clean up early boot function calls
Message-ID: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v2 series is a followup to the single patch #1, whose v1 I sent out
about a week ago.

In a couple of places, the early boot code uses non-standard argument,
return value or return address registers when calling functions. This makes
the code more complicated than it needs to be, which was not a problem in the
early days, but with all the recent changes for KASLR, hibernate etc, it
makes sense to clean this up once and for all. This code removes all uses of
callee saved registers on the secondary boot and resume paths, and on th
primary boot path, it only leaves the necessary ones, and documents them
explicitly in patch #9.

I will leave it to the honourable arm64 maintainers to decide if any of
these improvements weigh up against the churn, given that this code has
already been updated numerous times over the past couple of kernel versions.

Adding James to cc since patch #6 may conflict with this hibernate/
debug-pagealloc series [0], to which I replied that merging .idmap.text
with .mmuoff.text would be a worthwhile simplification. 

Patch #1 removes the de facto requirement of __enable_mmu() that the
addresses of idmap_pg_dir and swapper_pg_dir must to be passed in register
x25 and x26, respectively. (v2: added Mark's ack)

Patch #2 fixes some style issues in sleep.S with no functional changes.

Patch #3 removes the use of x20 between el2_setup and set_cpu_boot_mode_flag()

Patch #4 moves the part of the KASLR processing that resides in __enable_mmu()
into primary_switch() (which is a more suitable place, given that only the
primary boot path ever invokes it)

Patch #5 replaces the special x27 return address of __enable_mmu() with x30/lr.
Given that we can no longer dereference literals containing virtual addresses,
all callers have been updated to return from __enable_mmu() back to the
idmap before performing a literal load + jump, this will allow us to simplify
the code in subsequent patches.

Patch #6 merges the code that executes before __enable_mmu() with the code
that executes after it, and changes the invocation of __enable_mmu() itself
into a simple bl instruction.

Patch #7 removes the 'global' x24 register in head.S, containing __PHYS_OFFSET

Patch #8 removes the use of x28 in __primary_switched(), and replaces it with
an ordinary stack frame to preserve the return address.

[0] http://marc.info/?l=linux-arm-kernel&m=147128126002457

Ard Biesheuvel (9):
  arm64: kernel: get rid of x25 and x26 with 'global' scope
  arm64: kernel: fix style issues in sleep.S
  arm64: kernel: use ordinary return/argument register for el2_setup()
  arm64: head.S: move KASLR processing out of __enable_mmu()
  arm64: kernel: use x30 for __enable_mmu return address
  arm64: call __enable_mmu as an ordinary function for secondary/resume
  arm64: kernel: drop use of x24 from primary boot path
  arm64: head.S: use ordinary stack frame for __primary_switched()
  arm64: head.S: document the use of callee saved registers

 arch/arm64/kernel/head.S  | 170 +++++++++++---------
 arch/arm64/kernel/sleep.S |  29 ++--
 2 files changed, 105 insertions(+), 94 deletions(-)

-- 
2.7.4
