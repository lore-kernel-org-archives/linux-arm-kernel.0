From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 18 Jun 2016 17:31:02 -0700
Subject: [PATCH 1/2] ARM: cache-l2x0.c: Replace magic numbers
In-Reply-To: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1466296268-27099-2-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace magic numbers used for L310 Prefetch Control Register

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mm/cache-l2x0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9f9d542..30e2012 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -716,8 +716,10 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	    revision < L310_CACHE_ID_RTL_R3P2) {
 		u32 val = l2x0_saved_regs.prefetch_ctrl;
 		/* I don't think bit23 is required here... but iMX6 does so */
-		if (val & (BIT(30) | BIT(23))) {
-			val &= ~(BIT(30) | BIT(23));
+		if (val & (L310_PREFETCH_CTRL_DBL_LINEFILL |
+			   L310_PREFETCH_CTRL_DBL_LINEFILL_INCR)) {
+			val &= ~(L310_PREFETCH_CTRL_DBL_LINEFILL |
+				 L310_PREFETCH_CTRL_DBL_LINEFILL_INCR);
 			l2x0_saved_regs.prefetch_ctrl = val;
 			errata[n++] = "752271";
 		}
-- 
2.5.5
