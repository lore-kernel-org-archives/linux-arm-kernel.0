From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Dec 2011 11:41:05 +0100
Subject: Massive log spam loading modules on ARM after 3.2-rc5 (regression)
In-Reply-To: <20111214215133.GA7780@elliptictech.com>
References: <20111214215133.GA7780@elliptictech.com>
Message-ID: <20111215104105.GE24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nick,

I found a problem, can you please try the following patch:

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

I'll think a bit more about that during lunch and come up with a proper
commit log if it works for you.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
