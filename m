From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Sep 2017 17:05:37 +0200
Subject: [PATCH] ARM: make memzero optimization smarter
Message-ID: <20170905150559.1739140-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing with a gcc-8.0.0 snapshot, I ran into a harmless
build warning:

In file included from include/linux/string.h:18:0,
		 ...
                 from drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:10:
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c: In function '__lb_other_process':
arch/arm/include/asm/string.h:50:5: error: 'memset' specified size 4294967295 exceeds maximum object size 2147483647 [-Werror=stringop-overflow=]
     memset((__p),(v),(__n));  \
     ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:394:3: note: in expansion of macro 'memset'
   memset(&skb->data[frame_size / 2], 0xAA, frame_size / 2 - 1);
   ^~~~~~

I think the warning is unintentional here, and gcc should not actually
warn, so I reported this in the gcc bugzilla as pr82103.

The problem here is that testing the 'frame_size' variable for non-zero
in the first memset() macro invocation leads to a code path in which
gcc thinks it may be zero, and that code path would lead to an overly
large length for the following memset that is now "(u32)-1". We know
this won't happen as the skb len is already guaranteed to be nonzero
when we get here (it has just been allocated with a nonzero size).

However, we can avoid this class of bogus warnings for the memset() macro
by only doing the micro-optimization for zero-length arguments when the
length is a compile-time constant. This should also reduce code size by
a few bytes, and avoid an extra branch for the cases that a variable-length
argument is always nonzero, which is probably the common case anyway.

I have made sure that the __memzero implementation can safely handle
a zero length argument.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82103
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index fe1c6af3a1b1..d4f464b46eae 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -43,7 +43,7 @@ extern void __memzero(void *ptr, __kernel_size_t n);
 #define memset(p,v,n)							\
 	({								\
 	 	void *__p = (p); size_t __n = n;			\
-		if ((__n) != 0) {					\
+		if (!__builtin_constant_p(__n) || (__n) != 0) {		\
 			if (__builtin_constant_p((v)) && (v) == 0)	\
 				__memzero((__p),(__n));			\
 			else						\
-- 
2.9.0
