From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 25 Nov 2010 14:26:51 +0530
Subject: [PATCH 1/5] OMAP4: PM: Use the low-power state change feature on
Message-ID: <mailman.62.1292426280.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4

For pwrdm's which support LOWPOWERSTATECHANGE, do not try waking
up the domain to put it back to deeper sleep state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/pm.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

Index: linux/arch/arm/mach-omap2/pm.c
===================================================================
--- linux.orig/arch/arm/mach-omap2/pm.c	2010-12-15 17:29:42.361228780
+0530
+++ linux/arch/arm/mach-omap2/pm.c	2010-12-15 20:19:48.321228780
+0530
@@ -89,6 +89,10 @@
 	}
 }

+/* Types of sleep_switch used in omap_set_pwrdm_state */
+#define FORCEWAKEUP_SWITCH	0
+#define LOWPOWERSTATE_SWITCH	1
+
 /*
  * This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
@@ -114,9 +118,14 @@
 		return ret;

 	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
-		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
-		sleep_switch = 1;
-		pwrdm_wait_transition(pwrdm);
+		if ((pwrdm_read_pwrst(pwrdm) > state) &&
+			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
+			sleep_switch = LOWPOWERSTATE_SWITCH;
+		} else {
+			omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			pwrdm_wait_transition(pwrdm);
+			sleep_switch = FORCEWAKEUP_SWITCH;
+		}
 	}

 	ret = pwrdm_set_next_pwrst(pwrdm, state);
@@ -126,12 +135,19 @@
 		goto err;
 	}

-	if (sleep_switch) {
+	switch (sleep_switch) {
+	case FORCEWAKEUP_SWITCH:
 		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
-		pwrdm_wait_transition(pwrdm);
-		pwrdm_state_switch(pwrdm);
+		break;
+	case LOWPOWERSTATE_SWITCH:
+		pwrdm_set_lowpwrstchange(pwrdm);
+		break;
+	default:
+		return ret;
 	}

+	pwrdm_wait_transition(pwrdm);
+	pwrdm_state_switch(pwrdm);
 err:
 	return ret;
 }


>
> Kevin
>
> > +		}
> >  		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> >  		sleep_switch = 1;
> >  		pwrdm_wait_transition(pwrdm);
