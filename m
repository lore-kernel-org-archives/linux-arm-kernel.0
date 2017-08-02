From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed,  2 Aug 2017 15:51:58 -0700
Subject: [PATCH 1/2] bitops: Avoid integer overflow warning in GENMASK_ULL
Message-ID: <20170802225159.159536-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GENMASK_ULL performs a left-shift of (~0ULL), which technically
results in an integer overflow. clang raises a warning about
this if the overflow occurs in a preprocessor expression. To
avoid the overflow first perform a right-shift to clear the
bits that are shifted out.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 include/linux/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a83c822c35c2..21dfe63001e3 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -22,7 +22,7 @@
 	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
 
 #define GENMASK_ULL(h, l) \
-	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+	((((~0ULL) >> (l)) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
