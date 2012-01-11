From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 11 Jan 2012 10:04:53 +0100
Subject: [PATCH 2/3] plat-nomadik: handle clocking properly
Message-ID: <1326272693-5709-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

clk_prepare() was missing from the Nomadik MTU driver, also handle
errors on prepare and enable in the simplest way possible, by
bugging out - we cannot start the system without time anyway.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/timer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 46f50f2..954a862 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -190,8 +190,8 @@ void __init nmdk_timer_init(void __iomem *base)
 	mtu_base = base;
 	clk0 = clk_get_sys("mtu0", NULL);
 	BUG_ON(IS_ERR(clk0));
-
-	clk_enable(clk0);
+	BUG_ON(clk_prepare(clk0) < 0);
+	BUG_ON(clk_enable(clk0) < 0);
 
 	/*
 	 * Tick rate is 2.4MHz for Nomadik and 2.4Mhz, 100MHz or 133 MHz
-- 
1.7.8
