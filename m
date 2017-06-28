From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:58:14 +0200
Subject: [PATCH] arm64: add missing conversion to __wsum in ip_fast_csum()
Message-ID: <20170628145814.24763-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 implementation of ip_fast_csum() do most of the work
in 128 or 64 bit and call csum_fold() to finalize. csum_fold()
itself take a __wsum argument, to insure that this value is
always a 32bit native-order value.

Fix this by using an helper __csum_fold() taking the native
32 bit value and doing the needed folding to 16 bit (and reuse
this helper for csum_fold() itself).

Note: a simpler patch would to use something like:
		return csum_fold((__wsum __force)(sum >> 32));
      but using an helper __csum_fold() allow to avoid
      a forced cast.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/include/asm/checksum.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 09f65339d..dcc655137 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -18,12 +18,16 @@
 
 #include <linux/types.h>
 
-static inline __sum16 csum_fold(__wsum csum)
+static inline __sum16 __csum_fold(u32 sum)
 {
-	u32 sum = (__force u32)csum;
 	sum += (sum >> 16) | (sum << 16);
 	return ~(__force __sum16)(sum >> 16);
 }
+
+static inline __sum16 csum_fold(__wsum csum)
+{
+	return __csum_fold((__force u32)csum);
+}
 #define csum_fold csum_fold
 
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
@@ -42,7 +46,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	} while (--ihl);
 
 	sum += ((sum >> 32) | (sum << 32));
-	return csum_fold(sum >> 32);
+	return __csum_fold(sum >> 32);
 }
 #define ip_fast_csum ip_fast_csum
 
-- 
2.13.0
