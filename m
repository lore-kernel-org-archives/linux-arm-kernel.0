From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 11 May 2010 16:47:10 -0700
Subject: [PATCH 5/6] OMAP3: PM: Enable IO / IO-CHAIN wakeups for PER
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273621631-9148-6-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Chan <mike@android.com>

IO events can also come from GPIO modules, which reside in the PER domain.
It is possible for the PER to enter RET while CORE is still in ON.
If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
wakeup in this case, unless we enable it.

Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e76af5b..eec0916 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -379,9 +379,16 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
-	/* PER */
+	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	if (per_next_state < PWRDM_POWER_ON ||
+			core_next_state < PWRDM_POWER_ON) {
+		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		omap3_enable_io_chain();
+	}
+
+	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
 		omap2_gpio_prepare_for_retention();
@@ -406,10 +413,8 @@ void omap_sram_idle(void)
 			omap3_core_save_context();
 			omap3_prcm_save_context();
 		}
-		/* Enable IO-PAD and IO-CHAIN wakeups */
-		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
 	}
+
 	omap3_intc_prepare_idle();
 
 	/*
@@ -471,7 +476,8 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if (per_next_state < PWRDM_POWER_ON ||
+			core_next_state < PWRDM_POWER_ON) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
-- 
1.7.0.2
