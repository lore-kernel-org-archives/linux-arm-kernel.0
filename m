From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed,  7 Oct 2015 15:28:10 +0000
Subject: [PATCH v4 0/2] arm64: Introduce IRQ stack 
Message-ID: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This is fourth version of the series. A major change is stack trace
support for IRQ stack since v3.

Any feedbacks or comments are always welcome.

Thanks in advance!

Changes since v3:
- Expanded stack trace to support IRQ stack
- Added more comments

Changes since v2:
- Optmised current_thread_info function as removing masking operation
  and volatile keyword per James and Catalin
- Reworked irq re-enterance check logic using top-bit comparison of
  stacks per James
- Added sp_el0 update in cpu_resume per James
- Selected HAVE_IRQ_EXIT_ON_IRQ_STACK to expose this feature explicitly
- Added a Tested-by tag from James
- Added comments on sp_el0 as a helper messeage

Changes since v1:
- Rebased on top of v4.3-rc1
- Removed Kconfig about IRQ stack, per James
- Used PERCPU for IRQ stack, per James
- Tried to allocate IRQ stack when CPU is about to start up, per James
- Moved sp_el0 update into kernel_entry macro, per James
- Dropped S_SP removal patch, per Mark and James

Jungseok Lee (2):
  arm64: Introduce IRQ stack
  arm64: Expand the stack trace feature to support IRQ stack

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/irq.h         | 18 ++++++
 arch/arm64/include/asm/thread_info.h | 10 +++-
 arch/arm64/kernel/asm-offsets.c      |  5 ++
 arch/arm64/kernel/entry.S            | 49 ++++++++++++++--
 arch/arm64/kernel/head.S             |  5 ++
 arch/arm64/kernel/irq.c              | 21 +++++++
 arch/arm64/kernel/sleep.S            |  3 +
 arch/arm64/kernel/smp.c              | 13 +++-
 arch/arm64/kernel/stacktrace.c       | 22 ++++++-
 arch/arm64/kernel/traps.c            | 13 ++++
 11 files changed, 149 insertions(+), 11 deletions(-)

-- 
2.5.0
