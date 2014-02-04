From: will.deacon@arm.com (Will Deacon)
Date: Tue,  4 Feb 2014 12:28:46 +0000
Subject: [PATCH] ARM: spinlock: ensure we have a compiler barrier before sev
Message-ID: <1391516926-14493-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When unlocking a spinlock, we require the following, strictly ordered
sequence of events:

	<barrier>	/* dmb */
	<unlock>
	<barrier>	/* dsb */
	<sev>

Whilst the code does indeed reflect this in terms of the architecture,
the final <barrier> + <sev> have been contracted into a single inline
asm without a "memory" clobber, therefore the compiler is at liberty to
reorder the unlock to the end of the above sequence. In such a case,
a waiting CPU may be woken up before the lock has been unlocked, leading
to extremely poor performance.

This patch reworks the dsb_sev() function to make use of the dsb()
macro and ensure ordering against the unlock.

Cc: <stable@vger.kernel.org>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index ef3c6072aa45..ac4bfae26702 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -37,18 +37,9 @@
 
 static inline void dsb_sev(void)
 {
-#if __LINUX_ARM_ARCH__ >= 7
-	__asm__ __volatile__ (
-		"dsb ishst\n"
-		SEV
-	);
-#else
-	__asm__ __volatile__ (
-		"mcr p15, 0, %0, c7, c10, 4\n"
-		SEV
-		: : "r" (0)
-	);
-#endif
+
+	dsb(ishst);
+	__asm__(SEV);
 }
 
 /*
-- 
1.8.2.2
