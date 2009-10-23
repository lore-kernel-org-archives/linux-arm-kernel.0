From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 23 Oct 2009 09:59:06 -0700
Subject: [PATCH 08/10] OMAP3: PM: Use pwrdm_set_next_pwrst instead of
	set_pwrdm_state in idle loop
In-Reply-To: <1256317148-25506-8-git-send-email-khilman@deeprootsystems.com>
References: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-4-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-5-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-6-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-7-git-send-email-khilman@deeprootsystems.com>
	<1256317148-25506-8-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1256317148-25506-9-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jouni Hogander <jouni.hogander@nokia.com>

It is more efficient to use pwrdm_set_next_pwrst for mpu, core and neon
instead of set_pwrdm_state in idle loop. It is anyway known that those are
active in idle loop. So no need to use set_pwrdm_state.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 5128b8c..1d10c4a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -110,8 +110,8 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 			core_state = PWRDM_POWER_RET;
 	}
 
-	set_pwrdm_state(mpu_pd, mpu_state);
-	set_pwrdm_state(core_pd, core_state);
+	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
+	pwrdm_set_next_pwrst(core_pd, core_state);
 
 	if (omap_irq_pending())
 		goto return_sleep_time;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a6624a1..35c917e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -359,7 +359,7 @@ void omap_sram_idle(void)
 
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
-		set_pwrdm_state(neon_pwrdm, mpu_next_state);
+		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-- 
1.6.4.3
