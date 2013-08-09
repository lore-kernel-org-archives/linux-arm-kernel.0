From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 9 Aug 2013 17:35:19 -0500
Subject: [RFC PATCH] ARM: smp_twd: Fix twd_get_clock() to get clock from dts
 or clock framework
Message-ID: <1376087720-14539-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Some platforms have a clock for the smp_twd that goes through a fixed
divider. Registering this smp_twd clocks is done by calling
clk_register_fixed_factor().

Fix up twd_get_clock() so that it can get the clock from the device
tree node or clk_register_fixed_factor().

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
CC: Russell King <linux@arm.linux.org.uk>
Cc: spear-devel at list.st.com
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/smp_twd.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 2595620..643b226 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -244,7 +244,10 @@ static void twd_get_clock(struct device_node *np)
 
 	if (np)
 		twd_clk = of_clk_get(np, 0);
-	else
+
+	/* Some platforms do not register the smp_twd clock in the device */
+	/* node of the twd timer. */
+	if (IS_ERR(twd_clk))	
 		twd_clk = clk_get_sys("smp_twd", NULL);
 
 	if (IS_ERR(twd_clk)) {
-- 
1.7.9.5
