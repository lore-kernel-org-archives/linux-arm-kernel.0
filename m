From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 May 2018 14:55:45 +0100
Subject: [PATCH v3 1/3] Revert "arm64: Increase the max granular size"
In-Reply-To: <20180511135547.34521-1-catalin.marinas@arm.com>
References: <20180511135547.34521-1-catalin.marinas@arm.com>
Message-ID: <20180511135547.34521-2-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 97303480753e48fb313dc0e15daaf11b0451cdb8.

Commit 97303480753e ("arm64: Increase the max granular size") increased
the cache line size to 128 to match Cavium ThunderX, apparently for some
performance benefit which could not be confirmed. This change, however,
has an impact on the network packet allocation in certain circumstances,
requiring slightly over a 4K page with a significant performance
degradation. The patch reverts L1_CACHE_SHIFT back to 6 (64-byte cache
line).

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 9bbffc7a301f..1dd2c2db0010 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -33,7 +33,7 @@
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
-#define L1_CACHE_SHIFT		7
+#define L1_CACHE_SHIFT		(6)
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 /*
