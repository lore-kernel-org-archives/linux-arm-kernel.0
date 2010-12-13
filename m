From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 13 Dec 2010 22:49:25 +0100
Subject: [PATCH 1/5] OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Message-ID: <1292276969-29733-2-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

For pwrdm's which support lowperstatechange, do not try waking
up the domain to put it back to deeper sleep state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/pm.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index cf1c4c9..dc68044 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -114,6 +114,14 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		return ret;
 
 	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
+		if ((pwrdm_read_pwrst(pwrdm) > state) &&
+			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
+				ret = pwrdm_set_next_pwrst(pwrdm, state);
+				pwrdm_set_lowpwrstchange(pwrdm);
+				pwrdm_wait_transition(pwrdm);
+				pwrdm_state_switch(pwrdm);
+				return ret;
+		}
 		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
 		sleep_switch = 1;
 		pwrdm_wait_transition(pwrdm);
-- 
1.7.0.4
