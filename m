From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jun 2010 15:04:45 +0100
Subject: [PATCH 1/4] ARM: atomic ops: fix register constraints for
	atomic64_add_unless
In-Reply-To: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
Message-ID: <1277906688-12065-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atomic64_add_unless function compares an atomic variable with
a given value and, if they are not equal, adds another given value
to the atomic variable. The function returns zero if the addition
did not occur and non-zero otherwise.

On ARM, the return value is initialised to 1 in C code. Inline assembly
code then performs the atomic64_add_unless operation, setting the
return value to 0 iff the addition does not occur. This means that
when the addition *does* occur, the value of ret must be preserved
across the inline assembly and therefore requires a "+r" constraint
rather than the current one of "=&r".

Thanks to Nicolas Pitre for helping to spot this.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index a0162fa..e9e56c0 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -440,7 +440,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
 "	teq	%2, #0\n"
 "	bne	1b\n"
 "2:"
-	: "=&r" (val), "=&r" (ret), "=&r" (tmp)
+	: "=&r" (val), "+r" (ret), "=&r" (tmp)
 	: "r" (&v->counter), "r" (u), "r" (a)
 	: "cc");
 
-- 
1.6.3.3
