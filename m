From: ashoks@broadcom.com (Ashok Kumar)
Date: Mon, 14 Dec 2015 05:27:42 -0800
Subject: [RFC PATCH 0/2] arm64: change PoC D-cache flush to PoU
Message-ID: <1450099664-38554-1-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For keeping I and D coherent, dcache flush till PoU(Point of Unification)
should be sufficient instead of doing till PoC(Point of coherence).
In SoC with more levels of cache, there could be a performance hit in doing
flush till PoC as __flush_dcache_area does both flush and invalidate.
Introduced new API __flush_dcache_area_pou which does only clean till PoU.

Also deferred dcache flush in __cpu_copy_user_page to __sync_icache_dcache.
May I know why I/D sync is needed in __cpu_copy_user_page? My understanding 
is that any self modifying code in userspace is supposed to take care of the 
coherency using the respective cache flush system call. 

Ashok Kumar (2):
  arm64: Defer dcache flush in __cpu_copy_user_page
  arm64: Use PoU cache instr for I/D coherency

 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 22 ++++++++++++++++++++++
 arch/arm64/mm/copypage.c            |  3 ++-
 arch/arm64/mm/flush.c               | 13 +++++++++----
 4 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.1.0
