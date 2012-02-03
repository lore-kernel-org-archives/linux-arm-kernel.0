From: balbi@ti.com (Felipe Balbi)
Date: Fri,  3 Feb 2012 09:28:14 +0200
Subject: [RFC/PATCH] arm: omap3: pm: do not clear power states twice
Message-ID: <1328254094-13978-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way the code is written, pwrdm_pre_transion()
calls _pwrdm_pre_transition_cb() (for each powerdomain)
which, in turn, calls pwrdm_clear_all_prev_pwrst().

It looks unnecessary to clear all previous power
states twice, so drop the initial set.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Hasn't been tested yet. Compile tested only. It looks
like we can safely remove those calls, but I would
like to hear from the PM folks first :-)

 arch/arm/mach-omap2/pm34xx.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..ca1704c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -290,11 +290,6 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 
-	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
-	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
-	pwrdm_clear_all_prev_pwrst(core_pwrdm);
-	pwrdm_clear_all_prev_pwrst(per_pwrdm);
-
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
@@ -312,8 +307,10 @@ void omap_sram_idle(void)
 	}
 
 	/* NEON control */
-	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON) {
+		pwrdm_clear_all_prev_pwrst(neon_pwrdm);
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
+	}
 
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-- 
1.7.9
