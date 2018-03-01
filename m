From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  1 Mar 2018 18:07:12 +0100
Subject: [PATCH] kasan, arm64: clean up KASAN_SHADOW_SCALE_SHIFT usage
Message-ID: <44281e784702443f06edb837ec672984783a9621.1519923749.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow up patch to the series I sent recently that cleans up
KASAN_SHADOW_SCALE_SHIFT usage (which value was hardcoded and scattered
all over the code). This fixes the one place that I forgot to fix.

The change is purely aesthetical, instead of hardcoding the value for
KASAN_SHADOW_SCALE_SHIFT in arch/arm64/Makefile, an appropriate variable
is declared and used.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a7c011..4bb18aee4846 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -97,12 +97,14 @@ else
 TEXT_OFFSET := 0x00080000
 endif
 
-# KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - 3)) - (1 << 61)
+# KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
+#				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
+KASAN_SHADOW_SCALE_SHIFT := 3
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
-			(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
-			+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - 3)) \
-			- (1 << (64 - 32 - 3)) )) )
+	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
+	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
+	- (1 << (64 - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) )) )
 
 export	TEXT_OFFSET GZFLAGS
 
-- 
2.16.2.395.g2e18187dfd-goog
