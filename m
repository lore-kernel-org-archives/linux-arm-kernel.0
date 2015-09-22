From: rric@kernel.org (Robert Richter)
Date: Tue, 22 Sep 2015 19:59:48 +0200
Subject: [PATCH] arm64: Increase the max granular size
Message-ID: <1442944788-17254-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tirumalesh Chalamarla <tchalamarla@cavium.com>

Increase the standard cacheline size to avoid having locks in the same
cacheline.

Cavium's ThunderX core implements cache lines of 128 byte size. With
current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
share the same cache line leading a performance degradation.
Increasing the size fixes that.

Increasing the size has no negative impact to cache invalidation on
systems with a smaller cache line. There is an impact on memory usage,
but that's not too important for arm64 use cases.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index bde449936e2f..5082b30bc2c0 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -18,7 +18,7 @@
 
 #include <asm/cachetype.h>
 
-#define L1_CACHE_SHIFT		6
+#define L1_CACHE_SHIFT		7
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 /*
-- 
2.1.1
