From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 15:55:40 +0100
Subject: [PATCH 7/7] at91 : fix compilation warning
In-Reply-To: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1326293740-15735-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the clock routine in a function. That will prevent to have
a warning from the compiler to say there is unused variable.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/pm.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f97bbfa..2250773 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -132,6 +132,28 @@ static int at91_pm_begin(suspend_state_t state)
 	return 0;
 }
 
+static inline int at91_program_clock(unsigned long scsr)
+{
+#ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
+	int i;
+
+	/* PCK0..PCK3 must be disabled, or configured to use clk32k */
+	for (i = 0; i < 4; i++) {
+		u32 css;
+
+		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
+			continue;
+
+		css = at91_sys_read(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		if (css != AT91_PMC_CSS_SLOW) {
+			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
+			return -1;
+		}
+	}
+#endif
+	return 0;
+}
+
 /*
  * Verify that all the clocks are correct before entering
  * slow-clock mode.
@@ -139,7 +161,6 @@ static int at91_pm_begin(suspend_state_t state)
 static int at91_pm_verify_clocks(void)
 {
 	unsigned long scsr;
-	int i;
 
 	scsr = at91_sys_read(AT91_PMC_SCSR);
 
@@ -162,21 +183,8 @@ static int at91_pm_verify_clocks(void)
 		}
 	}
 
-#ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
-	/* PCK0..PCK3 must be disabled, or configured to use clk32k */
-	for (i = 0; i < 4; i++) {
-		u32 css;
-
-		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
-			continue;
-
-		css = at91_sys_read(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
-		if (css != AT91_PMC_CSS_SLOW) {
-			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
-			return 0;
-		}
-	}
-#endif
+	if (at91_program_clock(scsr))
+		return 0;
 
 	return 1;
 }
-- 
1.7.4.1
