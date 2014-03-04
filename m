From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  4 Mar 2014 17:18:01 +0100
Subject: [PATCH v3 4/7] ARM: sun6i: Protect CPU clock
In-Reply-To: <1393949884-892-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393949884-892-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393949884-892-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now, AHB is an indirect child clock of the CPU clock. If that happens to
change, since the CPU clock has no other consumers declared in Linux, it would
be shut down, which is not really a good idea.

Prevent this by forcing it enabled.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sun6i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-sunxi/sun6i.c b/arch/arm/mach-sunxi/sun6i.c
index c5dc819..6b39055 100644
--- a/arch/arm/mach-sunxi/sun6i.c
+++ b/arch/arm/mach-sunxi/sun6i.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
@@ -22,9 +23,17 @@
 
 static void __init sun6i_dt_init(void)
 {
+	struct clk *clk;
+
 	sunxi_setup_restart();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	/* Make sure the clocks we absolutely need are enabled */
+	/* CPU clock */
+	clk = clk_get(NULL, "cpu");
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
 }
 
 extern void __init sun6i_reset_init(void);
-- 
1.9.0
