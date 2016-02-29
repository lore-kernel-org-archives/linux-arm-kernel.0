From: brad.mouring@ni.com (Brad Mouring)
Date: Mon, 29 Feb 2016 10:01:55 -0600
Subject: [PATCH 1/2] pl2x0: Add OF control of cache power management
In-Reply-To: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
References: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
Message-ID: <1456761716-10174-1-git-send-email-brad.mouring@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ability to override power management bits of 310 controllers
through OF entries. As the saved register is only applied when
working on a supported controller, it is safe to save the settings.

Additionally, to control the actual configuration of the power
control register, remove the unconditional enabling of features in
the l2c310_enable function.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Acked-by: Josh Cartwright <joshc@ni.com>
---
 arch/arm/mm/cache-l2x0.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9f9d542..7432dea 100644
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
 
@@ -1271,6 +1267,29 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	}
 
 	l2x0_saved_regs.prefetch_ctrl = prefetch;
+
+	power = l2x0_saved_regs.pwr_ctrl;
+
+	ret = of_property_read_u32(np, "arm,dynamic-clock-gating", &val);
+	if (ret == 0) {
+		if (val)
+			power |= L310_DYNAMIC_CLK_GATING_EN;
+		else
+			power &= ~L310_DYNAMIC_CLK_GATING_EN;
+	} else if (ret != -EINVAL) {
+		pr_err("L2C-310 OF dynamic-clock-gating property value is missing\n");
+	}
+	ret = of_property_read_u32(np, "arm,standby-mode", &val);
+	if (ret == 0) {
+		if (val)
+			power |= L310_STNDBY_MODE_EN;
+		else
+			power &= ~L310_STNDBY_MODE_EN;
+	} else if (ret != -EINVAL) {
+		pr_err("L2C-310 OF standby-mode property value is missing\n");
+	}
+
+	l2x0_saved_regs.pwr_ctrl = power;
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
-- 
2.7.1
