From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 15 Dec 2011 21:47:56 +0100
Subject: [PATCH] ARM: unwinder: fix bisection to find origin in .idx section
In-Reply-To: <20111215145109.GA4143@elliptictech.com>
References: <20111215145109.GA4143@elliptictech.com>
Message-ID: <1323982076-20068-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bisection implemented in unwind_find_origin() stopped to early. If
there is only a single entry left to check the original code just took
the end point as origin which might be wrong.

This was introduced in

	de66a97 (ARM: 7187/1: fix unwinding for XIP kernels)

Reported-by: Nick Bowler <nbowler@elliptictech.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello Linus,

I suggested earlier to revert de66a97. I still think this is the safest
bet for 3.2. Anyhow here comes the fix that made Nick happy. If you
revert I'll fold it into my resubmission.

Best regards
Uwe

 arch/arm/kernel/unwind.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 3f03fe0..00df012 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -160,12 +160,12 @@ static const struct unwind_idx *unwind_find_origin(
 		const struct unwind_idx *start, const struct unwind_idx *stop)
 {
 	pr_debug("%s(%p, %p)\n", __func__, start, stop);
-	while (start < stop - 1) {
+	while (start < stop) {
 		const struct unwind_idx *mid = start + ((stop - start) >> 1);
 
 		if (mid->addr_offset >= 0x40000000)
 			/* negative offset */
-			start = mid;
+			start = mid + 1;
 		else
 			/* positive offset */
 			stop = mid;
-- 
1.7.7.2
