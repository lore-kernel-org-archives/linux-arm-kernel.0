From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:12 +0100
Subject: [PATCH 5/8] arm64: barriers: use barrier() instead of smp_mb() when
 !SMP
In-Reply-To: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
References: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399044255-20435-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently introduced acquire/release accessors refer to smp_mb()
in the !CONFIG_SMP case. This is confusing when reading the code, so use
barrier() directly when we know we're UP.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/barrier.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 71a42d6599fb..709f1f6d6bbd 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,7 +40,7 @@
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	barrier();							\
 	ACCESS_ONCE(*p) = (v);						\
 } while (0)
 
@@ -48,7 +48,7 @@ do {									\
 ({									\
 	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	barrier();							\
 	___p1;								\
 })
 
-- 
1.9.2
