From: apinski@cavium.com (Andrew Pinski)
Date: Sun, 23 Apr 2017 16:47:01 -0700
Subject: [PATCH 2/2] arm64:vdso: Remove ISB from gettimeofday.
In-Reply-To: <1492991221-5156-1-git-send-email-apinski@cavium.com>
References: <1492991221-5156-1-git-send-email-apinski@cavium.com>
Message-ID: <1492991221-5156-2-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ISB is normally required before mrs CNTVCT if we want the
mrs to completed after the loads. In this case it is not.
As we are taking the difference and if that difference
was going to be negative, we just use the last counter value
instead.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/kernel/vdso/gettimeofday.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.c b/arch/arm64/kernel/vdso/gettimeofday.c
index a0ab8b1..cf3235a 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.c
+++ b/arch/arm64/kernel/vdso/gettimeofday.c
@@ -117,10 +117,20 @@ static notrace u64 get_clock_shifted_nsec(u64 cycle_last, u64 mult)
 	u64 res;
 
 	/* Read the virtual counter. */
-	isb();
+	/*
+	 * This normally requires an ISB but since we know the
+	 * read of the last cycle will always be after the
+	 * read of the values are valid word.
+	 */
 	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
 
-	res = res - cycle_last;
+	/*
+	 * If the current cycle is greater than the last,
+	 *  then get the difference.
+	 */
+	if (res > cycle_last)
+		res = res - cycle_last;
+
 	/* We can only guarantee 56 bits of precision. */
 	res &= ~(0xff00ul<<48);
 	return res * mult;
-- 
2.7.4
