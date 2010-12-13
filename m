From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 13 Dec 2010 22:49:26 +0100
Subject: [PATCH 2/5] OMAP4: PM: Do not assume clkdm supports hw transitions
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Message-ID: <1292276969-29733-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

omap_set_pwrdm_state today assumes a clkdm supports hw_auto
transitions and hence leaves some which do not support this
in sw wkup state preventing low power transitions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/pm.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index dc68044..a2a70e1 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -91,8 +91,7 @@ static void omap2_init_processor_devices(void)
 
 /*
  * This sets pwrdm state (other than mpu & core. Currently only ON &
- * RET are supported. Function is assuming that clkdm doesn't have
- * hw_sup mode enabled.
+ * RET are supported.
  */
 int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
@@ -135,7 +134,10 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	}
 
 	if (sleep_switch) {
-		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		if (pwrdm->pwrdm_clkdms[0]->flags & CLKDM_CAN_ENABLE_AUTO)
+			omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		else
+			omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
 		pwrdm_wait_transition(pwrdm);
 		pwrdm_state_switch(pwrdm);
 	}
-- 
1.7.0.4
