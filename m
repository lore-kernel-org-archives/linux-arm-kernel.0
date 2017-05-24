From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:57:57 +0100
Subject: [PATCH 0/9] SError rework to support RAS notifications via SEI
Message-ID: <20170524165806.29866-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rules for when SError should be masked/unmasked are unclear. Today
we unmask SError on each CPU during boot, but ignore it thereafter. This
means once we enter userspace SError is always masked in the kernel.
Because of this, we always blame the next user space process to be
scheduled for any SError triggered by the kernel.

When we add an ESB for synchronising RAS events in the context switch
code, we won't ever take an SError (it will be deferred and written to
a system register), we would need to always explicitly test for an error.

Instead we should unmask SError when running in the kernel, and we should
decide an order for masking/unmasking exceptions.

'dai' is memorable and almost what we have today.

This means:
 * Masking debug will also mask SError and irq.
 * Masking SError will also mask irq.
 * Fiq is almost always unmasked. (It's masked by debug as that masks
   everything)

The entry.S changes are in very small pieces, hopefully this makes the bugs
obvious. I intend to merge all the convert-foo patches together once they've
been reviewed.

The (expected) changes in behaviour for this series are:
 * SError and fiq may be unmasked in the kernel.
 * el1_sync exceptions (except debug) inherit their flags, instead of unmasking
   debug and maybe irq for instruction/data abort. This means EL1's
   undef/sp_pc/inv may now run with IRQs unmasked.
 * el0_sync exceptions (except debug) unmask everything. fpsimd_acc fpsimd_exc
   and inv now run with interrupts enabled. (This looked like a side effect of
   some earlier cleanup.)
 * kernel_exit explicitly masks all the flags.

With these changes, adding further RAS support that depends on SError handling
becomes simpler.

Comments welcome.

James Morse (8):
  arm64: explicitly mask all exceptions
  arm64: introduce an order for exceptions
  arm64: unmask all exceptions on CPU startup
  arm64: entry.S: mask all exceptions during kernel_exit
  arm64: entry.S: move enable_step_tsk into kernel_exit
  arm64: entry.S: convert el1_sync
  arm64: entry.S convert el0_sync
  arm64: entry.S: convert elX_irq

Xie XiuQi (1):
  arm64: entry.S: move SError handling into a C function for future
    expansion

 arch/arm64/Kconfig                 |   1 +
 arch/arm64/include/asm/assembler.h |  47 +++++++++------
 arch/arm64/include/asm/irqflags.h  |  65 ++++++++++++++-------
 arch/arm64/kernel/debug-monitors.c |   4 +-
 arch/arm64/kernel/entry.S          | 116 +++++++++++++++++++------------------
 arch/arm64/kernel/hibernate.c      |   4 +-
 arch/arm64/kernel/machine_kexec.c  |   3 +-
 arch/arm64/kernel/setup.c          |   7 ++-
 arch/arm64/kernel/smp.c            |  12 ++--
 arch/arm64/kernel/suspend.c        |   6 +-
 arch/arm64/kernel/traps.c          |  15 ++++-
 arch/arm64/mm/proc.S               |   9 ++-
 12 files changed, 167 insertions(+), 122 deletions(-)

-- 
2.11.0
