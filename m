From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 28 Jul 2016 17:48:42 -0700
Subject: [RESEND PATCH 2/2] ARM: cache-l2x0.c: Do not clear bit 23 in prefetch
 control register
In-Reply-To: <1469753322-11407-1-git-send-email-andrew.smirnov@gmail.com>
References: <1469753322-11407-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1469753322-11407-2-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per L2C-310 TRM[1]:

"... You can control this feature using bits 30,27 and 23 of the
Prefetch Control Register. Bit 23 and 27 are only used if you set bit 30
HIGH..."

which means there is no need to clear bit 23 if bit 30 is being cleared.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0246e/CJAJACBJ.html

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mm/cache-l2x0.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 30e2012..12c1ba7 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -715,11 +715,8 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	if (revision >= L310_CACHE_ID_RTL_R3P0 &&
 	    revision < L310_CACHE_ID_RTL_R3P2) {
 		u32 val = l2x0_saved_regs.prefetch_ctrl;
-		/* I don't think bit23 is required here... but iMX6 does so */
-		if (val & (L310_PREFETCH_CTRL_DBL_LINEFILL |
-			   L310_PREFETCH_CTRL_DBL_LINEFILL_INCR)) {
-			val &= ~(L310_PREFETCH_CTRL_DBL_LINEFILL |
-				 L310_PREFETCH_CTRL_DBL_LINEFILL_INCR);
+		if (val & L310_PREFETCH_CTRL_DBL_LINEFILL) {
+			val &= ~L310_PREFETCH_CTRL_DBL_LINEFILL;
 			l2x0_saved_regs.prefetch_ctrl = val;
 			errata[n++] = "752271";
 		}
-- 
2.5.5
