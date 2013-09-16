From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Sep 2013 14:22:04 +0200
Subject: [PATCH] ARM: ux500: disable outer cache debug
Message-ID: <1379334124-9703-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a multiplatform regression on the Ux500.

When compiling the Ux500 platforms in multiplatform configurations
both PL310_ERRATA_588369 and PL310_ERRATA_727915 would crash the
platform when trying to launch the init process.

The Ux500 cannot access the debug registers of the PL310, it will
just crash if you try this. So disable this by setting the debug
callback to NULL when initializing the l2x0 on this platform.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC folks: this (hopefully) fixes the bug that made
Snowball (and other Ux500) not boot properly on multi_v7.
Please apply this patch directly to your fixes branch if you're
happy with it.
---
 arch/arm/mach-ux500/cache-l2x0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 82ccf1d..264f894 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -69,6 +69,7 @@ static int __init ux500_l2x0_init(void)
 	 * some SMI service available.
 	 */
 	outer_cache.disable = NULL;
+	outer_cache.set_debug = NULL;
 
 	return 0;
 }
-- 
1.8.3.1
