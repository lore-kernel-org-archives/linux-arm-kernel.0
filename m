From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 25 Oct 2009 14:31:40 +0000
Subject: [RFC 11/11] ARM: avoid flushing I-cache in flush_cache_mm()
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <f4e898a97589fdee3c689780212fe225e6732a6b.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flush_cache_mm() is called in two cases:
1. when a process exits, just before the page tables are torn down.
   We can allow the stale lines to evict themselves over time without
   causing any harm.

2. when a process forks, and we've allocated a new ASID.
   The instruction cache issues are dealt with as pages are brought
   into the new process address space.  Flushing the I-cache here is
   therefore unnecessary.

However, we must keep the VIPT aliasing D-cache flush to ensure that
any dirty cache lines are not written back after the pages have been
reallocated for some other use - which would result in corruption.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/flush.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index ee7ce68..329594e 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -50,7 +50,6 @@ void flush_cache_mm(struct mm_struct *mm)
 		    :
 		    : "r" (0)
 		    : "cc");
-		__flush_icache_all();
 	}
 }
 
-- 
1.6.2.5
