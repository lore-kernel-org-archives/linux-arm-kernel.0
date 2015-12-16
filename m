From: ashoks@broadcom.com (Ashok Kumar)
Date: Wed, 16 Dec 2015 02:11:28 -0800
Subject: [PATCH v3 0/2] arm64: change PoC D-cache flush to PoU
Message-ID: <1450260690-5431-1-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For keeping I and D coherent, dcache flush till PoU(Point of Unification)
should be sufficient instead of doing till PoC(Point of coherence).
In SoC with more levels of cache, there could be a performance hit in doing
flush till PoC as __flush_dcache_area does both flush and invalidate.
Introduced new API __clean_dcache_area_pou which does only clean till PoU.

Also deferred dcache flush in __cpu_copy_user_page to __sync_icache_dcache.

changes since v2 [2]:
 Incorporated Mark Rutland's review comments of
  * fixing comments
  * creating a helper function for __sync_icache_dcache.

changes since v1 [1]:
 Incorporated Mark Rutland's review comments of
  * renaming __flush_dcache_area_pou to __clean_dcache_area_pou
  * using inner shareable domain for dsb in __clean_dcache_area_pou
  * having a common macro for __flush_dcache_area and
    __clean_dcache_area_pou.

Thanks,
Ashok

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393527.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393837.html

Ashok Kumar (2):
  arm64: Defer dcache flush in __cpu_copy_user_page
  arm64: Use PoU cache instr for I/D coherency

 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 50 +++++++++++++++++++++++++++++--------
 arch/arm64/mm/copypage.c            |  3 ++-
 arch/arm64/mm/flush.c               | 33 +++++++++++++-----------
 4 files changed, 60 insertions(+), 27 deletions(-)

-- 
2.1.0
