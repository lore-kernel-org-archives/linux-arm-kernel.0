From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 11:41:52 +0100
Subject: [PATCH v2 01/20] arm64: rwlocks: don't fail trylock purely due to
 contention
In-Reply-To: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
Message-ID: <1437734531-10698-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STXR can fail for a number of reasons, so don't fail an rwlock trylock
operation simply because the STXR reported failure.

I'm not aware of any issues with the current code, but this makes it
consistent with spin_trylock and also other architectures (e.g. arch/arm).

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cee128732435..0f08ba5cfb33 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -140,10 +140,11 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 	unsigned int tmp;
 
 	asm volatile(
-	"	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 1f\n"
+	"1:	ldaxr	%w0, %1\n"
+	"	cbnz	%w0, 2f\n"
 	"	stxr	%w0, %w2, %1\n"
-	"1:\n"
+	"	cbnz	%w0, 1b\n"
+	"2:\n"
 	: "=&r" (tmp), "+Q" (rw->lock)
 	: "r" (0x80000000)
 	: "memory");
@@ -209,11 +210,12 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 	unsigned int tmp, tmp2 = 1;
 
 	asm volatile(
-	"	ldaxr	%w0, %2\n"
+	"1:	ldaxr	%w0, %2\n"
 	"	add	%w0, %w0, #1\n"
-	"	tbnz	%w0, #31, 1f\n"
+	"	tbnz	%w0, #31, 2f\n"
 	"	stxr	%w1, %w0, %2\n"
-	"1:\n"
+	"	cbnz	%w1, 1b\n"
+	"2:\n"
 	: "=&r" (tmp), "+r" (tmp2), "+Q" (rw->lock)
 	:
 	: "memory");
-- 
2.1.4
