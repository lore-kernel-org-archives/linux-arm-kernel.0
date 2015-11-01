From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun,  1 Nov 2015 07:46:14 +0000
Subject: [PATCH v6 0/3] Introduce IRQ stack on arm64 with percpu changes
Message-ID: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 6 of IRQ stack on arm64.

A major change between v5 and v6 is how IRQ stack is allocated. The space
is allocated via generic VM APIs, such as __get_free_pages() or kmalloc()
up to v5. In contrast, PERCPU is responsible for the work in this version
since it helps to 1) handle stack pointer with a minimum number of memory
access and 2) unify memory allocation regardless of page size. (Now ARM64
supports three kinds of page size: 4KB, 16KB, and 64KB.)

Unfortunately, generic percpu codes should be touched a little bit to
support PERCPU stack allocation. That is, 'atom_size' should be adjusted
in case of 4KB page system because stack pointer logic works on the
assumption that IRQ stack is aligned with its own size. Although it is not
mandated by ARMv8 architecture, the restriction faciliates IRQ re-entrance
check and call trace linkage between procee stack and IRQ one.

It would be redundant to introduce ARM64-specific setup_per_cpu_areas()
for a single parameter, 'atom_size' change. This is why this series tries
to update the generic percpu layer. At the same time, but, it is doubtable
to define a new definition for a single arch support. Thus, it is arguable
which approach is better than the other. (I tried to get feedbacks via
linux-mm, but no comments were left.)

In case of Patch1 and Patch2, v6 tag, not v1 one, is appended to align
with a history of this IRQ work. Please let me know if it violates patch
submission rules.

Any comments are greatly welcome.

Thanks in advance!

Best Regards
Jungseok Lee

Changes since v5:
- Introduced a new definition for 'atom_size' configuration
- Used PERCPU for stack allocation, per Catalin

Changes since v4: 
- Supported 64KB page system
- Introduced IRQ_STACK_* macro, per Catalin 
- Rebased on top of for-next/core

Changes since v3: 
- Expanded stack trace to support IRQ stack
- Added more comments

Changes since v2: 
- Optmised current_thread_info function as removing masking operation
  and volatile keyword, per James and Catalin
- Reworked irq re-enterance check logic using top-bit comparison of
  stacks, per James
- Added sp_el0 update in cpu_resume, per James
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

Jungseok Lee (3):
  percpu: remove PERCPU_ENOUGH_ROOM which is stale definition
  percpu: add PERCPU_ATOM_SIZE for a generic percpu area setup
  arm64: Introduce IRQ stack

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/irq.h         |  6 +++
 arch/arm64/include/asm/percpu.h      |  6 +++
 arch/arm64/include/asm/thread_info.h | 10 +++-
 arch/arm64/kernel/entry.S            | 42 ++++++++++++++--
 arch/arm64/kernel/head.S             |  5 ++
 arch/arm64/kernel/irq.c              |  2 +
 arch/arm64/kernel/sleep.S            |  3 ++
 arch/arm64/kernel/smp.c              |  4 +-
 include/linux/percpu.h               |  6 +--
 mm/percpu.c                          |  6 +--
 11 files changed, 75 insertions(+), 16 deletions(-)

-- 
2.5.0
