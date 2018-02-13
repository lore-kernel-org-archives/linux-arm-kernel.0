From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Feb 2018 13:13:07 +0000
Subject: [PATCH] arm64: lse: Pass -fomit-frame-pointer to out-of-line ll/sc
 atomics
Message-ID: <1518527587-18260-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In cases where x30 is used as a temporary in the out-of-line ll/sc atomics
(e.g. atomic_fetch_add), the compiler tends to put out a full stackframe,
which included pointing the x29 at the new frame.

Since these things aren't traceable anyway, we can pass -fomit-frame-pointer
to reduce the work when spilling.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 4e696f96451f..c287b58b257a 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -17,6 +17,6 @@ CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
 		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
 		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
-		   -fcall-saved-x18
+		   -fcall-saved-x18 -fomit-frame-pointer
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
-- 
2.1.4
