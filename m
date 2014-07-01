From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  1 Jul 2014 11:33:16 +0200
Subject: [PATCH v2 03/14] AT91: PIT: Use DIV_ROUND_CLOSEST to compute the
 cycles
In-Reply-To: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1404207208-14513-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, the pit_cycle computation was dividing the rate by HZ, rounding to
the closest integer, but without using the appropriate macro.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/at91sam926x_time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index fd3170b65fbb..2e6f1a37ab90 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -252,7 +252,7 @@ void __init at91sam926x_pit_init(void)
 	if (IS_ERR(mck))
 		panic("AT91: PIT: Unable to get mck clk\n");
 	pit_rate = clk_get_rate(mck) / 16;
-	pit_cycle = (pit_rate + HZ/2) / HZ;
+	pit_cycle = DIV_ROUND_CLOSEST(pit_rate, HZ);
 	WARN_ON(((pit_cycle - 1) & ~AT91_PIT_PIV) != 0);
 
 	/* Initialize and enable the timer */
-- 
2.0.0
