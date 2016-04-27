From: brad.mouring@ni.com (Brad Mouring)
Date: Wed, 27 Apr 2016 10:35:50 -0500
Subject: [PATCH v3 1/2] arm: pl2x0: Add OF control of cache power management
In-Reply-To: <1461771351-11645-1-git-send-email-brad.mouring@ni.com>
References: <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
 <1461771351-11645-1-git-send-email-brad.mouring@ni.com>
Message-ID: <1461771351-11645-2-git-send-email-brad.mouring@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ability to override power management bits of 310 controllers
(dynamic clock gating and standby mode) through OF entries. As the
saved register is only applied when working on a supported controller,
it is safe to save the settings.

In order to maintain existing behavior, if the settings are not found
in the DT, the corresponding feature will be enabled.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
---
 arch/arm/mm/cache-l2x0.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9f9d542..c61996c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -647,11 +647,6 @@ static void __init l2c310_enable(void __iomem *base, unsigned num_lock)
 		aux &= ~(L310_AUX_CTRL_FULL_LINE_ZERO | L310_AUX_CTRL_EARLY_BRESP);
 	}
 
-	/* r3p0 or later has power control register */
-	if (rev >= L310_CACHE_ID_RTL_R3P0)
-		l2x0_saved_regs.pwr_ctrl = L310_DYNAMIC_CLK_GATING_EN |
-						L310_STNDBY_MODE_EN;
-
 	/*
 	 * Always enable non-secure access to the lockdown registers -
 	 * we write to them as part of the L2C enable sequence so they
@@ -1141,6 +1136,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	u32 filter[2] = { 0, 0 };
 	u32 assoc;
 	u32 prefetch;
+	u32 power;
 	u32 val;
 	int ret;
 
@@ -1271,6 +1267,26 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	}
 
 	l2x0_saved_regs.prefetch_ctrl = prefetch;
+
+	power = l2x0_saved_regs.pwr_ctrl |
+		L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN;
+
+	ret = of_property_read_u32(np, "arm,dynamic-clock-gating", &val);
+	if (!ret) {
+		if (!val)
+			power &= ~L310_DYNAMIC_CLK_GATING_EN;
+	} else if (ret != -EINVAL) {
+		pr_err("L2C-310 OF dynamic-clock-gating property value is missing or invalid\n");
+	}
+	ret = of_property_read_u32(np, "arm,standby-mode", &val);
+	if (!ret) {
+		if (!val)
+			power &= ~L310_STNDBY_MODE_EN;
+	} else if (ret != -EINVAL) {
+		pr_err("L2C-310 OF standby-mode property value is missing or invalid\n");
+	}
+
+	l2x0_saved_regs.pwr_ctrl = power;
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
-- 
2.7.3
