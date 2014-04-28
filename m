From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:33:10 +0100
Subject: [PATCH 82/97] ARM: l2c: always enable low power modes
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerIc-0001ZH-VX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always enable the L2C low power modes on L2C-310 R3P0 and newer parts.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 610fa25eff0c..333ef64873f9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -695,6 +695,18 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 			1 + (prefetch & L310_PREFETCH_CTRL_OFFSET_MASK));
 	}
 
+	/* r3p0 or later has power control register */
+	if (rev >= L310_CACHE_ID_RTL_R3P0) {
+		u32 power_ctrl;
+
+		l2c_write_sec(L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN,
+			      base, L310_POWER_CTRL);
+		power_ctrl = readl_relaxed(base + L310_POWER_CTRL);
+		pr_info("L2C-310 dynamic clock gating %sabled, standby mode %sabled\n",
+			power_ctrl & L310_DYNAMIC_CLK_GATING_EN ? "en" : "dis",
+			power_ctrl & L310_STNDBY_MODE_EN ? "en" : "dis");
+	}
+
 	l2c_enable(base, aux, num_lock);
 
 	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {
-- 
1.8.3.1
