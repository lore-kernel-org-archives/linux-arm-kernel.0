From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:21 +0800
Subject: [PATCH 0/9] arm64: add more accurate code for tracing the hardirq
 flags changes
Message-ID: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current arm64 code, we trace the hardirq flags change occasionally.
Sometimes, the trace code is buggy, such as the el0_irq.

This patch sets 
   0.) in order to avoid the save/restore registers, add patches to adjust
        the code.
   1.) add the trace code at the entry/exit, 
   2.) add the trace code at the irq macros.
   3.) removes the duplicated trace code.

I tested this patch set with CONFIG_PROVE_LOCKING/CONFIG_LOCKDEP/CONFIG_LOCK_STAT
enabled in the Juno-r1 board.

The whole patch set is based on the patch: 
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/420154.html

Thanks to the code review of Steve/James/Mark, I really appriciate it.

Huang Shijie (9):
  arm64: entry: use the callee-saved registers to save some registers
  arm64: entry: add a new macro to restore the registers for syscall
  arm64: entry: record the hardirq changes on the entry/exit code
  arm64: entry: remove the duplicated code for tracing the IRQ flags
  arm64: entry: only restore the syscall registers once
  arm64: entry: adjust el1_sync so that a function can be called
  arm64: entry: save the x0 back into the stack before disabling the
    interrupt
  arm64: add the hardirq flags trace code for irq macros
  arm64: entry: remove the duplicated hardirq flags trace code

 arch/arm64/include/asm/assembler.h |  9 ++++
 arch/arm64/kernel/entry.S          | 88 ++++++++++++++++++++++----------------
 arch/arm64/kernel/signal.c         |  6 ---
 arch/arm64/mm/fault.c              | 10 -----
 4 files changed, 59 insertions(+), 54 deletions(-)

-- 
2.5.5
