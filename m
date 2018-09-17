From: minchan@kernel.org (Minchan Kim)
Date: Mon, 17 Sep 2018 09:44:48 +0900
Subject: [PATCH v1 0/3] arm: support get_user_pages_fast
Message-ID: <20180917004451.174527-1-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently, I got a report get_user_pages_fast helps app's launching time
due to reducing uninterruptible sleep time because it could reduce
mmap_sem lock contentions when app is launching.

To support gupf in ARM-non-LPAE, first patch reorders memory type table
to use 5th bit of the page table.

Second patch introduces L_PTE_SPECIAL for arm so that last patch can
support get_user_pags_fast.

I would greatly appreciate if guys review that I screw up something,
especially, architecture stuffs.

* from RFC
  * Remove CPU_v7M - Catalin
  * define DEV_NONSHARED to SHARED - Catalin
  * https://lkml.kernel.org/r/20180910165011.zcighyuabshsmxjb at armageddon.cambridge.arm.com

Minchan Kim (3):
  arm: mm: reordering memory type table
  arm: mm: introduce L_PTE_SPECIAL
  arm: mm: support get_user_pages_fast

 arch/arm/Kconfig                      |   2 +-
 arch/arm/include/asm/pgtable-2level.h |  22 ++-
 arch/arm/include/asm/pgtable-3level.h |   6 -
 arch/arm/include/asm/pgtable.h        |  13 ++
 arch/arm/mm/Makefile                  |   6 +
 arch/arm/mm/gup.c                     | 221 ++++++++++++++++++++++++++
 arch/arm/mm/proc-macros.S             |   4 +-
 7 files changed, 259 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mm/gup.c

-- 
2.19.0.397.gdd90340f6a-goog
